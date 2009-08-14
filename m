From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] block-sha1/sha1.c: silence compiler complaints by casting void* to uintptr_t
Date: Fri, 14 Aug 2009 17:52:15 -0500
Message-ID: <_-0l9qI_nKm-VVtKlL5hzen4bhcyRmiZ1z4jSmKK1LwECXueziRDzSTyacEehOkoqsfYIaEUlds@cipher.nrlssc.navy.mil>
References: <alpine.LFD.2.00.0908130017080.10633@xanadu.home>
Cc: gitster@pobox.com, torvalds@linux-foundation.org,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: nico@cam.org
X-From: git-owner@vger.kernel.org Sat Aug 15 00:53:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc5eX-0006fx-7f
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 00:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757240AbZHNWxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 18:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756777AbZHNWxd
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 18:53:33 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49111 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049AbZHNWxc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 18:53:32 -0400
Received: by mail.nrlssc.navy.mil id n7EMqvbA014503; Fri, 14 Aug 2009 17:53:02 -0500
In-Reply-To: <alpine.LFD.2.00.0908130017080.10633@xanadu.home>
X-OriginalArrivalTime: 14 Aug 2009 22:52:57.0639 (UTC) FILETIME=[F77F2B70:01CA1D31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125965>

From: Brandon Casey <drafnel@gmail.com>

Some compilers produce errors when arithmetic is attempted on pointers to
void.  So cast to uintptr_t when performing arithmetic on void pointers.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


This, on top of Nico's last patch "block-sha1: more good unaligned memory
access candidates", allows this series to compile and run successfully on
Sun Sparc and IRIX MIPS for me.

It produces no differences on Linux using gcc.  gcc 3.4.6 and 4.1.2 produce
an identical binary for me on x86 and x86-64 with and without this change.
Any conceivable negative effects on other arch's?

-brandon


 block-sha1/sha1.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index e5a1007..ccaba9e 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -246,14 +246,14 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
 		memcpy(lenW + (char *)ctx->W, data, left);
 		lenW = (lenW + left) & 63;
 		len -= left;
-		data += left;
+		data = (const void*) ((uintptr_t) data + left);
 		if (lenW)
 			return;
 		blk_SHA1_Block(ctx, ctx->W);
 	}
 	while (len >= 64) {
 		blk_SHA1_Block(ctx, data);
-		data += 64;
+		data = (const void*) ((uintptr_t) data + 64);
 		len -= 64;
 	}
 	if (len)
-- 
1.6.4
