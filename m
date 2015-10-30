From: Atousa Duprat <atousa.p@gmail.com>
Subject: Re: git fsck failure on OS X with files >= 4 GiB
Date: Thu, 29 Oct 2015 19:15:05 -0700
Message-ID: <CA+izobsBmYHHepYka795K2VnVLYBmN2tFqEyzSweMoS9gvuRVw@mail.gmail.com>
References: <CAG3jReJn2Pz6-bXLw6baOZaE1BHYiC+1-zN0eagigfG3umWpJA@mail.gmail.com>
	<CAEDE8505fXAwVXx=EZwxPHvXpMByzpnXJ9LBgfx3U6VUaFbPHw@mail.gmail.com>
	<CAG3jRe+23sy1k9QNdpdn3GF3nbzPMmYO=TM=SufEq83OtwNxbA@mail.gmail.com>
	<CAEDE853n2HR-SK9_sGn8n3j0xoTb3eQa86UvdW0DBrc+Z1sDrg@mail.gmail.com>
	<CA+izobtdwszVrYsnKU=_ytLuNbPGyRe_7kXqyrQO7u5Lo+OdPg@mail.gmail.com>
	<xmqqlhalsict.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Rafael_Esp=C3=ADndola?= <rafael.espindola@gmail.com>,
	Filipe Cabecinhas <filcab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 03:15:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrzDy-0006q9-HX
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 03:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169AbbJ3CPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 22:15:07 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:36512 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbbJ3CPG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 22:15:06 -0400
Received: by ykba4 with SMTP id a4so62398983ykb.3
        for <git@vger.kernel.org>; Thu, 29 Oct 2015 19:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BmHzheDgqRcRrlspe189KBr+BgifUuYARNKkitrdTMU=;
        b=monr3vOpn/r4UL9tYsfvSY0MG54yAKQLhZTSjYY2GLkOQvR8i1pKBFAZNJs2PL8fce
         8Ip4feZ2rqX8mo+JgUeNovaJUT+y0+7A8Iez+R13He4TzFVyGoqqFbwW9u3E13L6Hg27
         bB4yzzKGa7Johery6ifeshS2cCQLIuhzKUz6vKFRobDM0Vew4q//PsBdJxPitLYd7CcX
         94GRCFIN+DiRXgn7akfh/WNZ4n6L3K0rcajM7HTwhwanpsDYmobNKvJR5fjdJxj0YlJs
         vmzNcXJaAOOzvFwGQTR6T/TM297uRGPsHDgmF6ps1HiuiTlzxyRhBfnD7FFyZ+Y4ZIpI
         DAgA==
X-Received: by 10.129.106.193 with SMTP id f184mr4590762ywc.21.1446171305275;
 Thu, 29 Oct 2015 19:15:05 -0700 (PDT)
Received: by 10.37.91.198 with HTTP; Thu, 29 Oct 2015 19:15:05 -0700 (PDT)
In-Reply-To: <xmqqlhalsict.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280474>

Thank you for the feedback.  I have revised the proposed patch as
suggested, allowing the use of SHA1_MAX_BLOCK_SIZE to enable the
chunked implementation.  When building for OSX with the CommonCrypto
library we error out if SHA1_MAX_BLOCK_SIZE is not defined, which will
avoid compiling a version of the tool that won't compute hashes
properly on large files.  It should be easy to enable this on other
platforms if needed.

Atousa

On Thu, Oct 29, 2015 at 10:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Atousa Duprat <atousa.p@gmail.com> writes:
>
>> [PATCH] Limit the size of the data block passed to SHA1_Update()
>>
>> This avoids issues where OS-specific implementations use
>> a 32-bit integer to specify block size.  Limit currently
>> set to 1GiB.
>> ---
>>  cache.h | 20 +++++++++++++++++++-
>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/cache.h b/cache.h
>> index 79066e5..c305985 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -14,10 +14,28 @@
>>  #ifndef git_SHA_CTX
>>  #define git_SHA_CTX SHA_CTX
>>  #define git_SHA1_Init SHA1_Init
>> -#define git_SHA1_Update SHA1_Update
>>  #define git_SHA1_Final SHA1_Final
>>  #endif
>>
>> +#define SHA1_MAX_BLOCK_SIZE (1024*1024*1024)
>> +
>> +static inline int git_SHA1_Update(SHA_CTX *c, const void *data, size_t len)
>> +{
>> + size_t nr;
>> + size_t total = 0;
>> + char *cdata = (char*)data;
>> + while(len > 0) {
>> + nr = len;
>> + if(nr > SHA1_MAX_BLOCK_SIZE)
>> + nr = SHA1_MAX_BLOCK_SIZE;
>> + SHA1_Update(c, cdata, nr);
>> + total += nr;
>> + cdata += nr;
>> + len -= nr;
>> + }
>> + return total;
>> +}
>> +
>
> I think the idea illustrated above is a good start, but there are
> a few issues:
>
>  * SHA1_Update() is used in fairly many places; it is unclear if it
>    is a good idea to inline.
>
>  * There is no need to punish implementations with working
>    SHA1_Update by another level of wrapping.
>
>  * What would you do when you find an implementation for which 1G is
>    still too big?
>
> Perhaps something like this in the header
>
> #ifdef SHA1_MAX_BLOCK_SIZE
> extern int SHA1_Update_Chunked(SHA_CTX *, const void *, size_t);
> #define git_SHA1_Update SHA1_Update_Chunked
> #endif
>
> with compat/sha1_chunked.c that has
>
> #ifdef SHA1_MAX_BLOCK_SIZE
> int SHA1_Update_Chunked(SHA_CTX *c, const void *data, size_t len)
> {
>         ... your looping implementation ...
> }
> #endif
>
> in it, that is only triggered via a Makefile macro, e.g.
> might be a good workaround.
>
> diff --git a/Makefile b/Makefile
> index 8466333..83348b8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -139,6 +139,10 @@ all::
>  # Define PPC_SHA1 environment variable when running make to make use of
>  # a bundled SHA1 routine optimized for PowerPC.
>  #
> +# Define SHA1_MAX_BLOCK_SIZE if your SSH1_Update() implementation can
> +# hash only a limited amount of data in one call (e.g. APPLE_COMMON_CRYPTO
> +# may want 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined).
> +#
>  # Define NEEDS_CRYPTO_WITH_SSL if you need -lcrypto when using -lssl (Darwin).
>  #
>  # Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto (Darwin).
> @@ -1002,6 +1006,7 @@ ifeq ($(uname_S),Darwin)
>         ifndef NO_APPLE_COMMON_CRYPTO
>                 APPLE_COMMON_CRYPTO = YesPlease
>                 COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
> +               SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L
>         endif
>         NO_REGEX = YesPlease
>         PTHREAD_LIBS =
> @@ -1350,6 +1355,11 @@ endif
>  endif
>  endif
>
> +ifdef SHA1_MAX_BLOCK_SIZE
> +LIB_OBJS += compat/sha1_chunked.o
> +BASIC_CFLAGS += SHA1_MAX_BLOCK_SIZE="$(SHA1_MAX_BLOCK_SIZE)"
> +endif
> +
>  ifdef NO_PERL_MAKEMAKER
>         export NO_PERL_MAKEMAKER
>  endif



-- 
Atousa Pahlevan, PhD
M.Math. University of Waterloo, Canada
Ph.D. Department of Computer Science, University of Victoria, Canada
Voice: 415-341-6206
Email: apahlevan@ieee.org
Website: www.apahlevan.org
