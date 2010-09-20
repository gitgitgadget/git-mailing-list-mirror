From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 34/37] merge_content(): Check whether D/F conflicts are still present
Date: Mon, 20 Sep 2010 02:29:07 -0600
Message-ID: <1284971350-30590-35-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblN-0006R4-Te
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954Ab0ITI2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:42 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37157 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919Ab0ITI2l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:41 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1071833pvg.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=uAKqm7PhQabRVV+YKaQbB4JdvIwoo+gM6h7LwzzABEY=;
        b=E6xRijfaTCxHk9a9t3U2vUML+pLi0UgMjgWc3roI28QItd4te9vchdb3NV9F9FiN2Y
         j4W1I100hCaOB7TRGE2vCNTShC64SumIEjKjorZ7fmOrQFmF9W3+/sk9FE7eWg6qhIsO
         +DbzJNUABUHapkrA/u316lGCNzGQK1hBEaYJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ljz2DjoAnSXnUnEZJq/YdsLB94261jTeI1hbFqH9OaFWcRkRM0evapcCT02k8PARSl
         4nYJgSBvouXEeIczHC8cltLJm37zUAmRDtAgb2OQy/K6l7DAMqKfnZPO3JJCiQox1jEk
         kf67k6ivdb4YgMAjWZ0bVR7QQb4uVIIIZ3iQM=
Received: by 10.142.185.4 with SMTP id i4mr6248176wff.258.1284971320811;
        Mon, 20 Sep 2010 01:28:40 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.38
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156582>

If all the paths below some directory involved in a D/F conflict were not
removed during the rest of the merge, then the contents of the file whose
path conflicted needs to be recorded in file with an alternative filename.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c       |   22 ++++++++++++++++++++--
 t/t6022-merge-rename.sh |    8 ++++----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 3cc5886..a971d59 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1193,6 +1193,8 @@ static int merge_content(struct merge_options *o,
 	const char *reason = "content";
 	struct merge_file_info mfi;
 	struct diff_filespec one, a, b;
+	struct stat st;
+	unsigned df_conflict_remains = 0;
 
 	if (!o_sha) {
 		reason = "add/add";
@@ -1207,7 +1209,13 @@ static int merge_content(struct merge_options *o,
 	b.mode = b_mode;
 
 	mfi = merge_file(o, &one, &a, &b, o->branch1, o->branch2);
-	if (mfi.clean && sha_eq(mfi.sha, a_sha) && mfi.mode == a.mode)
+	if (df_rename_conflict_branch &&
+	    lstat(path, &st) == 0 && S_ISDIR(st.st_mode)) {
+		df_conflict_remains = 1;
+	}
+
+	if (mfi.clean && !df_conflict_remains &&
+	    sha_eq(mfi.sha, a_sha) && mfi.mode == a.mode)
 		output(o, 3, "Skipped %s (merged same as existing)", path);
 	else
 		output(o, 2, "Auto-merging %s", path);
@@ -1219,7 +1227,17 @@ static int merge_content(struct merge_options *o,
 				reason, path);
 	}
 
-	update_file(o, mfi.clean, mfi.sha, mfi.mode, path);
+	if (df_conflict_remains) {
+		const char *new_path;
+		update_file_flags(o, mfi.sha, mfi.mode, path,
+				  o->call_depth || mfi.clean, 0);
+		new_path = unique_path(o, path, df_rename_conflict_branch);
+		mfi.clean = 0;
+		output(o, 1, "Adding as %s instead", new_path);
+		update_file_flags(o, mfi.sha, mfi.mode, new_path, 0, 1);
+	} else {
+		update_file(o, mfi.clean, mfi.sha, mfi.mode, path);
+	}
 	return mfi.clean;
 
 }
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 0b67002..422092e 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -394,7 +394,7 @@ test_expect_success 'Rename+D/F conflict; renamed file merges + dir not in way'
 	test_cmp expected dir
 '
 
-test_expect_failure 'Rename+D/F conflict; renamed file merges but dir in way' '
+test_expect_success 'Rename+D/F conflict; renamed file merges but dir in way' '
 	git reset --hard &&
 	rm -rf dir~* &&
 	git checkout -q renamed-file-has-no-conflicts^0 &&
@@ -415,7 +415,7 @@ test_expect_failure 'Rename+D/F conflict; renamed file merges but dir in way' '
 	test_cmp expected dir~HEAD
 '
 
-test_expect_failure 'Same as previous, but merged other way' '
+test_expect_success 'Same as previous, but merged other way' '
 	git reset --hard &&
 	rm -rf dir~* &&
 	git checkout -q dir-in-way^0 &&
@@ -471,7 +471,7 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge, dir not in
 	test_cmp expected dir
 '
 
-test_expect_failure 'Rename+D/F conflict; renamed file cannot merge and dir in the way' '
+test_expect_success 'Rename+D/F conflict; renamed file cannot merge and dir in the way' '
 	modify s/dir-not-in-way/dir-in-way/ expected &&
 
 	git reset --hard &&
@@ -509,7 +509,7 @@ cat >expected <<\EOF &&
 >>>>>>> renamed-file-has-conflicts
 EOF
 
-test_expect_failure 'Same as previous, but merged other way' '
+test_expect_success 'Same as previous, but merged other way' '
 	git reset --hard &&
 	rm -rf dir~* &&
 	git checkout -q dir-in-way^0 &&
-- 
1.7.3.271.g16009
