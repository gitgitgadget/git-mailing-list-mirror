From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] Keep last used delta base in the delta window
Date: Sun, 26 Aug 2007 22:56:33 +0200
Message-ID: <11881617934179-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 26 22:57:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPPAP-0006dH-8x
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 22:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbXHZU4g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 16:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbXHZU4g
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 16:56:36 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:51187 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbXHZU4f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 16:56:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 7E1E073B5FB5
	for <git@vger.kernel.org>; Sun, 26 Aug 2007 22:56:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nMRAjQBpdobo; Sun, 26 Aug 2007 22:56:33 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id C22F473B5FB2; Sun, 26 Aug 2007 22:56:33 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56733>

Keeping the last used delta base object, if it would be dropped,
supports creating smaller packs with shorter delta chains.

The runtime impact is minimal, as it only skips slots in the delta window.

Original (for git.git repository):
$ echo | time /data/git/bin/git-pack-objects --non-empty --all --reflog --unpacked=pack-a19e665cf563f4ca8ce2306eeb4bfb78815882a5.pack --no-reuse-object .git/objects/.tmp-29631-pack
Generating pack...
Counting objects: 9846
Done counting 56224 objects.
Deltifying 56224 objects...
 100% (56224/56224) done
Writing 56224 objects...
1d3d374f6b9f9f8882ce3a47bab6976702aca35d

Total 56224 (delta 37798), reused 0 (delta 0)
57.19user 0.90system 1:00.39elapsed 96%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (6major+33878minor)pagefaults 0swaps

Pack size: 14655528
Pack stat:
      all sizes: count 56224 total 26029188 min 0 max 220191 mean 462.96 median 59 std_dev 3065.89
 all path sizes: count 56224 total 756044939 min 0 max 254816 mean 13447.01 median 6291 std_dev 26983.93
     tree sizes: count 18426 total 26029188 min 0 max 279666 mean 1412.63 median 451 std_dev 7242.15
tree path sizes: count 18426 total 756044939 min 0 max 30327513 mean 41031.42 median 457 std_dev 563089.70
         depths: count 56224 total 713895 min 0 max 50 mean 12.70 median 5 std_dev 15.85

chain length >= 40: 6271 objects
chain length = 1: 2615 objects
chain length = 2: 2350 objects
chain length = 3: 2073 objects
chain length = 4: 1809 objects
chain length = 5: 1578 objects
chain length = 6: 1384 objects
chain length = 7: 1242 objects
chain length = 8: 1119 objects
chain length = 9: 1060 objects
chain length = 10: 975 objects
chain length = 11: 904 objects
chain length = 12: 816 objects
chain length = 13: 778 objects
chain length = 14: 776 objects
chain length = 15: 709 objects
chain length = 16: 671 objects
chain length = 17: 651 objects
chain length = 18: 645 objects
chain length = 19: 674 objects
chain length = 20: 603 objects
chain length = 21: 563 objects
chain length = 22: 537 objects
chain length = 23: 530 objects
chain length = 24: 485 objects
chain length = 25: 473 objects
chain length = 26: 452 objects
chain length = 27: 427 objects
chain length = 28: 439 objects
chain length = 29: 420 objects
chain length = 30: 416 objects
chain length = 31: 387 objects
chain length = 32: 407 objects
chain length = 33: 387 objects
chain length = 34: 377 objects
chain length = 35: 354 objects
chain length = 36: 367 objects
chain length = 37: 364 objects
chain length = 38: 359 objects
chain length = 39: 351 objects

With the patch:
$ echo | time ./git-pack-objects --non-empty --all --reflog --unpacked=pack-a19e665cf563f4ca8ce2306eeb4bfb78815882a5.pack --no-reuse-object .git/objects/.tmp-29638-pack
Generating pack...
Counting objects: 9806
Done counting 56224 objects.
Deltifying 56224 objects...
 100% (56224/56224) done
Writing 56224 objects...
1d3d374f6b9f9f8882ce3a47bab6976702aca35d

Total 56224 (delta 37871), reused 0 (delta 0)
57.67user 1.08system 1:00.73elapsed 96%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+32236minor)pagefaults 0swaps

Pack size: 14306798
Pack stat:
      all sizes: count 56224 total 25299924 min 0 max 220191 mean 449.98 median 58 std_dev 2968.96
 all path sizes: count 56224 total 773260074 min 0 max 272126 mean 13753.20 median 6320 std_dev 27370.12
     tree sizes: count 18353 total 25299924 min 0 max 279899 mean 1378.52 median 450 std_dev 7097.53
tree path sizes: count 18353 total 773260074 min 0 max 28995033 mean 42132.63 median 455 std_dev 594290.34
         depths: count 56224 total 664005 min 0 max 50 mean 11.81 median 4 std_dev 14.85

chain length >= 40: 5056 objects
chain length = 1: 3174 objects
chain length = 2: 2613 objects
chain length = 3: 2209 objects
chain length = 4: 1918 objects
chain length = 5: 1565 objects
chain length = 6: 1412 objects
chain length = 7: 1211 objects
chain length = 8: 1090 objects
chain length = 9: 1001 objects
chain length = 10: 950 objects
chain length = 11: 893 objects
chain length = 12: 803 objects
chain length = 13: 772 objects
chain length = 14: 787 objects
chain length = 15: 691 objects
chain length = 16: 656 objects
chain length = 17: 624 objects
chain length = 18: 619 objects
chain length = 19: 591 objects
chain length = 20: 569 objects
chain length = 21: 552 objects
chain length = 22: 525 objects
chain length = 23: 509 objects
chain length = 24: 506 objects
chain length = 25: 479 objects
chain length = 26: 462 objects
chain length = 27: 472 objects
chain length = 28: 479 objects
chain length = 29: 475 objects
chain length = 30: 464 objects
chain length = 31: 446 objects
chain length = 32: 426 objects
chain length = 33: 433 objects
chain length = 34: 427 objects
chain length = 35: 412 objects
chain length = 36: 405 objects
chain length = 37: 393 objects
chain length = 38: 394 objects
chain length = 39: 408 objects

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-pack-objects.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 77481df..24e8719 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1438,6 +1438,7 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 	uint32_t i = nr_objects, idx = 0, count = 0, processed = 0;
 	unsigned int array_size = window * sizeof(struct unpacked);
 	struct unpacked *array;
+	struct object_entry *last_base = 0;
 	int max_depth;
 
 	if (!nr_objects)
@@ -1470,6 +1471,13 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 		if (entry->no_try_delta)
 			continue;
 
+		if (last_base && n->entry == last_base) {
+			idx ++;
+			if (idx >= window)
+				idx = 0;
+			n = array + idx;
+		}
+
 		free_unpacked(n);
 		n->entry = entry;
 
@@ -1513,6 +1521,7 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 		if (entry->delta && depth <= n->depth)
 			continue;
 
+		last_base = entry->delta;
 		next:
 		idx++;
 		if (count + 1 < window)
-- 
1.4.4.4
