From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] configure.ac: check for HMAC_CTX_cleanup
Date: Wed, 7 Jan 2015 16:46:07 -0500
Message-ID: <CAPig+cQ5dibu7ETWLfO5zbeeuVu2rcTDP3ghN9pt1cLrw141uw@mail.gmail.com>
References: <CAPig+cSFAzsUj2sOaCyPTu_U8_c5qkF1qQo4nzecVzY0TqmJpg@mail.gmail.com>
	<1420662236-27593-1-git-send-email-reubenhwk@gmail.com>
	<1420662236-27593-4-git-send-email-reubenhwk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Reuben Hawkins <reubenhwk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 22:46:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8yQg-0005UH-0c
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 22:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941AbbAGVqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 16:46:09 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:64450 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611AbbAGVqH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 16:46:07 -0500
Received: by mail-yk0-f177.google.com with SMTP id 9so995995ykp.36
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 13:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pHBf4MFh6X0iiuKIR1EOCHx+ZLe22fAPiv6/2QjZMGQ=;
        b=egQ8S8S43EeoY4aBzshu740Q3mUZRhTiBtKzwJtsLJIZtzJeNSlP/G0NlRBM3xQyId
         1Bcl/xbhyelkiJN6pMYu4VHFWPDoolsFmSnO2RK40zw87rzJPIalD9ERTxcIQNrgcxOz
         l8ixX7IKda8PjWWfI/mVeRIzL0hpeXQdDqM1n4ES0f6VRZw2cIxxynH4bcG30xbwnhU3
         iQXoU6dYvUE9BlaOZB+vcuHYSO6uQ3QKLsenSNiVC6zH2+AYApvcpP5Q4pT1/Bs+Ei/9
         BXsxquGkpgNyjk6IQ6NBGgA64GgOfSJ7imFvFhNA5aHmU66HFOMbV5Y+irH5NR54U0i5
         MCIg==
X-Received: by 10.170.119.7 with SMTP id l7mr4062597ykb.51.1420667167178; Wed,
 07 Jan 2015 13:46:07 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Wed, 7 Jan 2015 13:46:07 -0800 (PST)
In-Reply-To: <1420662236-27593-4-git-send-email-reubenhwk@gmail.com>
X-Google-Sender-Auth: SZpiCyELsH9iZy4Wp6owSU8ev78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262162>

On Wed, Jan 7, 2015 at 3:23 PM, Reuben Hawkins <reubenhwk@gmail.com> wrote:
> OpenSSL version 0.9.6b and before defined the function HMAC_cleanup.
> Newer versions define HMAC_CTX_cleanup.  Check for HMAC_CTX_cleanup and
> fall back to HMAC_cleanup when the newer function is missing.

Missing sign-off.

Overall, these patches are nicely improved from the previous round. A
few more comments below...

> ---
>  Makefile          | 3 +++
>  configure.ac      | 7 +++++++
>  git-compat-util.h | 3 +++
>  3 files changed, 13 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index af551a0..d3c2b58 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1059,6 +1059,9 @@ ifndef NO_OPENSSL
>         ifdef NEEDS_CRYPTO_WITH_SSL
>                 OPENSSL_LIBSSL += -lcrypto
>         endif
> +       ifdef NO_HMAC_CTX_CLEANUP
> +               BASIC_CFLAGS += -DNO_HMAC_CTX_CLEANUP
> +       endif

You need to document this new Makefile variable (NO_HMAC_CTX_CLEANUP)
at the top of Makefile (as mentioned in my previous review[1]).

[1]: http://article.gmane.org/gmane.comp.version-control.git/261631

>  else
>         BASIC_CFLAGS += -DNO_OPENSSL
>         BLK_SHA1 = 1
> diff --git a/configure.ac b/configure.ac
> index 424dec5..c282663 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -923,6 +923,13 @@ AC_CHECK_LIB([iconv], [locale_charset],
>                       [CHARSET_LIB=-lcharset])])
>  GIT_CONF_SUBST([CHARSET_LIB])
>  #
> +# Define NO_HMAC_CTX_CLEANUP=YesPlease if HMAC_CTX_cleanup is missing.
> +AC_CHECK_LIB([crypto], [HMAC_CTX_cleanup],
> +       [NO_HMAC_CTX_CLEANUP=],
> +       [NO_HMAC_CTX_CLEANUP=YesPlease],
> +       [])
> +GIT_CONF_SUBST([NO_HMAC_CTX_CLEANUP])

It is customary to drop empty trailing arguments in m4.

Also, you can simplify this entire check to:

    AC_CHECK_LIB([crypto], [HMAC_CTX_cleanup],
        [], [GIT_CONF_SUBST([NO_HMAC_CTX_CLEANUP], [YesPlease])])

>  # Define HAVE_CLOCK_GETTIME=YesPlease if clock_gettime is available.
>  GIT_CHECK_FUNC(clock_gettime,
>  [HAVE_CLOCK_GETTIME=YesPlease],
