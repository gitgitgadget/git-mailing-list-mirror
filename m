From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] configure.ac: check for clock_gettime and CLOCK_MONOTONIC
Date: Fri, 9 Jan 2015 00:36:41 -0500
Message-ID: <CAPig+cRd5+9nq3YNA6e1R_tvmBTHByOg-=KRWG1m3Fxb0e_vFQ@mail.gmail.com>
References: <1420747257-16132-1-git-send-email-reubenhwk@gmail.com>
	<1420747257-16132-2-git-send-email-reubenhwk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Reuben Hawkins <reubenhwk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 06:37:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9SFa-0005pt-GK
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 06:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452AbbAIFgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 00:36:42 -0500
Received: from mail-yh0-f53.google.com ([209.85.213.53]:44032 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034AbbAIFgl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 00:36:41 -0500
Received: by mail-yh0-f53.google.com with SMTP id i57so3267290yha.12
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 21:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MKuJaUrcs+3JrrWewGHaYqzJTJDuNPWpf6BUK9pYFDA=;
        b=wa5umim433odKHVH8HTgLTKmncBqzTiuvM3hMcmALjjuS9Jph2dN02q/ufuH66/fut
         tE0F93oU7aD6gMw6o3gTPkfr+yKEu+dBv3Bhk0z8xCkQqe4Bhc9xfFcyDCzhebFeebSG
         Il7Nq7T0YOPleHy0k7JbjOIfmkY2F0nPzAdjbOwydPLuld9lwFt7LF+hiTJNI/Y4caNk
         QZWFEHddvhdVyWAFOLMDakaPUBxMKnjNgbG1eHd+2Il1mFPgV5kx8qGzthHO3pRPdUO+
         TgFH0TvvEvv0z51e5M2JXi7N7jPNZyIoavB51N86gItVl7llLc3XASmLo3fs18X19FU2
         FNag==
X-Received: by 10.236.8.6 with SMTP id 6mr10056493yhq.112.1420781801181; Thu,
 08 Jan 2015 21:36:41 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Thu, 8 Jan 2015 21:36:41 -0800 (PST)
In-Reply-To: <1420747257-16132-2-git-send-email-reubenhwk@gmail.com>
X-Google-Sender-Auth: 7p7_w-6aoJkZQqpNILolICd2BXs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262230>

On Thu, Jan 8, 2015 at 3:00 PM, Reuben Hawkins <reubenhwk@gmail.com> wrote:
> The checks will override and unset YesPlease settings for HAVE_CLOCK_GETTIME
> and HAVE_CLOCK_MONOTONIC in config.mak.uname.

I find this hard to grok and would rewrite it as:

    Set or clear Makefile variables HAVE_CLOCK_GETTIME and
    HAVE_CLOCK_MONOTONIC based upon results of the checks (overriding
    default values from config.mak.uname).

> CLOCK_MONOTONIC isn't available on RHEL3, but there are still RHEL3 systems
> being used in production.
>
> Signed-off-by: Reuben Hawkins <reubenhwk@gmail.com>

With or without the minor rewrite above...

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

> ---
> diff --git a/Makefile b/Makefile
> index 7482a4d..57e33f2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -339,6 +339,8 @@ all::
>  # return NULL when it receives a bogus time_t.
>  #
>  # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime in librt.
> +#
> +# Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC in librt.
>
>  GIT-VERSION-FILE: FORCE
>         @$(SHELL_PATH) ./GIT-VERSION-GEN
> @@ -1382,6 +1384,10 @@ ifdef HAVE_CLOCK_GETTIME
>         EXTLIBS += -lrt
>  endif
>
> +ifdef HAVE_CLOCK_MONOTONIC
> +       BASIC_CFLAGS += -DHAVE_CLOCK_MONOTONIC
> +endif
> +
>  ifeq ($(TCLTK_PATH),)
>  NO_TCLTK = NoThanks
>  endif
> diff --git a/config.mak.uname b/config.mak.uname
> index a2f380f..926773e 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -35,6 +35,7 @@ ifeq ($(uname_S),Linux)
>         LIBC_CONTAINS_LIBINTL = YesPlease
>         HAVE_DEV_TTY = YesPlease
>         HAVE_CLOCK_GETTIME = YesPlease
> +       HAVE_CLOCK_MONOTONIC = YesPlease
>  endif
>  ifeq ($(uname_S),GNU/kFreeBSD)
>         HAVE_ALLOCA_H = YesPlease
> diff --git a/configure.ac b/configure.ac
> index 210eb4e..c3293b9 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -924,6 +924,28 @@ AC_CHECK_LIB([iconv], [locale_charset],
>                       [CHARSET_LIB=-lcharset])])
>  GIT_CONF_SUBST([CHARSET_LIB])
>  #
> +# Define HAVE_CLOCK_GETTIME=YesPlease if clock_gettime is available.
> +GIT_CHECK_FUNC(clock_gettime,
> +       [HAVE_CLOCK_GETTIME=YesPlease],
> +       [HAVE_CLOCK_GETTIME=])
> +GIT_CONF_SUBST([HAVE_CLOCK_GETTIME])
> +
> +AC_DEFUN([CLOCK_MONOTONIC_SRC], [
> +AC_LANG_PROGRAM([[
> +#include <time.h>
> +clockid_t id = CLOCK_MONOTONIC;
> +]])])
> +
> +#
> +# Define HAVE_CLOCK_MONOTONIC=YesPlease if CLOCK_MONOTONIC is available.
> +AC_MSG_CHECKING([for CLOCK_MONOTONIC])
> +AC_COMPILE_IFELSE([CLOCK_MONOTONIC_SRC],
> +       [AC_MSG_RESULT([yes])
> +       HAVE_CLOCK_MONOTONIC=YesPlease],
> +       [AC_MSG_RESULT([no])
> +       HAVE_CLOCK_MONOTONIC=])
> +GIT_CONF_SUBST([HAVE_CLOCK_MONOTONIC])
> +#
>  # Define NO_SETITIMER if you don't have setitimer.
>  GIT_CHECK_FUNC(setitimer,
>  [NO_SETITIMER=],
> diff --git a/trace.c b/trace.c
> index 4778608..bfbd48f 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -324,7 +324,7 @@ int trace_want(struct trace_key *key)
>         return !!get_trace_fd(key);
>  }
>
> -#ifdef HAVE_CLOCK_GETTIME
> +#if defined(HAVE_CLOCK_GETTIME) && defined(HAVE_CLOCK_MONOTONIC)
>
>  static inline uint64_t highres_nanos(void)
>  {
> --
> 2.2.0.68.g8f72f0c.dirty
