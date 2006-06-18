From: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] Fix PPC SHA1 routine for large input buffers
Date: Mon, 19 Jun 2006 09:25:16 +1000
Message-ID: <17557.57564.267469.561683@cargo.ozlabs.ibm.com>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	<46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
	<46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>
	<Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606111747110.2703@localhost.localdomain>
	<Pine.LNX.4.64.0606181223580.5498@g5.osdl.org>
	<46a038f90606181440q4fd03bebl9495ace131eb958@mail.gmail.com>
	<Pine.LNX.4.64.0606181532130.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606181543270.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Nicolas Pitre <nico@cam.org>, Jon Smirl <jonsmirl@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 19 01:25:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fs6dz-0006O0-4P
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 01:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWFRXZX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 19:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWFRXZX
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 19:25:23 -0400
Received: from ozlabs.org ([203.10.76.45]:31708 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750847AbWFRXZW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 19:25:22 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 5EE7A67B28; Mon, 19 Jun 2006 09:25:21 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606181543270.5498@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22112>

The PPC SHA1 routine had an overflow which meant that it gave
incorrect results for input buffers >= 512MB.  This fixes it by
ensuring that the update of the total length in bits is done using
64-bit arithmetic.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
Linus Torvalds writes:

> Paul - I think the ppc SHA1_Update() overflows in 32 bits, when the length 
> of the memory area to be checksummed is huge.

Yep.  I checked the assembly output of this, and it looks right, but I
haven't actually tested it by running it...

Paul.

diff --git a/ppc/sha1.c b/ppc/sha1.c
index 5ba4fc5..0820398 100644
--- a/ppc/sha1.c
+++ b/ppc/sha1.c
@@ -30,7 +30,7 @@ int SHA1_Update(SHA_CTX *c, const void *
 	unsigned long nb;
 	const unsigned char *p = ptr;
 
-	c->len += n << 3;
+	c->len += (uint64_t) n << 3;
 	while (n != 0) {
 		if (c->cnt || n < 64) {
 			nb = 64 - c->cnt;
