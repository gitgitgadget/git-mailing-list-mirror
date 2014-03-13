From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH][GSOC2014] install_branch_config: change logical chain to
 lookup table
Date: Thu, 13 Mar 2014 18:21:01 -0400
Message-ID: <CAPig+cRCKCcfYQVM=pyXUQtTsbaD8g=OKff+K5+Bd+kBgqAufg@mail.gmail.com>
References: <BLU0-SMTP223196BC56240FAE28FF9DD5760@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: TamerTas <tamertas@outlook.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 23:21:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WODzy-0002L7-0j
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 23:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235AbaCMWVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 18:21:04 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:40842 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072AbaCMWVD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 18:21:03 -0400
Received: by mail-yk0-f173.google.com with SMTP id 10so4495297ykt.4
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 15:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/SE2NUyHjiuRKx3UaclYTUXbXDPvlvgTz8+oPpHJX6E=;
        b=dgASioSrXOb17O6Hono5MQbBJTTbmTYURqrms0tUAKdRI71wEJqeQPZ7zf44tC9mDE
         qiICoO8IabZXIas7QjYvzUZzW3hNvZKl4uWEdYqSTUegM0KdkKYC3IFbPphrMrchfq0S
         JnKa28SOVJduChZSwmGUrGqjPFUBCeYawYfoPNMzfwC3s1i3UibVI62NrfxKQ6zSKktv
         DTCOco3ts2y4kErKLyDfIyjQY5KyVaXtYfyrBNcSKnakQIkpgvEh0qv2kFzKaVvwZNxb
         MckEYDHMIOMsjSFBdTaTk6ULJvx8+/1V3VD/7c9wUWciBJBAkYJlc/O3cnFTPQqm6u2k
         NpAw==
X-Received: by 10.236.143.148 with SMTP id l20mr5918392yhj.102.1394749261875;
 Thu, 13 Mar 2014 15:21:01 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 13 Mar 2014 15:21:01 -0700 (PDT)
In-Reply-To: <BLU0-SMTP223196BC56240FAE28FF9DD5760@phx.gbl>
X-Google-Sender-Auth: XoGuYoe6qQrRiaS_DSWskexNXfY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244055>

On Wed, Mar 12, 2014 at 5:24 PM, TamerTas <tamertas@outlook.com> wrote:
>
> Signed-off-by: TamerTas <tamertas@outlook.com>
> --

There should be three hyphens "---" here but somehow you have only two
"--". Since "---" is detected automatically when the patch is applied,
this deviation can be problematic.

> Thanks for the feedback. Comments below.

Thanks for the resubmission. Comments below. :-)

> I've made the suggested changes [1] to patch [2]

Better. This is a more well-crafted submission.

> but, since there are different number of format
> specifiers, an if-else clause is necessary.
> Removing the if-else chain completely doesn't seem to be possible.
> So making the format table-driven seems to be like an optional change.

Explaining why you chose one approach over another is indeed good
etiquette, and can forestall questions which reviewers may otherwise
ask.

Note, however, that it is possible to move this logic into a table.
Clue: it is not an error to supply more arguments than there are %s's
in the format string. This is not saying that you must make it
table-driven, but perhaps it may alter the reasons you gave above for
rejecting it (assuming you still do).

> [1]: http://git.661346.n2.nabble.com/PATCH-GSOC2014-changed-logical-chain-in-branch-c-to-lookup-tables-tp7605343p7605444.html
> [2]: http://git.661346.n2.nabble.com/PATCH-GSOC2014-changed-logical-chain-in-branch-c-to-lookup-tables-tp7605343p7605407.html
> --
>  branch.c |   44 +++++++++++++++++++++-----------------------
>  1 file changed, 21 insertions(+), 23 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 723a36b..1ccf30f 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -50,10 +50,25 @@ static int should_setup_rebase(const char *origin)
>  void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
>  {
>         const char *shortname = remote + 11;
> +       const char *setup_message[] = {
> +               N_("Branch %s set up to track local ref %s."),
> +               N_("Branch %s set up to track local branch %s."),
> +               N_("Branch %s set up to track remote ref %s."),
> +               N_("Branch %s set up to track remote branch %s from %s."),
> +               N_("Branch %s set up to track local ref %s by rebasing.")
> +               N_("Branch %s set up to track local branch %s by rebasing."),
> +               N_("Branch %s set up to track remote ref %s by rebasing."),
> +               N_("Branch %s set up to track remote branch %s from %s by rebasing."),

Some compilers will warn about the trailing comma, so you might want to drop it.

> +       };
> +
>         int remote_is_branch = starts_with(remote, "refs/heads/");
>         struct strbuf key = STRBUF_INIT;
>         int rebasing = should_setup_rebase(origin);
>
> +       int msg_index = (!!remote_is_branch << 0) +
> +                       (!!origin << 1) +
> +                       (!!rebasing << 2);

Better than the last (buggy) attempt. Nevertheless, it's a fairly
magical incantation requiring more thought than some other approaches.
Have you considered instead using a multi-dimensional array for the
messages and then indexing into it with these variables as direct keys
(after using ! or !! to constrain them to 0 or 1)? Would that be
better or worse?

>         if (remote_is_branch
>             && !strcmp(local, shortname)
>             && !origin) {
> @@ -77,29 +92,12 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
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
> +           if(remote_is_branch && origin)
> +               printf_ln(_(setup_message[msg_index]), local, shortname, origin);
> +           else if (remote_is_branch && !origin)
> +               printf_ln(_(setup_message[msg_index]), local, shortname);
> +           else
> +               printf_ln(_(setup_message[msg_index]), local, remote);

Assigning setup_message[msg_index] to a variable and referencing that
variable in the printf_ln() invocations might make this less noisy.

Consider the clue given above about making the code table-driven. Even
if you don't go the table-driven route, that clue can simplify this
code considerably.

>         }
>  }
>
> --
> 1.7.9.5
