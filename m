From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Thu, 06 Aug 2009 05:19:33 +0200
Message-ID: <4A7A4BC5.7010106@gmail.com>
References: <20090805181755.22765.qmail@science.horizon.com> <alpine.LFD.2.01.0908051352280.3390@localhost.localdomain> <alpine.LFD.2.01.0908051545000.3390@localhost.localdomain> <alpine.LFD.2.01.0908051800030.3390@localhost.localdomain> <alpine.LFD.2.00.0908052144430.16073@xanadu.home> <alpine.LFD.2.01.0908051902580.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, George Spelvin <linux@horizon.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 05:19:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYtWA-00029Q-Oz
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 05:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbZHFDTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 23:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753609AbZHFDTh
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 23:19:37 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:56960 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545AbZHFDTg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 23:19:36 -0400
Received: by ewy10 with SMTP id 10so485559ewy.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 20:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=P1QxpGtWqyAdSyrVdblAFVnK6y2bqJ+NDN2H/AS2fEI=;
        b=X2UA2LTl/poxVbjSQ13OH6vYNXKshEVUvRb593vaiISe70LFyfEjxkwGf7JwuLMaSj
         WZJfEJ8bRb6TZfLyH9x77OYhmhNP7HuvV0Uuu71qUZHN6JXssMa+vexsZRCHGr//Aqjc
         ng2zx3dVOkbJNR2Tw0yYLrENA+dhod9vpeoy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=xbyv8e3jYbkc2hMRrPCunhgrM0pbap/44WOzkekcNF+ybbGlHXgiV1SKD+Cxz6ZRzb
         Lz8Nj9kywjkUIFWRgtbDTflrpPPTPsS53h2evaMft5mBT+xxGldTFL16i+acULWe3ZkK
         eWKRIfNk9Emh9LCkk5QLK+8xgru4SJpferQrQ=
Received: by 10.210.92.8 with SMTP id p8mr11446164ebb.15.1249528776004;
        Wed, 05 Aug 2009 20:19:36 -0700 (PDT)
Received: from ?172.19.43.221? (ip-89-174-122-237.multimo.pl [89.174.122.237])
        by mx.google.com with ESMTPS id 28sm1468461eye.24.2009.08.05.20.19.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Aug 2009 20:19:35 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <alpine.LFD.2.01.0908051902580.3390@localhost.localdomain>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125024>

Linus Torvalds wrote:
> 
> The bigger issue seems to be that it's shifter-limited, or that's what I 
> take away from my profiles. I suspect it's even _more_ shifter-limited on 
> some other micro-architectures, because gcc is being stupid, and generates
> 
> 	ror $31,%eax
> 
> from the "left shift + right shift" combination. It seems to -always- 
> generate a "ror", rather than trying to generate 'rot' if the shift count 
> would be smaller that way.
> 
> And I know _some_ old micro-architectures will literally internally loop 
> on the rol/ror counts, so "ror $31" can be _much_ more expensive than "rol 
> $1".
> 
> That isn't the case on my Nehalem, though. But I can't seem to get gcc to 
> generate better code without actually using inline asm..

The compiler does the right thing w/ something like this:

+#if __GNUC__>1 && defined(__i386)
+#define SHA_ROT(data,bits) ({ \
+  unsigned d = (data); \
+  if (bits<16) \
+    __asm__ ("roll %1,%0" : "=r" (d) : "I" (bits), "0" (d)); \
+  else \
+    __asm__ ("rorl %1,%0" : "=r" (d) : "I" (32-bits), "0" (d)); \
+  d; \
+  })
+#else
 #define SHA_ROT(X,n) (((X) << (n)) | ((X) >> (32-(n))))
+#endif
 
which doesn't obfuscate the code as much.
(I needed the asm on p4 anyway, as w/o it the mozilla version is even
 slower than an rfc3174 one. rol vs ror makes no measurable difference)

>  static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
>  {
> @@ -93,7 +105,7 @@ static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
>  
>  	/* Unroll it? */
>  	for (t = 16; t <= 79; t++)
> -		W[t] = SHA_ROT(W[t-3] ^ W[t-8] ^ W[t-14] ^ W[t-16], 1);
> +		W[t] = SHA_ROL(W[t-3] ^ W[t-8] ^ W[t-14] ^ W[t-16], 1);

unrolling this once (but not more) is a win, at least on p4.

>  #define T_0_19(t) \
> -	TEMP = SHA_ROT(A,5) + (((C^D)&B)^D)     + E + W[t] + 0x5a827999; \
> -	E = D; D = C; C = SHA_ROT(B, 30); B = A; A = TEMP;
> +	TEMP = SHA_ROL(A,5) + (((C^D)&B)^D)     + E + W[t] + 0x5a827999; \
> +	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP;
>  
>  	T_0_19( 0); T_0_19( 1); T_0_19( 2); T_0_19( 3); T_0_19( 4);
>  	T_0_19( 5); T_0_19( 6); T_0_19( 7); T_0_19( 8); T_0_19( 9);

unrolling these otoh is a clear loss (iirc ~10%). 

artur
