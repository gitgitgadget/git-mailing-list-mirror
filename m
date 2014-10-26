From: David Michael <fedora.dm0@gmail.com>
Subject: Re: [PATCH 3/3] compat/bswap.h: Detect endianness from XL C compiler macros
Date: Sun, 26 Oct 2014 16:04:01 -0400
Message-ID: <CAEvUa7mcJhYwivQjbWnVEXj_+fhCS+2edCFWjmEotOXKahQdww@mail.gmail.com>
References: <87k33mag65.fsf@gmail.com>
	<20141026183815.GB18144@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 26 21:04:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiU2q-00034E-J5
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 21:04:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbaJZUED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 16:04:03 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35892 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbaJZUEC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 16:04:02 -0400
Received: by mail-pd0-f170.google.com with SMTP id z10so4329070pdj.15
        for <git@vger.kernel.org>; Sun, 26 Oct 2014 13:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7qipUW1QCSgyHzXndrYP4QBJxHw+kRuZ6eqP+TvzCFY=;
        b=ufOj30vnYCyS4FKTNyLVy4A+3/NtcPkHZairtwJtsyoOvXJviqc5AIGdiNjr/1ebQ3
         7XOarn8q/JO8XbQvfznvMfXoehfSAUSHgDfMrdYTA1bSwHx4LxyItdYY/W1k5P2aNis1
         9JLoOvJ5RvwGTS6aGnDvZhYTv5Eur6RlYGln722rBPyPP4eno26zsDJad890UiMfatfN
         Ct1eGxRuENiUnDRz6fxyPqf2ZKqzoK0gsHJerMqmApVCASRuawKt1Iw24ndeAkQaNjWK
         5pT2LFwH0TzmNCJgRis3fN9nHO1Rx4rmhqBVeymRhn0y6o6xuT1lLPpdcmYPijvR+jSY
         HmjA==
X-Received: by 10.66.146.71 with SMTP id ta7mr4706511pab.16.1414353841617;
 Sun, 26 Oct 2014 13:04:01 -0700 (PDT)
Received: by 10.70.84.9 with HTTP; Sun, 26 Oct 2014 13:04:01 -0700 (PDT)
In-Reply-To: <20141026183815.GB18144@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 26, 2014 at 2:38 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Oct 26, 2014 at 01:34:26PM -0400, David Michael wrote:
>
>> diff --git a/compat/bswap.h b/compat/bswap.h
>> index f6fd9a6..7fed637 100644
>> --- a/compat/bswap.h
>> +++ b/compat/bswap.h
>> @@ -122,6 +122,10 @@ static inline uint64_t git_bswap64(uint64_t x)
>>  #  define GIT_BYTE_ORDER GIT_BIG_ENDIAN
>>  # elif defined(_LITTLE_ENDIAN) && !defined(_BIG_ENDIAN)
>>  #  define GIT_BYTE_ORDER GIT_LITTLE_ENDIAN
>> +# elif defined(__THW_BIG_ENDIAN__) && !defined(__THW_LITTLE_ENDIAN__)
>> +#  define GIT_BYTE_ORDER GIT_BIG_ENDIAN
>> +# elif defined(__THW_LITTLE_ENDIAN__) && !defined(__THW_BIG_ENDIAN__)
>> +#  define GIT_BYTE_ORDER GIT_LITTLE_ENDIAN
>
> Out of curiosity, is there ever a case where _both_ are defined? That
> is, would:
>
> diff --git a/compat/bswap.h b/compat/bswap.h
> index f6fd9a6..b78a0bd 100644
> --- a/compat/bswap.h
> +++ b/compat/bswap.h
> @@ -122,6 +122,10 @@ static inline uint64_t git_bswap64(uint64_t x)
>  #  define GIT_BYTE_ORDER GIT_BIG_ENDIAN
>  # elif defined(_LITTLE_ENDIAN) && !defined(_BIG_ENDIAN)
>  #  define GIT_BYTE_ORDER GIT_LITTLE_ENDIAN
> +# elif defined(__THW_BIG_ENDIAN__)
> +#  define GIT_BYTE_ORDER GIT_BIG_ENDIAN
> +# elif defined(__THW_LITTLE_ENDIAN__)
> +#  define GIT_BYTE_ORDER GIT_LITTLE_ENDIAN
>  # else
>  #  error "Cannot determine endianness"
>  # endif
>
> be enough, or is that used to mark some other special case? Even if not,
> there is not much downside to the more thorough conditions you put
> above, but as a reviewer I wondered if there is something else going on.

I'm not 100% sure if __THW_LITTLE_ENDIAN__ will ever be defined, so
I'd be okay with dropping those references completely.  There is a
recent version of the compiler for little endian Linux distributions,
but I haven't found the documentation for it.  (The product
documentation still seems to only refer to the big endian Linux
version.)  The compiler's macro may be redundant in this case anyway,
since Linux systems should have <bits/endian.h> supplying that
information.

I only used both macros for completeness; the __THW_BIG_ENDIAN__ macro
(defined to 1 on z/OS and AIX) is what I actually needed here.  z/OS
doesn't seem to have any other compile-time byte order indicator,
short of testing for the OS itself.

Would you prefer the two-line patch to only test for the big endian
macro, or maybe just test for __MVS__ to look at the OS?

Thanks.

David
