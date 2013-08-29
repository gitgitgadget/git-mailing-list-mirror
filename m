From: Brad King <brad.king@kitware.com>
Subject: [PATCH/RFC 7/7] update-ref: support multiple simultaneous updates
Date: Thu, 29 Aug 2013 10:11:55 -0400
Message-ID: <8d323b9c2a71a9bafa8b48caf1d85c1035549b16.1377784597.git.brad.king@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 16:22:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF37L-0000xR-Qb
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 16:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350Ab3H2OW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 10:22:29 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:48737 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754170Ab3H2OWP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 10:22:15 -0400
X-Greylist: delayed 522 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Aug 2013 10:22:15 EDT
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 80D0D9FB8E; Thu, 29 Aug 2013 10:11:55 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1377784597.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233264>

Add a --stdin signature to read update instructions from standard input
and apply multiple ref updates and deletes together.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 Documentation/git-update-ref.txt |   19 +++++++-
 builtin/update-ref.c             |   93 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 0df13ff..a79afe8 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -8,7 +8,7 @@ git-update-ref - Update the object name stored in a ref safely
 SYNOPSIS
 --------
 [verse]
-'git update-ref' [-m <reason>] (-d <ref> [<oldvalue>] | [--no-deref] <ref> <newvalue> [<oldvalue>])
+'git update-ref' [-m <reason>] (-d <ref> [<oldvalue>] | [--no-deref] <ref> <newvalue> [<oldvalue>] | --stdin)
 
 DESCRIPTION
 -----------
@@ -58,6 +58,23 @@ archive by creating a symlink tree).
 With `-d` flag, it deletes the named <ref> after verifying it
 still contains <oldvalue>.
 
+With `--stdin`, update-ref reads instructions from standard input
+and performs all modifications together.  Specify updates with
+lines of the form:
+
+	[ --no-deref SP ] <ref> SP <newvalue> [ SP <oldvalue> ] LF
+
+and deletes with lines of the form:
+
+	[ --no-deref SP ] -d SP <ref> [ SP <oldvalue> ] LF
+
+or as updates with 40 "0" as <newvalue>.  Blank lines are ignored.
+Lines of any other format or a repeated <ref> produce an error.
+If all <ref>s can be locked with matching <oldvalue>s
+simultaneously all modifications are performed.  Otherwise, no
+modifications are performed.  Note that while each individual
+<ref> is updated or deleted atomically, a concurrent reader may
+still see a subset of the modifications.
 
 Logging Updates
 ---------------
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 51d2684..2f0d34c 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -6,19 +6,102 @@
 static const char * const git_update_ref_usage[] = {
 	N_("git update-ref [options] -d <refname> [<oldval>]"),
 	N_("git update-ref [options]    <refname> <newval> [<oldval>]"),
+	N_("git update-ref [options] --stdin"),
 	NULL
 };
 
+static const char blank[] = " \t\r\n";
+
+static int updates_size;
+static int updates_count;
+static struct ref_update *updates;
+
+static void update_refs_stdin(const char *line)
+{
+	int delete = 0, i;
+	const char *c, *s, *oldvalue, *value[2] = {0,0};
+	struct ref_update *update;
+	c = line;
+
+	/* Skip blank lines: */
+	if (*c == '\n')
+		return;
+
+	/* Allocate a ref_update struct: */
+	if (updates_count == updates_size) {
+		updates_size = updates_size? updates_size*2 : 16;
+		updates = xrealloc(updates, sizeof(*updates)*updates_size);
+		memset(updates + updates_count, 0,
+		       sizeof(*updates)*(updates_size-updates_count));
+	}
+	update = &updates[updates_count++];
+
+	/* --no-deref SP */
+	if (strncmp(c, "--no-deref ", 11) == 0) {
+		c += 11;
+		update->flags |= REF_NODEREF;
+	}
+
+	/* -d SP */
+	if (strncmp(c, "-d ", 3) == 0) {
+		c += 3;
+		delete = 1;
+	}
+
+	/* <ref> */
+	s = c;
+	c = s + strcspn(s, blank);
+	update->ref_name = xstrndup(s, c-s);
+
+	/* [ SP <value> ]... */
+	for (i=0; i < 2; ++i) {
+		if (*c != ' ')
+			break;
+		++c;
+		s = c;
+		c = s + strcspn(s, blank);
+		value[i] = xstrndup(s, c-s);
+	}
+
+	if (*c && *c != '\n')
+		die("unrecognized input line: %s", line);
+
+	if (check_refname_format(update->ref_name, REFNAME_ALLOW_ONELEVEL))
+		die("invalid <ref> format on input line: %s", line);
+
+	if (delete) {
+		hashclr(update->new_sha1);
+		oldvalue = value[0];
+		if (value[1])
+			die("both <newvalue> and <oldvalue> on delete line: %s",
+			    line);
+	} else {
+		if (!value[0])
+			die("missing <newvalue> on update line: %s", line);
+		if (get_sha1(value[0], update->new_sha1))
+			die("invalid <newvalue> on update line: %s", line);
+		oldvalue = value[1];
+	}
+	if (oldvalue) {
+		update->old_sha1 = xmalloc(20);
+		if (get_sha1(oldvalue, update->old_sha1))
+			die("invalid <oldvalue> on %s line: %s",
+			    delete? "delete":"update", line);
+	}
+}
+
 int cmd_update_ref(int argc, const char **argv, const char *prefix)
 {
 	const char *refname, *oldval, *msg = NULL;
 	unsigned char sha1[20], oldsha1[20];
-	int delete = 0, no_deref = 0, flags = 0;
+	int delete = 0, no_deref = 0, read_stdin = 0, flags = 0;
+	char line[1000];
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOLEAN('d', NULL, &delete, N_("delete the reference")),
 		OPT_BOOLEAN( 0 , "no-deref", &no_deref,
 					N_("update <refname> not the one it points to")),
+		OPT_BOOLEAN( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
 		OPT_END(),
 	};
 
@@ -28,6 +111,14 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	if (msg && !*msg)
 		die("Refusing to perform update with empty message.");
 
+	if (read_stdin) {
+		if (delete || no_deref || argc > 0)
+			usage_with_options(git_update_ref_usage, options);
+		while (fgets(line, sizeof(line), stdin))
+			update_refs_stdin(line);
+		return update_refs(msg, updates, updates_count, DIE_ON_ERR);
+	}
+
 	if (delete) {
 		if (argc < 1 || argc > 2)
 			usage_with_options(git_update_ref_usage, options);
-- 
1.7.10.4
