From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] pack-objects: emit base before delta.
Date: Thu, 30 Jun 2005 22:58:03 -0700
Message-ID: <7vbr5nxe38.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 07:50:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoEQF-0007GH-LI
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 07:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbVGAF6K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 01:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbVGAF6K
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 01:58:10 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:20700 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S263226AbVGAF6F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2005 01:58:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050701055803.RSQH8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 1 Jul 2005 01:58:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This micro-optimizes the order of objects in a pack.  By
emitting base objects before deltified ones, unpack-objects do
not keep items on delta_list.

I think it is prudent to keep the add_delta_to_list() logic in
unpack-objects, so this commit only changes the packing side.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 pack-objects.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

9be15981d7038f1d9d0b105f45760987584e60a6
diff --git a/pack-objects.c b/pack-objects.c
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -114,11 +114,13 @@ static unsigned long write_one(struct sh
 		 * if it is written already.
 		 */
 		return offset;
-	e->offset = offset;
-	offset += write_object(f, e);
-	/* if we are delitified, write out its base object. */
+
+	/* if we are delitified, write out its base objects first */
 	if (e->delta)
 		offset = write_one(f, e->delta, offset);
+
+	e->offset = offset;
+	offset += write_object(f, e);
 	return offset;
 }
 
------------
