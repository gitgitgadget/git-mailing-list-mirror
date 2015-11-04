From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Limit the size of the data block passed to SHA1_Update()
Date: Wed, 4 Nov 2015 14:51:04 -0500
Message-ID: <CAPig+cS7NktyhveQUiBFkRtJH1D-Aif861e9qshL2R=ZNg2+Lw@mail.gmail.com>
References: <56389FBC.7050909@web.de>
	<1446611086-6102-1-git-send-email-apahlevan@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: "atousa.p@gmail.com" <atousa.p@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:51:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu45U-0008Bi-1w
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 20:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965639AbbKDTvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 14:51:08 -0500
Received: from mail-yk0-f178.google.com ([209.85.160.178]:36788 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965374AbbKDTvF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 14:51:05 -0500
Received: by ykba4 with SMTP id a4so91885940ykb.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 11:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=PB3qwmkH0IuE0tA7qXcaIiFji/M7ivp7FIhgDhUSrjs=;
        b=rtDgHffM5xDo5IETIBL95UnabQNw86BMOGx8YGWKEtySMjkQV4uZWdXYzqJcStIxFL
         nMG6AjFcV5C7y5WYwKkNDs3q/BNnu9HjWwtnB7fi/twWbRtnZ3kln0PU2sE4+jsw8lda
         9hMQ1k/H/8PzhP1WiJVBEN2UTMVpPMR0XlZwBgCmYDj67tM6xRXVenfV8+2TmSfUqBv5
         WWS1OrFHo/kMtFDl17C3vnz7BmV/gbgd0IiSR80GXeT8LNd06EUcSmDS3QIJ/q386OZV
         sBzxi0hjKYup7DiY0UFKLwYpkg/t+59uxvesZv2o7v/PG37pJ5vZRx/IgqBlgFVdjFIn
         dm1w==
X-Received: by 10.31.2.193 with SMTP id 184mr3610082vkc.151.1446666665024;
 Wed, 04 Nov 2015 11:51:05 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Wed, 4 Nov 2015 11:51:04 -0800 (PST)
In-Reply-To: <1446611086-6102-1-git-send-email-apahlevan@ieee.org>
X-Google-Sender-Auth: 06cww8m8KNM8LQhi3v_lZuWyJ4U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280871>

On Tuesday, November 3, 2015, <atousa.p@gmail.com> wrote:
> [PATCH] Limit the size of the data block passed to SHA1_Update()

As an aid for reviewers, please include the version number of the
patch, such as [PATCH vN] where "N" is the revision. format-patch's -v
option can help automate this.

> Some implementations of SHA_Updates have inherent limits
> on the max chunk size. SHA1_MAX_BLOCK_SIZE can be defined
> to set the max chunk size supported, if required.  This is
> enabled for OSX CommonCrypto library and set to 1GiB.
>
> Signed-off-by: Atousa Pahlevan Duprat <apahlevan@ieee.org>
> ---

It is helpful to reviewers if you can describe here, below the "---"
line, how this version of the patch differs from the previous one.
More below...

> diff --git a/Makefile b/Makefile
> @@ -136,11 +136,15 @@ all::
>  # to provide your own OpenSSL library, for example from MacPorts.
>  #
>  # Define BLK_SHA1 environment variable to make use of the bundled
> -# optimized C SHA1 routine.
> +# optimized C SHA1 routine.  This implies NO_APPLE_COMMON_CRYPTO.
>  #
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
> @@ -986,6 +990,10 @@ ifeq (no,$(USE_PARENS_AROUND_GETTEXT_N))
>  endif
>  endif
>
> +ifdef BLK_SHA1
> +       NO_APPLE_COMMON_CRYPTO=1
> +endif

I think Junio already mentioned[1] that this change (and its
corresponding documentation update above) likely is undesirable, but I
just wanted to mention that you would typically want to split such a
change out to a separate patch since it's unrelated to the overall
intention of the current patch. More below...

[1]: http://article.gmane.org/gmane.comp.version-control.git/280859

>  ifeq ($(uname_S),Darwin)
>         ifndef NO_FINK
>                 ifeq ($(shell test -d /sw/lib && echo y),y)
> @@ -1346,6 +1354,8 @@ else
>  ifdef APPLE_COMMON_CRYPTO
>         COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
>         SHA1_HEADER = <CommonCrypto/CommonDigest.h>
> +       # Apple CommonCrypto requires chunking
> +       SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
>  else
>         SHA1_HEADER = <openssl/sha.h>
>         EXTLIBS += $(LIB_4_CRYPTO)
> @@ -1353,6 +1363,10 @@ endif
>  endif
>  endif
>
> +ifdef SHA1_MAX_BLOCK_SIZE
> +       LIB_OBJS += compat/sha1_chunked.o
> +       BASIC_CFLAGS += -DSHA1_MAX_BLOCK_SIZE="$(SHA1_MAX_BLOCK_SIZE)"
> +endif
> diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
> @@ -18,5 +18,5 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx);
>
>  #define git_SHA_CTX    blk_SHA_CTX
>  #define git_SHA1_Init  blk_SHA1_Init
> -#define git_SHA1_Update        blk_SHA1_Update
> +#define platform_SHA1_Update   blk_SHA1_Update
>  #define git_SHA1_Final blk_SHA1_Final
> diff --git a/cache.h b/cache.h
> index 79066e5..e345e38 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -10,12 +10,21 @@
>  #include "trace.h"
>  #include "string-list.h"
>
> +/* platform's underlying implementation of SHA1 */
>  #include SHA1_HEADER
>  #ifndef git_SHA_CTX
> -#define git_SHA_CTX    SHA_CTX
> -#define git_SHA1_Init  SHA1_Init
> -#define git_SHA1_Update        SHA1_Update
> -#define git_SHA1_Final SHA1_Final
> +#define git_SHA_CTX            SHA_CTX
> +#define git_SHA1_Init          SHA1_Init
> +#define platform_SHA1_Update   SHA1_Update
> +#define git_SHA1_Final         SHA1_Final
> +#endif

It's a bit ugly that this special-cases only "update" with the
"platform_" abstraction. It _might_ be preferable to generalize this
for all the SHA1 operations. If so, that's something you'd want to do
as a separate preparatory patch specifically aimed at adding this new
abstraction layer.

(In fact, even if you decide only to special-case "update", that still
might deserve a separate preparatory patch since it's a conceptually
distinct change from the overall focus of this patch, and would make
this patch less noisy, thus easier to review.)

> +/* choose chunked implementation or not */
> +#ifdef SHA1_MAX_BLOCK_SIZE
> +int git_SHA1_Update_Chunked(SHA_CTX *c, const void *data, size_t len);
> +#define git_SHA1_Update       git_SHA1_Update_Chunked
> +#else
> +#define git_SHA1_Update       platform_SHA1_Update
>  #endif
