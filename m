From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] branch.c: simplify chain of if statements
Date: Mon, 17 Mar 2014 04:46:55 -0400
Message-ID: <CAPig+cTodcfSVmHZeHuAj2kuE_CxuZqZuaNHv33hrhDmQuSmuA@mail.gmail.com>
References: <1395004962-18200-1-git-send-email-dragos.foianu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Dragos Foianu <dragos.foianu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 09:47:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPTCn-0004H9-Eo
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 09:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106AbaCQIq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 04:46:57 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:52710 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbaCQIqz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 04:46:55 -0400
Received: by mail-yk0-f169.google.com with SMTP id 142so14209119ykq.0
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 01:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=KRrexGz4NOG4ild2nPZaXLe7gcsHpyf/dS9iMndJ/IM=;
        b=O2wnzgTZYVeiy0WhGlryU/qmVSUOXZlLaotcGp04qU2MHxC4fw/9wsYzUKAqnbT+CQ
         8vOwM9Ula96Bgdk+lnpuKaT670msubz3H1zCS7YI+77DN3wDyatfMVbrf7IvZrSqIEn9
         FOvnrbshtBKLPLOiAj4091QLz//XBJs1miKkvI+Zg/0DarQeA7HRNaTUQKyx6/ppSYIY
         n+o4zLTaauIt5JgPRDetND7OwM6k0Yyzh0ih4msAPErWIY/KtH5hjPqEVbMnkbtKAY+m
         l/5RLlfqZoUk4eK6eFooIdyDTXzcLNIPF1ovs7x/YxnrlqNq13pQqdm4ZRNzd/U3hw4h
         5rBw==
X-Received: by 10.236.150.68 with SMTP id y44mr225951yhj.113.1395046015077;
 Mon, 17 Mar 2014 01:46:55 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 17 Mar 2014 01:46:55 -0700 (PDT)
In-Reply-To: <1395004962-18200-1-git-send-email-dragos.foianu@gmail.com>
X-Google-Sender-Auth: ckEbWvOgsk5fGNfwzLIiKNCaOzE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244232>

Thanks for the submission. Comments below to give you a taste of the
Git review process...

On Sun, Mar 16, 2014 at 5:22 PM, Dragos Foianu <dragos.foianu@gmail.com> wrote:
> This patch uses a table-driven approach in order to make the code
> cleaner.

In fact, this change is not table-driven (emphasis on *driven*). It
merely moves the strings into a table, but all the logic is still in
the code. To be table-driven, the logic would be encoded in the table
as well, and that logic would *drive* the code.

This is not to say that the code must be table-driven. The GSoC
microproject merely asks if doing so would make sense. Whether it
would is for you to decide, and then to explain to reviewers the
reason(s) why you did or did not make it so.

> Although not necessary, it helps code reability by not
> forcing the user to read the print message when trying to
> understand what the code does.

The if-chain is just sufficiently complex that the print messages may
actually help the reader understand the logic of the code, so this
argument seems specious.

> The rebase check has been moved to
> the verbose if statement to avoid making the same check in each of
> the four if statements.
>
> Signed-off-by: Dragos Foianu <dragos.foianu@gmail.com>
> ---

Overall, the patch appears to be properly constructed and you seem to
have digested Documentation/SubmittingPatches. Good.

>  branch.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 723a36b..e2fe455 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -54,6 +54,14 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>         struct strbuf key = STRBUF_INIT;
>         int rebasing = should_setup_rebase(origin);
>
> +       const char *verbose_prints[4] = {

No need to hard-code 4. 'const char *verbose_prints[]' is sufficient.

On this project, it is preferred (though not consistent) to name
arrays using singular form, such as verbose_print[], so that accessing
a single element, such as verbose_print[42], reads more grammatically
correct.

verbose_prints[] is not as descriptive as it could be. Perhaps
something like verbose_messages[] would be more informative (though
awfully long; maybe just messages[]).

> +               "Branch %s set up to track remote branch %s from %s%s",

Even though you are correctly accessing these strings via _() in the
printf_ln() invocation, you still need to mark them translatable here
with N_(). See section 4.7 [1] of the gettext manual.

[1]: http://www.gnu.org/software/gettext/manual/gettext.html#Special-cases

> +               "Branch %s set up to track local branch %s%s",
> +               "Branch %s set up to track remote ref %s%s",
> +               "Branch %s set up to track local ref %s%s"
> +       };
> +       char *verbose_rebasing = rebasing ? " by rebasing." : ".";

This should be 'const char *'.

Matthieu already mentioned [2] that this sort of "lego" string
construction is not internationalization-friendly. See section 4.3 [3]
of the gettext manual for details.

[2]: http://thread.gmane.org/gmane.comp.version-control.git/244210/focus=244226
[3]: http://www.gnu.org/software/gettext/manual/gettext.html#Preparing-Strings

>         if (remote_is_branch
>             && !strcmp(local, shortname)
>             && !origin) {
> @@ -78,25 +86,17 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>
>         if (flag & BRANCH_CONFIG_VERBOSE) {
>                 if (remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote branch %s from %s by rebasing.") :
> -                                 _("Branch %s set up to track remote branch %s from %s."),
> -                                 local, shortname, origin);
> +                       printf_ln(_(verbose_prints[0]),
> +                               local, shortname, origin, verbose_rebasing);
>                 else if (remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local branch %s by rebasing.") :
> -                                 _("Branch %s set up to track local branch %s."),
> -                                 local, shortname);
> +                       printf_ln(_(verbose_prints[1]),
> +                               local, shortname, verbose_rebasing);
>                 else if (!remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote ref %s by rebasing.") :
> -                                 _("Branch %s set up to track remote ref %s."),
> -                                 local, remote);
> +                       printf_ln(_(verbose_prints[2]),
> +                               local, remote, verbose_rebasing);
>                 else if (!remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local ref %s by rebasing.") :
> -                                 _("Branch %s set up to track local ref %s."),
> -                                 local, remote);
> +                       printf_ln(_(verbose_prints[3]),
> +                               local, remote, verbose_rebasing);

These hard-coded indexing constants (0, 1, 2, 3) are fragile and
convey little meaning to the reader. Try to consider how to compute
the index into verbose_prints[] based upon the values of
'remote_is_branch' and 'origin'. What are the different ways you could
do so?

>                 else
>                         die("BUG: impossible combination of %d and %p",
>                             remote_is_branch, origin);
> --
> 1.8.3.2
