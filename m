From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 1/2] diff: move no-index detection to builtin/diff.c
Date: Sat, 14 Dec 2013 14:07:20 +0100
Message-ID: <1387026441-14539-1-git-send-email-t.gummerer@gmail.com>
References: <20131214004347.GZ2311@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 14:07:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrowH-0004Gm-2m
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 14:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480Ab3LNNHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Dec 2013 08:07:20 -0500
Received: from mail-bk0-f48.google.com ([209.85.214.48]:52308 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053Ab3LNNHT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 08:07:19 -0500
Received: by mail-bk0-f48.google.com with SMTP id r7so1751069bkg.35
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 05:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+3GFSbea33NDC7MF7mPKnvkfqhO4urWYhl44swIx/zc=;
        b=Wix/JPfwKJ9YspiJhln/Z61SPbqjlpZmaLY1n3BFD/lwYQPmiTD9LG+MfnUCz2PEw6
         GQLPPYWlClCEGeDlTFQF9+NCHK3gnOKCq8xVXTkzNCuxudQJ7Ef6Gxh4afyTsdvZBIjW
         gej96RdmwH8Fo/7YuN4tcZ+Cb8H5pibyYNe7vPZLw7AAv0DpEIBCYQtr/1a72tmFMl5+
         7nNVsAUJnLkdmOyeX2KjR6lLV24jzXaOMylIuuys1/WFhaqXHX/D3aPwAUL9R9D0ns6A
         lfmYmCtDWtpW2EJJbOxpP0TZ/D+TFJ/JlYgfNq7+eT+1i8912zy3Oge86+jBrqnh+IpD
         Nphg==
X-Received: by 10.204.101.199 with SMTP id d7mr1823522bko.18.1387026436755;
        Sat, 14 Dec 2013 05:07:16 -0800 (PST)
Received: from localhost ([2001:5c0:1400:a::103b])
        by mx.google.com with ESMTPSA id q5sm4778531bkr.5.2013.12.14.05.07.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Dec 2013 05:07:15 -0800 (PST)
X-Mailer: git-send-email 1.8.5.4.g8639e57
In-Reply-To: <20131214004347.GZ2311@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239306>

Currently the --no-index option is parsed in diff_no_index().  Move the
detection if a no-index diff should be executed to builtin/diff.c, where
we can use it for executing diff_no_index() conditionally.  This will
also allow us to execute other operations conditionally, which will be
done in the next patch.

There are no functional changes.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

Thanks Jonathan for reviewing the last round, this version addresses
those comments, fixing the error message when git diff --no-index is
run outside of a git directory and avoids some nesting as suggested.

 builtin/diff.c  | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 diff-no-index.c | 44 +-------------------------------------------
 diff.h          |  2 +-
 3 files changed, 52 insertions(+), 47 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index adb93a9..f49a938 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -16,6 +16,9 @@
 #include "submodule.h"
 #include "sha1-array.h"
 
+#define DIFF_NO_INDEX_EXPLICIT 1
+#define DIFF_NO_INDEX_IMPLICIT 2
+
 struct blobinfo {
 	unsigned char sha1[20];
 	const char *name;
@@ -257,7 +260,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	int blobs = 0, paths = 0;
 	const char *path = NULL;
 	struct blobinfo blob[2];
-	int nongit;
+	int nongit = 0, no_index = 0;
 	int result = 0;
 
 	/*
@@ -283,14 +286,58 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	 * Other cases are errors.
 	 */
 
+	/* Were we asked to do --no-index explicitly? */
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "--")) {
+			i++;
+			break;
+		}
+		if (!strcmp(argv[i], "--no-index"))
+			no_index = DIFF_NO_INDEX_EXPLICIT;
+		if (argv[i][0] != '-')
+			break;
+	}
+
 	prefix = setup_git_directory_gently(&nongit);
+	if (!no_index) {
+		/*
+		 * Treat git diff with at least one path outside of the
+		 * repo the same as if the command would have been executed
+		 * outside of a git repository.  In this case it behaves
+		 * the same way as "git diff --no-index <a> <b>", which acts
+		 * as a colourful "diff" replacement.
+		 */
+		if (nongit || ((argc == i + 2) &&
+			       (!path_inside_repo(prefix, argv[i]) ||
+				!path_inside_repo(prefix, argv[i + 1]))))
+			no_index = DIFF_NO_INDEX_IMPLICIT;
+	}
+
 	gitmodules_config();
 	git_config(git_diff_ui_config, NULL);
 
 	init_revisions(&rev, prefix);
 
-	/* If this is a no-index diff, just run it and exit there. */
-	diff_no_index(&rev, argc, argv, nongit, prefix);
+	if (no_index && argc != i + 2) {
+		if (no_index == DIFF_NO_INDEX_IMPLICIT) {
+			/*
+			 * There was no --no-index and there were not two
+			 * paths. It is possible that the user intended
+			 * to do an inside-repository operation.
+			 */
+			fprintf(stderr, "Not a git repository\n");
+			fprintf(stderr,
+				"To compare two paths outside a working tree:\n");
+		}
+		/* Give the usage message for non-repository usage and exit. */
+		usagef("git diff %s <path> <path>",
+		       no_index == DIFF_NO_INDEX_EXPLICIT ?
+		       "--no-index" : "[--no-index]");
+
+	}
+	if (no_index)
+		/* If this is a no-index diff, just run it and exit there. */
+		diff_no_index(&rev, argc, argv, prefix);
 
 	/* Otherwise, we are doing the usual "git" diff */
 	rev.diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;
diff --git a/diff-no-index.c b/diff-no-index.c
index 00a8eef..33e5982 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -183,54 +183,12 @@ static int queue_diff(struct diff_options *o,
 
 void diff_no_index(struct rev_info *revs,
 		   int argc, const char **argv,
-		   int nongit, const char *prefix)
+		   const char *prefix)
 {
 	int i, prefixlen;
-	int no_index = 0;
 	unsigned deprecated_show_diff_q_option_used = 0;
 	const char *paths[2];
 
-	/* Were we asked to do --no-index explicitly? */
-	for (i = 1; i < argc; i++) {
-		if (!strcmp(argv[i], "--")) {
-			i++;
-			break;
-		}
-		if (!strcmp(argv[i], "--no-index"))
-			no_index = 1;
-		if (argv[i][0] != '-')
-			break;
-	}
-
-	if (!no_index && !nongit) {
-		/*
-		 * Inside a git repository, without --no-index.  Only
-		 * when a path outside the repository is given,
-		 * e.g. "git diff /var/tmp/[12]", or "git diff
-		 * Makefile /var/tmp/Makefile", allow it to be used as
-		 * a colourful "diff" replacement.
-		 */
-		if ((argc != i + 2) ||
-		    (path_inside_repo(prefix, argv[i]) &&
-		     path_inside_repo(prefix, argv[i+1])))
-			return;
-	}
-	if (argc != i + 2) {
-		if (!no_index) {
-			/*
-			 * There was no --no-index and there were not two
-			 * paths. It is possible that the user intended
-			 * to do an inside-repository operation.
-			 */
-			fprintf(stderr, "Not a git repository\n");
-			fprintf(stderr,
-				"To compare two paths outside a working tree:\n");
-		}
-		/* Give the usage message for non-repository usage and exit. */
-		usagef("git diff %s <path> <path>",
-		       no_index ? "--no-index" : "[--no-index]");
-	}
-
 	diff_setup(&revs->diffopt);
 	for (i = 1; i < argc - 2; ) {
 		int j;
diff --git a/diff.h b/diff.h
index e342325..de105d3 100644
--- a/diff.h
+++ b/diff.h
@@ -330,7 +330,7 @@ extern int diff_flush_patch_id(struct diff_options *, unsigned char *);
 
 extern int diff_result_code(struct diff_options *, int);
 
-extern void diff_no_index(struct rev_info *, int, const char **, int, const char *);
+extern void diff_no_index(struct rev_info *, int, const char **, const char *);
 
 extern int index_differs_from(const char *def, int diff_flags);
 
-- 
1.8.5.4.g8639e57
