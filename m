From: David Kastrup <dak@gnu.org>
Subject: [PATCH] diff-delta.c: Rationalize culling of hash buckets
Date: Sat, 08 Sep 2007 21:41:24 +0200
Organization: Organization?!?
Message-ID: <85zlzxt063.fsf@lola.goethe.zz>
References: <f1161c08aeeca60b6c33af34ccea68fd99b9ea4e.1189243702.git.dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 08 21:41:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IU6Bk-0002qE-IK
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 21:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636AbXIHTlc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 15:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754645AbXIHTlc
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 15:41:32 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:43313 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754566AbXIHTlb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Sep 2007 15:41:31 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id A402131ECD8
	for <git@vger.kernel.org>; Sat,  8 Sep 2007 21:41:29 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 942D92DABFF
	for <git@vger.kernel.org>; Sat,  8 Sep 2007 21:41:29 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-020-082.pools.arcor-ip.net [84.61.20.82])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 7151C19B326
	for <git@vger.kernel.org>; Sat,  8 Sep 2007 21:41:25 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id BBB751CAD71D; Sat,  8 Sep 2007 21:41:24 +0200 (CEST)
In-Reply-To: <f1161c08aeeca60b6c33af34ccea68fd99b9ea4e.1189243702.git.dak@gnu.org>
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4199/Sat Sep  8 20:36:00 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58133>

The previous hash bucket culling resulted in a somewhat unpredictable
number of hash bucket entries in the order of magnitude of HASH_LIMIT.

Replace this with a Bresenham-like algorithm leaving us with exactly
HASH_LIMIT entries by uniform culling.
---

This is assuming that the previous patch series has been applied
(lacking any final comments or Acks on it; but I think I addressed the
issues).  The hash bucket code culling has really annoyed me with its
unintuitive results.  If the preceding patch series is thrown out (I
can't think why it would), one could rework this to fit the current
master if really needed.

 diff-delta.c |   41 +++++++++++++++++++++++++++++++----------
 1 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index e7c33aa..98795c6 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -207,19 +207,40 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	 * the reference buffer.
 	 */
 	for (i = 0; i < hsize; i++) {
-		if (hash_count[i] < HASH_LIMIT)
+		int acc;
+
+		if (hash_count[i] <= HASH_LIMIT)
 			continue;
+
+		entries -= hash_count[i] - HASH_LIMIT;
+		/* We leave exactly HASH_LIMIT entries in the bucket */
+
 		uentry = uhash[i];
+		acc = 0;
 		do {
-			struct unpacked_index_entry *keep = uentry;
-			int skip = hash_count[i] / HASH_LIMIT;
-			do {
-				--entries;
-				uentry = uentry->next;
-			} while(--skip && uentry);
-			++entries;
-			keep->next = uentry;
-		} while(uentry);
+			acc += hash_count[i] - HASH_LIMIT;
+			if (acc > 0) {
+				struct unpacked_index_entry *keep = uentry;
+				do {
+					uentry = uentry->next;
+					acc -= HASH_LIMIT;
+				} while (acc > 0);
+				keep->next = uentry->next;
+			}
+			uentry = uentry->next;
+		} while (uentry);
+
+		/* Assume that this loop is gone through exactly
+		 * HASH_LIMIT times and is entered and left with
+		 * acc==0.  So the first statement in the loop
+		 * contributes (hash_count[i]-HASH_LIMIT)*HASH_LIMIT
+		 * to the accumulator, and the inner loop consequently
+		 * is run (hash_count[i]-HASH_LIMIT) times, removing
+		 * one element from the list each time.  Since acc
+		 * balances out to 0 at the final run, the inner loop
+		 * body can't be left with uentry==NULL.  So we indeed
+		 * encounter uentry==NULL in the outer loop only.
+		 */
 	}
 	free(hash_count);
 
-- 
1.5.3.GIT
