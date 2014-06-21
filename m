From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC PATCH 3/7] rebase -i: Stop on root commits with empty log messages
Date: Fri, 20 Jun 2014 20:33:00 -0400
Message-ID: <CAPig+cS48D1GBX9duHLVWnsW+g5_8rBGOdU=UBRuxrS9JpUh_A@mail.gmail.com>
References: <cover.1403146774.git.bafain@gmail.com>
	<53A258E2.501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 02:33:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy9Ex-0004yp-Ll
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jun 2014 02:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756689AbaFUAdC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 20:33:02 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:39246 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756609AbaFUAdB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 20:33:01 -0400
Received: by mail-yh0-f44.google.com with SMTP id f10so3418655yha.17
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 17:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=WK2H69vB6kWwQoLja3fGmb+LQIoCWORk1OkF4de74Kg=;
        b=WMsyg+x4QkLgNWRibYai/kt4ZSdu5WGmQCSzzrnxnqdMTOC37itobWVLhTuQCC461Y
         0+iyMjLwq4JjTl/XTlWUOGmuQ43oxaL9rVm4AAqa65v3sZrm4brY51Qr7Cnh+jnBBnur
         Ixq8Kmi0KaCJkvYmd1k8gTOedbAEIqfCwsIV85ZEoP0ly//qoOFK/aFHs+fwmKwypUW5
         JMa8BIv8f4zLvIN3AWyMUh8VNO7H6rKVWcREMKW2ghyVpBfYfteWF02oenHfGgPFxubr
         W0EXVX+7zKVXOvFFTuasBbN0KxqFb52VLVdyBRU00jTmpAGGsx46uuzisXQ9YPCWSnUv
         rxhg==
X-Received: by 10.236.108.176 with SMTP id q36mr10035078yhg.87.1403310780266;
 Fri, 20 Jun 2014 17:33:00 -0700 (PDT)
Received: by 10.170.36.80 with HTTP; Fri, 20 Jun 2014 17:33:00 -0700 (PDT)
In-Reply-To: <53A258E2.501@gmail.com>
X-Google-Sender-Auth: L0XpHzeSxLUvonWhUjTjPB1jsbw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252298>

On Wed, Jun 18, 2014 at 11:28 PM, Fabian Ruch <bafain@gmail.com> wrote:
> When `rebase` is executed with `--root` but no `--onto` is specified,
> `rebase` creates a sentinel commit which is replaced with the root
> commit in three steps. This combination of options results never in a
> fast-forward.
>
>  1. The sentinel commit is forced into the authorship of the root
>     commit.
>
>  2. The changes introduced by the root commit are applied to the index
>     but not committed. If this step fails for whatever reason, all
>     commit information will be there and the user can safely run
>     `git-commit --amend` after resolving the problems.
>
>  3. The new root commit is created by squashing the changes into the
>     sentinel commit which already carries the authorship of the
>     cherry-picked root commit.
>
> The command line used to create the commit in the third step specifies
> effectless and erroneous options. Remove those.
>
>  - `--allow-empty-message` is erroneous: If the root's commit message is
>    empty, the rebase shall fail like for any other commit that is on the
>    to-do list and has an empty commit message.
>
>    Fix the bug that git-rebase does not fail when the initial commit has
>    an empty log message but is replayed using `--root` is specified.
>    Add test.
>
>  - `-C` is effectless: The commit being amended, which is the sentinel
>    commit, already carries the authorship and log message of the
>    cherry-picked root commit. The committer email and commit date fields
>    are reset either way.
>
> After all, if step two fails, `rebase --continue` won't include these
> flags in the git-commit command line either.
>
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---
>  git-rebase--interactive.sh |  4 ++--
>  t/t3412-rebase-root.sh     | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index fffdfa5..f09eeae 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -539,8 +539,8 @@ do_pick () {
>                 git commit --allow-empty --allow-empty-message --amend \
>                            --no-post-rewrite -n -q -C $1 &&
>                         pick_one -n $1 &&
> -                       git commit --allow-empty --allow-empty-message \
> -                                  --amend --no-post-rewrite -n -q -C $1 \
> +                       git commit --allow-empty --amend \
> +                                  --no-post-rewrite -n -q \
>                                    ${gpg_sign_opt:+"$gpg_sign_opt"} ||
>                         die_with_patch $1 "Could not apply $1... $2"
>         else
> diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
> index 0b52105..3608db4 100755
> --- a/t/t3412-rebase-root.sh
> +++ b/t/t3412-rebase-root.sh
> @@ -278,4 +278,43 @@ test_expect_success 'rebase -i -p --root with conflict (second part)' '
>         test_cmp expect-conflict-p out
>  '
>
> +test_expect_success 'stop rebase --root on empty root log message' '
> +       # create a root commit with a non-empty tree so that rebase does
> +       # not fail because of an empty commit, and an empty log message
> +       echo root-commit >file &&
> +       git add file &&
> +       tree=$(git write-tree) &&
> +       root=$(git commit-tree $tree </dev/null) &&
> +       git checkout -b no-message-root-commit $root &&
> +       # do not ff because otherwise neither the patch nor the message
> +       # are looked at and checked for emptiness
> +       test_must_fail env EDITOR=true git rebase -i --force-rebase --root &&
> +       echo root-commit >file.expected &&
> +       test_cmp file file.expected &&

It is customary, and provides nicer diagnostic output upon failure, to
have the "expected" file mentioned first:

    test_cmp file.expected file &&

> +       git rebase --abort

Do you want to place this under control of test_when_finished
somewhere above the "git rebase" invocation to ensure cleanup if
something fails before this point?

> +'
> +
> +test_expect_success 'stop rebase --root on empty child log message' '
> +       # create a root commit with a non-empty tree and provide a log
> +       # message so that rebase does not fail until the root commit is
> +       # successfully replayed
> +       echo root-commit >file &&
> +       git add file &&
> +       tree=$(git write-tree) &&
> +       root=$(git commit-tree $tree -m root-commit) &&
> +       git checkout -b no-message-child-commit $root &&
> +       # create a child commit with a non-empty patch so that rebase
> +       # does not fail because of an empty commit, but an empty log
> +       # message
> +       echo child-commit >file &&
> +       git add file &&
> +       git commit --allow-empty-message --no-edit &&
> +       # do not ff because otherwise neither the patch nor the message
> +       # are looked at and checked for emptiness
> +       test_must_fail env EDITOR=true git rebase -i --force-rebase --root &&
> +       echo child-commit >file.expected &&
> +       test_cmp file file.expected &&
> +       git rebase --abort

Same two comments as for previous test.

> +'
> +
>  test_done
> --
> 2.0.0
