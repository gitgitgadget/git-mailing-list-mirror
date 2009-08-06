From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Thu, 06 Aug 2009 23:52:26 +0200
Message-ID: <4A7B509A.5010405@gmail.com>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com> <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain> <4A7B384C.2020407@gmail.com> <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain> <4A7B4D84.80906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 23:52:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZAt4-0007pC-NS
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 23:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbZHFVwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 17:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbZHFVw3
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 17:52:29 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:46438 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbZHFVw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 17:52:29 -0400
Received: by bwz9 with SMTP id 9so1051114bwz.41
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 14:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=q13e85zPi2PexIm+1T5uaz2byhT3FVrzNpmR7jnKljs=;
        b=cm4avC1mM5GnMVOM85xredErETuOjZYK9kevuPNDngNgY3gsC5z++5kbT2USShWm+2
         P+oSW2vCR/mxlbB0Ip4ZZvI9zYoLRpw7MtF6lz4xa/pTwKpO6UFpDaIqXOBiOCncodPk
         EJtcQ4EjalDdMpV3tBdHCwsuXlnD2mv+wpy8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=QwEAhciTa5QpHD8/uBEC4xDpZM+BFk4gRS5bInFx97isENxmYVsw3e5QWfKakq/TK+
         XHMnigGFkx+MyiM8W9t3jzj6kpfdibwiRo8dJzmA5VoXVJPtTkizceCTSSKe7cyxgJw0
         ag8nMZlQ5Z9rruYgs9AAQyyqE4tVQPvY3/bX4=
Received: by 10.103.191.4 with SMTP id t4mr146790mup.133.1249595548595;
        Thu, 06 Aug 2009 14:52:28 -0700 (PDT)
Received: from ?172.19.43.221? (ip-89-174-40-61.multimo.pl [89.174.40.61])
        by mx.google.com with ESMTPS id y2sm2005296mug.42.2009.08.06.14.52.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 14:52:28 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <4A7B4D84.80906@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125131>

Artur Skawina wrote:
> Linus Torvalds wrote:
>> Oh, I did make a small change, but I doubt it matters. Instead of doing
>>
>> 	TEMP += E + SHA_ROL(A,5) + (fn) + (constant); \
>> 	B = SHA_ROR(B, 2); E = TEMP; } while (0)
>>
>> I now do
>>
>> 	E += TEMP + SHA_ROL(A,5) + (fn) + (constant); \
>> 	B = SHA_ROR(B, 2); } while (0)
>>
>> which is a bit more logical (the old TEMP usage was just due to a fairly 
>> mindless conversion). That _might_ have lower register pressure if the 
>> compiler is silly enough to not notice that it can do it. Maybe that 
>> matters.
> 
> before: linus          0.6622       92.17
> after:  linus          0.6631       92.05
> after:  linus          0.6601       92.46
> after:  linus          0.6624       92.14
> 
> IOW, no difference, just noise.

Just to check, i did this: 

diff -urNp sha1bench-linus.org/block-sha1/sha1.c sha1bench-linus/block-sha1/sha1.c
--- sha1bench-linus.org/block-sha1/sha1.c	2009-08-06 23:26:15.607321815 +0200
+++ sha1bench-linus/block-sha1/sha1.c	2009-08-06 23:41:36.858325807 +0200
@@ -103,8 +103,8 @@ void blk_SHA1_Final(unsigned char hashou
 
 #define SHA_ROUND(t, input, fn, constant, A, B, C, D, E) do { \
 	unsigned int TEMP = input(t); W(t) = TEMP; \
-	E += TEMP + SHA_ROL(A,5) + (fn) + (constant); \
-	B = SHA_ROR(B, 2); } while (0)
+	E += TEMP + (fn) + (constant); \
+	B = SHA_ROR(B, 2); E += SHA_ROL(A,5); } while (0)
 
 #define T_0_15(t, A, B, C, D, E)  SHA_ROUND(t, SHA_SRC, (((C^D)&B)^D) , 0x5a827999, A, B, C, D, E )
 #define T_16_19(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (((C^D)&B)^D) , 0x5a827999, A, B, C, D, E )

and the result was:

#             TIME[s] SPEED[MB/s]
rfc3174          1.47       41.51
rfc3174         1.474       41.42
linus          0.3564       171.2
linusas        0.5736       106.4
linusas2       0.3568       171.1
mozilla          1.17       52.19
mozillaas       1.382       44.17
openssl        0.2636       231.5
spelvin        0.2662       229.2
spelvina       0.2515       242.7
nettle         0.4386       139.2

Hmm. 
Does this make any difference for you? For me it's the best one so far
(the linusas2 number clearly shows that for me the register renaming does
nothing; other than that the functions should be very similar)

artur
