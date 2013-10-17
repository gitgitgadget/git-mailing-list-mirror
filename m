From: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
Subject: [PATCH] diffcore-rename.c: Estimate filename similarity for rename detection
Date: Thu, 17 Oct 2013 12:20:13 +0300
Message-ID: <7658EED3-641E-4AE7-A691-0399ED14D298@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 17 11:20:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWjkk-0006hg-NN
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 11:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981Ab3JQJUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 05:20:16 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:47669 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab3JQJUP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Oct 2013 05:20:15 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so1676022lbh.0
        for <git@vger.kernel.org>; Thu, 17 Oct 2013 02:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=3nRB8bKjTWpHApK3J2TQWR56DWZSyNJdth7paiKNRq8=;
        b=uZmQPoM4gVkreWe0E8WTBhWNQW5ApZ5rHozbtU6fQv4MFOPGZBkCup/g3KboD4VW/m
         yGfN4SgWKPOm1rrUpUBVpzRYNBVr7533VOXGyE/Fn40D5g4svD8cBMI5WBsArPWGSQPE
         8rPeuQ+RoBuSBj5Cfzqfr5u/1753E1eqCj/SGuO2RX0ayVlv66a+ZnxwEPwnkSxRHcZG
         j9Wn//cKsRRTsyfGiefxQ2N/XxyNR3Mw2sSEJUyHLKs/7+Z3wCExgRG81bkYNco78eY0
         BOYMJ96PAb8GVTJqJNjj6v/gasZGXiRV3zMO9/IU0v7fXWZ7BodNN3gDoRDL6D8lX+t+
         Sm8A==
X-Received: by 10.152.6.202 with SMTP id d10mr460684laa.49.1382001613138;
        Thu, 17 Oct 2013 02:20:13 -0700 (PDT)
Received: from [10.128.134.109] (fsgw.f-secure.com. [193.110.108.33])
        by mx.google.com with ESMTPSA id ur6sm54189335lbc.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Oct 2013 02:20:12 -0700 (PDT)
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236290>


On rename detection like command "git diff -M ...", rename is detected
based on file similarities. This file similarities are calculated based
on the contents of file. And, if the similarities of contents are the
same, filename is taken into account.
But, the similarity of filename is calculated just whether the basename
is the same or not, and always returns just one or zero.
So, for example, if there are multiple same files in the diff-ing commits,
the result of rename detection is almost random, without taking into account
the similarity of filename.

Calculate filename similarities, and use the result to compare file similarity
in case contents similarities are the same.
Use Sorensen-Dice coefficient of bigrams in strings to calculate filename
similarities because it take into account all part of the filenames, and time
complexity is O(N), assuming N is the length of filenames.
---
 diffcore-rename.c | 81 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 64 insertions(+), 17 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 6c7a72f..355ea6d 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -96,26 +96,51 @@ static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
 	return &(rename_src[first]);
 }
 
-static int basename_same(struct diff_filespec *src, struct diff_filespec *dst)
+static int estimate_filename_similarity(struct diff_filespec *src, struct diff_filespec *dst)
 {
-	int src_len = strlen(src->path), dst_len = strlen(dst->path);
-	while (src_len && dst_len) {
-		char c1 = src->path[--src_len];
-		char c2 = dst->path[--dst_len];
-		if (c1 != c2)
-			return 0;
-		if (c1 == '/')
-			return 1;
+	/*
+	 * Calculate similarity between src path and dst path using
+	 * Sorensen-Dice coefficient of bigrams in strings
+	 */
+	const char *src_path = src->path;
+	const char *dst_path = dst->path;
+	size_t src_len = strlen(src_path);
+	size_t dst_len = strlen(dst_path);
+	static uint16_t src_bigram[256][256];
+	int i;
+	int bigrams_number = 0;
+	int similarity;
+
+	for (i=0; i<src_len; i++) {
+		int c1 = ((unsigned char*)src_path)[i];
+		int c2 = ((unsigned char*)src_path)[i + 1];
+		src_bigram[c1][c2] ++;
+	}
+	for (i=0; i<dst_len; i++) {
+		int c1 = ((unsigned char*)dst_path)[i];
+		int c2 = ((unsigned char*)dst_path)[i + 1];
+		if (src_bigram[c1][c2] > 0) {
+			src_bigram[c1][c2] --;
+			bigrams_number ++;
+		}
+	}
+	similarity = MAX_SCORE * 2 * bigrams_number / (src_len + dst_len);
+
+    /* Clean up src_bigram */
+	for (i=0; i<src_len; i++) {
+		int c1 = ((unsigned char*)src_path)[i];
+		int c2 = ((unsigned char*)src_path)[i + 1];
+		src_bigram[c1][c2] = 0;
 	}
-	return (!src_len || src->path[src_len - 1] == '/') &&
-		(!dst_len || dst->path[dst_len - 1] == '/');
+
+	return similarity;
 }
 
 struct diff_score {
 	int src; /* index in rename_src */
 	int dst; /* index in rename_dst */
 	unsigned short score;
-	short name_score;
+	unsigned short name_score;
 };
 
 static int estimate_similarity(struct diff_filespec *src,
@@ -228,7 +253,7 @@ static void record_rename_pair(int dst_index, int src_index, int score)
  */
 static int score_compare(const void *a_, const void *b_)
 {
-	const struct diff_score *a = a_, *b = b_;
+	struct diff_score *a = (struct diff_score *)a_, *b = (struct diff_score *)b_;
 
 	/* sink the unused ones to the bottom */
 	if (a->dst < 0)
@@ -236,8 +261,23 @@ static int score_compare(const void *a_, const void *b_)
 	else if (b->dst < 0)
 		return -1;
 
-	if (a->score == b->score)
+	if (a->score == b->score){
+		if(a->score == 0)
+			return 0;
+		/* Calculate name_score only when both score is the same */
+		if(a->name_score == USHRT_MAX){
+			struct diff_filespec *two = rename_dst[a->dst].two;
+			struct diff_filespec *one = rename_src[a->src].p->one;
+			a->name_score =  estimate_filename_similarity(one, two);
+		}
+		if(b->name_score == USHRT_MAX){
+			struct diff_filespec *two = rename_dst[b->dst].two;
+			struct diff_filespec *one = rename_src[b->src].p->one;
+			b->name_score = estimate_filename_similarity(one, two);
+		}
+
 		return b->name_score - a->name_score;
+	}
 
 	return b->score - a->score;
 }
@@ -282,7 +322,7 @@ static int find_identical_files(struct file_similarity *src,
 			score = !source->rename_used;
 			if (source->rename_used && options->detect_rename != DIFF_DETECT_COPY)
 				continue;
-			score += basename_same(source, target);
+			score += estimate_filename_similarity(source, target);
 			if (score > best_score) {
 				best = p;
 				best_score = score;
@@ -605,10 +645,17 @@ void diffcore_rename(struct diff_options *options)
 
 			this_src.score = estimate_similarity(one, two,
 							     minimum_score);
-			this_src.name_score = basename_same(one, two);
+			/*
+			 * name_score is needed only when "score"s are the same.
+			 * So, name_score will be calculated on score_compare
+			 * only when needed.
+			 */
+			this_src.name_score = USHRT_MAX;
 			this_src.dst = i;
 			this_src.src = j;
-			record_if_better(m, &this_src);
+			if(this_src.score >= minimum_score){
+				record_if_better(m, &this_src);
+			}
 			/*
 			 * Once we run estimate_similarity,
 			 * We do not need the text anymore.
-- 
1.8.4.475.g867697c
