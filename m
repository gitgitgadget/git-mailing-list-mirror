From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH][GSoC] branch.c:install_branch_config Simplified long
 chain of if statements
Date: Mon, 10 Mar 2014 19:17:19 -0400
Message-ID: <CAPig+cRZyvrPL69eunsV89-AycF=TWeN8x5cUvBhcF0MLVvOog@mail.gmail.com>
References: <1394489041-2377-1-git-send-email-enzodicicco@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Vincenzo di Cicco <enzodicicco@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 00:17:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN9Rk-0006oF-VP
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 00:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764AbaCJXRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 19:17:21 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:52050 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbaCJXRU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 19:17:20 -0400
Received: by mail-yh0-f49.google.com with SMTP id z6so7825055yhz.36
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 16:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QVqFYLNePrKVxrZLMBNR0OG2olDaR1OiuvSrcUCC8Ak=;
        b=yZ8gK9jcb+1jD2DpDBDt8ivhoWUfqDsWs+dIMwLBVbN5WZ1HIf1BI7QFp2I3OKaokl
         F9RQrkfX3zXxbud1ov9in7agEiGUDEBRfovU+YazMXPWbF+uFpsBCIZoC1G8C5vUOUie
         mx/IYEga/FD36XnvD8mfHEexIViBkOMN/deFf4Pvw1D1+2vLIuUHy7dNu3sbecRasQMD
         1iojMq0u4FmPGsyMdPJcmTKGeQZ8k0L8BxLKrKoyIn6wBrtoLj+stz8GVGRx2yCrcU/B
         4+y7oWOfTf6BjnLonJw62/9HYS8FKtEklBKEbmVmxeQsMv2c0vmJId4vOw8RK4W37XD3
         +v4Q==
X-Received: by 10.236.41.165 with SMTP id h25mr5618535yhb.126.1394493439493;
 Mon, 10 Mar 2014 16:17:19 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 10 Mar 2014 16:17:19 -0700 (PDT)
In-Reply-To: <1394489041-2377-1-git-send-email-enzodicicco@gmail.com>
X-Google-Sender-Auth: k4MjkNr0-SHQ2HEs_MTPsVxQx5I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243825>

Thanks for the submission. Comments below to give you a feel for the
Git review process...

On Mon, Mar 10, 2014 at 6:04 PM, Vincenzo di Cicco
<enzodicicco@gmail.com> wrote:
> From: NaN <enzodicicco@gmail.com>

Drop this line unless it is intentionally different from your email
From: header, which "git am" will pick up automatically when applying
your patch. On this project, real names are preferred (as you
correctly used in your sign-off).

> Hi there, I've made this patch in according to the rules to participate at GSoC.
> I've seen other patches about this issue very well constructed, so this is only another way to solve this microproject and to test how I can send a patch and discuss about it.
>
> Thanks,
> NaN

These "commentary" lines, which are not intended as part of the
official commit message, belong below the "---" line following your
sign-off. Wrap them to 65-70 characters.

> Signed-off-by: Vincenzo di Cicco <enzodicicco@gmail.com>
> ---
>  Table-driven approach to avoid the long chain of if statements.

This non-commentary information is suitable for the commit message,
thus it belongs above your sign-off.

>  branch.c | 37 ++++++++++++++-----------------------
>  1 file changed, 14 insertions(+), 23 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 723a36b..cb8a544 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -53,6 +53,10 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>         int remote_is_branch = starts_with(remote, "refs/heads/");
>         struct strbuf key = STRBUF_INIT;
>         int rebasing = should_setup_rebase(origin);
> +       struct strbuf msg = STRBUF_INIT;
> +       char *locations[2][2] = {{"locate ref \%s", "local branch \%s"},
> +                                {"remote ref \%s", "remote branch \%s from \%s"}};
> +       char *location;

Use 'const char *'. You can probably drop the hard-coded array dimensions.

These strings ought to be internationalized, as in the original code,
thus they should be wrapped with N_().

>         if (remote_is_branch
>             && !strcmp(local, shortname)
> @@ -77,30 +81,17 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>         strbuf_release(&key);
>
>         if (flag & BRANCH_CONFIG_VERBOSE) {
> -               if (remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote branch %s from %s by rebasing.") :
> -                                 _("Branch %s set up to track remote branch %s from %s."),
> -                                 local, shortname, origin);
> -               else if (remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local branch %s by rebasing.") :
> -                                 _("Branch %s set up to track local branch %s."),
> -                                 local, shortname);
> -               else if (!remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote ref %s by rebasing.") :
> -                                 _("Branch %s set up to track remote ref %s."),
> -                                 local, remote);
> -               else if (!remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local ref %s by rebasing.") :
> -                                 _("Branch %s set up to track local ref %s."),
> -                                 local, remote);
> -               else
> -                       die("BUG: impossible combination of %d and %p",
> -                           remote_is_branch, origin);
> +               location = locations[origin != NULL][remote_is_branch];

On this project, it is more idiomatic to say !!origin than 'origin != NULL'.

If we take the time to trace through the code, we can see that
remote_is_branch is indeed either 0 or 1, thus this expression is safe
today, however, if the implementation of starts_with() ever changes so
that it returns a value other than 1 for true, then this code will
break. To avoid such breakage, and to avoid placing burden of tracing
code, you might instead write the expression as:

    location = locations[!!origin][!!remote_is_branch];

> +               strbuf_addstr(&msg, "Branch \%s set up to track ");
> +               strbuf_addstr(&msg, location);
> +               if(rebasing)
> +                       strbuf_addstr(&msg, " by rebasing");
> +               strbuf_addch(&msg, '.');

This approach of composing strings is problematic for translation,
which is why the GSoC microproject states:

    Don't forget that the strangely-named function _() is used for
    internationalization and limits the possibility of gluing
    strings together.

For further details about why this approach is undesirable, see this
other email thread [1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243793

> +               printf_ln(_(msg.buf), local, remote_is_branch ? remote: shortname, origin);

gettext function _() expects constant strings which it can present to
(human) translators, so passing it a buffer containing a string
composed at run-time will not work.

>         }
> +       strbuf_release(&msg);
>  }
>
>  /*
> --
> 1.9.0
