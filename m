From: Brad King <brad.king@kitware.com>
Subject: [PATCH v2 7/8] update-ref: support multiple simultaneous updates
Date: Fri, 30 Aug 2013 14:12:05 -0400
Message-ID: <ba564b6566b54d780a24355ca893294d814d8d24.1377885441.git.brad.king@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <cover.1377885441.git.brad.king@kitware.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 20:14:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFTCt-0007jF-44
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 20:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756822Ab3H3SNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 14:13:53 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:50951 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756725Ab3H3SNr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 14:13:47 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id DE64A9FB90; Fri, 30 Aug 2013 14:12:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1377885441.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233455>

Add a --stdin signature to read update instructions from standard input
and apply multiple ref updates together.  Use an input format that
supports any update that could be specified via the command-line,
including object names like 'branch:path with space'.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 Documentation/git-update-ref.txt |   21 ++++++-
 builtin/update-ref.c             |  121 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 0df13ff..295d0bb 100644
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
@@ -58,6 +58,25 @@ archive by creating a symlink tree).
 With `-d` flag, it deletes the named <ref> after verifying it
 still contains <oldvalue>.
 
+With `--stdin`, update-ref reads instructions from standard input and
+performs all modifications together.  Empty lines are ignored.
+Each non-empty line is parsed as whitespace-separated arguments.
+Use single-quotes to enclose whitespace and backslashes and an
+unquoted backslash to escape a single quote.  Specify updates with
+lines of the form:
+
+	[--no-deref] [--] <ref> <newvalue> [<oldvalue>]
+
+Lines of any other format or a repeated <ref> produce an error.
+Specify a zero <newvalue> to delete a ref and/or a zero <oldvalue>
+to make sure that a ref not exist.  Use either 40 "0" or the
+empty string (written as '') to specify a zero value.
+
+If all <ref>s can be locked with matching <oldvalue>s
+simultaneously all modifications are performed.  Otherwise, no
+modifications are performed.  Note that while each individual
+<ref> is updated or deleted atomically, a concurrent reader may
+still see a subset of the modifications.
 
 Logging Updates
 ---------------
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 51d2684..eb8db85 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -6,19 +6,129 @@
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
+static const char* update_refs_stdin_next_arg(const char* next,
+					      struct strbuf *arg)
+{
+	/* Skip leading whitespace: */
+	while (isspace(*next))
+		++next;
+
+	/* Return NULL when no argument is found: */
+	if (!*next)
+		return NULL;
+
+	/* Parse the argument: */
+	strbuf_reset(arg);
+	for (;;) {
+		char c = *next;
+		if (!c || isspace(c))
+			break;
+		++next;
+		if (c == '\'') {
+			size_t len = strcspn(next, "'");
+			if (!next[len])
+				die("unterminated single-quote: '%s", next);
+			strbuf_add(arg, next, len);
+			next += len + 1;
+			continue;
+		}
+		if (c == '\\') {
+			if (*next == '\'')
+				c = *next++;
+			else
+				die("unquoted backslash not escaping "
+				    "single-quote: \\%s", next);
+		}
+		strbuf_addch(arg, c);
+	}
+	return next;
+}
+
+static void update_refs_stdin(const char *line)
+{
+	int options = 1, flags = 0, argc = 0;
+	char *argv[3] = {0, 0, 0};
+	struct strbuf arg = STRBUF_INIT;
+	struct ref_update *update;
+	const char *next = line;
+
+	/* Skip blank lines: */
+	if (!line[0])
+		return;
+
+	/* Parse arguments on this line: */
+	while ((next = update_refs_stdin_next_arg(next, &arg)) != NULL) {
+		if (options && arg.buf[0] == '-')
+			if (!strcmp(arg.buf, "--no-deref"))
+				flags |= REF_NODEREF;
+			else if (!strcmp(arg.buf, "--"))
+				options = 0;
+			else
+				die("unknown option %s", arg.buf);
+		else if (argc >= 3)
+			die("too many arguments on line: %s", line);
+		else {
+			argv[argc++] = xstrdup(arg.buf);
+			options = 0;
+		}
+	}
+	strbuf_release(&arg);
+
+	/* Allocate and zero-init a struct ref_update: */
+	if (updates_count == updates_size) {
+		updates_size = updates_size ? (updates_size * 2) : 16;
+		updates = xrealloc(updates, sizeof(*updates) * updates_size);
+		memset(updates + updates_count, 0,
+		       sizeof(*updates) * (updates_size - updates_count));
+	}
+	update = &updates[updates_count++];
+	update->flags = flags;
+
+	/* Set the update ref_name: */
+	if (!argv[0])
+		die("no ref on line: %s", line);
+	if (check_refname_format(argv[0], REFNAME_ALLOW_ONELEVEL))
+		die("invalid ref format on line: %s", line);
+	update->ref_name = argv[0];
+	argv[0] = 0;
+
+	/* Set the update new_sha1 and, if specified, old_sha1: */
+	if (!argv[1])
+		die("missing new value on line: %s", line);
+	if (*argv[1] && get_sha1(argv[1], update->new_sha1))
+		die("invalid new value on line: %s", line);
+	if (argv[2]) {
+		update->have_old = 1;
+		if (*argv[2] && get_sha1(argv[2], update->old_sha1))
+			die("invalid old value on line: %s", line);
+	}
+
+	while (argc > 0)
+		free(argv[--argc]);
+}
+
 int cmd_update_ref(int argc, const char **argv, const char *prefix)
 {
 	const char *refname, *oldval, *msg = NULL;
 	unsigned char sha1[20], oldsha1[20];
-	int delete = 0, no_deref = 0, flags = 0;
+	int delete = 0, no_deref = 0, read_stdin = 0, flags = 0;
+	struct strbuf line = STRBUF_INIT;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOLEAN('d', NULL, &delete, N_("delete the reference")),
 		OPT_BOOLEAN( 0 , "no-deref", &no_deref,
 					N_("update <refname> not the one it points to")),
+		OPT_BOOLEAN( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
 		OPT_END(),
 	};
 
@@ -28,6 +138,15 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	if (msg && !*msg)
 		die("Refusing to perform update with empty message.");
 
+	if (read_stdin) {
+		if (delete || no_deref || argc > 0)
+			usage_with_options(git_update_ref_usage, options);
+		while (strbuf_getline(&line, stdin, '\n') != EOF)
+			update_refs_stdin(line.buf);
+		strbuf_release(&line);
+		return update_refs(msg, updates, updates_count, DIE_ON_ERR);
+	}
+
 	if (delete) {
 		if (argc < 1 || argc > 2)
 			usage_with_options(git_update_ref_usage, options);
-- 
1.7.10.4
