From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 4/4] replace: add --edit option
Date: Sat, 26 Apr 2014 22:00:57 +0200
Message-ID: <20140426200058.21546.28299.chriscool@tuxfamily.org>
References: <20140426194404.21546.82305.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 26 22:02:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We8oL-0000ML-57
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 22:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbaDZUCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 16:02:44 -0400
Received: from [194.158.98.45] ([194.158.98.45]:56646 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751180AbaDZUB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 16:01:58 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 02D7861;
	Sat, 26 Apr 2014 22:01:35 +0200 (CEST)
X-git-sha1: 04e23a9287cba19917971665c6c876be9dbb51d5 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140426194404.21546.82305.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247182>

From: Jeff King <peff@peff.net>

This allows you to run:

    git replace --edit SHA1

to get dumped in an editor with the contents of the object
for SHA1. The result is then read back in and used as a
"replace" object for SHA1. The writing/reading is
type-aware, so you get to edit "ls-tree" output rather than
the binary tree format.

Missing documentation and tests.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replace.c | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 1 deletion(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index af40129..3da1bae 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -12,6 +12,7 @@
 #include "builtin.h"
 #include "refs.h"
 #include "parse-options.h"
+#include "run-command.h"
 
 static const char * const git_replace_usage[] = {
 	N_("git replace [-f] <object> <replacement>"),
@@ -176,6 +177,107 @@ static int replace_object(const char *object_ref, const char *replace_ref, int f
 	return replace_object_sha1(object_ref, object, replace_ref, repl, force);
 }
 
+/*
+ * Write the contents of the object named by "sha1" to the file "filename",
+ * pretty-printed for human editing based on its type.
+ */
+static void export_object(const unsigned char *sha1, const char *filename)
+{
+	const char *argv[] = { "--no-replace-objects", "cat-file", "-p", NULL, NULL };
+	struct child_process cmd = { argv };
+	int fd;
+
+	fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	if (fd < 0)
+		die_errno("unable to open %s for writing", filename);
+
+	argv[3] = sha1_to_hex(sha1);
+	cmd.git_cmd = 1;
+	cmd.out = fd;
+
+	if (run_command(&cmd))
+		die("cat-file reported failure");
+
+	close(fd);
+}
+
+/*
+ * Read a previously-exported (and possibly edited) object back from "filename",
+ * interpreting it as "type", and writing the result to the object database.
+ * The sha1 of the written object is returned via sha1.
+ */
+static void import_object(unsigned char *sha1, enum object_type type,
+			  const char *filename)
+{
+	int fd;
+
+	fd = open(filename, O_RDONLY);
+	if (fd < 0)
+		die_errno("unable to open %s for reading", filename);
+
+	if (type == OBJ_TREE) {
+		const char *argv[] = { "mktree", NULL };
+		struct child_process cmd = { argv };
+		struct strbuf result = STRBUF_INIT;
+
+		cmd.argv = argv;
+		cmd.git_cmd = 1;
+		cmd.in = fd;
+		cmd.out = -1;
+
+		if (start_command(&cmd))
+			die("unable to spawn mktree");
+
+		if (strbuf_read(&result, cmd.out, 41) < 0)
+			die_errno("unable to read from mktree");
+		close(cmd.out);
+
+		if (finish_command(&cmd))
+			die("mktree reported failure");
+		if (get_sha1_hex(result.buf, sha1) < 0)
+			die("mktree did not return an object name");
+
+		strbuf_release(&result);
+	} else {
+		struct stat st;
+		int flags = HASH_FORMAT_CHECK | HASH_WRITE_OBJECT;
+
+		if (fstat(fd, &st) < 0)
+			die_errno("unable to fstat %s", filename);
+		if (index_fd(sha1, fd, &st, type, NULL, flags) < 0)
+			die("unable to write object to database");
+		/* index_fd close()s fd for us */
+	}
+
+	/*
+	 * No need to close(fd) here; both run-command and index-fd
+	 * will have done it for us.
+	 */
+}
+
+static int edit_and_replace(const char *object_ref, int force)
+{
+	char *tmpfile = git_pathdup("REPLACE_EDITOBJ");
+	enum object_type type;
+	unsigned char old[20], new[20];
+
+	if (get_sha1(object_ref, old) < 0)
+		die("Not a valid object name: '%s'", object_ref);
+
+	type = sha1_object_info(old, NULL);
+	if (type < 0)
+		die("unable to get object type for %s", sha1_to_hex(old));
+
+	export_object(old, tmpfile);
+	if (launch_editor(tmpfile, NULL, NULL) < 0)
+		die("editing object file failed");
+	import_object(new, type, tmpfile);
+
+	free(tmpfile);
+
+	return replace_object_sha1(object_ref, old, "replacement", new, force);
+}
+
 int cmd_replace(int argc, const char **argv, const char *prefix)
 {
 	int force = 0;
@@ -184,11 +286,13 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		MODE_UNSPECIFIED = 0,
 		MODE_LIST,
 		MODE_DELETE,
+		MODE_EDIT,
 		MODE_REPLACE
 	} cmdmode = MODE_UNSPECIFIED;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list replace refs"), MODE_LIST),
 		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete replace refs"), MODE_DELETE),
+		OPT_CMDMODE('e', "edit", &cmdmode, N_("edit existing object"), MODE_EDIT),
 		OPT_BOOL('f', "force", &force, N_("replace the ref if it exists")),
 		OPT_STRING(0, "format", &format, N_("format"), N_("use this format")),
 		OPT_END()
@@ -205,7 +309,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		usage_msg_opt("--format cannot be used when not listing",
 			      git_replace_usage, options);
 
-	if (force && cmdmode != MODE_REPLACE)
+	if (force && cmdmode != MODE_REPLACE && cmdmode != MODE_EDIT)
 		usage_msg_opt("-f only makes sense when writing a replacement",
 			      git_replace_usage, options);
 
@@ -222,6 +326,12 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 				      git_replace_usage, options);
 		return replace_object(argv[0], argv[1], force);
 
+	case MODE_EDIT:
+		if (argc != 1)
+			usage_msg_opt("-e needs exactly one argument",
+				      git_replace_usage, options);
+		return edit_and_replace(argv[0], force);
+
 	case MODE_LIST:
 		if (argc > 1)
 			usage_msg_opt("only one pattern can be given with -l",
-- 
1.9.1.636.g20d5f34
