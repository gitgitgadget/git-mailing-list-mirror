From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 23/56] merge-recursive: Fix sorting order and directory change assumptions
Date: Thu, 11 Aug 2011 23:19:56 -0600
Message-ID: <1313126429-17368-24-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkBn-00051N-1S
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513Ab1HLFVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:25 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60966 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669Ab1HLFVV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:21 -0400
Received: by ywf7 with SMTP id 7so1758906ywf.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=w5pN7c5ywiEUEOEnsLImdXxTvdw4kqUVi2DV7ekB7VI=;
        b=P/iOcfz6zTN8kiMEoLruP733GBCsM07E2mrvWETgQXAvZgAO1SS9VF2eSCb6pQTpUI
         msPZAQyhuXFwDCZlMNcQEDvY6F9nC6zJV7r/g0kNWFIMx/2UYpzacUstfo6+RRGEkeCS
         +zxGo/cifsDpwFt7VlZy+/iTNkIiPY8ZmqZHA=
Received: by 10.42.150.66 with SMTP id z2mr490240icv.383.1313126480622;
        Thu, 11 Aug 2011 22:21:20 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.18
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179187>

We cannot assume that directory/file conflicts will appear in sorted
order; for example, 'letters.txt' comes between 'letters' and
'letters/file'.

Thanks to Johannes for a pointer about qsort stability issues with
Windows and suggested code change.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Changes since v1: Mentioned Johannes' pointer and squashed in his
  patch that Junio had appended to the end of the en/merge-recursive
  series.  Added his s-o-b because of that.

 merge-recursive.c   |   40 +++++++++++++++++++++++++++++++++++-----
 t/t6020-merge-df.sh |   26 ++++++++++++++++++--------
 2 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 85620f7..76b895f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -333,6 +333,37 @@ static struct string_list *get_unmerged(void)
 	return unmerged;
 }
 
+static int string_list_df_name_compare(const void *a, const void *b)
+{
+	const struct string_list_item *one = a;
+	const struct string_list_item *two = b;
+	int onelen = strlen(one->string);
+	int twolen = strlen(two->string);
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
+	int cmp = df_name_compare(one->string, onelen, S_IFDIR,
+				  two->string, twolen, S_IFDIR);
+	/*
+	 * Now that 'foo' and 'foo/bar' compare equal, we have to make sure
+	 * that 'foo' comes before 'foo/bar'.
+	 */
+	if (cmp)
+		return cmp;
+	return onelen - twolen;
+}
+
+
+
 static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
 						      struct string_list *entries)
 {
@@ -345,11 +376,6 @@ static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
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
@@ -362,6 +388,10 @@ static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
 	if (o->call_depth)
 		return;
 
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
1.7.6.100.gac5c1
