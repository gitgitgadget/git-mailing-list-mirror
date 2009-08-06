From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Thu, 06 Aug 2009 06:08:03 +0200
Message-ID: <4A7A5723.6070704@gmail.com>
References: <20090805181755.22765.qmail@science.horizon.com> <alpine.LFD.2.01.0908051352280.3390@localhost.localdomain> <alpine.LFD.2.01.0908051545000.3390@localhost.localdomain> <alpine.LFD.2.01.0908051800030.3390@localhost.localdomain> <alpine.LFD.2.00.0908052144430.16073@xanadu.home> <alpine.LFD.2.01.0908051902580.3390@localhost.localdomain> <4A7A4BC5.7010106@gmail.com> <alpine.LFD.2.01.0908052024081.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, George Spelvin <linux@horizon.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 06:08:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYuHB-0004eY-Cz
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 06:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbZHFEII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 00:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbZHFEIH
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 00:08:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:35858 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbZHFEIF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 00:08:05 -0400
Received: by fg-out-1718.google.com with SMTP id e12so997723fga.17
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 21:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=6m6vcG7rsf8SrfWafC8LmkEtVNpZEQGbGaNEFjA3lpU=;
        b=W8QGzcWvBE8B9F19KiwRRnb5MhzSsJJR2kHrUF5rwf3Q2GxZo65pDlkZ/AXV0jd2g0
         iobg+SVpCvT9Si1lgj+/g4ZbhHwYC24MEHSHp9pAB2yQeUBAvzMRbKoJDR+155yems74
         Mv9mygpRkLRmNmG35yT4hPX+k2UyS/rU2A0DU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=xkweBHHjaEWAQz9Dj0AEMjNBK9Z8zmQq09TNL/ynsxkMdJkb8pNeX39Y9tlm7V0CoJ
         v97p3NQPYbm8u5l97zCz5kFo97MwNgz0EZ4qAgSwaqal+u4ooyEiPH/Hr6aZoEbayEKu
         3byaXtR7JY/vQDOxXKmjQaT+q/lAzIPYhX9eo=
Received: by 10.86.57.2 with SMTP id f2mr4580747fga.34.1249531685233;
        Wed, 05 Aug 2009 21:08:05 -0700 (PDT)
Received: from ?172.19.43.221? (ip-89-174-124-154.multimo.pl [89.174.124.154])
        by mx.google.com with ESMTPS id l19sm10936720fgb.2.2009.08.05.21.08.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Aug 2009 21:08:04 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <alpine.LFD.2.01.0908052024081.3390@localhost.localdomain>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125030>

Linus Torvalds wrote:
> 
> On Thu, 6 Aug 2009, Artur Skawina wrote:
>>>  #define T_0_19(t) \
>>> -	TEMP = SHA_ROT(A,5) + (((C^D)&B)^D)     + E + W[t] + 0x5a827999; \
>>> -	E = D; D = C; C = SHA_ROT(B, 30); B = A; A = TEMP;
>>> +	TEMP = SHA_ROL(A,5) + (((C^D)&B)^D)     + E + W[t] + 0x5a827999; \
>>> +	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP;
>>>  
>>>  	T_0_19( 0); T_0_19( 1); T_0_19( 2); T_0_19( 3); T_0_19( 4);
>>>  	T_0_19( 5); T_0_19( 6); T_0_19( 7); T_0_19( 8); T_0_19( 9);
>> unrolling these otoh is a clear loss (iirc ~10%). 
> 
> I can well imagine. The P4 decode bandwidth is abysmal unless you get 
> things into the trace cache, and the trace cache is of a very limited 
> size.
> 
> However, on at least Nehalem, unrolling it all is quite a noticeable win.
> 
> The way it's written, I can easily make it do one or the other by just 
> turning the macro inside a loop (and we can have a preprocessor flag to 
> choose one or the other), but let me work on it a bit more first.

that's of course how i measured it.. :)

> I'm trying to move the htonl() inside the loops (the same way I suggested 
> George do with his assembly), and it seems to help a tiny bit. But I may 
> be measuring noise.

i haven't tried your version at all yet (just applied the rol/ror and
unrolling changes, but neither was a win on p4)

> However, right now my biggest profile hit is on this irritating loop:
> 
> 	/* Unroll it? */
> 	for (t = 16; t <= 79; t++)
> 		W[t] = SHA_ROL(W[t-3] ^ W[t-8] ^ W[t-14] ^ W[t-16], 1);
> 
> and I haven't been able to move _that_ into the other iterations yet.

i've done that before -- was a small loss -- maybe because of the small
trace cache. deleted that attempt while cleaning up the #if mess, so don't
have the patch, but it was basically

#define newW(t) (W[t] = SHA_ROL(W[t-3] ^ W[t-8] ^ W[t-14] ^ W[t-16], 1))

and than s/W[t]/newW(t)/ in rounds 16..79.

I've only tested on p4 and there the winner so far is still:

-  for (t = 16; t <= 79; t++)
+  for (t = 16; t <= 79; t+=2) {
     ctx->W[t] =
-      SHA_ROT(ctx->W[t-3] ^ ctx->W[t-8] ^ ctx->W[t-14] ^ ctx->W[t-16], 1);
+      SHA_ROT(ctx->W[t-16] ^ ctx->W[t-14] ^ ctx->W[t-8] ^ ctx->W[t-3], 1);
+    ctx->W[t+1] =
+      SHA_ROT(ctx->W[t-15] ^ ctx->W[t-13] ^ ctx->W[t-7] ^ ctx->W[t-2], 1);
+  }

> Here's my micro-optimization update. It does the first 16 rounds (of the 
> first 20-round thing) specially, and takes the data directly from the 
> input array. I'm _this_ close to breaking the 28s second barrier on 
> git-fsck, but not quite yet.

tried this before too -- doesn't help. Not much a of a surprise --
if unrolling didn't help adding another loop (for rounds 17..20) won't.

artur
