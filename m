From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] t5300 considered dangerous
Date: Mon, 26 Dec 2005 18:10:21 -0800
Message-ID: <7vd5jjffxu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512270018310.3067@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 03:10:35 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Er4IK-0005oh-Qs
	for gcvg-git@gmane.org; Tue, 27 Dec 2005 03:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbVL0CKY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Dec 2005 21:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVL0CKY
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Dec 2005 21:10:24 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:20184 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751046AbVL0CKX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2005 21:10:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051227020817.WINK17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Dec 2005 21:08:17 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14068>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The test case corrupts a pack, and then also the index of that pack, by 
> writing "0" at certain offsets, and then tests if git-verify-pack fails.

These certain offsets are:

 . byte    2 in pack
   This corrupts PACK_SIGNATURE ("A" in "PACK").

 . byte    7 in pack
   This corrupts PACK_VERSION ("\002" in "\0\0\0\002").

 . byte   12 in pack
   This corrupts the type/size byte of whatever the first object
   happens to be (the type/size byte has non-zero upper nibble).

 . byte 1200 in idx that is currently 1208 bytes long.
   This tries to corrupt the checksum of the index file itself,

You are right about the last one; this location has 1/256 chance
of validly being 0, and making the set of objects to be packed
constant is one way to fix it.  More appropriate way would be to
measure how long the .idx file is, and corrupt the last 20 bytes;
I was too lazy.

-- >8 --

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 7dfb1ab..dd719bb 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -163,8 +163,10 @@ test_expect_success \
      else :;
      fi &&
 
+     l=`wc -c <test-3.idx` &&
+     l=`expr "$l" - 20` &&
      cp test-1-${packname_1}.pack test-3.pack &&
-     dd if=/dev/zero of=test-3.idx count=1 bs=1 conv=notrunc seek=1200 &&
+     dd if=/dev/zero of=test-3.idx count=20 bs=1 conv=notrunc seek=$l &&
      if git-verify-pack test-3.pack
      then false
      else :;
