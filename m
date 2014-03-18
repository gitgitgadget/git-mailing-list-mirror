From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2] branch.c: simplify chain of if statements
Date: Tue, 18 Mar 2014 18:31:07 -0400
Message-ID: <CAPig+cS9QApn1T3-R8n+W+1ee9FbNftsmhrr90SJKs+gqzvC5A@mail.gmail.com>
References: <1395071493-31435-1-git-send-email-dragos.foianu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Dragos Foianu <dragos.foianu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 23:31:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ2Xc-0005K5-7B
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 23:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775AbaCRWbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 18:31:10 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:33761 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755175AbaCRWbI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 18:31:08 -0400
Received: by mail-yh0-f53.google.com with SMTP id v1so7617878yhn.26
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 15:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9whfwyh9pxaGsuau8jcY7R3+1r3rDfGE2Ef3QENHQYg=;
        b=AJ/DeTdRn0L+62Y5FD6OzPHnk1/L/XVO7kjvbl92l7DgRanyIuuL254SOsgHOiIeAC
         WtrbAvV5KoLy2pLPGoI4SIBDLwTq5g051YFglVu9pHj1OM154dzXsuN+GLZ/8k71aXdC
         FuINWh/sLHz1ekpaa+9tKScTSFmbvyWsoQ19bFxCrydtDt97Lqnj24KKOanUsUGDmRgK
         XcRiUtOwYSmP8orf24gNG7YVtnkGkEtf1i4iNdmLNey+8Nc1ddtWH4f2tKECGuBUH90j
         GTMP+JOYJRLANm3P7t36rwyaJF+Jfz9bt+75+7E3SrRH6JK5auKrAEPMhwL6Rcvt8LgZ
         EGng==
X-Received: by 10.236.139.70 with SMTP id b46mr21627995yhj.63.1395181867725;
 Tue, 18 Mar 2014 15:31:07 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Tue, 18 Mar 2014 15:31:07 -0700 (PDT)
In-Reply-To: <1395071493-31435-1-git-send-email-dragos.foianu@gmail.com>
X-Google-Sender-Auth: bC5_S5CyhFzYf-GWAQpF4qZdiJ0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244389>

Thanks for the resubmission. Comments below...

On Mon, Mar 17, 2014 at 11:51 AM, Dragos Foianu <dragos.foianu@gmail.com> wrote:
> This patch uses a table to store the different messages that can
> be emitted by the verbose install_branch_config function. It
> computes an index based on the three flags and prints the message
> located at the specific index in the table of messages. If the
> index somehow is not within the table, we have a bug.

Most of this text can be dropped due to redundancy.

Saying "This patch..." is unnecessary.

The remaining text primarily says in prose what the patch itself
conveys more concisely and precisely. It's easier to read and
understand the actual code than it is to wade through a lengthy
description of the code change.

Speak in imperative voice: "Use a table to store..."

You might, for instance, say instead something like this:

    install_branch_config() uses a long, somewhat complex if-chain to
    select a message to display in verbose mode.  Simplify the logic
    by moving the messages to a table from which they can be
    easily retrieved without complex logic.

> Signed-off-by: Dragos Foianu <dragos.foianu@gmail.com>
> ---
>  branch.c | 44 +++++++++++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 19 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 723a36b..95645d5 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -54,6 +54,18 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>         struct strbuf key = STRBUF_INIT;
>         int rebasing = should_setup_rebase(origin);
>
> +       const char *messages[] = {
> +               N_("Branch %s set up to track local ref %s."),
> +               N_("Branch %s set up to track remote ref %s."),
> +               N_("Branch %s set up to track local branch %s."),
> +               N_("Branch %s set up to track remote branch %s from %s."),
> +               N_("Branch %s set up to track local ref %s by rebasing."),
> +               N_("Branch %s set up to track remote ref %s by rebasing."),
> +               N_("Branch %s set up to track local branch %s by rebasing."),
> +               N_("Branch %s set up to track remote branch %s from %s by rebasing.")
> +       };
> +       int index = 0;
> +
>         if (remote_is_branch
>             && !strcmp(local, shortname)
>             && !origin) {
> @@ -76,28 +88,22 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>         }
>         strbuf_release(&key);
>
> +       if (origin)
> +               index += 1;
> +       if (remote_is_branch)
> +               index += 2;
> +       if (rebasing)
> +               index += 4;

Other submissions have computed this value mathematically without need
for conditionals. For instance, we've seen:

    index = (!!origin << 0) + (!!remote_is_branch << 1) + (!!rebasing << 2)

as, well as the equivalent:

    index = !!origin + !!remote_is_branch * 2 + !!rebasing * 4

Although this works, it does place greater cognitive demands on the
reader by requiring more effort to figure out what is going on and how
it relates to table position. The original (ungainly) chain of 'if'
statements in the original code does not suffer this problem. It
likewise is harder to understand than merely indexing into a
multi-dimension table where each variable is a key.

>         if (flag & BRANCH_CONFIG_VERBOSE) {
>                 if (remote_is_branch && origin)
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
> +                       printf_ln(_(messages[index]),
> +                               local, shortname, origin);
>                 else
> +                       printf_ln(_(messages[index]),
> +                               local, (!remote_is_branch) ? remote : shortname);

It's possible to simplify this logic and have only a single
printf_ln() invocation. Hint: It's safe to pass in more arguments than
there are %s directives in the format string.

> +
> +               if (index < 0 || index > sizeof(messages) / sizeof(*messages))
>                         die("BUG: impossible combination of %d and %p",
>                             remote_is_branch, origin);

You can use ARRAY_SIZE() in place of sizeof(...)/sizeof(...).

Since an out-of-bound index would be a programmer bug, it would
probably be more appropriate to use an assert(), just after 'index' is
computed, rather than if+die(). The original code used die() because
it couldn't detect the error until the end of the if-chain.

>         }
> --
> 1.8.3.2
