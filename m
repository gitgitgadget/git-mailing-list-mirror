From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 4/4] replace: add --edit option
Date: Thu, 6 Mar 2014 12:51:17 -0500
Message-ID: <20140306175117.GD30691@sigill.intra.peff.net>
References: <20140306174803.GA30486@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 06 18:51:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLcS3-0002uj-P6
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 18:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbaCFRvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 12:51:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:34195 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750972AbaCFRvT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 12:51:19 -0500
Received: (qmail 20948 invoked by uid 102); 6 Mar 2014 17:51:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Mar 2014 11:51:19 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Mar 2014 12:51:17 -0500
Content-Disposition: inline
In-Reply-To: <20140306174803.GA30486@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243528>

This allows you to run:

    git replace --edit SHA1

to get dumped in an editor with the contents of the object
for SHA1. The result is then read back in and used as a
"replace" object for SHA1. The writing/reading is
type-aware, so you get to edit "ls-tree" output rather than
the binary tree format.

Missing documentation and tests.

Signed-off-by: Jeff King <peff@peff.net>
---
Besides missing docs and tests, we might find that we want to factor the
code a little differently when we start adding other helpers (like
"--graft"). I will probably push this forward at some point, but I'm not
planning on working on it for the rest of the day, so if you want to
pick it up as a base in the meantime and try "--graft", "--env-filter",
or anything else clever on top, please go ahead.

 builtin/replace.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index a090302..3ed5f75 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -12,6 +12,7 @@
 #include "builtin.h"
 #include "refs.h"
 #include "parse-options.h"
+#include "run-command.h"
 
 static const char * const git_replace_usage[] = {
 	N_("git replace [-f] <object> <replacement>"),
@@ -176,6 +177,105 @@ static int replace_object(const char *object_ref, const char *replace_ref, int f
 	return replace_object_sha1(object_ref, object, replace_ref, repl, force);
 }
 
+/*
+ * Write the contents of the object named by "sha1" to the file "filename",
+ * pretty-printed for human editing based on its type.
+ */
+static void export_object(const unsigned char *sha1, const char *filename)
+{
+	const char *argv[] = { "cat-file", "-p", NULL, NULL };
+	struct child_process cmd = { argv };
+	int fd;
+
+	fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	if (fd < 0)
+		die_errno("unable to open %s for writing", filename);
+
+	argv[2] = sha1_to_hex(sha1);
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
@@ -184,11 +284,13 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
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
@@ -205,7 +307,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		usage_msg_opt("--format cannot be used when not listing",
 			      git_replace_usage, options);
 
-	if (force && cmdmode != MODE_REPLACE)
+	if (force && cmdmode != MODE_REPLACE && cmdmode != MODE_EDIT)
 		usage_msg_opt("-f only makes sense when writing a replacement",
 			      git_replace_usage, options);
 
@@ -222,6 +324,12 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
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
1.8.5.2.500.g8060133
