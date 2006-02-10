From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] count-delta.c: Match the delta data semantics change in version 3.
Date: Thu, 09 Feb 2006 17:17:02 -0800
Message-ID: <7vbqxg3tdd.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602091736500.5397@localhost.localdomain>
	<7v7j846qco.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 02:17:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7MuL-0001fF-1c
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 02:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWBJBRF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 20:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWBJBRF
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 20:17:05 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:5789 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750965AbWBJBRE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 20:17:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210011440.HLOM17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 20:14:40 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <7v7j846qco.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 09 Feb 2006 15:53:59 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15854>

Junio C Hamano <junkio@cox.net> writes:

> I agree with the general direction and this futureproofing is a
> good thing to have before 1.2.0, I think.
>
> The bit is however _already_ looked at by the count_delta(),
> to assess the extent of damage, IIRC.  Should we be
> futureproofing that bit as well?

Something like this?

-- >8 --
This matches the count_delta() logic to the change previous
commit introduces to patch_delta().

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 count-delta.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

6cb2807fd27b9e970a9b012b925deab99f480d61
diff --git a/count-delta.c b/count-delta.c
index 7559ff6..978a60c 100644
--- a/count-delta.c
+++ b/count-delta.c
@@ -50,13 +50,10 @@ int count_delta(void *delta_buf, unsigne
 			if (cmd & 0x08) cp_off |= (*data++ << 24);
 			if (cmd & 0x10) cp_size = *data++;
 			if (cmd & 0x20) cp_size |= (*data++ << 8);
+			if (cmd & 0x40) cp_size |= (*data++ << 16);
 			if (cp_size == 0) cp_size = 0x10000;
 
-			if (cmd & 0x40)
-				/* copy from dst */
-				;
-			else
-				copied_from_source += cp_size;
+			copied_from_source += cp_size;
 			out += cp_size;
 		} else {
 			/* write literal into dst */
-- 
1.1.6.gce16
