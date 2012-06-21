From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 1/2] diff: handle relative paths in no-index
Date: Thu, 21 Jun 2012 14:09:50 -0400
Message-ID: <1340302191-23444-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, peff@peff.net
X-From: git-owner@vger.kernel.org Thu Jun 21 20:10:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shlpu-0002s6-RE
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 20:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760097Ab2FUSK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 14:10:26 -0400
Received: from mail-yw0-f51.google.com ([209.85.213.51]:52221 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760093Ab2FUSKY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 14:10:24 -0400
Received: by yhnn12 with SMTP id n12so900774yhn.10
        for <git@vger.kernel.org>; Thu, 21 Jun 2012 11:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ypoarJlDo4ipaKAns+VX//65WBdu5fDsmqX132KtzPg=;
        b=SLgdtNJ4HQ/bJVDCWF5KPXVRp1SKKlAvj5yIZ95nDrzrbbAUBcZeutEOgR6Bi+5/SW
         //0Cc3duRU9xi/WF7MjD6RUbtsCttWYB6G6t06eYgvpxmv4SemKbxn9m/EFCd7aq/AOD
         t8YBwoyWL0idM/l2SlUNnHxgtm6isi0FDZAbqm2KAV3XPw5RV+1nDQnyRfME3H2bgGf6
         UmWi+4EsO+VEwnFjXuiB8DYi8hdLB0IMFVUrLqScLZekPXtFWZzGYJMmYyLJN4/YOoX4
         Co8QBkqAwCkmlLfNcwd9Gumw75OqvnJPu9jAnLTL3dAwFWSNiKNFRsr8zCGPOqyJGQR7
         gqVQ==
Received: by 10.42.10.73 with SMTP id p9mr13873705icp.43.1340302223571;
        Thu, 21 Jun 2012 11:10:23 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id qo3sm34285598igc.8.2012.06.21.11.10.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jun 2012 11:10:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3.gf4ddae1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200412>

From: Jeff King <peff@peff.net>

When diff-no-index is given a relative path to a file outside the
repository, it aborts with error. However, if the file is given
using an absolute path, the diff runs as expected. The two cases
should be treated the same.

Tests and commit message by Tim Henigan.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

Jeff King implemented these changes as part of a discussion on the list.
He gave me permission to post to them as a patch on his behalf [1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/200160/focus=200301


 cache.h                  |  1 +
 diff-no-index.c          | 21 ++-------------------
 setup.c                  | 24 ++++++++++++++++++++++--
 t/t4053-diff-no-index.sh | 15 ++++++++++++++-
 4 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/cache.h b/cache.h
index 06413e1..0bd14ca 100644
--- a/cache.h
+++ b/cache.h
@@ -411,6 +411,7 @@ extern const char *prefix_filename(const char *prefix, int len, const char *path
 extern int check_filename(const char *prefix, const char *name);
 extern void verify_filename(const char *prefix, const char *name);
 extern void verify_non_filename(const char *prefix, const char *name);
+extern int path_inside_repo(const char *prefix, const char *path);
 
 #define INIT_DB_QUIET 0x0001
 
diff --git a/diff-no-index.c b/diff-no-index.c
index f0b0010..e6b9952 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -151,23 +151,6 @@ static int queue_diff(struct diff_options *o,
 	}
 }
 
-static int path_outside_repo(const char *path)
-{
-	const char *work_tree;
-	size_t len;
-
-	if (!is_absolute_path(path))
-		return 0;
-	work_tree = get_git_work_tree();
-	if (!work_tree)
-		return 1;
-	len = strlen(work_tree);
-	if (strncmp(path, work_tree, len) ||
-	    (path[len] != '\0' && path[len] != '/'))
-		return 1;
-	return 0;
-}
-
 void diff_no_index(struct rev_info *revs,
 		   int argc, const char **argv,
 		   int nongit, const char *prefix)
@@ -197,8 +180,8 @@ void diff_no_index(struct rev_info *revs,
 		 * a colourful "diff" replacement.
 		 */
 		if ((argc != i + 2) ||
-		    (!path_outside_repo(argv[i]) &&
-		     !path_outside_repo(argv[i+1])))
+		    (path_inside_repo(prefix, argv[i]) &&
+		     path_inside_repo(prefix, argv[i+1])))
 			return;
 	}
 	if (argc != i + 2)
diff --git a/setup.c b/setup.c
index 731851a..2cfa037 100644
--- a/setup.c
+++ b/setup.c
@@ -4,7 +4,7 @@
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 
-char *prefix_path(const char *prefix, int len, const char *path)
+static char *prefix_path_gently(const char *prefix, int len, const char *path)
 {
 	const char *orig = path;
 	char *sanitized;
@@ -31,7 +31,8 @@ char *prefix_path(const char *prefix, int len, const char *path)
 		if (strncmp(sanitized, work_tree, len) ||
 		    (len > root_len && sanitized[len] != '\0' && sanitized[len] != '/')) {
 		error_out:
-			die("'%s' is outside repository", orig);
+			free(sanitized);
+			return NULL;
 		}
 		if (sanitized[len] == '/')
 			len++;
@@ -40,6 +41,25 @@ char *prefix_path(const char *prefix, int len, const char *path)
 	return sanitized;
 }
 
+char *prefix_path(const char *prefix, int len, const char *path)
+{
+	char *r = prefix_path_gently(prefix, len, path);
+	if (!r)
+		die("'%s' is outside repository", path);
+	return r;
+}
+
+int path_inside_repo(const char *prefix, const char *path)
+{
+	int len = prefix ? strlen(prefix) : 0;
+	char *r = prefix_path_gently(prefix, len, path);
+	if (r) {
+		free(r);
+		return 1;
+	}
+	return 0;
+}
+
 int check_filename(const char *prefix, const char *arg)
 {
 	const char *name;
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 4dc8c67..979e983 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -8,7 +8,12 @@ test_expect_success 'setup' '
 	mkdir a &&
 	mkdir b &&
 	echo 1 >a/1 &&
-	echo 2 >a/2
+	echo 2 >a/2 &&
+	git init repo &&
+	echo 1 >repo/a &&
+	mkdir -p non/git &&
+	echo 1 >non/git/a &&
+	echo 1 >non/git/b
 '
 
 test_expect_success 'git diff --no-index directories' '
@@ -16,4 +21,12 @@ test_expect_success 'git diff --no-index directories' '
 	test $? = 1 && test_line_count = 14 cnt
 '
 
+test_expect_success 'git diff --no-index relative path outside repo' '
+	(
+		cd repo &&
+		test_expect_code 0 git diff --no-index a ../non/git/a &&
+		test_expect_code 0 git diff --no-index ../non/git/a ../non/git/b
+	)
+'
+
 test_done
-- 
1.7.11.3.gf4ddae1
