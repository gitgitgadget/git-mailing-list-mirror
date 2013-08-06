From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/3] Makefile: Fix APPLE_COMMON_CRYPTO with BLK_SHA1
Date: Tue, 6 Aug 2013 04:25:43 -0700
Message-ID: <CAJDDKr7FHs0sKH9_r=QG9hs1Rp1_QgvqXyaiTkVLFVq0xMr8=A@mail.gmail.com>
References: <1375718364-13824-1-git-send-email-brian@gernhardtsoftware.com>
	<1375718364-13824-2-git-send-email-brian@gernhardtsoftware.com>
	<7v4nb4kosp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>,
	Jeremy Huddleston <jeremyhu@apple.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 13:26:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6fOr-0001kn-5C
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 13:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756041Ab3HFLZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 07:25:49 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:46836 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755350Ab3HFLZo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 07:25:44 -0400
Received: by mail-pd0-f172.google.com with SMTP id z11so223810pdj.31
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 04:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rX6WjSBhcQQeOKvo5vbLcNLDlS+dpIyxWMggeX29rn8=;
        b=LLK7xZvhgOF1XIf1gqC14rfWdaG7bGkzJlNdBUaD9/P07tCZ84mMAlkNHEeaw72Bpd
         Ft0IBssFVEz0vY1twHVJP4pFDL5iC1Jpxv9Oe2F+kYBsmmbz6z1PkDunRERpLoKmjZuy
         K/mXxa1ifjjUNCKioG4jhMscwjhEsO3CVkmUwTfq0QSVPpF1j1AITKWs3FememzUHQZt
         R2gr+qzk3QkUSJcGo3ReUtuP3UPttuYldh5awtDgaazGJ998M6j3mPm34PJ40h6iaLba
         BXZ9TSnMd2LA5GPeqxFv+HwgXyryVZIRDdXllEZbFD+0hrypOiplc+iG2zNS8vzyA1dm
         UJ1A==
X-Received: by 10.66.25.205 with SMTP id e13mr2584426pag.180.1375788343098;
 Tue, 06 Aug 2013 04:25:43 -0700 (PDT)
Received: by 10.70.95.230 with HTTP; Tue, 6 Aug 2013 04:25:43 -0700 (PDT)
In-Reply-To: <7v4nb4kosp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231733>

On Mon, Aug 5, 2013 at 10:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Brian Gernhardt <brian@gernhardtsoftware.com> writes:
>
>> It used to be that APPLE_COMMON_CRYPTO did nothing when BLK_SHA1 was
>> set.  But APPLE_COMMON_CRYPTO is now used for more than just SHA1 (see
>> 3ef2bca) so make sure that the appropriate libraries are always set.
>>
>> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
>> ---
>>  Makefile | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 82f2e22..7051956 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1182,6 +1182,9 @@ ifdef NEEDS_SSL_WITH_CRYPTO
>>  else
>>       LIB_4_CRYPTO = $(OPENSSL_LINK) -lcrypto
>>  endif
>> +ifdef APPLE_COMMON_CRYPTO
>> +     LIB_4_CRYPTO += -framework Security -framework CoreFoundation
>> +endif
>>  endif
>>  ifdef NEEDS_LIBICONV
>>       ifdef ICONVDIR
>> @@ -1413,7 +1416,6 @@ ifdef PPC_SHA1
>>       LIB_H += ppc/sha1.h
>>  else
>>  ifdef APPLE_COMMON_CRYPTO
>> -     LIB_4_CRYPTO += -framework Security -framework CoreFoundation
>>       COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
>>       SHA1_HEADER = <CommonCrypto/CommonDigest.h>
>>  else
>
> Hmph.
>
> So the people previously tested this must have built imap-send
> without blk-sha1, which not just linked with these libs but also
> included the <CommonCrypto/CommonDigest.h> header file and defined
> the -DCOMMON_DIGEST_FOR_OPENSSL preprocessor macro.  Building with
> blk-sha1 would not have worked for them.
> Now we always link with these libraries, even when building with
> blk-sha1.  Do the COMPAT_CFLAGS and SHA1_HEADER pieces only needed
> when using the SHA1 digest implementation from CommonCrypto and
> nothing imap-send uses?

LIB_4_CRYPTO is used by imap-send only, and these libraries are needed
for the base64 git_CC_EVP_(Encode|Decode), so unconditionally adding
these libraries there is correct.

COMPAT_CFLAGS and SHA1_HEADER enable the common crypto SHA1 only.
BLK_SHA1 provides its own SHA1 so they're not needed there.

I tested the tip of da/darwin (pu) w/ and w/out BLK_SHA1.

Tested-by: David Aguilar <davvid@gmail.com>
-- 
David
