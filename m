From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] diffcore-rename: favour identical basenames
Date: Thu, 21 Jun 2007 12:52:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706211248420.4059@racer.site>
References: <20070621030622.GD8477@spearce.org>
 <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	govindsalinas <govindsalinas@yahoo.com>, gitster@pobox.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 21 13:52:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1LD0-0000Gy-6V
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 13:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406AbXFULwR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 07:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754041AbXFULwR
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 07:52:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:37534 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753841AbXFULwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 07:52:16 -0400
Received: (qmail invoked by alias); 21 Jun 2007 11:52:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 21 Jun 2007 13:52:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7stdiWhj74u/6onYvbZvJd2/eB9wVS962ekITbX
	UH45EoMtqLJtQG
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50614>


When there are several candidates for a rename source, and one of them
has an identical basename to the rename target, take that one.

Noticed by Govind Salinas, posted by Shawn O. Pearce, partial patch
by Linus Torvalds.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 20 Jun 2007, Linus Torvalds wrote:

	> I think we should just consider the basename as an "added 
	> similarity  bonus".
	> 
	> IOW, we currently sort purely by data similarity, but how about 
	> just adding a small increment for "same base name".
	> 
	> [patch suggestion snipped, since it is identical what is below]

	How 'bout this?

 diffcore-rename.c      |   33 ++++++++++++++++++++++++++++++++-
 t/t4001-diff-rename.sh |   13 +++++++++++++
 2 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 93c40d9..79c984c 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -119,6 +119,21 @@ static int is_exact_match(struct diff_filespec *src,
 	return 0;
 }
 
+static int basename_same(struct diff_filespec *src, struct diff_filespec *dst)
+{
+	int src_len = strlen(src->path), dst_len = strlen(dst->path);
+	while (src_len && dst_len) {
+		char c1 = src->path[--src_len];
+		char c2 = dst->path[--dst_len];
+		if (c1 != c2)
+			return 0;
+		if (c1 == '/')
+			return 1;
+	}
+	return (!src_len || src->path[src_len - 1] == '/') &&
+		(!dst_len || dst->path[dst_len - 1] == '/');
+}
+
 struct diff_score {
 	int src; /* index in rename_src */
 	int dst; /* index in rename_dst */
@@ -186,8 +201,11 @@ static int estimate_similarity(struct diff_filespec *src,
 	 */
 	if (!dst->size)
 		score = 0; /* should not happen */
-	else
+	else {
 		score = (int)(src_copied * MAX_SCORE / max_size);
+		if (basename_same(src, dst))
+			score++;
+	}
 	return score;
 }
 
@@ -295,9 +313,22 @@ void diffcore_rename(struct diff_options *options)
 			if (rename_dst[i].pair)
 				continue; /* dealt with an earlier round */
 			for (j = 0; j < rename_src_nr; j++) {
+				int k;
 				struct diff_filespec *one = rename_src[j].one;
 				if (!is_exact_match(one, two, contents_too))
 					continue;
+
+				/* see if there is a basename match, too */
+				for (k = j; k < rename_src_nr; k++) {
+					one = rename_src[k].one;
+					if (basename_same(one, two) &&
+						is_exact_match(one, two,
+							contents_too)) {
+						j = k;
+						break;
+					}
+				}
+
 				record_rename_pair(i, j, (int)MAX_SCORE);
 				rename_count++;
 				break; /* we are done with this entry */
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 2e3c20d..90c085f 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -64,4 +64,17 @@ test_expect_success \
     'validate the output.' \
     'compare_diff_patch current expected'
 
+test_expect_success 'favour same basenames over different ones' '
+	cp path1 another-path &&
+	git add another-path &&
+	git commit -m 1 &&
+	git rm path1 &&
+	mkdir subdir &&
+	git mv another-path subdir/path1 &&
+	git runstatus | grep "renamed: .*path1 -> subdir/path1"'
+
+test_expect_success  'favour same basenames even with minor differences' '
+	git show HEAD:path1 | sed "s/15/16/" > subdir/path1 &&
+	git runstatus | grep "renamed: .*path1 -> subdir/path1"'
+
 test_done
-- 
1.5.2.2.2822.g027a6-dirty
