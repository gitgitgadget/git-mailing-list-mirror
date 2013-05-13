From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 3/3] cache.h: eliminate SHA-1 deprecation warnings on
 OS X 10.8
Date: Mon, 13 May 2013 09:32:43 -0400
Message-ID: <CAPig+cQwhhwyt+XHXz2_PLqmZ=goy7pz-GC3kFqOHm1R6=70YA@mail.gmail.com>
References: <1368433419-24065-1-git-send-email-davvid@gmail.com>
	<1368433419-24065-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 15:32:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubsry-0005wZ-JR
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 15:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638Ab3EMNcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 09:32:46 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:50621 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab3EMNcp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 09:32:45 -0400
Received: by mail-lb0-f178.google.com with SMTP id p10so2687114lbv.37
        for <git@vger.kernel.org>; Mon, 13 May 2013 06:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=ltfcPuEYd1HBUQg3YwkOIS/g+4FrmhaN0yRYho8vGiA=;
        b=QmVjWI9wAXgtp9VfNzZru6m/Q1hLPHWZfFa2PN0GSSLWYWEaKIHpPYEHpeCFEkI35y
         qTXw0UjDCveGCkmwEGBtiNeV4LhNvuOPPB8donsDroq3np4QkreGlAVgKjx12ufRJEUb
         gNwZUFL2SpPXXUQE43C5H3O3K1PYbSR7RxJqqi9u3N5bgs+UW5RXSh6qUFk3qFvywAJd
         u4yfJm78ZjtpZQ874HGgY6TSIsHalTXSqnNjGsaQ0mw4KtdqKWFSpPFSZN2RiyNroLzV
         tTDnjyVkcLMlQdBs1ZnGQBur33cCPaLvTO70mjGmwHmJylrGnd5Cjc/tfQ5xEbUZXSWg
         2cGg==
X-Received: by 10.112.157.231 with SMTP id wp7mr5818482lbb.91.1368451963557;
 Mon, 13 May 2013 06:32:43 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Mon, 13 May 2013 06:32:43 -0700 (PDT)
In-Reply-To: <1368433419-24065-2-git-send-email-davvid@gmail.com>
X-Google-Sender-Auth: BKKk3FDzc3PpVbfPV0TnY_fO6Ec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224134>

On Mon, May 13, 2013 at 4:23 AM, David Aguilar <davvid@gmail.com> wrote:
> Mac OS X Mountain Lion prints warnings when building git:
>
>         warning: 'SHA1_Init' is deprecated
>         (declared at /usr/include/openssl/sha.h:121)
>
> Silence the warnings by using the CommonCrytpo SHA-1
> functions for SHA1_Init(), SHA1_Update(), and SHA1_Final().
>
> Add a COMMON_DIGEST_SHA1 option to the Makefile to allow
> choosing this implementation and define it by default on Darwin.

The approach of adding a Makefile option for each CommonCrypto
facility does not really scale well. For instance, these days, I
generally build git against OpenSSL from MacPorts, which gives me a
warning-free git build since MacPorts/OpenSSL lacks those
Apple-specific deprecation flags. With this patch series introducing
several Makefile knobs, people wishing to use MacPorts/OpenSSL will
have to tweak each knob. These patches already introduce two knobs
(COMMON_DIGEST_SHA1, COMMON_DIGEST_HMAC). Adding more knobs to silence
the remaining 29 deprecation warnings will make the build more
cumbersome for those who prefer OpenSSL. Instead, introducing a single
knob (such as APPLE_COMMON_CRYPTO) would avoid this problem.

More generally, is the approach of trying to figure out CommonCrypto
replacements for DIGEST, HMAC, and the other 29 warnings worthwhile?
After all, Apple introduced deprecation warnings due to the
ABI-instability of OpenSSL, not due to any particular flaw in OpenSSL
or its API. A more manageable approach might simply be to disable that
particular warning on Darwin (via CFLAGS or perhaps '#pragma GCC
diagnostic ignored' for more fine-grained control).

> Define COMMON_DIGEST_FOR_OPENSSL to enable the OpenSSL
> compatibility macros in CommonDigest.h.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> Changes since last round:
> COMMON_DIGEST_FOR_OPENSSL is used to enable the compatibility macros.
>
>  Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index a0f7afc..29c02ed 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1055,6 +1055,7 @@ ifeq ($(uname_S),Darwin)
>                 endif
>         endif
>         COMMON_DIGEST_HMAC = YesPlease
> +       COMMON_DIGEST_SHA1 = YesPlease
>         NO_REGEX = YesPlease
>         PTHREAD_LIBS =
>  endif
> @@ -1390,10 +1391,15 @@ ifdef PPC_SHA1
>         LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
>         LIB_H += ppc/sha1.h
>  else
> +ifdef COMMON_DIGEST_SHA1
> +       BASIC_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
> +       SHA1_HEADER = <CommonCrypto/CommonDigest.h>
> +else
>         SHA1_HEADER = <openssl/sha.h>
>         EXTLIBS += $(LIB_4_CRYPTO)
>  endif
>  endif
> +endif
>
>  ifdef COMMON_DIGEST_HMAC
>         BASIC_CFLAGS += -DCOMMON_DIGEST_FOR_HMAC
> --
> 1.8.3.rc1.52.g872cb7b
>
