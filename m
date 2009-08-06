From: Junio C Hamano <gitster@pobox.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Wed, 05 Aug 2009 19:04:41 -0700
Message-ID: <7vocqtu286.fsf@alter.siamese.dyndns.org>
References: <20090805181755.22765.qmail@science.horizon.com>
 <alpine.LFD.2.01.0908051352280.3390@localhost.localdomain>
 <alpine.LFD.2.01.0908051545000.3390@localhost.localdomain>
 <alpine.LFD.2.01.0908051800030.3390@localhost.localdomain>
 <alpine.LFD.2.00.0908052144430.16073@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	George Spelvin <linux@horizon.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 04:05:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYsM7-0001ww-II
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 04:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703AbZHFCEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 22:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753687AbZHFCEt
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 22:04:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45282 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055AbZHFCEs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 22:04:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E245F1EC69;
	Wed,  5 Aug 2009 22:04:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 23FAE1EC66; Wed,  5 Aug 2009
 22:04:42 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0908052144430.16073@xanadu.home> (Nicolas
 Pitre's message of "Wed\, 05 Aug 2009 21\:52\:35 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 85487E06-822D-11DE-B705-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125019>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 5 Aug 2009, Linus Torvalds wrote:
>
>> But while looking at 32-bit issues, I noticed that I really should also 
>> cast 'len' when shifting it. Otherwise the thing is limited to fairly 
>> small areas (28 bits - 256MB). This is not just a 32-bit problem ("int" is 
>> a signed 32-bit thing even in a 64-bit build), but I only noticed it when 
>> looking at 32-bit issues.
>
> Even better is to not shift len at all in SHA_update() but shift 
> ctx->size only at the end in SHA_final().  It is not like if 
> SHA_update() could operate on partial bytes, so counting total bytes 
> instead of total bits is all you need.  This way you need no cast there 
> and make the code slightly faster.

Like this?

By the way, Mozilla one calls Init at the end of Final but block-sha1
doesn't.  I do not think it matters for our callers, but on the other hand
FInal is not performance critical part nor Init is heavy, so it may not be
a bad idea to imitate them as well.  Or am I missing something?

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index eef32f7..8293f7b 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -31,7 +31,7 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
 {
 	int lenW = ctx->lenW;
 
-	ctx->size += (unsigned long long) len << 3;
+	ctx->size += (unsigned long long) len;
 
 	/* Read the data into W and process blocks as they get full
 	 */
@@ -68,6 +68,7 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
 
 	/* Pad with a binary 1 (ie 0x80), then zeroes, then length
 	 */
+	ctx->size <<= 3; /* bytes to bits */
 	padlen[0] = htonl(ctx->size >> 32);
 	padlen[1] = htonl(ctx->size);
 
