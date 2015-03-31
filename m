From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] prune --worktrees: fix expire vs worktree existence condition
Date: Tue, 31 Mar 2015 19:25:01 +0700
Message-ID: <CACsJy8DjmSvatifN3s4eyNz5uGuJ=BaTAJrC6aKVa+2Q=MZjeg@mail.gmail.com>
References: <1427748467-27786-1-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 14:26:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcvEf-0004ZM-Vh
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 14:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbbCaMZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 08:25:33 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38733 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbbCaMZc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 08:25:32 -0400
Received: by igbqf9 with SMTP id qf9so15229567igb.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2015 05:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Br7Bsk+VNgANlt3ffUBxyKai4kDA9X0WlUgC4HkZNVU=;
        b=1G2GCZPhu2W5m1JpeCPc2LLx6KkY78y1akQDU/ganwgOnqK5G3HeVC920gaSQAeXzv
         G2xsn6Ju/JFuUC1RZrc1Zk7j15/i/92xnr95NiCf73eukQ/3+DZ5u2Z2h4jwkDsbCkwu
         TlEg9Uc7JXEgCqqoZ6lShFqJt1SB+0A82DZITeuqiz8VgkjodcsZD+Qz6aHoZQpcfinG
         FkbI+S2QMSjWtkZcrpPB9W+G6mk6a6SVwO74vTJCYOM6Fg0yyRmaanHrPzo9L7DAgZVM
         SZIALnXj67/iUESrx6p/Y+aHVQ0/a2ovviP3aE/3fv8CSmqrW3SqTXWrPjng+ToowQrR
         A0yQ==
X-Received: by 10.42.41.148 with SMTP id p20mr66320986ice.62.1427804731420;
 Tue, 31 Mar 2015 05:25:31 -0700 (PDT)
Received: by 10.107.47.170 with HTTP; Tue, 31 Mar 2015 05:25:01 -0700 (PDT)
In-Reply-To: <1427748467-27786-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266522>

On Tue, Mar 31, 2015 at 3:47 AM, Max Kirillov <max@max630.net> wrote:
> `git prune --worktrees` was pruning worktrees which were non-existent OR
> expired, while it rather should prune those which are orphaned AND
> expired, as git-checkout documentation describes. Fix it.
>
> Add test 'not prune proper checkouts', which uses valid but expired
> worktree.
>
> Modify test 'not prune recent checkouts' to remove the worktree before
> pruning - link in worktrees still must survive. In older form it is
> useless because would pass always when the other test passes.

Urgh.. Ack.

> Signed-off-by: Max Kirillov <max@max630.net>
> ---
>  builtin/prune.c                   | 10 +++++++---
>  t/t2026-prune-linked-checkouts.sh | 12 ++++++++++++
>  2 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/prune.c b/builtin/prune.c
> index 34a5ce1..fd31485 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -120,11 +120,15 @@ static int prune_worktree(const char *id, struct strbuf *reason)
>                 if (!stat(git_path("worktrees/%s/link", id), &st_link) &&
>                     st_link.st_nlink > 1)
>                         return 0;
> -               strbuf_addf(reason, _("Removing worktrees/%s: gitdir file points to non-existent location"), id);
> -               return 1;
> +               if (st.st_mtime <= expire) {
> +                   strbuf_addf(reason, _("Removing worktrees/%s: gitdir file points to non-existent location"), id);
> +                   return 1;
> +               } else {
> +                   return 0;
> +               }
>         }
>         free(path);
> -       return st.st_mtime <= expire;
> +       return 0;
>  }
>
>  static void prune_worktrees(void)
> diff --git a/t/t2026-prune-linked-checkouts.sh b/t/t2026-prune-linked-checkouts.sh
> index e885baf..1821a48 100755
> --- a/t/t2026-prune-linked-checkouts.sh
> +++ b/t/t2026-prune-linked-checkouts.sh
> @@ -4,6 +4,10 @@ test_description='prune $GIT_DIR/worktrees'
>
>  . ./test-lib.sh
>
> +test_expect_success initialize '
> +       git commit --allow-empty -m init
> +'
> +
>  test_expect_success 'prune --worktrees on normal repo' '
>         git prune --worktrees &&
>         test_must_fail git prune --worktrees abc
> @@ -77,8 +81,16 @@ test_expect_success 'not prune recent checkouts' '
>         mkdir zz &&
>         mkdir -p .git/worktrees/jlm &&
>         echo "$(pwd)"/zz >.git/worktrees/jlm/gitdir &&
> +       rmdir zz &&
>         git prune --worktrees --verbose --expire=2.days.ago &&
>         test -d .git/worktrees/jlm
>  '
>
> +test_expect_success 'not prune proper checkouts' '
> +       test_when_finished rm -r .git/worktrees &&
> +       git checkout "--to=$PWD/nop" --detach master &&
> +       git prune --worktrees &&
> +       test -d .git/worktrees/nop
> +'
> +
>  test_done
> --
> 2.3.4.2801.g3d0809b
>



-- 
Duy
