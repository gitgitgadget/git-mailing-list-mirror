From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: [PATCH] fix bug in read-cache.c which loses files when merging a
	tree
Date: Mon, 18 Apr 2005 13:17:19 -0500
Message-ID: <1113848239.4998.45.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 20:14:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNakW-0007Gh-EP
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 20:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVDRSRb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 14:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVDRSRb
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 14:17:31 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:51178 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261164AbVDRSR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 14:17:29 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id j3IIHKA04205;
	Mon, 18 Apr 2005 14:17:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I noticed this when I tried a non-trivial scsi merge and checked the
results against BK.  The problem is that remove_entry_at() actually
decrements active_nr, so decrementing it in add_cache_entry() before
calling remove_entry_at() is a double decrement (hence we lose cache
entries at the end).

James

read-cache.c: 4d4d94f75cceb8039eb466c1956f8b54dc0e24b6
--- read-cache.c
+++ read-cache.c	2005-04-18 13:08:09.000000000 -0500
@@ -402,7 +402,6 @@
 	if (pos < active_nr && ce_stage(ce) == 0) {
 		while (same_name(active_cache[pos], ce)) {
 			ok_to_add = 1;
-			active_nr--;
 			if (!remove_entry_at(pos))
 				break;
 		}


