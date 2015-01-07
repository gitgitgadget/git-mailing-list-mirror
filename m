From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] configure.ac: check for clock_gettime and CLOCK_MONOTONIC
Date: Wed, 7 Jan 2015 16:37:22 -0500
Message-ID: <CAPig+cSx9FZtn=RH25OX97EBmbnKfVT66WsgtqenVZpm8LBjHQ@mail.gmail.com>
References: <CAPig+cSFAzsUj2sOaCyPTu_U8_c5qkF1qQo4nzecVzY0TqmJpg@mail.gmail.com>
	<1420662236-27593-1-git-send-email-reubenhwk@gmail.com>
	<1420662236-27593-3-git-send-email-reubenhwk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Reuben Hawkins <reubenhwk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 22:37:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8yIB-0001dp-Vu
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 22:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097AbbAGVhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 16:37:24 -0500
Received: from mail-yh0-f41.google.com ([209.85.213.41]:41246 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbbAGVhX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 16:37:23 -0500
Received: by mail-yh0-f41.google.com with SMTP id a41so1047431yho.28
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 13:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CPsr5b7cxTprTblWtn0RUfaKoPlNEBBF3eUlGv/DaOs=;
        b=r+fnYqrP8qNdMnkkc0pZoDVCTzEvYr1hw2mNKSC4NciMCzTy5H7eBpMS1FY68uATDB
         CtNsv86dZk0/mH/ny8A6HNzcxnz4r2T1hQkaW4x4MhNeoPVZ4tBNl2GqbhqgyZsPsHSO
         SzujCIpnkuaMnqxXsji8Oaha3vvLYWC1AngParz/+tRAJE7vHmravYP6sjlqcsr6U1XW
         l1M80YBK/JAjkXuA2mhK07cSxPR70BKG+8bS2B9Y66eozgRbBUjnGIS/4VISWQuybwBK
         YumAWox6IveuUAiiIMmW+sTEDcqZAJ7Cn87/ZID095e4b01EknfVSgZ+36VPTG5WDltN
         64Sw==
X-Received: by 10.236.8.6 with SMTP id 6mr3791877yhq.112.1420666642969; Wed,
 07 Jan 2015 13:37:22 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Wed, 7 Jan 2015 13:37:22 -0800 (PST)
In-Reply-To: <1420662236-27593-3-git-send-email-reubenhwk@gmail.com>
X-Google-Sender-Auth: MbDSMDe1U4D5YO8YN4oEq36fPko
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262161>

On Wed, Jan 7, 2015 at 3:23 PM, Reuben Hawkins <reubenhwk@gmail.com> wrote:
> CLOCK_MONOTONIC isn't available on RHEL3, but there are still RHEL3
> systems being used in production.  This change makes compiling git
> less tedious on older platforms without CLOCK_MONOTONIC.

The second sentence is implied by the very presence of this patch,
thus adds no value. I, personally, would drop it.

Also, your sign-off is missing (as mentioned in my previous review[1]).

> ---
> diff --git a/Makefile b/Makefile
> index 7482a4d..af551a0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1382,6 +1382,10 @@ ifdef HAVE_CLOCK_GETTIME
>         EXTLIBS += -lrt
>  endif
>
> +ifdef HAVE_CLOCK_MONOTONIC
> +       BASIC_CFLAGS += -DHAVE_CLOCK_MONOTONIC
> +endif

You need to document this new Makefile variable (HAVE_CLOCK_MONOTONIC)
at the top of Makefile (as mentioned in my previous review[1]), so
that people who build without running 'configure' will know that they
may need to tweak it.

>  ifeq ($(TCLTK_PATH),)
>  NO_TCLTK = NoThanks
>  endif
> diff --git a/configure.ac b/configure.ac
> index dcc4bf0..424dec5 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -923,6 +923,28 @@ AC_CHECK_LIB([iconv], [locale_charset],
>                       [CHARSET_LIB=-lcharset])])
>  GIT_CONF_SUBST([CHARSET_LIB])
>  #
> +# Define HAVE_CLOCK_GETTIME=YesPlease if clock_gettime is available.
> +GIT_CHECK_FUNC(clock_gettime,
> +[HAVE_CLOCK_GETTIME=YesPlease],
> +[HAVE_CLOCK_GETTIME=])
> +GIT_CONF_SUBST([HAVE_CLOCK_GETTIME])

You could simplify the above four lines to this one-liner:

    GIT_CHECK_FUNC(clock_gettime,
        GIT_CONF_SUBST([HAVE_CLOCK_GETTIME], [YesPlease]))

> +
> +AC_DEFUN([CLOCK_MONOTONIC_SRC], [
> +AC_LANG_PROGRAM([[
> +#include <time.h>
> +clockid_t id = CLOCK_MONOTONIC;
> +]], [])])

No need to pass empty trailing arguments in m4. It's customary to drop
them altogether (since they are implied).

> +#
> +# Define HAVE_CLOCK_MONOTONIC=YesPlease if CLOCK_MONOTONIC is available.
> +AC_MSG_CHECKING([for CLOCK_MONOTONIC])
> +AC_COMPILE_IFELSE([CLOCK_MONOTONIC_SRC],
> +       [AC_MSG_RESULT([yes])
> +       HAVE_CLOCK_MONOTONIC=YesPlease],
> +       [AC_MSG_RESULT([no])
> +       HAVE_CLOCK_MONOTONIC=])
> +GIT_CONF_SUBST([HAVE_CLOCK_MONOTONIC])

Ditto regarding simplification:

    AC_MSG_CHECKING([for CLOCK_MONOTONIC])
    AC_COMPILE_IFELSE([CLOCK_MONOTONIC_SRC],
        [AC_MSG_RESULT([yes])
        GIT_CONF_SUBST([HAVE_CLOCK_MONOTONIC], [YesPlease])],
        [AC_MSG_RESULT([no])])

> +#
>  # Define NO_SETITIMER if you don't have setitimer.
>  GIT_CHECK_FUNC(setitimer,
>  [NO_SETITIMER=],

[1]: http://article.gmane.org/gmane.comp.version-control.git/261630
