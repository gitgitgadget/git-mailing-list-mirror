From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] rebase -i: Remember merge options beyond continue actions
Date: Mon, 9 Jun 2014 20:17:41 -0400
Message-ID: <CAPig+cSHFFPUEQz8==HLQr0My2Bfsth_F16wVf9giytqGwzZww@mail.gmail.com>
References: <53964B32.2090804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Diogo de Campos <campos@esss.com.br>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 02:17:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu9l4-0002pq-Ty
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 02:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbaFJARm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 20:17:42 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35746 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304AbaFJARl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 20:17:41 -0400
Received: by mail-yk0-f169.google.com with SMTP id 200so3087443ykr.14
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 17:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=JLuyvZ0j8CXxnpacVP1K5GnRqUEh22VhQv0n36AO0G4=;
        b=IxFeTWb3VrhAqBhaYTQ2nfVB4uJJCh6F7C8b48PJfcwadduuoqATDzdy129pIZmvY0
         eHH4YJ2wkTSx7T0vTP3CSPfErl8NkG15h+D/0QmCdfsWDdquuPgDZdpSo31rm2IkNDIA
         eFwaunt39nDGJW8TnnUgEZ+F8OhqePt1QAA6a6kWxdjUSb2iBVqx2S2l1Onj4uz3cjV1
         d8eewsVehN6DF/2ZiPPEfQTPUgTVWRMljvilPsAyTnNNT/8L7OewyafUCl9auHxkL5Xx
         RbJxEQRPx1O9kSmBJacHEERyJi4tlgZUwZljDAFmmx6zBkbhsPQhZii3az4mS5tLtULD
         SpQw==
X-Received: by 10.236.147.74 with SMTP id s50mr6670614yhj.108.1402359461161;
 Mon, 09 Jun 2014 17:17:41 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Mon, 9 Jun 2014 17:17:41 -0700 (PDT)
In-Reply-To: <53964B32.2090804@gmail.com>
X-Google-Sender-Auth: dFei9AQcaDFK9XGeV-GAPIwtfEk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251148>

On Mon, Jun 9, 2014 at 8:02 PM, Fabian Ruch <bafain@gmail.com> wrote:
> If the user explicitly specified a merge strategy or strategy options,
> "rebase --interactive" started using the default merge strategy again
> after "rebase --continue".

For reference, this problem was reported as far back as 2013-08-09 [1].

[1]: http://article.gmane.org/gmane.comp.version-control.git/232013

> This problem gets fixed by this commit. Add test.
>
> Since the "rebase" options "-s" and "-X" imply "--merge", we can simply
> remove the "do_merge" guard in the interactive mode and always compile
> the "cherry-pick" arguments from the "rebase" state variables "strategy"
> and "strategy_opts".

Missing sign-off.

> ---
>  git-rebase--interactive.sh    | 18 +++++++-----------
>  t/t3404-rebase-interactive.sh | 16 ++++++++++++++++
>  2 files changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 6ec9d3c..817c933 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -77,17 +77,13 @@ amend="$state_dir"/amend
>  rewritten_list="$state_dir"/rewritten-list
>  rewritten_pending="$state_dir"/rewritten-pending
>
> -strategy_args=
> -if test -n "$do_merge"
> -then
> -       strategy_args=${strategy:+--strategy=$strategy}
> -       eval '
> -               for strategy_opt in '"$strategy_opts"'
> -               do
> -                       strategy_args="$strategy_args -X$(git rev-parse --sq-quote "${strategy_opt#--}")"
> -               done
> -       '
> -fi
> +strategy_args=${strategy:+--strategy=$strategy}
> +eval '
> +       for strategy_opt in '"$strategy_opts"'
> +       do
> +               strategy_args="$strategy_args -X$(git rev-parse --sq-quote "${strategy_opt#--}")"
> +       done
> +'
>
>  GIT_CHERRY_PICK_HELP="$resolvemsg"
>  export GIT_CHERRY_PICK_HELP
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index c0023a5..73849f1 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -998,6 +998,22 @@ test_expect_success 'rebase -i with --strategy and -X' '
>         test $(cat file1) = Z
>  '
>
> +test_expect_success 'interrupted rebase -i with --strategy and -X' '
> +       git checkout -b conflict-merge-use-theirs-interrupted conflict-branch &&
> +       git reset --hard HEAD^ &&
> +       >breakpoint &&
> +       git add breakpoint &&
> +       git commit -m "breakpoint for interactive mode" &&
> +       echo five >conflict &&
> +       echo Z >file1 &&
> +       git commit -a -m "one file conflict" &&
> +       set_fake_editor &&
> +       FAKE_LINES="edit 1 2" git rebase -i --strategy=recursive -Xours conflict-branch &&
> +       git rebase --continue &&
> +       test $(git show conflict-branch:conflict) = $(cat conflict) &&
> +       test $(cat file1) = Z
> +'
> +
>  test_expect_success 'rebase -i error on commits with \ in message' '
>         current_head=$(git rev-parse HEAD)
>         test_when_finished "git rebase --abort; git reset --hard $current_head; rm -f error" &&
> --
> 2.0.0
