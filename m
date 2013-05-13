From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3 3/3] cache.h: eliminate SHA-1 deprecation warnings on
 OS X 10.8
Date: Mon, 13 May 2013 01:04:30 -0700
Message-ID: <CAJDDKr5Y0XZfiV8Xpm0KpbB5_nxAexBMhYnV5ZMwOznNSJ4PbA@mail.gmail.com>
References: <1368429635-5512-1-git-send-email-davvid@gmail.com>
	<CAPig+cRGkhA9xd0d3QG3kGZTV3EXe-_S0j0x1+NkucNg_NU4dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 13 10:04:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbnkM-0001YV-7c
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 10:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686Ab3EMIEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 04:04:33 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:60144 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663Ab3EMIEb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 04:04:31 -0400
Received: by mail-wi0-f181.google.com with SMTP id hi5so1235780wib.14
        for <git@vger.kernel.org>; Mon, 13 May 2013 01:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=cmzNp3ERsGXVQgJD9zAOWHx9FcxAlC3iivJ2tA0SWTM=;
        b=dE7T+Zj4U4bL4pGkjpC2zpIXK/ELF09J6vUPi5+c13+81B7KnoBlm279zAicXpWwrA
         OdEvkj9N+W6kw58zz/kDgej0JJtvezxGkNzr37k7nYRgaMjBfKnWEpTlgg6M/efyqpJ7
         NWJNpugByNUTYcPsvacvj9/sX2D7ckoViuubVJlaWjIws44SqbDEN3C3MwkzW9rqxJF6
         HFglDpgYHYdyB9N8d+EFWNHAoVZ2Vcqt7W4XS58kRuZlZH67EfOnH3mzYU8AbpgzjscY
         w6r6DV1PWvORobsQBqMb9o98kFmoaPAbq9WK5ZllaOMDW35Sf1f4NX8mDZEtEbt5Sm6o
         5B/Q==
X-Received: by 10.180.95.106 with SMTP id dj10mr16637585wib.1.1368432270517;
 Mon, 13 May 2013 01:04:30 -0700 (PDT)
Received: by 10.194.240.195 with HTTP; Mon, 13 May 2013 01:04:30 -0700 (PDT)
In-Reply-To: <CAPig+cRGkhA9xd0d3QG3kGZTV3EXe-_S0j0x1+NkucNg_NU4dQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224106>

On Mon, May 13, 2013 at 12:55 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, May 13, 2013 at 3:20 AM, David Aguilar <davvid@gmail.com> wrote:
>> Mac OS X Mountain Lion prints warnings when building git:
>>
>>         warning: 'SHA1_Init' is deprecated
>>         (declared at /usr/include/openssl/sha.h:121)
>>
>> Silence the warnings by using the Common Digest SHA-1
>> functions for SHA1_Init(), SHA1_Update(), and SHA1_Final().
>>
>> Add a COMMON_DIGEST_SHA1 option to the Makefile to allow
>> choosing this implementation and define it by default on Darwin.
>>
>> Define COMMON_DIGEST_FOR_SHA1 to enable the OpenSSL compatibility
>> macros in CommonDigest.h.
>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>> ---
>> Here's a replacement patch for what's in pu.
>> This version uses the built-in #defines and can thus avoid
>> touching cache.h.
>>
>>  Makefile | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Makefile b/Makefile
>> index 25282b4..9d174b9 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1055,6 +1055,7 @@ ifeq ($(uname_S),Darwin)
>>                 endif
>>         endif
>>         COMMON_DIGEST_HMAC = YesPlease
>> +       COMMON_DIGEST_SHA1 = YesPlease
>>         NO_REGEX = YesPlease
>>         PTHREAD_LIBS =
>>  endif
>> @@ -1390,10 +1391,15 @@ ifdef PPC_SHA1
>>         LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
>>         LIB_H += ppc/sha1.h
>>  else
>> +ifdef COMMON_DIGEST_SHA1
>> +       BASIC_CFLAGS += -DCOMMON_DIGEST_FOR_SHA1=1
>
> This is incorrect. As noted in my previous email, you need to define
> COMMON_DIGEST_FOR_OPENSSL, not COMMON_DIGEST_FOR_SHA1, in order for
> CommonDigest.h to provide the OpenSSL defines magically. Thus:
>
> s/COMMON_DIGEST_FOR_SHA1=1/COMMON_DIGEST_FOR_OPENSSL/

Yes, you're right.  Strangely, it compiled just fine either way which
is why I hadn't noticed.

I'll resend along w/ a replacement for 2/3 to drop the "=1" in the -D
definition.
--
David
