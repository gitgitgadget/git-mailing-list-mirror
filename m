From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH] rebase: use reflog to find common base with upstream
Date: Mon, 21 Oct 2013 22:40:22 -0700
Message-ID: <CANiSa6gNJiUGb47Sw38V3oeJ-=0c1oZ0wO-GhNQminN3+SvgaA@mail.gmail.com>
References: <d8e9f102609ee4502f579cb4ce872e0a40756204.1381949622.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Oct 22 07:40:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYUhg-0001jY-9G
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 07:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166Ab3JVFkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 01:40:24 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33467 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab3JVFkY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 01:40:24 -0400
Received: by mail-wi0-f181.google.com with SMTP id l12so5077542wiv.8
        for <git@vger.kernel.org>; Mon, 21 Oct 2013 22:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9MOtgzTDriWdm/W5wdAVi03JiO+vlxAXdAKjWKpWqm0=;
        b=0YidcScltzZfwujLxlTdIYRHGyWevynmCpypV+vXzr/IxiMxmZtzUk+eVBGQXJ+T9O
         JrAdnMiy/FEU3G4cB2iEd50Ex3ZcYdfeW0AQLoLJyvovXZSVPA0SFgf9vfnQ8EJqWvdN
         lRKaSp4hmstz/s60qk9Mw929KmoaSAtEiRAifEKmSqAqprVXOSFkjayd/tOi+WFJ5Un4
         g/zOdUW9LsZ/4d/BfEGuEvGqxGtZnbOmO1r0BcoQN/5QxRu/5hjjRC1qEX3rqjAgw4Z7
         xPyLGSTiH0eF79Zfv1YFooz848w47C9AJM2eGAdyBzbSuwtLqUpA5DDQdybU864QV4E5
         YpzA==
X-Received: by 10.194.78.78 with SMTP id z14mr8414078wjw.32.1382420422875;
 Mon, 21 Oct 2013 22:40:22 -0700 (PDT)
Received: by 10.180.12.69 with HTTP; Mon, 21 Oct 2013 22:40:22 -0700 (PDT)
In-Reply-To: <d8e9f102609ee4502f579cb4ce872e0a40756204.1381949622.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236455>

On Wed, Oct 16, 2013 at 11:53 AM, John Keeping <john@keeping.me.uk> wrote:
> Commit 15a147e (rebase: use @{upstream} if no upstream specified,
> 2011-02-09) says:
>
>         Make it default to 'git rebase @{upstream}'. That is also what
>         'git pull [--rebase]' defaults to, so it only makes sense that
>         'git rebase' defaults to the same thing.
>
> but that isn't actually the case.  Since commit d44e712 (pull: support
> rebased upstream + fetch + pull --rebase, 2009-07-19), pull has actually
> chosen the most recent reflog entry which is an ancestor of the current
> branch if it can find one.
>
> Change rebase so that it uses the same logic.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  git-rebase.sh     | 8 ++++++++
>  t/t3400-rebase.sh | 6 ++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 226752f..fd36cf7 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -437,6 +437,14 @@ then
>                         error_on_missing_default_upstream "rebase" "rebase" \
>                                 "against" "git rebase <branch>"
>                 fi
> +               for reflog in $(git rev-list -g "$upstream_name" 2>/dev/null)
> +               do
> +                       if test "$reflog" = "$(git merge-base "$reflog" HEAD)"
> +                       then
> +                               upstream_name=$reflog
> +                               break
> +                       fi
> +               done
>                 ;;
>         *)      upstream_name="$1"
>                 shift

A little later, "onto_name" gets assigned like so:

  onto_name=${onto-"$upstream_name"}

So if upstream_name was set above, then onto would get the same value,
which is not what we want, right? It seems like this block of code
should come a bit later.

I also think it not be run only when rebase was run without a given
upstream. If the configured upstream is "origin/master", it seems like
it would be surprising to get different behavior from "git rebase" and
"git rebase origin/master".
