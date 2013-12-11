From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 1/2] diff: move no-index detection to builtin/diff.c
Date: Wed, 11 Dec 2013 10:58:42 +0100
Message-ID: <1386755923-22132-1-git-send-email-t.gummerer@gmail.com>
References: <20131210181655.GB2311@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 10:59:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqgZH-0006FF-QY
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 10:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116Ab3LKJ6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 04:58:53 -0500
Received: from mail-qc0-f176.google.com ([209.85.216.176]:57571 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab3LKJ6u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 04:58:50 -0500
Received: by mail-qc0-f176.google.com with SMTP id i8so4767019qcq.21
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 01:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0x0lX3csVlhyllqBC2rsGpJvJAsca2WyFtAtlhBwgc8=;
        b=RiYEdoo8y6QvT7AYXLDUGcsNAGMR508/RDaiuVkpbJ+7zfWqHFnmy7IR6WwB7EmFjH
         EZ74JtO2SesWl6Fpe1AqCsT0ltJox4o9+OUuThIf8e0sWmKwMEEcYMtjHK18GTqqow34
         Bu7NEshyqm1V4KbiU6N66VrVHlqddGudftNV7iVqkv9upbgdktkrC8LdbBScqrANUyUJ
         /ZE5FfuV/IkGRJkcRRooFZWC9jqjh+GS8YMIoGMoKKzBnGCGCsF01hVq/VMZcOy8Fu9S
         ptdXdslA6Tt10PiLTCfzJVNs/R+4pgcNR5l2wEYaKLqrjQPbyon0vKRNyhXNLKV1gRS9
         HUMw==
X-Received: by 10.224.94.8 with SMTP id x8mr889984qam.1.1386755929400;
        Wed, 11 Dec 2013 01:58:49 -0800 (PST)
Received: from localhost ([2001:5c0:1400:a::589])
        by mx.google.com with ESMTPSA id i7sm50962509qeo.7.2013.12.11.01.58.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2013 01:58:48 -0800 (PST)
X-Mailer: git-send-email 1.8.5.4.g8639e57
In-Reply-To: <20131210181655.GB2311@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239181>

Currently the --no-index option is parsed in diff_no_index().  Move the
detection if a no-index diff should be executed to builtin/diff.c, where
we can use it for executing diff_no_index() conditionally.  This will
also allow us to execute other operations conditionally, which will be
done in the next patch.

There are no functional changes.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

Thanks to Jonathan for the suggestions in the previous round.
Since the last roud I've made the no_index detection easier to read,
and use two different values for no_index to indicate whether the
no_index option is given explicitly, or if a no_index diff should be
executed implicitly.

 builtin/diff.c  | 52 +++++++++++++++++++++++++++++++++++++++++++++++++---
 diff-no-index.c | 44 +-------------------------------------------
 diff.h          |  2 +-
 3 files changed, 51 insertions(+), 47 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index adb93a9..da69e4a 100644
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
@@ -283,14 +286,57 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
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
+	/*
+	 * Treat git diff with at least one path outside of the
+	 * repo the same as if the command would have been executed
+	 * outside of a git repository.  In this case it behaves
+	 * the same way as "git diff --no-index <a> <b>", which acts
+	 * as a colourful "diff" replacement.
+	 */
+	if (nongit || ((argc == i + 2) &&
+		       (!path_inside_repo(prefix, argv[i]) ||
+			!path_inside_repo(prefix, argv[i + 1]))))
+		no_index = DIFF_NO_INDEX_IMPLICIT;
+
 	gitmodules_config();
 	git_config(git_diff_ui_config, NULL);
 
 	init_revisions(&rev, prefix);
 
-	/* If this is a no-index diff, just run it and exit there. */
-	diff_no_index(&rev, argc, argv, nongit, prefix);
+	if (no_index) {
+		if (argc != i + 2) {
+			if (no_index == DIFF_NO_INDEX_IMPLICIT) {
+				/*
+				 * There was no --no-index and there were not two
+				 * paths. It is possible that the user intended
+				 * to do an inside-repository operation.
+				 */
+				fprintf(stderr, "Not a git repository\n");
+				fprintf(stderr,
+					"To compare two paths outside a working tree:\n");
+			}
+			/* Give the usage message for non-repository usage and exit. */
+			usagef("git diff %s <path> <path>",
+			       no_index == DIFF_NO_INDEX_EXPLICIT ?
+					"--no-index" : "[--no-index]");
+
+		}
+		/* If this is a no-index diff, just run it and exit there. */
+		diff_no_index(&rev, argc, argv, prefix);
+	}
 
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
