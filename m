From: Derek Moore <derek.p.moore@gmail.com>
Subject: Re: [PATCH v1] rebase -m: Use empty tree base for parentless commits
Date: Thu, 9 Oct 2014 14:06:33 -0500
Message-ID: <CAMsgyKbzNh3nx6m59JBnKjTmk9sFfqP95jtYH0uC3nW83SPiwA@mail.gmail.com>
References: <5434312E.6040407@redhat.com>
	<bf0e177fbaac91f8c55526729e580fade9f0f395.1412879523.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	gitster@pobox.com
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 21:06:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcJ2s-00020m-82
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 21:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbaJITGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 15:06:35 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:60750 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbaJITGd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 15:06:33 -0400
Received: by mail-oi0-f45.google.com with SMTP id i138so4251503oig.4
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 12:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=K4HLleWkFwoismDD3ciRM/he/veqXW5KKWEm/ZRvrNw=;
        b=MtEzNXrgjhgwobAWfnCgXeWXcChjHDrs1D2elqpziaZdyt7g9DIFZM0nzhTjOVX4YN
         rT14U7GYy7mDdICHuUEC+hs86YHZ6YYWYMfk3MaN/pCFlfjNjRS3dPoC+mG8D8fqldA9
         NN9k5xzF7ywTguLsJHpMPN6mfR6Fh//77mN6xXMHj38NlELq0b3oGp0M+gYWS4RLcSxe
         uOPNrtZiICATESLNAEHuQZzbpqiy3yyAKPkgKek4r8NNJvSAPNs7ypDuQzOnN+zadVA1
         vvTDyfW6uHkHNRpO/2/qIsyZv3gTUUB+1NCYyIe200CK0XLYJ8y7RYfWyAIQTM/ac991
         lTuw==
X-Received: by 10.202.86.67 with SMTP id k64mr109753oib.62.1412881593235; Thu,
 09 Oct 2014 12:06:33 -0700 (PDT)
Received: by 10.76.33.68 with HTTP; Thu, 9 Oct 2014 12:06:33 -0700 (PDT)
In-Reply-To: <bf0e177fbaac91f8c55526729e580fade9f0f395.1412879523.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Should perhaps you be using some symbolic method of referencing the
empty tree instead of referencing a magic number?

E.g., https://git.wiki.kernel.org/index.php/Aliases#Obtaining_the_Empty_Tree_SHA1

On Thu, Oct 9, 2014 at 1:50 PM, Fabian Ruch <bafain@gmail.com> wrote:
> When the user specifies a merge strategy, `git-merge-$strategy` is
> used in non-interactive mode to replay the changes introduced by the
> current branch relative to some upstream. Specifically, for each
> commit `c` that is not in upstream the changes that led from `c^` to
> `c` are reapplied.
>
> If the current has a different root than the upstream, either because
> the history is disconnected or merged in a disconnected history, then
> there will be a parentless commit `c` and `c^` will not refer to a
> commit.
>
> In order to cope with such a situation, check for every `c` whether
> its list of parents is empty. If it is empty, determine the
> introduced changes by comparing the committed tree to the empty tree
> instead. Otherwise, take the differences between `c^` and `c` as
> before.
>
> The other git-rebase modes do not have similar problems because they
> use git-cherry-pick to replay changes, even with strategy options. It
> seems that the non-interactive rebase with merge strategies was not
> implemented using git-cherry-pick because it did not support them at
> the time (`git rebase --merge` added in 58634dbf and `git cherry-pick
> --strategy` added in 91e52598). The idea of using the empty tree as
> reference tree for orphan commits is taken from the git-cherry-pick
> implementation.
>
> Regarding the patch, we do not have to commit the empty tree before
> we can pass it as a base argument to `git-merge-$strategy` because
> tree objects are recognized as such and implicitly committed by
> `git-merge-$strategy`.
>
> Add a test. The test case rebases a single disconnected commit which
> creates an isolated file on master and, therefore, does not require a
> specific merge strategy. It is a mere sanity check.
>
> Reported-by: David M. Lloyd <david.lloyd@redhat.com>
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---
> Hi David,
>
> I don't think you made a mistake at all. If I understand the --merge
> mode of git-rebase correctly there is no need to require a parent.
> The error occurs when the script tries to determine the changes your
> merge commit introduces, which includes the whole "importing/master"
> branch. The strategy is not yet part of the picture then and will not
> be until the changes are being replayed.
>
> The test case tries to simplify your scenario because the relevant
> characteristic seems to be that a parentless commit gets rebased, the
> root commit of "importing/master".
>
> Regards,
>    Fabian
>
>  git-rebase--merge.sh          |  8 +++++++-
>  t/t3400-rebase.sh             | 12 ++++++++++++
>  t/t3402-rebase-merge.sh       | 12 ++++++++++++
>  t/t3404-rebase-interactive.sh | 10 ++++++++++
>  4 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
> index d3fb67d..3f754ae 100644
> --- a/git-rebase--merge.sh
> +++ b/git-rebase--merge.sh
> @@ -67,7 +67,13 @@ call_merge () {
>                 GIT_MERGE_VERBOSITY=1 && export GIT_MERGE_VERBOSITY
>         fi
>         test -z "$strategy" && strategy=recursive
> -       eval 'git-merge-$strategy' $strategy_opts '"$cmt^" -- "$hd" "$cmt"'
> +       base=$(git rev-list --parents -1 $cmt | cut -d ' ' -s -f 2 -)
> +       if test -z "$base"
> +       then
> +               # the empty tree sha1
> +               base=4b825dc642cb6eb9a060e54bf8d69288fbee4904
> +       fi
> +       eval 'git-merge-$strategy' $strategy_opts '"$base" -- "$hd" "$cmt"'
>         rv=$?
>         case "$rv" in
>         0)
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 47b5682..9b0b57f 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -10,6 +10,8 @@ among other things.
>  '
>  . ./test-lib.sh
>
> +. "$TEST_DIRECTORY"/lib-rebase.sh
> +
>  GIT_AUTHOR_NAME=author@name
>  GIT_AUTHOR_EMAIL=bogus@email@address
>  export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
> @@ -255,4 +257,14 @@ test_expect_success 'rebase commit with an ancient timestamp' '
>         grep "author .* 34567 +0600$" actual
>  '
>
> +test_expect_success 'rebase disconnected' '
> +       test_when_finished reset_rebase &&
> +       git checkout --orphan test-rebase-disconnected &&
> +       git rm -rf . &&
> +       test_commit disconnected &&
> +       git rebase master &&
> +       test_path_is_file disconnected.t &&
> +       test_cmp_rev master HEAD^
> +'
> +
>  test_done
> diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
> index 5a27ec9..1653540 100755
> --- a/t/t3402-rebase-merge.sh
> +++ b/t/t3402-rebase-merge.sh
> @@ -7,6 +7,8 @@ test_description='git rebase --merge test'
>
>  . ./test-lib.sh
>
> +. "$TEST_DIRECTORY"/lib-rebase.sh
> +
>  T="A quick brown fox
>  jumps over the lazy dog."
>  for i in 1 2 3 4 5 6 7 8 9 10
> @@ -153,4 +155,14 @@ test_expect_success 'rebase --skip works with two conflicts in a row' '
>         git rebase --skip
>  '
>
> +test_expect_success 'rebase --merge disconnected' '
> +       test_when_finished reset_rebase &&
> +       git checkout --orphan test-rebase-disconnected &&
> +       git rm -rf . &&
> +       test_commit disconnected &&
> +       git rebase --merge master &&
> +       test_path_is_file disconnected.t &&
> +       test_cmp_rev master HEAD^
> +'
> +
>  test_done
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 8197ed2..858c036 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1039,4 +1039,14 @@ test_expect_success 'short SHA-1 collide' '
>         )
>  '
>
> +test_expect_success 'rebase --interactive disconnected' '
> +       test_when_finished reset_rebase &&
> +       git checkout --orphan test-rebase-disconnected &&
> +       git rm -rf . &&
> +       test_commit disconnected &&
> +       EDITOR=true git rebase --interactive master &&
> +       test_path_is_file disconnected.t &&
> +       test_cmp_rev master HEAD^
> +'
> +
>  test_done
> --
> 2.1.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
