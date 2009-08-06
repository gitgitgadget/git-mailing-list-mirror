From: Nicolas Pitre <nico@cam.org>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Wed, 05 Aug 2009 22:20:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908052209490.16073@xanadu.home>
References: <20090805181755.22765.qmail@science.horizon.com>
 <alpine.LFD.2.01.0908051352280.3390@localhost.localdomain>
 <alpine.LFD.2.01.0908051545000.3390@localhost.localdomain>
 <alpine.LFD.2.01.0908051800030.3390@localhost.localdomain>
 <alpine.LFD.2.00.0908052144430.16073@xanadu.home>
 <7vocqtu286.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	George Spelvin <linux@horizon.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 04:20:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYsaZ-0005YR-7D
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 04:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036AbZHFCUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 22:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752620AbZHFCUJ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 22:20:09 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36618 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbZHFCUI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 22:20:08 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KNX00H0DNTFGFF0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 05 Aug 2009 22:20:04 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vocqtu286.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125022>

On Wed, 5 Aug 2009, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Wed, 5 Aug 2009, Linus Torvalds wrote:
> >
> >> But while looking at 32-bit issues, I noticed that I really should also 
> >> cast 'len' when shifting it. Otherwise the thing is limited to fairly 
> >> small areas (28 bits - 256MB). This is not just a 32-bit problem ("int" is 
> >> a signed 32-bit thing even in a 64-bit build), but I only noticed it when 
> >> looking at 32-bit issues.
> >
> > Even better is to not shift len at all in SHA_update() but shift 
> > ctx->size only at the end in SHA_final().  It is not like if 
> > SHA_update() could operate on partial bytes, so counting total bytes 
> > instead of total bits is all you need.  This way you need no cast there 
> > and make the code slightly faster.
> 
> Like this?

Almost (see below).

> By the way, Mozilla one calls Init at the end of Final but block-sha1
> doesn't.  I do not think it matters for our callers, but on the other hand
> FInal is not performance critical part nor Init is heavy, so it may not be
> a bad idea to imitate them as well.  Or am I missing something?

It is done only to make sure potentially crypto sensitive information is 
wiped out of the ctx structure instance.  In our case we have no such 
concerns.

> diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
> index eef32f7..8293f7b 100644
> --- a/block-sha1/sha1.c
> +++ b/block-sha1/sha1.c
> @@ -31,7 +31,7 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
>  {
>  	int lenW = ctx->lenW;
>  
> -	ctx->size += (unsigned long long) len << 3;
> +	ctx->size += (unsigned long long) len;

You can get rid of the cast as well now.

>  	/* Read the data into W and process blocks as they get full
>  	 */
> @@ -68,6 +68,7 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
>  
>  	/* Pad with a binary 1 (ie 0x80), then zeroes, then length
>  	 */
> +	ctx->size <<= 3; /* bytes to bits */
>  	padlen[0] = htonl(ctx->size >> 32);
>  	padlen[1] = htonl(ctx->size);

Instead, I'd do:

	padlen[0] = htonl(ctx->size >> (32 - 3));
	padlen[1] = htonl(ctx->size << 3);

That would eliminate a redundant write back of ctx->size.


Nicolas
