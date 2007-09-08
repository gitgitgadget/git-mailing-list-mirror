From: David Kastrup <dak@gnu.org>
Subject: [PATCH] diff-delta.c: Rationalize culling of hash buckets
Date: Sat, 08 Sep 2007 23:25:55 +0200
Organization: Organization?!?
Message-ID: <85r6l8svbw.fsf@lola.goethe.zz>
References: <851wd8ua9z.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 08 23:26:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IU7oZ-0006m8-Il
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 23:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbXIHVZ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 17:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752932AbXIHVZ6
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 17:25:58 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:39367 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752925AbXIHVZ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Sep 2007 17:25:57 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 45D764C942
	for <git@vger.kernel.org>; Sat,  8 Sep 2007 23:25:56 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id 308E82C6B6E
	for <git@vger.kernel.org>; Sat,  8 Sep 2007 23:25:56 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-020-082.pools.arcor-ip.net [84.61.20.82])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 0486325D2E4
	for <git@vger.kernel.org>; Sat,  8 Sep 2007 23:25:56 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 972231CAD71D; Sat,  8 Sep 2007 23:25:55 +0200 (CEST)
In-Reply-To: <851wd8ua9z.fsf@lola.goethe.zz>
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4200/Sat Sep  8 21:00:15 2007 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58139>

The previous hash bucket culling resulted in a somewhat unpredictable
number of hash bucket entries in the order of magnitude of HASH_LIMIT.

Replace this with a Bresenham-like algorithm leaving us with exactly
HASH_LIMIT entries by uniform culling.

Signed-off-by: David Kastrup <dak@gnu.org>
---
This is to be applied on top of the patch for packing the index
structure.  Which is the reason it is posted as a followup to the
respective article.  In contrast to that patch, this patch has only
been tested/reviewed by myself as to yet.

 diff-delta.c |   41 +++++++++++++++++++++++++++++++----------
 1 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index d355e5e..1a8d6fb 100644
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
 		entry = hash[i];
+		acc = 0;
 		do {
-			struct unpacked_index_entry *keep = entry;
-			int skip = hash_count[i] / HASH_LIMIT;
-			do {
-				--entries;
-				entry = entry->next;
-			} while(--skip && entry);
-			++entries;
-			keep->next = entry;
-		} while(entry);
+			acc += hash_count[i] - HASH_LIMIT;
+			if (acc > 0) {
+				struct unpacked_index_entry *keep = entry;
+				do {
+					entry = entry->next;
+					acc -= HASH_LIMIT;
+				} while (acc > 0);
+				keep->next = entry->next;
+			}
+			entry = entry->next;
+		} while (entry);
+
+		/* Assume that this loop is gone through exactly
+		 * HASH_LIMIT times and is entered and left with
+		 * acc==0.  So the first statement in the loop
+		 * contributes (hash_count[i]-HASH_LIMIT)*HASH_LIMIT
+		 * to the accumulator, and the inner loop consequently
+		 * is run (hash_count[i]-HASH_LIMIT) times, removing
+		 * one element from the list each time.  Since acc
+		 * balances out to 0 at the final run, the inner loop
+		 * body can't be left with entry==NULL.  So we indeed
+		 * encounter entry==NULL in the outer loop only.
+		 */
 	}
 	free(hash_count);
 
-- 
1.5.3.GIT
