From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 2/2] pull: allow dirty tree when rebase.autostash enabled
Date: Thu, 11 Jun 2015 21:34:08 +0800
Message-ID: <CACRoPnQ0+h2g2cUJk+8zSkcHjoHjezAGC=5pTjn8aFsgB0GrQA@mail.gmail.com>
References: <1433282157-8171-1-git-send-email-me@ikke.info>
	<1433625145-29668-1-git-send-email-me@ikke.info>
	<1433625145-29668-2-git-send-email-me@ikke.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Junio C. Hamano" <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Kevin Daudt <compufreak@gmail.com>
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Thu Jun 11 15:34:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z32ca-0007Sr-Rb
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 15:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436AbbFKNeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 09:34:13 -0400
Received: from mail-lb0-f195.google.com ([209.85.217.195]:36605 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbbFKNeK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 09:34:10 -0400
Received: by lbiv13 with SMTP id v13so1394284lbi.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 06:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vBZJrxYU+1P+hEsia7nt0WZZNff60KHNmJZ1BJGJLfs=;
        b=0jkRDxo2OpkI8PncR45ZM4ZXPMxOfNM+JfFG7i17377TFrCOrrh7il2A1GHD2vOq+4
         hPZXVaMtqC2f/m4A8zzR/0COUJa++2DDFSH7BEFfIrohyqFPugXMwZWYrFH5TGXI4XqT
         XqhnQdp6dFdsvMGcVh5MBN4Pjz1iUZvCMEfkyY+HARQFa6pYl20Z0LP2kN5wG0yet6IG
         CJAqXEffyTRagDxwDhje30AWqd6Rc9JYg/Mh3vHTkblFwyLmlliEGZNC7nPr9J8gcBke
         /BGlpr1RJIG6XlFoEgy6pAPBFTCTffGxf8qX79fDd12HKw8z70khteLU4IiZALk6tIy5
         1Bzw==
X-Received: by 10.152.164.193 with SMTP id ys1mr10030062lab.65.1434029649006;
 Thu, 11 Jun 2015 06:34:09 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 11 Jun 2015 06:34:08 -0700 (PDT)
In-Reply-To: <1433625145-29668-2-git-send-email-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271405>

On Sun, Jun 7, 2015 at 5:12 AM, Kevin Daudt <me@ikke.info> wrote:
> From: Kevin Daudt <compufreak@gmail.com>
>
> rebase learned to stash changes when it encounters a dirty work tree, but
> git pull --rebase does not.
>
> Only verify if the working tree is dirty when rebase.autostash is not
> enabled.
>
> Signed-off-by: Kevin Daudt <me@ikke.info>

Ehh? The sign-off does not match the author of the patch.

> Helped-by: Paul Tan <pyokagan@gmail.com>
> ---
>  git-pull.sh     |  5 ++++-
>  t/t5520-pull.sh | 12 ++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/git-pull.sh b/git-pull.sh
> index 0917d0d..f0a3b6e 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -239,7 +239,10 @@ test true = "$rebase" && {
>                         die "$(gettext "updating an unborn branch with changes added to the index")"
>                 fi
>         else
> -               require_clean_work_tree "pull with rebase" "Please commit or stash them."
> +               if [ $(git config --bool --get rebase.autostash || echo false) = false ]
> +               then
> +                       require_clean_work_tree "pull with rebase" "Please commit or stash them."
> +               fi
>         fi
>         oldremoteref= &&
>         test -n "$curr_branch" &&
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 925ad49..d06119f 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -135,6 +135,18 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
>         test_cmp file expect
>  '
>
> +test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
> +       test_config branch.to-rebase.rebase true &&

Ok, though I wonder why not just a git pull --rebase...

> +       test_config rebase.autostash true &&
> +       git checkout HEAD -- file &&

Why not git reset --hard before-rebase? If we don't reset HEAD, then
how would we know if we actually did a rebase?

> +       echo dirty > new_file &&

style: echo dirty >new_file &&

> +       git add new_file &&
> +       git pull . copy &&
> +       test $(git rev-parse HEAD^) = $(git rev-parse copy) &&

Okay, although it would be better to use "test_cmp_rev HEAD^ copy"
because it prints out the hashes if they are different.

> +       test $(cat new_file) = dirty &&

"$(cat new_file)" should be quoted to prevent field splitting.

> +       test "$(cat file)" = "modified again"
> +'
> +
>  test_expect_success 'pull.rebase' '
>         git reset --hard before-rebase &&
>         test_config pull.rebase true &&
> --
> 2.4.2

Thanks,
Paul
