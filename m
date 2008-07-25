From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/6] archive: add write_archive()
Date: Fri, 25 Jul 2008 12:41:21 +0200
Message-ID: <1216982486-5887-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 12:50:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMKse-0001aq-SV
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 12:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922AbYGYKte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 06:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754104AbYGYKte
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 06:49:34 -0400
Received: from india601.server4you.de ([85.25.151.105]:55539 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629AbYGYKtd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 06:49:33 -0400
Received: by india601.server4you.de (Postfix, from userid 1000)
	id 44DCF2F8105; Fri, 25 Jul 2008 12:41:26 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90026>

Both archive and upload-archive have to parse command line arguments and
then call the archiver specific write function.  Move the duplicate code
to a new function, write_archive().

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive.c                |   18 ++++++++++++++++++
 archive.h                |    1 +
 builtin-archive.c        |   13 +------------
 builtin-upload-archive.c |   10 +---------
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/archive.c b/archive.c
index b8b45ba..75eb257 100644
--- a/archive.c
+++ b/archive.c
@@ -155,3 +155,21 @@ int write_archive_entries(struct archiver_args *args,
 		err = 0;
 	return err;
 }
+
+int write_archive(int argc, const char **argv, const char *prefix,
+		int setup_prefix)
+{
+	const struct archiver *ar = NULL;
+	struct archiver_args args;
+	int tree_idx;
+
+	tree_idx = parse_archive_args(argc, argv, &ar, &args);
+	if (setup_prefix && prefix == NULL)
+		prefix = setup_git_directory();
+
+	argv += tree_idx;
+	parse_treeish_arg(argv, &args, prefix);
+	parse_pathspec_arg(argv + 1, &args);
+
+	return ar->write_archive(&args);
+}
diff --git a/archive.h b/archive.h
index 4a02371..6b5fe5a 100644
--- a/archive.h
+++ b/archive.h
@@ -41,5 +41,6 @@ extern int write_tar_archive(struct archiver_args *);
 extern int write_zip_archive(struct archiver_args *);
 
 extern int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
+extern int write_archive(int argc, const char **argv, const char *prefix, int setup_prefix);
 
 #endif	/* ARCHIVE_H */
diff --git a/builtin-archive.c b/builtin-archive.c
index df97724..502b339 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -232,9 +232,6 @@ static const char *extract_remote_arg(int *ac, const char **av)
 
 int cmd_archive(int argc, const char **argv, const char *prefix)
 {
-	const struct archiver *ar = NULL;
-	struct archiver_args args;
-	int tree_idx;
 	const char *remote = NULL;
 
 	remote = extract_remote_arg(&argc, argv);
@@ -243,13 +240,5 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
 
-	tree_idx = parse_archive_args(argc, argv, &ar, &args);
-	if (prefix == NULL)
-		prefix = setup_git_directory();
-
-	argv += tree_idx;
-	parse_treeish_arg(argv, &args, prefix);
-	parse_pathspec_arg(argv + 1, &args);
-
-	return ar->write_archive(&args);
+	return write_archive(argc, argv, prefix, 1);
 }
diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index 13a6c62..cc37b36 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -19,12 +19,9 @@ static const char lostchild[] =
 
 static int run_upload_archive(int argc, const char **argv, const char *prefix)
 {
-	const struct archiver *ar;
-	struct archiver_args args;
 	const char *sent_argv[MAX_ARGS];
 	const char *arg_cmd = "argument ";
 	char *p, buf[4096];
-	int treeish_idx;
 	int sent_argc;
 	int len;
 
@@ -66,12 +63,7 @@ static int run_upload_archive(int argc, const char **argv, const char *prefix)
 	sent_argv[sent_argc] = NULL;
 
 	/* parse all options sent by the client */
-	treeish_idx = parse_archive_args(sent_argc, sent_argv, &ar, &args);
-
-	parse_treeish_arg(sent_argv + treeish_idx, &args, prefix);
-	parse_pathspec_arg(sent_argv + treeish_idx + 1, &args);
-
-	return ar->write_archive(&args);
+	return write_archive(sent_argc, sent_argv, prefix, 0);
 }
 
 static void error_clnt(const char *fmt, ...)
-- 
1.6.0.rc0.42.g186458
