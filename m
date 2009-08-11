From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: block-sha1: improve code on large-register-set machines
Date: Tue, 11 Aug 2009 16:20:57 -0500
Message-ID: <fLYKSyures_wcvAvAV9-MgKQlhk959HJpx-pKz7T1n-Mel7f2RBkMw@cipher.nrlssc.navy.mil>
References: <alpine.LFD.2.01.0908101637440.3417@localhost.localdomain> <alpine.LFD.2.00.0908102246210.10633@xanadu.home> <alpine.LFD.2.01.0908110758160.3417@localhost.localdomain> <alpine.LFD.2.00.0908111254290.10633@xanadu.home> <alpine.LFD.2.00.0908111517390.10633@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 11 23:22:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaynA-0001uZ-To
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 23:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223AbZHKVVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 17:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755092AbZHKVVv
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 17:21:51 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:38721 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755075AbZHKVVv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 17:21:51 -0400
Received: by mail.nrlssc.navy.mil id n7BLKxr3001243; Tue, 11 Aug 2009 16:20:59 -0500
In-Reply-To: <alpine.LFD.2.00.0908111517390.10633@xanadu.home>
X-OriginalArrivalTime: 11 Aug 2009 21:20:58.0048 (UTC) FILETIME=[9E532C00:01CA1AC9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125601>

Nicolas Pitre wrote:
> On Tue, 11 Aug 2009, Nicolas Pitre wrote:
> 
>> On Tue, 11 Aug 2009, Linus Torvalds wrote:
>>
>>> On Tue, 11 Aug 2009, Nicolas Pitre wrote:
>>>> #define SHA_SRC(t) \
>>>>   ({ unsigned char *__d = (unsigned char *)&data[t]; \
>>>>      (__d[0] << 24) | (__d[1] << 16) | (__d[2] << 8) | (__d[3] << 0); })
>>>>
>>>> And this provides the exact same performance as the ntohl() based 
>>>> version (4.980s) except that this now cope with unaligned buffers too.
>>> The actual object SHA1 calculations are likely not aligned (we do that 
>>> object header thing), and if you can't do the htonl() any better way I 
>>> guess the byte-based thing is the way to go..
> 
> OK, even better: 4.400s.
> 
> This is with this instead of the above:
> 
> #define SHA_SRC(t) \
>    ({   unsigned char *__d = (unsigned char *)data; \
>         (__d[(t)*4 + 0] << 24) | (__d[(t)*4 + 1] << 16) | \
>         (__d[(t)*4 + 2] <<  8) | (__d[(t)*4 + 3] <<  0); })
> 
> The previous version would allocate a new register for __d and then 
> index it with an offset of 0, 1, 2 or 3.  This version always uses the 
> register containing the data pointer with absolute offsets.  The binary 
> is a bit smaller too.

In that case, why not change the interface of blk_SHA1Block() so that its
second argument is const unsigned char* and get rid of __d and the { } ?

Then it will look like this:

   static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned char *data);

   ...

   #define SHA_SRC(t) \
       ( (data[(t)*4 + 0] << 24) | (data[(t)*4 + 1] << 16) | \
         (data[(t)*4 + 2] <<  8) | (data[(t)*4 + 3] <<  0) )


Plus, we need something like the following to handle storing the hash to
an unaligned buffer (warning copy/pasted):

@@ -73,8 +74,12 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *c
 
        /* Output hash
         */
-       for (i = 0; i < 5; i++)
-               ((unsigned int *)hashout)[i] = htonl(ctx->H[i]);
+       for (i = 0; i < 5; i++) {
+               *hashout++ = (unsigned char) (ctx->H[i] >> 24);
+               *hashout++ = (unsigned char) (ctx->H[i] >> 16);
+               *hashout++ = (unsigned char) (ctx->H[i] >> 8);
+               *hashout++ = (unsigned char) (ctx->H[i] >> 0);
+       }
 }
 
 #if defined(__i386__) || defined(__x86_64__)


With these two changes plus a few other minor tweaks, the block-sha1 code compiles
and passes the test suite on sparc (solaris 7) and mips (irix 6.5).

-brandon
