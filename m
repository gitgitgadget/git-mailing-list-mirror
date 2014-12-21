From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] configure.ac,imap-send.c: check HMAC_CTX_cleanup
Date: Sun, 21 Dec 2014 16:28:18 -0500
Message-ID: <CAPig+cSFAzsUj2sOaCyPTu_U8_c5qkF1qQo4nzecVzY0TqmJpg@mail.gmail.com>
References: <1419188016-26134-1-git-send-email-reubenhwk@gmail.com>
	<1419188016-26134-3-git-send-email-reubenhwk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Reuben Hawkins <reubenhwk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 22:28:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2o37-0005vu-9z
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 22:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972AbaLUV2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 16:28:20 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:61031 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbaLUV2T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 16:28:19 -0500
Received: by mail-yk0-f169.google.com with SMTP id 79so1769810ykr.14
        for <git@vger.kernel.org>; Sun, 21 Dec 2014 13:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6Yl5Mw4prGVFBAJov7Gx+0ZFLMrchzS1JRdg7gkNeFA=;
        b=U9bpDRkWtZjeN77AST7aMHgDFijBy6iDV3YDskdxQFmJqj4JTMp6IGj+qBonxRLpn/
         4DLFTx+Wpge+AjT5/WWHfomwJvRS7+/bpjtRpGt3zjF3KC1wjCwwn/tLxCNM8JTm0b8w
         rRsux0jQWW6+VsHEKr3bv6CPLiQieCxI48FWU0D21mQpTnh/wedDgNR7Vv2wS1k9GOO4
         KYvaCrH+bdD2fULOP2+h6Z12XCUNEd9OPviP9F3ZrkUlNWEW9u41OvgjDyL4li7AFzoo
         qc71vgOpUNFytqjI4/WAtxssluq3wM98NjFxKka7CZ8667+egm/AddG8euejjKjM7BG8
         AxPA==
X-Received: by 10.236.8.100 with SMTP id 64mr15619751yhq.112.1419197298507;
 Sun, 21 Dec 2014 13:28:18 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Sun, 21 Dec 2014 13:28:18 -0800 (PST)
In-Reply-To: <1419188016-26134-3-git-send-email-reubenhwk@gmail.com>
X-Google-Sender-Auth: bekYgS3WO_xiu3O50fJDPA2pNU0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261631>

On Sun, Dec 21, 2014 at 1:53 PM, Reuben Hawkins <reubenhwk@gmail.com> wrote:
> Older versions of OpenSSL have HMAC_cleanup, but not HMAC_CTX_cleanup.
> This change checks for both, uses HMAC_CTX_cleanup on platforms which
> have it, otherwise falls back to HMAC_cleanup.

On this project, imperative mood is preferred. Also, this _is_ a patch
(implying "change"), so it's not necessary to say "This change". An
alternate way to write the above might be:

    Check for both, and use HMAC_CTX_cleanup when available,
    otherwise HMAC_cleanup.

> This changes makes building GIT on older platforms less tedious.

This is implied by the first paragraph, so no need to state it here explicitly.

More below.

> ---
> diff --git a/Makefile b/Makefile
> index 7482a4d..a495d94 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1059,6 +1059,12 @@ ifndef NO_OPENSSL
>         ifdef NEEDS_CRYPTO_WITH_SSL
>                 OPENSSL_LIBSSL += -lcrypto
>         endif
> +       ifdef HAVE_HMAC_CTX_CLEANUP
> +               BASIC_CFLAGS += -DHAVE_HMAC_CTX_CLEANUP
> +       endif
> +       ifdef HAVE_HMAC_CLEANUP
> +               BASIC_CFLAGS += -DHAVE_HMAC_CLEANUP
> +       endif

See discussion below regarding build breakage due to this incomplete change.

>  else
>         BASIC_CFLAGS += -DNO_OPENSSL
>         BLK_SHA1 = 1
> diff --git a/configure.ac b/configure.ac
> index 3900044..b22788c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -899,6 +899,7 @@ GIT_CONF_SUBST([SNPRINTF_RETURNS_BOGUS])
>  ## Checks for library functions.
>  ## (in default C library and libraries checked by AC_CHECK_LIB)
>  AC_MSG_NOTICE([CHECKS for library functions])
> +

Sneaking in unrelated whitespace change.

>  #
>  # Define NO_LIBGEN_H if you don't have libgen.h.
>  AC_CHECK_HEADER([libgen.h],
> @@ -932,6 +933,18 @@ AC_CHECK_LIB([iconv], [locale_charset],
>                       [CHARSET_LIB=-lcharset])])
>  GIT_CONF_SUBST([CHARSET_LIB])
>  #
> +# Define HAVE_HMAC_CTX_CLEANUP=Yes if we have the newer HMAC cleanup function

s/Yes/YesPease/
s/$/./

> +AC_CHECK_LIB([crypto], [HMAC_CTX_cleanup],
> +       [HAVE_HMAC_CTX_CLEANUP=Yes],
> +       [], [])

No need to pass trailing empty [] arguments explicitly in m4.

> +GIT_CONF_SUBST([HAVE_HMAC_CTX_CLEANUP])

You need to document this new variable in the comment block at the top
of Makefile so that people who build without running the configure
script will know that they may need to tweak it.

> +#
> +# Define HAVE_HMAC_CLEANUP=Yes if we have the older HMAC cleanup function

s/Yes/YesPease/
s/$/./

> +AC_CHECK_LIB([crypto], [HMAC_cleanup],
> +       [HAVE_HMAC_CLEANUP=Yes],
> +       [], [])
> +GIT_CONF_SUBST([HAVE_HMAC_CLEANUP])

This test for HMAC_cleanup() is likely overkill until we encounter a
system which has neither HMAC_CTX_cleanup() nor HMAC_cleanup(). For
the present, it's probably safe to assume that the older
HMAC_cleanup() is available everywhere when HMAC_CTX_cleanup() is not.

> +#
>  # Define NO_CLOCK_GETTIME if you don't have clock_gettime.
>  GIT_CHECK_FUNC(clock_gettime,
>  [HAVE_CLOCK_GETTIME=Yes],
> diff --git a/imap-send.c b/imap-send.c
> index 70bcc7a..eec2378 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -861,7 +861,13 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
>         HMAC_Init(&hmac, (unsigned char *)pass, strlen(pass), EVP_md5());
>         HMAC_Update(&hmac, (unsigned char *)challenge, decoded_len);
>         HMAC_Final(&hmac, hash, NULL);
> +#if defined(HAVE_HMAC_CTX_CLEANUP)
>         HMAC_CTX_cleanup(&hmac);
> +#elif defined(HAVE_HMAC_CLEANUP)
> +       HMAC_cleanup(&hmac);
> +#else
> +# error "no HMAC_cleanup function"
> +#endif

Several issues:

This change utterly breaks the build for people who do not run the
configure script since neither HAVE_HMAC_CTX_CLEANUP nor
HAVE_HMAC_CLEANUP Makefile variable is set (which means that the
corresponding C #defines are never made).

Somehow, you need to make sure that Makefile variable
HAVE_HMAC_CTX_CLEANUP is set by default since HMAC_CTX_cleanup() is
available on most platforms, and only a few much older ones lack it.
Typically, you would do this in config.make.uname, however, this is
one of those instances in which it is easier to disable a feature for
the rare case than to enable it for the common case. Therefore, it
would be more appropriate to name this variable NO_HMAC_CTX_CLEANUP
(and document it appropriately in Makefile).

Finally, rather than polluting imap-send.c with #if conditionals,
relegate the ugliness to git-compat-util.h. For instance, within the
'#ifndef NO_OPENSSL' conditional, you might add:

    #ifdef NO_HMAC_CTX_CLEANUP
    #define HMAC_CTX_cleanup HMAC_cleanup
    #endif

and then you don't have to touch imap-send.c at all.

>         hex[32] = 0;
>         for (i = 0; i < 16; i++) {
> --
> 2.2.0.GIT
