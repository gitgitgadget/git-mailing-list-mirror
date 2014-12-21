From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] configure.ac: check tv_nsec field in struct stat
Date: Sun, 21 Dec 2014 15:20:16 -0500
Message-ID: <CAPig+cQWpq12axtJNsjoiKLKTpi6_xreS1fYDXYBtNv0Bj=T2Q@mail.gmail.com>
References: <1419188016-26134-1-git-send-email-reubenhwk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Reuben Hawkins <reubenhwk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 21:20:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2mzM-0006Bs-V3
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 21:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbaLUUUS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Dec 2014 15:20:18 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:42752 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbaLUUUR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Dec 2014 15:20:17 -0500
Received: by mail-yh0-f42.google.com with SMTP id v1so1776945yhn.15
        for <git@vger.kernel.org>; Sun, 21 Dec 2014 12:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=qCfjoR8GsgTz5HJV/YEKiZTNtpTgdQ1WXB3Woa1yCv8=;
        b=U4S0KhaaSLt9Z1AxqnruhEGQFxlgSz2FMOdmZTP0kNGOKOk/2l/uCi0R1Yhd+YliYK
         Ocj8Y86rJn20PUSrEoqWxr/obsTkrW/5nWJ1d6fgt/Nl8MUqtXdUsp0R4Tji6oNx7Ivr
         3/5DfjnYh2iGz5jFevSTl/mzX7+ME3xBiw1Bx8RKNm8p0pfBIu6gRNJcY/FmcoPa25LF
         CfuP+5KjXzc7Qn9qFrp6QFiKffRSycwL8uK41dNpb4k7hX31JlrwDX0e79J0hi6AFac1
         ZVwu1jaIH2yCKnxi490IdJqmtIhIIZt60b1b9LzpA/vUckcvKw46bM+UMVhjDaMw6WEC
         EY+Q==
X-Received: by 10.170.130.21 with SMTP id w21mr17620172ykb.22.1419193216366;
 Sun, 21 Dec 2014 12:20:16 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Sun, 21 Dec 2014 12:20:16 -0800 (PST)
In-Reply-To: <1419188016-26134-1-git-send-email-reubenhwk@gmail.com>
X-Google-Sender-Auth: rJG7kupdrou0QQx8kY2YyS5zXug
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261626>

On Sun, Dec 21, 2014 at 1:53 PM, Reuben Hawkins <reubenhwk@gmail.com> w=
rote:
> This check will automatically set the correct NO_NSEC setting.

Missing sign-off. See git/Documentation/SubmittingPatches.

> ---
> diff --git a/configure.ac b/configure.ac
> index 6af9647..3cfdd51 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -754,6 +754,25 @@ AC_CHECK_TYPES([struct itimerval],
>  [#include <sys/time.h>])
>  GIT_CONF_SUBST([NO_STRUCT_ITIMERVAL])
>  #
> +# Define HAVE_ST_MTIM=3DNo if you don't have struct stat.st_mtim.tv_=
nsec.

This comment is misleading. HAVE_ST_MTIM is never actually #defined or
set manually by the user, or used anywhere outside of the conditional
below. Also, the name itself is misleading: HAVE_ST_MTIM_NSEC would be
more appropriate.

> +AC_CHECK_MEMBER([struct stat.st_mtim.tv_nsec],
> +[HAVE_ST_MTIM=3DYes],
> +[HAVE_ST_MTIM=3DNo],

In Autoconf, it's customary to use lowercase values (such as "yes"
rather than "Yes") for these temporary variables. A "no" value is
usually represented by an empty assignment (HAVE_ST_MTIM=3D). However,
AC_CHECK_MEMBER() assigns the test result automatically to a shell
variable (in this case, named
ac_cv_member_struct_stat_st_mtim_tv_nsec), so there is no need to
invent your own (HAVE_ST_MTIM).

So, you can reduce this to:

   AC_CHECK_MEMBER([struct stat.st_mtim.tv_nsec])

and later check the value with

    test x$ac_cv_member_struct_stat_st_mtim_tv_nsec =3D yes

> +[#include <sys/stat.h>])
> +#
> +# Define HAVE_ST_MTIMESPEC=3DNo if you don't have struct stat.st_mti=
mespec.tv_nsec.

Ditto regarding misleading comment and variable name.

> +AC_CHECK_MEMBER([struct stat.st_mtimespec.tv_nsec],
> +[HAVE_ST_MTIMESPEC=3DYes],
> +[HAVE_ST_MTIMESPEC=3DNo],
> +[#include <sys/stat.h>])
> +#
> +# Define NO_NSEC if both HAVE_ST_MTIMESPEC and HAVE_ST_MTIM are set =
to No.
> +if test '(' "$HAVE_ST_MTIM" =3D "No" ')' -a '(' "$HAVE_ST_MTIMESPEC"=
 =3D "No" ')' ; then

Use of  'test -a' is unportable. The Autoconf manual has this to say:

    The -a, -o, =E2=80=98(=E2=80=99, and =E2=80=98)=E2=80=99 operands a=
re not present in all
    implementations, and have been marked obsolete by Posix 2008.

Instead, use:

    test ... && test ....

> +       NO_NSEC=3DYesPlease
> +       GIT_CONF_SUBST([NO_NSEC])

git-compat-util.h also needs to know if it should use st_ctimespec
rather than st_ctim. By this point, although indirect, you've
determined which of the two is available (if any), so as a bonus, you
can tell the build system about that, as well. Something like this,
perhaps:

    if test x$ac_cv_member_struct_stat_st_mtimspec_tv_nsec =3D xyes; th=
en
        USE_ST_TIMESPEC=3DYesPlease
        GIT_CONF_SUBST([USE_ST_TIMESPEC])
    elif test x$ac_cv_member_struct_stat_st_mtime_tv_nsec !=3D xyes; th=
en
        NO_NSEC=3DYesPlease
        GIT_CONF_SUBST([NO_NSEC])
    fi

> +fi
> +
> +#
>  # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct d=
irent.
>  AC_CHECK_MEMBER(struct dirent.d_ino,
>  [NO_D_INO_IN_DIRENT=3D],
> --
> 2.2.0.GIT
