From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v6 2/2] imap-send: eliminate HMAC deprecation warnings on
 Mac OS X
Date: Wed, 15 May 2013 20:28:33 -0700
Message-ID: <CAJDDKr7N8xbUxDDzy+BijiJet6C3KV1O-B4tmWRFuZ5odQUuEQ@mail.gmail.com>
References: <1368663120-47102-1-git-send-email-davvid@gmail.com>
	<1368663120-47102-2-git-send-email-davvid@gmail.com>
	<7v7gizahcn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 16 05:28:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucos1-000599-4x
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 05:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875Ab3EPD2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 23:28:35 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34811 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301Ab3EPD2e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 23:28:34 -0400
Received: by mail-wi0-f178.google.com with SMTP id ey16so2266187wid.17
        for <git@vger.kernel.org>; Wed, 15 May 2013 20:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=OBOO+UmwkMh2Qj0bcQKSYk4asKGRE6Cg1QiqNI9E0l0=;
        b=snDSc7rUW0xySjbIAekul+l4Vbcnqv2l360RRC6LVMWLUyeew+laZpUiStgVNF7g15
         MEYAnL2cE5Hdw2DCWGGcTk1Zv0vqisKgoTS4XbbpR/zEn65nVj6Zq2EerN4ly+gotxiq
         TexkLfED6gEJqE9mWZpHe/NCXXZNqwTc43Wi/JO+RiI0VXg2ep0DLQeIubsTW2UzrQXd
         6aaUuqxBcdR64t8Cola4dgO9t3D8lELI4nWZJX/O7FQ+V1AafE8dnQaStyySTjlNwCa0
         JZt2bUFPQ8tXIyQj48b5dJ+4FjGSI9B3jmjy6z29q8ydpVbexAgtNVaU61+gPvxX+KH7
         ZKZA==
X-Received: by 10.180.21.243 with SMTP id y19mr19939776wie.13.1368674913256;
 Wed, 15 May 2013 20:28:33 -0700 (PDT)
Received: by 10.194.240.195 with HTTP; Wed, 15 May 2013 20:28:33 -0700 (PDT)
In-Reply-To: <7v7gizahcn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224467>

On Wed, May 15, 2013 at 5:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> Mac OS X 10.8 Mountain Lion warns that HMAC_Init() and friends
>> are deprecated.  Detect the COMMON_CRYPTO_FOR_OPENSSL definition
>
> Ahh, I think you meant to use that name but forgot to adjust the
> symbol you use in the patch ;-)
>
> I'll queue with s/COMMON_DIGEST_FOR_OPENSSL/COMMON_CRYPTO_FOR_OPENSSL/;

The symbol in Apple's header is COMMON_DIGEST_FOR_OPENSSL.

I rebased this patch for so many bikesheds I was bound to screw up the
commit message ;-)

>> diff --git a/imap-send.c b/imap-send.c
>> index d9bcfb4..96012b1 100644
>> --- a/imap-send.c
>> +++ b/imap-send.c
>> @@ -29,8 +29,18 @@
>>  #ifdef NO_OPENSSL
>>  typedef void *SSL;
>>  #else
>> +#ifdef COMMON_DIGEST_FOR_OPENSSL

Yup, the symbol is fine.

>> +#include <CommonCrypto/CommonHMAC.h>
>> +#define HMAC_CTX CCHmacContext
>> +#define HMAC_Init(hmac, key, len, algo) CCHmacInit(hmac, algo, key, len)
>> +#define HMAC_Update CCHmacUpdate
>> +#define HMAC_Final(hmac, hash, ptr) CCHmacFinal(hmac, hash)
>> +#define HMAC_CTX_cleanup
>> +#define EVP_md5() kCCHmacAlgMD5
>> +#else
>>  #include <openssl/evp.h>
>>  #include <openssl/hmac.h>
>> +#endif
>>  #include <openssl/x509v3.h>
>>  #endif



--
David
