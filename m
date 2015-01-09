From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] configure.ac: check for HMAC_CTX_cleanup
Date: Fri, 9 Jan 2015 00:37:08 -0500
Message-ID: <CAPig+cQb6k8ktWR5Fz+dstfhFj5dZ+kpfzVk1Vp5piYJ3zy4rg@mail.gmail.com>
References: <1420747257-16132-1-git-send-email-reubenhwk@gmail.com>
	<1420747257-16132-3-git-send-email-reubenhwk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Reuben Hawkins <reubenhwk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 06:37:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9SG4-0008SB-8W
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 06:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbbAIFhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 00:37:09 -0500
Received: from mail-yh0-f52.google.com ([209.85.213.52]:60792 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067AbbAIFhI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 00:37:08 -0500
Received: by mail-yh0-f52.google.com with SMTP id z6so3273440yhz.11
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 21:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=NmbmVxWg1mribqHH5zxmYldLHRsCYqMeEzz8it8M8xg=;
        b=jZ3jG/ErbntBdb/tW2suc2wrd8j61VANtwpegdrN0/a1cyuj60Kxdn5zQYHw8Kw4i4
         aen0cLWaCfcNfP86NfB1hSElTfwTllLIxsjNciOvcc7zQKqBNjRDfyEHrd/K/BjKELXx
         3xXY/Pc/PLl2uTCtQKe5dmr0nDieqebpN5d4QajsK1j0zjwf5K4rzUeRV0jpj0zpoBts
         hF8+g2FscfI18UQyTyXGzVVUIiYiykY8XVjwb8qr2PB0jhjjSiBINcuY/SY6HGysieAQ
         rKsWQhtssSfb207FAEDzYfhcc2jLstHpmdnn1u+oVWKlU4FA6LbvZmBk39ZVKBI4lyqF
         XhZQ==
X-Received: by 10.170.83.4 with SMTP id z4mr11349721ykz.103.1420781828106;
 Thu, 08 Jan 2015 21:37:08 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Thu, 8 Jan 2015 21:37:08 -0800 (PST)
In-Reply-To: <1420747257-16132-3-git-send-email-reubenhwk@gmail.com>
X-Google-Sender-Auth: ceO3U3nTn7jlsmqBl9A51O6EfSY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262229>

On Thu, Jan 8, 2015 at 3:00 PM, Reuben Hawkins <reubenhwk@gmail.com> wrote:
> OpenSSL version 0.9.6b and before defined the function HMAC_cleanup.
> Newer versions define HMAC_CTX_cleanup.  Check for HMAC_CTX_cleanup and
> fall back to HMAC_cleanup when the newer function is missing.
>
> Signed-off-by: Reuben Hawkins <reubenhwk@gmail.com>

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

Note that this patch has a minor and simple-to-resolve conflict with
b195aa00c1 (git-compat-util: suppress unavoidable Apple-specific
deprecation warnings; 2014-12-16) which was just promoted to master.
Junio may resolve it locally or ask you to re-send.

> ---
> diff --git a/Makefile b/Makefile
> index 57e33f2..2ce1f1f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -341,6 +341,9 @@ all::
>  # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime in librt.
>  #
>  # Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC in librt.
> +#
> +# Define NO_HMAC_CTX_CLEANUP if your OpenSSL is version 0.9.6b or earlier to
> +# cleanup the HMAC context with the older HMAC_cleanup function.
>
>  GIT-VERSION-FILE: FORCE
>         @$(SHELL_PATH) ./GIT-VERSION-GEN
> @@ -1061,6 +1064,9 @@ ifndef NO_OPENSSL
>         ifdef NEEDS_CRYPTO_WITH_SSL
>                 OPENSSL_LIBSSL += -lcrypto
>         endif
> +       ifdef NO_HMAC_CTX_CLEANUP
> +               BASIC_CFLAGS += -DNO_HMAC_CTX_CLEANUP
> +       endif
>  else
>         BASIC_CFLAGS += -DNO_OPENSSL
>         BLK_SHA1 = 1
> diff --git a/configure.ac b/configure.ac
> index c3293b9..9c66c3e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -924,6 +924,10 @@ AC_CHECK_LIB([iconv], [locale_charset],
>                       [CHARSET_LIB=-lcharset])])
>  GIT_CONF_SUBST([CHARSET_LIB])
>  #
> +# Define NO_HMAC_CTX_CLEANUP=YesPlease if HMAC_CTX_cleanup is missing.
> +AC_CHECK_LIB([crypto], [HMAC_CTX_cleanup],
> +       [], [GIT_CONF_SUBST([NO_HMAC_CTX_CLEANUP], [YesPlease])])
> +#
>  # Define HAVE_CLOCK_GETTIME=YesPlease if clock_gettime is available.
>  GIT_CHECK_FUNC(clock_gettime,
>         [HAVE_CLOCK_GETTIME=YesPlease],
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 400e921..2fdca2d 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -213,6 +213,9 @@ extern char *gitbasename(char *);
>  #ifndef NO_OPENSSL
>  #include <openssl/ssl.h>
>  #include <openssl/err.h>
> +#ifdef NO_HMAC_CTX_CLEANUP
> +#define HMAC_CTX_cleanup HMAC_cleanup
> +#endif
>  #endif
>
>  /* On most systems <netdb.h> would have given us this, but
> --
> 2.2.0.68.g8f72f0c.dirty
