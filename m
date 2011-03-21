From: Elijah Newren <newren@gmail.com>
Subject: [WIP PATCH 05/10] merge-recursive: Fix sorting order and directory change assumptions
Date: Mon, 21 Mar 2011 12:30:59 -0600
Message-ID: <1300732264-9638-6-git-send-email-newren@gmail.com>
References: <1300732264-9638-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 19:25:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1jml-0000RW-CZ
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 19:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138Ab1CUSYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 14:24:50 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47678 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab1CUSYr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 14:24:47 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so5223921vxi.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 11:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=QK4GuF/+qwIhvpsL5aXcC/2JAbGREGW3c73+67SocNo=;
        b=NCqDvIMbXwmyN8eCb5pxml/rSbNNfaOOirrbY6G5GHL8rb/KythXAj6XMHpW359eSH
         96JEs6EKU/5Osq93H116FtcKUpUbuy5fNPrY1G/NVNQ9wfloKb99rfkeuxjj0fLafPDc
         pxtJVm8gO3CxmfXKnRvtMtlhb7QLdy2dmJufY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NlqYEO4e9TY+f2z1vffR/9zS9Giyxn+qOHLitBI+dLI4Rv4Oy1z6bFNqAzAhPcOLW8
         SogPVC9IXOk3fxHAOWfv/aN/bvKh0p+VoV1k7XVepvONv0lINx8nZvN+NiX5Stw6n9NI
         6KmKP0QIqHAh3HLIsTdbNfVQxts3Ck2gI7AyI=
Received: by 10.220.168.198 with SMTP id v6mr1197716vcy.75.1300731886857;
        Mon, 21 Mar 2011 11:24:46 -0700 (PDT)
Received: from localhost6.localdomain6 (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id b6sm1507291vci.0.2011.03.21.11.24.44
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 11:24:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.120.g38a18
In-Reply-To: <1300732264-9638-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169628>

As pointed out in the review of my earlier series, we cannot assume that
directory/file conflicts will appear in sorted order; for example,
'letters.txt' comes between 'letters' and 'letters/file'.

Also, we should not make changes to the working directory when merging
merge-bases, so removing files to make room for directories of d/f
conflicts should be skipped in such cases.

(These changes were made last September/October, but were mixed in with
an update of my series that I never got around to resubmitting.  Now that
the original series was accepted, I split these changes back out.)
---
 merge-recursive.c   |   38 +++++++++++++++++++++++++++++++++-----
 t/t6020-merge-df.sh |   26 ++++++++++++++++++--------
 2 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1da385c..7a04ca7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -344,6 +344,28 @@ static struct string_list *get_unmerged(void)
 	return unmerged;
 }
 
+static int string_list_df_name_compare(const void *a, const void *b)
+{
+	const struct string_list_item *one = a;
+	const struct string_list_item *two = b;
+	/*
+	 * Here we only care that entries for D/F conflicts are
+	 * adjacent, in particular with the file of the D/F conflict
+	 * appearing before files below the corresponding directory.
+	 * The order of the rest of the list is irrelevant for us.
+	 *
+	 * To achieve this, we sort with df_name_compare and provide
+	 * the mode S_IFDIR so that D/F conflicts will sort correctly.
+	 * We use the mode S_IFDIR for everything else for simplicity,
+	 * since in other cases any changes in their order due to
+	 * sorting cause no problems for us.
+	 */
+	return df_name_compare(one->string, strlen(one->string), S_IFDIR,
+			       two->string, strlen(two->string), S_IFDIR);
+}
+
+
+
 static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
 						      struct string_list *entries)
 {
@@ -356,17 +378,23 @@ static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
 	 * otherwise, if the file is not supposed to be removed by the
 	 * merge, the contents of the file will be placed in another
 	 * unique filename.
-	 *
-	 * NOTE: This function relies on the fact that entries for a
-	 * D/F conflict will appear adjacent in the index, with the
-	 * entries for the file appearing before entries for paths
-	 * below the corresponding directory.
 	 */
 	const char *last_file = NULL;
 	int last_len = 0;
 	struct stage_data *last_e;
 	int i;
 
+	/*
+	 * If we're merging merge-bases, we don't want to bother with
+	 * any working directory changes.
+	 */
+	if (o->call_depth)
+		return;
+
+	/* Ensure D/F conflicts are adjacent in the entries list. */
+	qsort(entries->items, entries->nr, sizeof(*entries->items),
+	      string_list_df_name_compare);
+
 	for (i = 0; i < entries->nr; i++) {
 		const char *path = entries->items[i].string;
 		int len = strlen(path);
diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
index eec8f4e..27c3d73 100755
--- a/t/t6020-merge-df.sh
+++ b/t/t6020-merge-df.sh
@@ -59,15 +59,19 @@ test_expect_success 'setup modify/delete + directory/file conflict' '
 	git add letters &&
 	git commit -m initial &&
 
+	# Throw in letters.txt for sorting order fun
+	# ("letters.txt" sorts between "letters" and "letters/file")
 	echo i >>letters &&
-	git add letters &&
+	echo "version 2" >letters.txt &&
+	git add letters letters.txt &&
 	git commit -m modified &&
 
 	git checkout -b delete HEAD^ &&
 	git rm letters &&
 	mkdir letters &&
 	>letters/file &&
-	git add letters &&
+	echo "version 1" >letters.txt &&
+	git add letters letters.txt &&
 	git commit -m deleted
 '
 
@@ -75,25 +79,31 @@ test_expect_success 'modify/delete + directory/file conflict' '
 	git checkout delete^0 &&
 	test_must_fail git merge modify &&
 
-	test 3 = $(git ls-files -s | wc -l) &&
-	test 2 = $(git ls-files -u | wc -l) &&
-	test 1 = $(git ls-files -o | wc -l) &&
+	test 5 -eq $(git ls-files -s | wc -l) &&
+	test 4 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
 
 	test -f letters/file &&
+	test -f letters.txt &&
 	test -f letters~modify
 '
 
 test_expect_success 'modify/delete + directory/file conflict; other way' '
+	# Yes, we really need the double reset since "letters" appears as
+	# both a file and a directory.
+	git reset --hard &&
 	git reset --hard &&
 	git clean -f &&
 	git checkout modify^0 &&
+
 	test_must_fail git merge delete &&
 
-	test 3 = $(git ls-files -s | wc -l) &&
-	test 2 = $(git ls-files -u | wc -l) &&
-	test 1 = $(git ls-files -o | wc -l) &&
+	test 5 -eq $(git ls-files -s | wc -l) &&
+	test 4 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
 
 	test -f letters/file &&
+	test -f letters.txt &&
 	test -f letters~HEAD
 '
 
-- 
1.7.4
