From: Atousa Duprat <atousa.p@gmail.com>
Subject: Re: [PATCH] Limit the size of the data block passed to SHA1_Update()
Date: Mon, 2 Nov 2015 12:52:34 -0800
Message-ID: <CA+izobvbDYLvShT8TdDhe9UiYHVWw+Le+Yy4yOnvCYOWE0bhQQ@mail.gmail.com>
References: <CAPig+cRRjCDhdT-DvGtZqns1mMxygnxi=ZnRKzg+H_do7oRpqQ@mail.gmail.com>
	<1446359536-25829-1-git-send-email-apahlevan@ieee.org>
	<xmqqh9l5h8g3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Randall Becker <rsbecker@nexbridge.com>,
	Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 21:52:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtM5o-0006eg-4x
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 21:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbbKBUwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 15:52:36 -0500
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34837 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbbKBUwf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 15:52:35 -0500
Received: by ykek133 with SMTP id k133so153139853yke.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 12:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HkcOGw91qEjC6c7nLqXEWpg9Q7cC1bi45uP5ib1oA3A=;
        b=B5tHM5YKyuWE5J8c0A6ZV24irkBoYkByMzrcgD0x9sOaaYVb/FA4cVJkwpDR9x3GPj
         FnuecG+sRYBV8+BsLmgXa0cCNOejJIzpaFO7Btf1924e407AlGTCI4pzTtKaJCTOIWb1
         S9FEl5MswwH8s1NFlfPnQ63XFSnpyInW+umXu4zAI5q2HafyBIb686w5NpSLyBfUjQGJ
         ZPja9wWUy2ThuRPQ56c/RGLsCbfbJMG1cjS2vpRVla9pnM84i2bEM36lQ0zwQAQVCOnF
         ssa9E3/4q+sUDG1VK/WfoS/+fF6r+kZ8KCSoVtQv375lXr22N+4MuzjOTpHzRIjrfdcZ
         Oa8g==
X-Received: by 10.129.50.23 with SMTP id y23mr11581368ywy.329.1446497554824;
 Mon, 02 Nov 2015 12:52:34 -0800 (PST)
Received: by 10.37.91.198 with HTTP; Mon, 2 Nov 2015 12:52:34 -0800 (PST)
In-Reply-To: <xmqqh9l5h8g3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280717>

In the Makefile there is the following:

ifdef BLK_SHA1
        SHA1_HEADER = "block-sha1/sha1.h"
        LIB_OBJS += block-sha1/sha1.o
else
ifdef PPC_SHA1
        SHA1_HEADER = "ppc/sha1.h"
        LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
else
ifdef APPLE_COMMON_CRYPTO
        COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
        SHA1_HEADER = <CommonCrypto/CommonDigest.h>
        SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
else
        SHA1_HEADER = <openssl/sha.h>
        EXTLIBS += $(LIB_4_CRYPTO)
endif

which seems to imply that BLK_SHA1 and APPLE_COMMON_CRYPTO are
mutually exclusive?

On Sun, Nov 1, 2015 at 10:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> atousa.p@gmail.com writes:
>
>> diff --git a/cache.h b/cache.h
>> index 79066e5..ec84b16 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -14,7 +14,12 @@
>>  #ifndef git_SHA_CTX
>>  #define git_SHA_CTX  SHA_CTX
>>  #define git_SHA1_Init        SHA1_Init
>> -#define git_SHA1_Update      SHA1_Update
>> +#ifdef SHA1_MAX_BLOCK_SIZE
>> +extern int SHA1_Update_Chunked(SHA_CTX *, const void *, size_t);
>> +#define git_SHA1_Update SHA1_Update_Chunked
>> +#else
>> +#define git_SHA1_Update SHA1_Update
>> +#endif
>>  #define git_SHA1_Final       SHA1_Final
>>  #endif
>
> Hmm, I admit that this mess is my creation, but unfortunately it
> does not allow us to say:
>
>         make SHA1_MAX_BLOCK_SIZE='1024L*1024L*1024L'
>
> when using other SHA-1 implementations (e.g. blk_SHA1_Update()).
>
> Ideas for cleaning it up, anybody?
>



-- 
Atousa Pahlevan, PhD
M.Math. University of Waterloo, Canada
Ph.D. Department of Computer Science, University of Victoria, Canada
Voice: 415-341-6206
Email: apahlevan@ieee.org
Website: www.apahlevan.org
