From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/3] cache.h: eliminate SHA-1 deprecation warnings on
 OS X 10.8
Date: Mon, 13 May 2013 03:55:54 -0400
Message-ID: <CAPig+cRGkhA9xd0d3QG3kGZTV3EXe-_S0j0x1+NkucNg_NU4dQ@mail.gmail.com>
References: <1368429635-5512-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 09:56:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubnc1-0004Fa-8P
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 09:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066Ab3EMHz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 03:55:56 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:39813 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232Ab3EMHz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 03:55:56 -0400
Received: by mail-lb0-f173.google.com with SMTP id t10so2015696lbi.18
        for <git@vger.kernel.org>; Mon, 13 May 2013 00:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=IyNJsIzSxfFf0oH0Hd7TJjBE8nkePPqVk7k82PUZbSw=;
        b=wFtQjbc5YlEZC9VE8zwrhwdP3kAOu5Ifj2yey3mo66E0kxFda4evWKv8ZAzuXFmpBS
         zpwYycA92+M3zmahW4ARw8ydX69HIqkJiIoOnZzPnNEwHXRJrNMVvbBeUcOfD3FX1NFA
         kXA+/bY3y10j0ERDpIh3ajoiksWPgNo6GTnJh0OzgX/GMbbvzwF4imIAmPVATkbIpwfH
         TMi9MktbWa7hNxfW+sP9fBbmDiVSMbGi8lwCqIl6nV9N834aYKn6pQpYhDPSMm67aQQe
         dYiJ5lAd2EcLmI35kq3eWIdpZ3MXeEXtSsFktf1X+ihMhIJ06ftCJ83QL3bnneVYrbMw
         VKYA==
X-Received: by 10.112.157.231 with SMTP id wp7mr5214484lbb.91.1368431754092;
 Mon, 13 May 2013 00:55:54 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Mon, 13 May 2013 00:55:54 -0700 (PDT)
In-Reply-To: <1368429635-5512-1-git-send-email-davvid@gmail.com>
X-Google-Sender-Auth: CHYd0vdQKVRL_14bIJfJshLxw6I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224103>

On Mon, May 13, 2013 at 3:20 AM, David Aguilar <davvid@gmail.com> wrote:
> Mac OS X Mountain Lion prints warnings when building git:
>
>         warning: 'SHA1_Init' is deprecated
>         (declared at /usr/include/openssl/sha.h:121)
>
> Silence the warnings by using the Common Digest SHA-1
> functions for SHA1_Init(), SHA1_Update(), and SHA1_Final().
>
> Add a COMMON_DIGEST_SHA1 option to the Makefile to allow
> choosing this implementation and define it by default on Darwin.
>
> Define COMMON_DIGEST_FOR_SHA1 to enable the OpenSSL compatibility
> macros in CommonDigest.h.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> Here's a replacement patch for what's in pu.
> This version uses the built-in #defines and can thus avoid
> touching cache.h.
>
>  Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 25282b4..9d174b9 100644
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
> +       BASIC_CFLAGS += -DCOMMON_DIGEST_FOR_SHA1=1

This is incorrect. As noted in my previous email, you need to define
COMMON_DIGEST_FOR_OPENSSL, not COMMON_DIGEST_FOR_SHA1, in order for
CommonDigest.h to provide the OpenSSL defines magically. Thus:

s/COMMON_DIGEST_FOR_SHA1=1/COMMON_DIGEST_FOR_OPENSSL/

> +       SHA1_HEADER = <CommonCrypto/CommonDigest.h>
> +else
>         SHA1_HEADER = <openssl/sha.h>
>         EXTLIBS += $(LIB_4_CRYPTO)
>  endif
>  endif
> +endif
>
>  ifdef COMMON_DIGEST_HMAC
>         BASIC_CFLAGS += -DCOMMON_DIGEST_FOR_HMAC=1
> --
> 1.8.3.rc1.47.g1b7707e
>
