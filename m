From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] configure.ac,trace.c: check for CLOCK_MONOTONIC
Date: Sun, 21 Dec 2014 15:54:30 -0500
Message-ID: <CAPig+cRu9SoFVmgmU2BF=oi4AUZWCs8RFsjEuKtEvm-wzRkk1g@mail.gmail.com>
References: <1419188016-26134-1-git-send-email-reubenhwk@gmail.com>
	<1419188016-26134-2-git-send-email-reubenhwk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Reuben Hawkins <reubenhwk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 21:54:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2nWg-00066k-C8
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 21:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468AbaLUUyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 15:54:41 -0500
Received: from mail-yk0-f172.google.com ([209.85.160.172]:55866 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385AbaLUUya (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 15:54:30 -0500
Received: by mail-yk0-f172.google.com with SMTP id 131so1761256ykp.3
        for <git@vger.kernel.org>; Sun, 21 Dec 2014 12:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=fKELzEVP87zwrou9+fuXO0QuV7WyEsW0Edk40NfJBCA=;
        b=ZMoCcNjN2qtiYtKjLO26J5k1z07hQeDyCHxhImn1kAJilh1rB5NKSm2kN+fJsO4M5b
         Cab8SkYIjk6TAav2B6ibcewohUmaUJgob4OQNP+TY/J633NnYqZCUG14cyuNH9iu5Rve
         Vhf/7dLiY0OoSTLqpEZJbDh8JmC2A4HvZ1adXkGMWNRoyU3rTJboAHckcCHvyXFlfUcZ
         XLCeo/HvU3gQhk6/UxIs0qARTJkRkx+O4FMza53eODzbHANSBOqcH7Fdz4DJUGhRj/i0
         kPSchR+mTA7qZ4BA4yCQ0KSMhNURKCis3q4jAdjeZpOJ+NIdH/+y0y4QpweagQ8H6wIC
         n+nQ==
X-Received: by 10.170.78.130 with SMTP id u124mr17274090yku.91.1419195270199;
 Sun, 21 Dec 2014 12:54:30 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Sun, 21 Dec 2014 12:54:30 -0800 (PST)
In-Reply-To: <1419188016-26134-2-git-send-email-reubenhwk@gmail.com>
X-Google-Sender-Auth: YL3M04fZ1HodT74JS35gag7bUYY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261630>

On Sun, Dec 21, 2014 at 1:53 PM, Reuben Hawkins <reubenhwk@gmail.com> wrote:
> CLOCK_MONOTONIC isn't available on RHEL3, but there are still RHEL3
> systems being used in production.  This change makes compiling git
> less tedious on older platforms.

Missing sign-off.

> ---
> diff --git a/configure.ac b/configure.ac
> index 3cfdd51..3900044 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -736,8 +736,10 @@ GIT_UNSTASH_FLAGS($ICONVDIR)
>
>  GIT_CONF_SUBST([OLD_ICONV])
>
> +
>  ## Checks for typedefs, structures, and compiler characteristics.
>  AC_MSG_NOTICE([CHECKS for typedefs, structures, and compiler characteristics])
> +

Sneaking in a couple whitespace changes unrelated the patch's stated
purpose. Such cleanup should be done typically as a separate
preparatory patch (though they probably aren't warranted in this
case).

>  #
>  TYPE_SOCKLEN_T
>  case $ac_cv_type_socklen_t in
> @@ -930,6 +932,30 @@ AC_CHECK_LIB([iconv], [locale_charset],
>                       [CHARSET_LIB=-lcharset])])
>  GIT_CONF_SUBST([CHARSET_LIB])
>  #
> +# Define NO_CLOCK_GETTIME if you don't have clock_gettime.

The comment talks about NO_CLOCK_GETTIME, however, the code names it
HAVE_CLOCK_GETTIME.

> +GIT_CHECK_FUNC(clock_gettime,
> +[HAVE_CLOCK_GETTIME=Yes],

For consistency with other build values: s/Yes/YesPlease/

> +[HAVE_CLOCK_GETTIME=])
> +GIT_CONF_SUBST([HAVE_CLOCK_GETTIME])
> +
> +AC_DEFUN([CLOCK_MONOTONIC_SRC], [
> +AC_LANG_PROGRAM([[
> +#include <time.h>
> +clockid_t id = CLOCK_MONOTONIC;
> +]], [])])
> +
> +#
> +# Define NO_CLOCK_MONOTONIC on really old systems that are still in production
> +# if you need GIT to compile but can't update the machine otherwise.

The comment talks about NO_CLOCK_MONOTONIC, however, the code names it
HAVE_CLOCK_MONOTONIC.

The "old systems .. need GIT to compile ... can't update" commentary
is unnecessary. That's pretty well implied by the mere use of
Autoconf. It would be sufficient to say "Define ... if you don't have
CLOCK_MONOTONIC."

> +AC_MSG_CHECKING([for CLOCK_MONOTONIC])
> +AC_COMPILE_IFELSE([CLOCK_MONOTONIC_SRC],
> +       [AC_MSG_RESULT([yes])
> +       HAVE_CLOCK_MONOTONIC=Yes],

Consistency: s/Yes/YesPlease/

> +       [AC_MSG_RESULT([no])
> +       HAVE_CLOCK_MONOTONIC=])
> +
> +GIT_CONF_SUBST([HAVE_CLOCK_MONOTONIC])

Be aware that this does not actually #define HAVE_CLOCK_MONOTONIC
anywhere. It only sets a Makefile variable in config.mak.autogen.
(Consequently, this patch it actually breaks support for this feature
in trace.c for people who build without running the configure script.)
You need to do extra work to get the #define.

In particular, add a comment to Makefile describing the
HAVE_CLOCK_MONOTONIC setting. (Placing it just below the existing
comment for HAVE_CLOCK_GETTIME would make loads of sense.)

Next, add code to the Makefile to actually #define
HAVE_CLOCK_MONOTONIC. Something like this (alongside the existing
HAVE_CLOCK_GETTIME code):

    ifdef HAVE_CLOCK_MONOTONIC
        BASIC_CFLAGS += -DHAVE_CLOCK_MONOTONIC
    endif

Finally, update config.make.uname to set
HAVE_CLOCK_MONOTONIC=YesPlease on platforms which are likely to have
it (for people who don't run the configure script). At the very least,
it should be enabled by default for Linux.

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
> 2.2.0.GIT
