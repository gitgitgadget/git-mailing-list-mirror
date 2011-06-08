From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 22/48] merge-recursive: Fix sorting order and directory change assumptions
Date: Wed,  8 Jun 2011 01:30:52 -0600
Message-ID: <1307518278-23814-23-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:30:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDDL-0005pC-FG
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918Ab1FHH3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:29:41 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43667 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732Ab1FHH3k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:40 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so118978pzk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=JcbkoXNuRaPVHNFsa8cMp3AuPIcCGJUQwbB8b+F+Lbg=;
        b=lfLBOtyKwASnm8UkZQzg/Dz/bqnbLlc3StXMURxlFIyGWhlvM79Y4UUL0h76fmuaBm
         hRdHRkjxKUe8YgrVElGgXALX62OKTyTB4oS7pfB59dfNKyWiW5IN03pnYL/F7CAi23vc
         AARorAsmvg4RRrOkQdrFkrXVfsWKbhIgrldFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iFpfGmtpouVh/35+QTvKWcHaZ2miq7H1iRP7a6SoiYCp5ONQliMHem+EhwBw+sCoGZ
         baIvyu1GQvdCILiZqKj/V0aIRbRxEOIMXuBGmsVrXPkM5IubpeztKIa7YvaZOlV7l0zQ
         HgssXqkFNa15BO5pXzNQhCRPwB2L70hSZMa5s=
Received: by 10.142.66.12 with SMTP id o12mr123885wfa.219.1307518179778;
        Wed, 08 Jun 2011 00:29:39 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.37
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175305>

We cannot assume that directory/file conflicts will appear in sorted
order; for example, 'letters.txt' comes between 'letters' and
'letters/file'.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c   |   31 ++++++++++++++++++++++++++-----
 t/t6020-merge-df.sh |   26 ++++++++++++++++++--------
 2 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 4771fb4..ed1fdb2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -333,6 +333,28 @@ static struct string_list *get_unmerged(void)
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
@@ -345,11 +367,6 @@ static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
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
@@ -362,6 +379,10 @@ static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
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
1.7.6.rc0.62.g2d69f
