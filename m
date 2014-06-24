From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] replace: add a --raw mode for --edit
Date: Tue, 24 Jun 2014 05:46:31 -0400
Message-ID: <20140624094631.GD14514@sigill.intra.peff.net>
References: <20140624094217.GA14216@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 11:46:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzNJF-0000TD-M7
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 11:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbaFXJqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 05:46:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:50138 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751475AbaFXJqd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 05:46:33 -0400
Received: (qmail 16552 invoked by uid 102); 24 Jun 2014 09:46:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Jun 2014 04:46:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jun 2014 05:46:31 -0400
Content-Disposition: inline
In-Reply-To: <20140624094217.GA14216@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252394>

One of the purposes of "git replace --edit" is to help a
user repair objects which are malformed or corrupted.
Usually we pretty-print trees with "ls-tree", which is much
easier to work with than the raw binary data.  However, some
forms of corruption break the tree-walker, in which case our
pretty-printing fails, rendering "--edit" useless for the
user.

This patch introduces a "--raw" option, which lets you edit
the binary data in these instances.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-replace.txt |  8 ++++++++
 builtin/replace.c             | 31 +++++++++++++++++++++----------
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 61461b9..089dcac 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -73,6 +73,14 @@ OPTIONS
 	newly created object. See linkgit:git-var[1] for details about
 	how the editor will be chosen.
 
+--raw::
+	When editing, provide the raw object contents rather than
+	pretty-printed ones. Currently this only affects trees, which
+	will be shown in their binary form. This is harder to work with,
+	but can help when repairing a tree that is so corrupted it
+	cannot be pretty-printed. Note that you may need to configure
+	your editor to cleanly read and write binary data.
+
 -l <pattern>::
 --list <pattern>::
 	List replace refs for objects that match the given pattern (or
diff --git a/builtin/replace.c b/builtin/replace.c
index 2584170..d1ea2c2 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -188,10 +188,12 @@ static int replace_object(const char *object_ref, const char *replace_ref, int f
 }
 
 /*
- * Write the contents of the object named by "sha1" to the file "filename",
- * pretty-printed for human editing based on its type.
+ * Write the contents of the object named by "sha1" to the file "filename".
+ * If "raw" is true, then the object's raw contents are printed according to
+ * "type". Otherwise, we pretty-print the contents for human editing.
  */
-static void export_object(const unsigned char *sha1, const char *filename)
+static void export_object(const unsigned char *sha1, enum object_type type,
+			  int raw, const char *filename)
 {
 	struct child_process cmd = { NULL };
 	int fd;
@@ -202,7 +204,10 @@ static void export_object(const unsigned char *sha1, const char *filename)
 
 	argv_array_push(&cmd.args, "--no-replace-objects");
 	argv_array_push(&cmd.args, "cat-file");
-	argv_array_push(&cmd.args, "-p");
+	if (raw)
+		argv_array_push(&cmd.args, typename(type));
+	else
+		argv_array_push(&cmd.args, "-p");
 	argv_array_push(&cmd.args, sha1_to_hex(sha1));
 	cmd.git_cmd = 1;
 	cmd.out = fd;
@@ -217,7 +222,7 @@ static void export_object(const unsigned char *sha1, const char *filename)
  * The sha1 of the written object is returned via sha1.
  */
 static void import_object(unsigned char *sha1, enum object_type type,
-			  const char *filename)
+			  int raw, const char *filename)
 {
 	int fd;
 
@@ -225,7 +230,7 @@ static void import_object(unsigned char *sha1, enum object_type type,
 	if (fd < 0)
 		die_errno("unable to open %s for reading", filename);
 
-	if (type == OBJ_TREE) {
+	if (!raw && type == OBJ_TREE) {
 		const char *argv[] = { "mktree", NULL };
 		struct child_process cmd = { argv };
 		struct strbuf result = STRBUF_INIT;
@@ -265,7 +270,7 @@ static void import_object(unsigned char *sha1, enum object_type type,
 	 */
 }
 
-static int edit_and_replace(const char *object_ref, int force)
+static int edit_and_replace(const char *object_ref, int force, int raw)
 {
 	char *tmpfile = git_pathdup("REPLACE_EDITOBJ");
 	enum object_type type;
@@ -281,10 +286,10 @@ static int edit_and_replace(const char *object_ref, int force)
 
 	check_ref_valid(old, prev, ref, sizeof(ref), force);
 
-	export_object(old, tmpfile);
+	export_object(old, type, raw, tmpfile);
 	if (launch_editor(tmpfile, NULL, NULL) < 0)
 		die("editing object file failed");
-	import_object(new, type, tmpfile);
+	import_object(new, type, raw, tmpfile);
 
 	free(tmpfile);
 
@@ -297,6 +302,7 @@ static int edit_and_replace(const char *object_ref, int force)
 int cmd_replace(int argc, const char **argv, const char *prefix)
 {
 	int force = 0;
+	int raw = 0;
 	const char *format = NULL;
 	enum {
 		MODE_UNSPECIFIED = 0,
@@ -310,6 +316,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete replace refs"), MODE_DELETE),
 		OPT_CMDMODE('e', "edit", &cmdmode, N_("edit existing object"), MODE_EDIT),
 		OPT_BOOL('f', "force", &force, N_("replace the ref if it exists")),
+		OPT_BOOL(0, "raw", &raw, N_("do not pretty-print contents for --edit")),
 		OPT_STRING(0, "format", &format, N_("format"), N_("use this format")),
 		OPT_END()
 	};
@@ -329,6 +336,10 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		usage_msg_opt("-f only makes sense when writing a replacement",
 			      git_replace_usage, options);
 
+	if (raw && cmdmode != MODE_EDIT)
+		usage_msg_opt("--raw only makes sense with --edit",
+			      git_replace_usage, options);
+
 	switch (cmdmode) {
 	case MODE_DELETE:
 		if (argc < 1)
@@ -346,7 +357,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		if (argc != 1)
 			usage_msg_opt("-e needs exactly one argument",
 				      git_replace_usage, options);
-		return edit_and_replace(argv[0], force);
+		return edit_and_replace(argv[0], force, raw);
 
 	case MODE_LIST:
 		if (argc > 1)
-- 
2.0.0.566.gfe3e6b2
