From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/4] replace: add --graft option
Date: Sun, 01 Jun 2014 17:10:34 +0200
Message-ID: <20140601151038.15428.99129.chriscool@tuxfamily.org>
References: <20140601150409.15428.27017.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 17:11:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wr7QG-0000O8-B7
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 17:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbaFAPLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2014 11:11:36 -0400
Received: from [194.158.98.15] ([194.158.98.15]:42105 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752250AbaFAPLf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 11:11:35 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 45E5B34;
	Sun,  1 Jun 2014 17:11:11 +0200 (CEST)
X-git-sha1: d82c2d61d4be8cb232b3298ac50277f983c589db 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140601150409.15428.27017.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250526>

The usage string for this option is:

git replace [-f] --graft <commit> [<parent>...]

First we create a new commit that is the same as <commit>
except that its parents are [<parents>...]

Then we create a replace ref that replace <commit> with
the commit we just created.

With this new option, it should be straightforward to
convert grafts to replace refs.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replace.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 1bb491d..9d1e82f 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -17,6 +17,7 @@
 static const char * const git_replace_usage[] = {
 	N_("git replace [-f] <object> <replacement>"),
 	N_("git replace [-f] --edit <object>"),
+	N_("git replace [-f] --graft <commit> [<parent>...]"),
 	N_("git replace -d <object>..."),
 	N_("git replace [--format=<format>] [-l [<pattern>]]"),
 	NULL
@@ -294,6 +295,76 @@ static int edit_and_replace(const char *object_ref, int force)
 	return replace_object_sha1(object_ref, old, "replacement", new, force);
 }
 
+static int read_sha1_commit(const unsigned char *sha1, struct strbuf *dst)
+{
+	void *buf;
+	enum object_type type;
+	unsigned long size;
+
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf)
+		return error(_("cannot read object %s"), sha1_to_hex(sha1));
+	if (type != OBJ_COMMIT) {
+		free(buf);
+		return error(_("object %s is not a commit"), sha1_to_hex(sha1));
+	}
+	strbuf_attach(dst, buf, size, size + 1);
+	return 0;
+}
+
+static int create_graft(int argc, const char **argv, int force)
+{
+	unsigned char old[20], new[20];
+	const char *old_ref = argv[0];
+	struct commit *commit;
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf new_parents = STRBUF_INIT;
+	const char *parent_start, *parent_end;
+	int i;
+
+	if (get_sha1(old_ref, old) < 0)
+		die(_("Not a valid object name: '%s'"), old_ref);
+	commit = lookup_commit_or_die(old, old_ref);
+	if (read_sha1_commit(old, &buf))
+		die(_("Invalid commit: '%s'"), old_ref);
+
+	/* make sure the commit is not corrupt */
+	if (parse_commit_buffer(commit, buf.buf, buf.len))
+		die(_("Could not parse commit: '%s'"), old_ref);
+
+	/* find existing parents */
+	parent_start = buf.buf;
+	parent_start += 46; /* "tree " + "hex sha1" + "\n" */
+	parent_end = parent_start;
+
+	while (starts_with(parent_end, "parent "))
+		parent_end += 48; /* "parent " + "hex sha1" + "\n" */
+
+	/* prepare new parents */
+	for (i = 1; i < argc; i++) {
+		unsigned char sha1[20];
+		if (get_sha1(argv[i], sha1) < 0)
+			die(_("Not a valid object name: '%s'"), argv[i]);
+		lookup_commit_or_die(sha1, argv[i]);
+		strbuf_addf(&new_parents, "parent %s\n", sha1_to_hex(sha1));
+	}
+
+	/* replace existing parents with new ones */
+	strbuf_splice(&buf, parent_start - buf.buf, parent_end - parent_start,
+		      new_parents.buf, new_parents.len);
+
+	if (write_sha1_file(buf.buf, buf.len, commit_type, new))
+		die(_("could not write replacement commit for: '%s'"), old_ref);
+
+	strbuf_release(&new_parents);
+	strbuf_release(&buf);
+
+	if (!hashcmp(old, new))
+		return error("new commit is the same as the old one: '%s'", sha1_to_hex(old));
+
+	return replace_object_sha1(old_ref, old, "replacement", new, force);
+}
+
 int cmd_replace(int argc, const char **argv, const char *prefix)
 {
 	int force = 0;
@@ -303,12 +374,14 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		MODE_LIST,
 		MODE_DELETE,
 		MODE_EDIT,
+		MODE_GRAFT,
 		MODE_REPLACE
 	} cmdmode = MODE_UNSPECIFIED;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list replace refs"), MODE_LIST),
 		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete replace refs"), MODE_DELETE),
 		OPT_CMDMODE('e', "edit", &cmdmode, N_("edit existing object"), MODE_EDIT),
+		OPT_CMDMODE('g', "graft", &cmdmode, N_("change a commit's parents"), MODE_GRAFT),
 		OPT_BOOL('f', "force", &force, N_("replace the ref if it exists")),
 		OPT_STRING(0, "format", &format, N_("format"), N_("use this format")),
 		OPT_END()
@@ -325,7 +398,10 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		usage_msg_opt("--format cannot be used when not listing",
 			      git_replace_usage, options);
 
-	if (force && cmdmode != MODE_REPLACE && cmdmode != MODE_EDIT)
+	if (force &&
+	    cmdmode != MODE_REPLACE &&
+	    cmdmode != MODE_EDIT &&
+	    cmdmode != MODE_GRAFT)
 		usage_msg_opt("-f only makes sense when writing a replacement",
 			      git_replace_usage, options);
 
@@ -348,6 +424,12 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 				      git_replace_usage, options);
 		return edit_and_replace(argv[0], force);
 
+	case MODE_GRAFT:
+		if (argc < 1)
+			usage_msg_opt("-g needs at least one argument",
+				      git_replace_usage, options);
+		return create_graft(argc, argv, force);
+
 	case MODE_LIST:
 		if (argc > 1)
 			usage_msg_opt("only one pattern can be given with -l",
-- 
2.0.0.rc0.40.gd30ccc4
