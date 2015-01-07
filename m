From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] configure.ac: check tv_nsec field in struct stat
Date: Wed, 7 Jan 2015 16:19:25 -0500
Message-ID: <CAPig+cSrht0fovEWhEknxPPzwZhA7vzeLcM+omaM7PR752GfGw@mail.gmail.com>
References: <CAPig+cSFAzsUj2sOaCyPTu_U8_c5qkF1qQo4nzecVzY0TqmJpg@mail.gmail.com>
	<1420662236-27593-1-git-send-email-reubenhwk@gmail.com>
	<1420662236-27593-2-git-send-email-reubenhwk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Reuben Hawkins <reubenhwk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 22:20:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8y0p-00071c-7U
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 22:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676AbbAGVT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 16:19:27 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:39621 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbbAGVT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 16:19:26 -0500
Received: by mail-yk0-f169.google.com with SMTP id 79so982246ykr.14
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 13:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=PSpT0PIyOmIho3K/zFrIAo7I1C+8YCwBBFiOyRM+W3w=;
        b=GgH90vIn1GMVvadV5+y2bowex+IIcVGc3wXujNeal7OujpF2fpGBIsnLdBrJ0kXAY1
         8a17HHSI4D+jJD/SGVZf+fipJmdMO7scUegWGLgr9i8vTXVJy55Cv2xM45bLCEFy7msO
         9B2eGSkw2vqiPjxcUxIuPEJTh6+d/HHaE3RqaM9+BlpD/FPfoM4/KgynEXNMMJo45Hnd
         +1r16k3K+BRvud5YTi/CC6/dGBagd7JQ7vm6uGZ70hslcg0sIenk8B84dxYFEpmIz0w2
         jmrWhfAc/gOYTIb3yx5kqCpzY9iK1mnNWGs85suYQraOcBwlv5W4ZuEyGpV0GJx0QBc6
         IS2w==
X-Received: by 10.236.89.172 with SMTP id c32mr3783560yhf.180.1420665565716;
 Wed, 07 Jan 2015 13:19:25 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Wed, 7 Jan 2015 13:19:25 -0800 (PST)
In-Reply-To: <1420662236-27593-2-git-send-email-reubenhwk@gmail.com>
X-Google-Sender-Auth: 508uTooXbjiACsP6mfLPM5LBi5o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262159>

On Wed, Jan 7, 2015 at 3:23 PM, Reuben Hawkins <reubenhwk@gmail.com> wrote:
> This check will automatically set the correct NO_NSEC setting.

This commit message neglects to mention the important point that
you're also now setting USE_ST_TIMESPEC when detected. You might
revise the message like this:

    Detect 'tv_nsec' field in 'struct stat' and set Makefile variable
    NO_NSEC appropriately.

    A side-effect of the above detection is that we also determine
    whether 'stat.st_mtimespec' is available, so, as a bonus, set the
    Makefile variable USE_ST_TIMESPEC, as well.

Also, your sign-off is missing (as mentioned in my previous review[1]).

[1]: http://article.gmane.org/gmane.comp.version-control.git/261626

> ---
>  configure.ac | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/configure.ac b/configure.ac
> index 6af9647..dcc4bf0 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -754,6 +754,18 @@ AC_CHECK_TYPES([struct itimerval],
>  [#include <sys/time.h>])
>  GIT_CONF_SUBST([NO_STRUCT_ITIMERVAL])
>  #
> +# Define USE_ST_TIMESPEC=YesPlease when stat.st_mtimespec.tv_nsec exist

It would be slightly more accurate to drop the ".tv_nsec" bit from this comment.

Also: s/exist/exists./

> +# Define NO_NSEC=YesPlease when neither stat.st_mtim.tv_nsec nor stat.st_mtimespec.tv_nsec exist

Perhaps wrap this long comment over two lines.

Also: s/exist/exist./

> +AC_CHECK_MEMBER([struct stat.st_mtimespec.tv_nsec])
> +AC_CHECK_MEMBER([struct stat.st_mtim.tv_nsec])
> +if test x$ac_cv_member_struct_stat_st_mtimespec_tv_nsec = xyes ; then
> +       USE_ST_TIMESPEC=YesPlease
> +       GIT_CONF_SUBST([USE_ST_TIMESPEC])
> +elif test x$ac_cv_member_struct_stat_st_mtim_tv_nsec != xyes ; then
> +       NO_NSEC=YesPlease
> +       GIT_CONF_SUBST([NO_NSEC])
> +fi
> +#
>  # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
>  AC_CHECK_MEMBER(struct dirent.d_ino,
>  [NO_D_INO_IN_DIRENT=],
> --
> 2.2.0.68.g8f72f0c.dirty
