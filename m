From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] bisect: use a PRNG with a bias when skipping away from
	untestable commits
Date: Sat, 13 Jun 2009 07:21:06 +0200
Message-ID: <20090613052107.4190.71471.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 07:22:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFLhG-0004uJ-Q8
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 07:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbZFMFWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 01:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbZFMFWR
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 01:22:17 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:48724 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698AbZFMFWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 01:22:16 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 713FF4C802F;
	Sat, 13 Jun 2009 07:22:09 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 0BC094C8079;
	Sat, 13 Jun 2009 07:22:06 +0200 (CEST)
X-git-sha1: a1559db439f59cf44356d84ecd57a5ae6de8bae4 
X-Mailer: git-mail-commits v0.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121481>

Using a PRNG (pseudo random number generator) with a bias should be better
than alternating between 3 fixed ratios.

In repositories with many untestable commits it should prevent alternating
between areas where many commits are untestable. The bias should favor
commits that can give more information, so that the bisection process
should not loose much efficiency.

HPA suggested to use a PRNG and found that the best bias is to raise a
ratio between 0 and 1 given by the PRNG to the power 1.5.

An integer square root function is implemented to avoid including
<math.h> and linking with -lm.

A PRNG function is implemented to get the same number sequence on
different machines as suggested by "man 3 rand".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c                    |   50 +++++++++++++++++++++++++++++++++---------
 t/t6030-bisect-porcelain.sh |    4 +-
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/bisect.c b/bisect.c
index 6fdff05..095b55e 100644
--- a/bisect.c
+++ b/bisect.c
@@ -585,16 +585,49 @@ struct commit_list *filter_skipped(struct commit_list *list,
 	return filtered;
 }
 
-static struct commit_list *apply_skip_ratio(struct commit_list *list,
-					    int count,
-					    int skip_num, int skip_denom)
+#define PRN_MODULO 32768
+
+/*
+ * This is a pseudo random number generator based on "man 3 rand".
+ * It is not used properly because the seed is the argument and it
+ * is increased by one between each call, but that should not matter
+ * for this application.
+ */
+int get_prn(int count) {
+	count = count * 1103515245 + 12345;
+	return ((unsigned)(count/65536) % PRN_MODULO);
+}
+
+/*
+ * Custom integer square root from
+ * http://en.wikipedia.org/wiki/Integer_square_root
+ */
+static int sqrti(int val)
+{
+	float d, x = val;
+
+	if (val == 0)
+		return 0;
+
+	do {
+		float y = (x + (float)val / x) / 2;
+		d = (y > x) ? y - x : x - y;
+		x = y;
+	} while (d >= 0.5);
+
+	return (int)x;
+}
+
+static struct commit_list *skip_away(struct commit_list *list, int count)
 {
-	int index, i;
 	struct commit_list *cur, *previous;
+	int prn, index, i;
+
+	prn = get_prn(count);
+	index = (count * prn / PRN_MODULO) * sqrti(prn) / sqrti(PRN_MODULO);
 
 	cur = list;
 	previous = NULL;
-	index = count * skip_num / skip_denom;
 
 	for (i = 0; cur; cur = cur->next, i++) {
 		if (i == index) {
@@ -614,7 +647,6 @@ static struct commit_list *managed_skipped(struct commit_list *list,
 					   struct commit_list **tried)
 {
 	int count, skipped_first;
-	int skip_num, skip_denom;
 
 	*tried = NULL;
 
@@ -626,11 +658,7 @@ static struct commit_list *managed_skipped(struct commit_list *list,
 	if (!skipped_first)
 		return list;
 
-	/* Use alternatively 1/5, 2/5 and 3/5 as skip ratio. */
-	skip_num = count % 3 + 1;
-	skip_denom = 5;
-
-	return apply_skip_ratio(list, count, skip_num, skip_denom);
+	return skip_away(list, count);
 }
 
 static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 4556cdd..1315bab 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -563,8 +563,8 @@ test_expect_success 'skipping away from skipped commit' '
 	hash7=$(git rev-parse --verify HEAD) &&
 	test "$hash7" = "$HASH7" &&
         git bisect skip &&
-	hash3=$(git rev-parse --verify HEAD) &&
-	test "$hash3" = "$HASH3"
+	para3=$(git rev-parse --verify HEAD) &&
+	test "$para3" = "$PARA_HASH3"
 '
 
 #
-- 
1.6.3.GIT
