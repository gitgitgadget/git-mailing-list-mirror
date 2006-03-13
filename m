From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix up diffcore-rename scoring
Date: Sun, 12 Mar 2006 22:26:34 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603122223160.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Mar 13 07:26:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIgVu-0001Ac-6a
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 07:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbWCMG0j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 01:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbWCMG0j
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 01:26:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46022 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751534AbWCMG0j (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 01:26:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2D6QYDZ016360
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Mar 2006 22:26:35 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2D6QYQu029622;
	Sun, 12 Mar 2006 22:26:34 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17552>


The "score" calculation for diffcore-rename was totally broken.

It scaled "score" as

	score = src_copied * MAX_SCORE / dst->size;

which means that you got a 100% similarity score even if src and dest were 
different, if just every byte of dst was copied from src, even if source 
was much larger than dst (eg we had copied 85% of the bytes, but _deleted_ 
the remaining 15%).

That's clearly bogus. We should do the score calculation relative not to 
the destination size, but to the max size of the two.

This seems to fix it.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/diffcore-rename.c b/diffcore-rename.c
index ed99fe2..e992698 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -133,7 +133,7 @@ static int estimate_similarity(struct di
 	 * match than anything else; the destination does not even
 	 * call into this function in that case.
 	 */
-	unsigned long delta_size, base_size, src_copied, literal_added;
+	unsigned long max_size, delta_size, base_size, src_copied, literal_added;
 	unsigned long delta_limit;
 	int score;
 
@@ -144,9 +144,9 @@ static int estimate_similarity(struct di
 	if (!S_ISREG(src->mode) || !S_ISREG(dst->mode))
 		return 0;
 
-	delta_size = ((src->size < dst->size) ?
-		      (dst->size - src->size) : (src->size - dst->size));
+	max_size = ((src->size > dst->size) ? src->size : dst->size);
 	base_size = ((src->size < dst->size) ? src->size : dst->size);
+	delta_size = max_size - base_size;
 
 	/* We would not consider edits that change the file size so
 	 * drastically.  delta_size must be smaller than
@@ -174,12 +174,10 @@ static int estimate_similarity(struct di
 	/* How similar are they?
 	 * what percentage of material in dst are from source?
 	 */
-	if (dst->size < src_copied)
-		score = MAX_SCORE;
-	else if (!dst->size)
+	if (!dst->size)
 		score = 0; /* should not happen */
 	else
-		score = src_copied * MAX_SCORE / dst->size;
+		score = src_copied * MAX_SCORE / max_size;
 	return score;
 }
 
