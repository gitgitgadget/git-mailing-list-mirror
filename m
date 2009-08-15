From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] block-sha1/sha1.c: silence compiler complaints by
 casting void* to uintptr_t
Date: Fri, 14 Aug 2009 20:16:51 -0700
Message-ID: <7v63cp22cc.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.0908130017080.10633@xanadu.home>
 <_-0l9qI_nKm-VVtKlL5hzen4bhcyRmiZ1z4jSmKK1LwECXueziRDzSTyacEehOkoqsfYIaEUlds@cipher.nrlssc.navy.mil> <alpine.DEB.1.00.0908150207270.8306@pacific.mpi-cbg.de> <alpine.LFD.2.01.0908141714040.3162@localhost.localdomain> <5HEgWEs64y4Ty7FnekstRP8Q71pNi_FTweLbMhYWc6zoZBA4jkJqpQ@cipher.nrlssc.navy.mil> <7v8whl7ss9.fsf@alter.siamese.dyndns.org> <MecVLMUB15cEJQiZpwSBg9ysnmFSB1QYZfIQuSOStnFx2KoeScNXGQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, nico@cam.org,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Aug 15 05:23:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc9rN-0004OK-Li
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 05:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116AbZHODRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 23:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753871AbZHODRE
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 23:17:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787AbZHODRD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 23:17:03 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BEB05B6EC;
	Fri, 14 Aug 2009 23:17:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93214B6E4; Fri, 14 Aug
 2009 23:16:53 -0400 (EDT)
In-Reply-To: <MecVLMUB15cEJQiZpwSBg9ysnmFSB1QYZfIQuSOStnFx2KoeScNXGQ@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Fri\, 14 Aug 2009 21\:34\:10 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1AC9ABC6-894A-11DE-929B-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125979>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> I was just pointing out that the SUNWspro compiler does not produce an
> identical binary on x86 for each of the three versions like the GNU
> compiler does.
>
> Sorry for the confusion.  Linus's suggestion of casting to "const char*"
> should be adopted.

Ah, I see.  Thanks.

Let's queue this, then.

-- >8 --
From: Brandon Casey <drafnel@gmail.com>
Date: Fri, 14 Aug 2009 17:52:15 -0500
Subject: [PATCH] block-sha1/sha1.c: silence compiler complaints by casting void * to char *

Some compilers produce errors when arithmetic is attempted on pointers to
void.  We want computations done on byte addresses, so cast them to char *
to work them around.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 block-sha1/sha1.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index e5a1007..464cb25 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -246,14 +246,14 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
 		memcpy(lenW + (char *)ctx->W, data, left);
 		lenW = (lenW + left) & 63;
 		len -= left;
-		data += left;
+		data = ((const char *)data + left);
 		if (lenW)
 			return;
 		blk_SHA1_Block(ctx, ctx->W);
 	}
 	while (len >= 64) {
 		blk_SHA1_Block(ctx, data);
-		data += 64;
+		data = ((const char *)data + 64);
 		len -= 64;
 	}
 	if (len)
