From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/3] diffcore-rename: propler honor the difference between
 -M and -C
Date: Fri, 18 Feb 2011 20:28:33 -0800 (PST)
Message-ID: <alpine.LFD.2.02.1102182025270.4165@i5.linux-foundation.org>
References: <alpine.LFD.2.02.1102182023120.4165@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 19 05:28:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqeQz-0001TH-FC
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 05:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048Ab1BSE2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 23:28:37 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:64725 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961Ab1BSE2g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 23:28:36 -0500
Received: by pxi15 with SMTP id 15so632044pxi.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 20:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:x-x-sender:to:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=hOSRKmnlzMCD5Lrs1pl6jlI7zEuVRSjWDkzufIcmV0o=;
        b=tekcPzyEaLGvt2VhI6VNiDgedMaFo39X0McSiuLVgXCGu+nYpqYQO+o4jtAAXVR9sF
         5PmHHz6noMKygSCdfiPoVHldZvBVvsHrHbRqhmjTnyr8XyqkRwHeRPCZE8xOu347tQ03
         q5xRYzOw52y9gYdoGhSOFZk4gwWgcU7v6y43o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:x-x-sender:to:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=lNNiMQmeP17vzdoPTJf2lfmXOrxu3TOES2S2SKUoegHhMpU9rkBMJLPq2ulhmHtA/x
         KXB+xBK8CPlhyamITUCmFFwSNbxGWsn/Q5Nb0f28LOoxpCS6QrvpbMQlmSvD4oYbkb3O
         pJ7bVLmHzGOKDbHJHFV5XHJO8fnKEII6b+MXI=
Received: by 10.142.44.17 with SMTP id r17mr1120227wfr.223.1298089715633;
        Fri, 18 Feb 2011 20:28:35 -0800 (PST)
Received: from i5.linux-foundation.org (c-24-22-0-219.hsd1.or.comcast.net [24.22.0.219])
        by mx.google.com with ESMTPS id e14sm3736295wfg.20.2011.02.18.20.28.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Feb 2011 20:28:35 -0800 (PST)
X-X-Sender: torvalds@i5.linux-foundation.org
In-Reply-To: <alpine.LFD.2.02.1102182023120.4165@i5.linux-foundation.org>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167249>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Feb 2011 20:10:32 -0800

We would allow rename detection to do copy detection even when asked
purely for renames.  That confuses users, but more importantly it can
terminally confuse the recursive merge rename logic.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
Hey, it actually deletes one more line than it adds, because I wanted to 
avoid having to indent that big for-loop that was largely duplicated, and 
decided to instead de-duplicate it and make it a helper function that is 
called a second time for the "find copies" case.

And it now uses the new "options" pointer in find_identical_files() to 
decide if it wants to find copies or just renames.

So this is the patch that actually changes semantics, and makes "-M" means 
"only renames" and "-C" mean "find copies too". Like it was always 
intended, but I don't know if we've ever implemented it that way. The 
"we'll find copies even with -M" is certainly not some new regression.

 diffcore-rename.c              |   53 +++++++++++++++++++--------------------
 t/t4003-diff-rename-1.sh       |    2 +-
 t/t4004-diff-rename-symlink.sh |    2 +-
 t/t4005-diff-rename-2.sh       |    2 +-
 t/t4008-diff-break-rewrite.sh  |    4 +-
 t/t4009-diff-rename-4.sh       |    2 +-
 6 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index e5e88fe..b9b039d 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -278,6 +278,8 @@ static int find_identical_files(struct file_similarity *src,
 			}
 			/* Give higher scores to sources that haven't been used already */
 			score = !source->rename_used;
+			if (source->rename_used && options->detect_rename != DIFF_DETECT_COPY)
+				continue;
 			score += basename_same(source, target);
 			if (score > best_score) {
 				best = p;
@@ -416,6 +418,27 @@ static void record_if_better(struct diff_score m[], struct diff_score *o)
 		m[worst] = *o;
 }
 
+static int find_renames(struct diff_score *mx, int dst_cnt, int minimum_score, int copies)
+{
+	int count = 0, i;
+
+	for (i = 0; i < dst_cnt * NUM_CANDIDATE_PER_DST; i++) {
+		struct diff_rename_dst *dst;
+
+		if ((mx[i].dst < 0) ||
+		    (mx[i].score < minimum_score))
+			break; /* there is no more usable pair. */
+		dst = &rename_dst[mx[i].dst];
+		if (dst->pair)
+			continue; /* already done, either exact or fuzzy. */
+		if (!copies && rename_src[mx[i].src].one->rename_used)
+			continue;
+		record_rename_pair(mx[i].dst, mx[i].src, mx[i].score);
+		count++;
+	}
+	return count;
+}
+
 void diffcore_rename(struct diff_options *options)
 {
 	int detect_rename = options->detect_rename;
@@ -538,33 +561,9 @@ void diffcore_rename(struct diff_options *options)
 	/* cost matrix sorted by most to least similar pair */
 	qsort(mx, dst_cnt * NUM_CANDIDATE_PER_DST, sizeof(*mx), score_compare);
 
-	for (i = 0; i < dst_cnt * NUM_CANDIDATE_PER_DST; i++) {
-		struct diff_rename_dst *dst;
-
-		if ((mx[i].dst < 0) ||
-		    (mx[i].score < minimum_score))
-			break; /* there is no more usable pair. */
-		dst = &rename_dst[mx[i].dst];
-		if (dst->pair)
-			continue; /* already done, either exact or fuzzy. */
-		if (rename_src[mx[i].src].one->rename_used)
-			continue;
-		record_rename_pair(mx[i].dst, mx[i].src, mx[i].score);
-		rename_count++;
-	}
-
-	for (i = 0; i < dst_cnt * NUM_CANDIDATE_PER_DST; i++) {
-		struct diff_rename_dst *dst;
-
-		if ((mx[i].dst < 0) ||
-		    (mx[i].score < minimum_score))
-			break; /* there is no more usable pair. */
-		dst = &rename_dst[mx[i].dst];
-		if (dst->pair)
-			continue; /* already done, either exact or fuzzy. */
-		record_rename_pair(mx[i].dst, mx[i].src, mx[i].score);
-		rename_count++;
-	}
+	rename_count += find_renames(mx, dst_cnt, minimum_score, 0);
+	if (detect_rename == DIFF_DETECT_COPY)
+		rename_count += find_renames(mx, dst_cnt, minimum_score, 1);
 	free(mx);
 
  cleanup:
diff --git a/t/t4003-diff-rename-1.sh b/t/t4003-diff-rename-1.sh
index c6130c4..bfa8835 100755
--- a/t/t4003-diff-rename-1.sh
+++ b/t/t4003-diff-rename-1.sh
@@ -29,7 +29,7 @@ test_expect_success \
 # copy-and-edit one, and rename-and-edit the other.  We do not say
 # anything about rezrov.
 
-GIT_DIFF_OPTS=--unified=0 git diff-index -M -p $tree >current
+GIT_DIFF_OPTS=--unified=0 git diff-index -C -p $tree >current
 cat >expected <<\EOF
 diff --git a/COPYING b/COPYING.1
 copy from COPYING
diff --git a/t/t4004-diff-rename-symlink.sh b/t/t4004-diff-rename-symlink.sh
index 92a65f4..6e562c8 100755
--- a/t/t4004-diff-rename-symlink.sh
+++ b/t/t4004-diff-rename-symlink.sh
@@ -35,7 +35,7 @@ test_expect_success SYMLINKS \
 # a new creation.
 
 test_expect_success SYMLINKS 'setup diff output' "
-    GIT_DIFF_OPTS=--unified=0 git diff-index -M -p $tree >current &&
+    GIT_DIFF_OPTS=--unified=0 git diff-index -C -p $tree >current &&
     cat >expected <<\EOF
 diff --git a/bozbar b/bozbar
 new file mode 120000
diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
index 1ba359d..77d7f49 100755
--- a/t/t4005-diff-rename-2.sh
+++ b/t/t4005-diff-rename-2.sh
@@ -29,7 +29,7 @@ test_expect_success \
 # and COPYING.2 are based on COPYING, and do not say anything about
 # rezrov.
 
-git diff-index -M $tree >current
+git diff-index -C $tree >current
 
 cat >expected <<\EOF
 :100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178 C1234	COPYING	COPYING.1
diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite.sh
index d79d9e1e..73b4a24 100755
--- a/t/t4008-diff-break-rewrite.sh
+++ b/t/t4008-diff-break-rewrite.sh
@@ -173,8 +173,8 @@ test_expect_success \
     'compare_diff_raw expected current'
 
 test_expect_success \
-    'run diff with -B -M' \
-    'git diff-index -B -M "$tree" >current'
+    'run diff with -B -C' \
+    'git diff-index -B -C "$tree" >current'
 
 cat >expected <<\EOF
 :100644 100644 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 08bb2fb671deff4c03a4d4a0a1315dff98d5732c C095	file0	file1
diff --git a/t/t4009-diff-rename-4.sh b/t/t4009-diff-rename-4.sh
index de3f174..f22c8e3 100755
--- a/t/t4009-diff-rename-4.sh
+++ b/t/t4009-diff-rename-4.sh
@@ -29,7 +29,7 @@ test_expect_success \
 # and COPYING.2 are based on COPYING, and do not say anything about
 # rezrov.
 
-git diff-index -z -M $tree >current
+git diff-index -z -C $tree >current
 
 cat >expected <<\EOF
 :100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178 C1234
-- 
1.7.4.1.51.g2bf8a
