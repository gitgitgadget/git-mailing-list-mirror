From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 52/56] merge-recursive: Fix spurious 'refusing to lose untracked file...' messages
Date: Thu, 11 Aug 2011 23:20:25 -0600
Message-ID: <1313126429-17368-53-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:23:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkD5-0005ix-TK
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475Ab1HLFWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:22:31 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39648 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754409Ab1HLFW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:22:27 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so835125iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LGz+N8ybxnA/lFUPzv4YqF8wsPejwIkX5FbJKR/4HpE=;
        b=g0nCNm8FK/2dkCqTwZD4oKmtf368pW3AXD9QwX4inXQ/Jv0mMHm862xqJEr5W70RVj
         Rh/5eUi6YQ1UCHGaepnMC8dSN3I8VvXmwIPJwJ8PU2l6avkfFjqbLw7i2rvRurgTUXAy
         Z8wpjI8lGzUXrUD6iUUSgJcCIEt5L11+rtuQ4=
Received: by 10.231.115.36 with SMTP id g36mr1171687ibq.3.1313126547190;
        Thu, 11 Aug 2011 22:22:27 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.22.25
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:22:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179210>

Calling update_stages() before update_file() can sometimes result in git
thinking the file being updated is untracked (whenever update_stages
moves it to stage 3).  Reverse the call order, and add a big comment to
update_stages to hopefully prevent others from making the same mistake.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Completely new patch (about a problem that existed previous to v1, but which
I hadn't noticed).

 merge-recursive.c       |   34 ++++++++++++++++++++--------------
 t/t6022-merge-rename.sh |    2 +-
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 05c8aa0..b2deb53 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -528,6 +528,15 @@ static int update_stages(const char *path, const struct diff_filespec *o,
 			 const struct diff_filespec *a,
 			 const struct diff_filespec *b)
 {
+
+	/*
+	 * NOTE: It is usually a bad idea to call update_stages on a path
+	 * before calling update_file on that same path, since it can
+	 * sometimes lead to spurious "refusing to lose untracked file..."
+	 * messages from update_file (via make_room_for path via
+	 * would_lose_untracked).  Instead, reverse the order of the calls
+	 * (executing update_file first and then update_stages).
+	 */
 	int clear = 1;
 	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_SKIP_DFCHECK;
 	if (clear)
@@ -1041,7 +1050,6 @@ static void conflict_rename_delete(struct merge_options *o,
 {
 	const struct diff_filespec *orig = pair->one;
 	const struct diff_filespec *dest = pair->two;
-	const char *path;
 	const unsigned char *a_sha = NULL;
 	const unsigned char *b_sha = NULL;
 	int a_mode = 0;
@@ -1055,22 +1063,21 @@ static void conflict_rename_delete(struct merge_options *o,
 		b_mode = dest->mode;
 	}
 
+	handle_change_delete(o,
+			     o->call_depth ? orig->path : dest->path,
+			     orig->sha1, orig->mode,
+			     a_sha, a_mode,
+			     b_sha, b_mode,
+			     "rename", "renamed");
+
 	if (o->call_depth) {
 		remove_file_from_cache(dest->path);
-		path = orig->path;
 	} else {
-		path = dest->path;
 		update_stages(dest->path, NULL,
 			      rename_branch == o->branch1 ? dest : NULL,
 			      rename_branch == o->branch1 ? NULL : dest);
 	}
 
-	handle_change_delete(o,
-			     path,
-			     orig->sha1, orig->mode,
-			     a_sha, a_mode,
-			     b_sha, b_mode,
-			     "rename", "renamed");
 }
 
 static struct diff_filespec *filespec_from_entry(struct diff_filespec *target,
@@ -1108,11 +1115,6 @@ static void handle_file(struct merge_options *o,
 	}
 
 	add = filespec_from_entry(&other, dst_entry, stage ^ 1);
-	if (stage == 2)
-		update_stages(rename->path, NULL, rename, add);
-	else
-		update_stages(rename->path, NULL, add, rename);
-
 	if (add) {
 		char *add_name = unique_path(o, rename->path, other_branch);
 		update_file(o, 0, add->sha1, add->mode, add_name);
@@ -1127,6 +1129,10 @@ static void handle_file(struct merge_options *o,
 		}
 	}
 	update_file(o, 0, rename->sha1, rename->mode, dst_name);
+	if (stage == 2)
+		update_stages(rename->path, NULL, rename, add);
+	else
+		update_stages(rename->path, NULL, add, rename);
 
 	if (dst_name != rename->path)
 		free(dst_name);
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 0fd2b0a..8f75762 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -787,7 +787,7 @@ test_expect_success 'setup spurious "refusing to lose untracked" message' '
 	git commit -mC
 '
 
-test_expect_failure 'no spurious "refusing to lose untracked" message' '
+test_expect_success 'no spurious "refusing to lose untracked" message' '
 	git checkout master^0 &&
 	test_must_fail git merge rename^0 2>errors.txt &&
 	! grep "refusing to lose untracked file" errors.txt
-- 
1.7.6.100.gac5c1
