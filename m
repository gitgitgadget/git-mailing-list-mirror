Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 371541F403
	for <e@80x24.org>; Sun, 10 Jun 2018 19:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753680AbeFJTk2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 15:40:28 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:64059 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752723AbeFJTk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jun 2018 15:40:27 -0400
Received: from [192.168.2.240] ([92.22.21.50])
        by smtp.talktalk.net with SMTP
        id S6CPf7gDEbZX5S6CPfWe6N; Sun, 10 Jun 2018 20:40:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1528659626;
        bh=gWNabk7dxRwkl1gkg5YHyULEJ6/BZBfnmikRL1VtqE0=;
        h=Reply-To:Subject:To:References:From:Date:In-Reply-To;
        b=NQ5ZWKWDNYeOO79XOs+gWgPoWPDKrAHjDpJ2Volb0ju82IUaZ0jUHuWo3r2aqC9wJ
         7k7tAIB+ne2qLZgCch1C9DG+cwcdFOYi7Vdiis84N5att/KJ7WgZ+NLEpDWYoYZAy5
         AdzHSeTJ1jAPDJ8lH5qFuw0UgKcHTi5al2Y6Pi/U=
X-Originating-IP: [92.22.21.50]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=WogICo9TToZCqFjIzRluTQ==:117
 a=WogICo9TToZCqFjIzRluTQ==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=SfmCHhbU3u-86xRLzG0A:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] git-rebase: error out when incompatible options
 passed
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607050654.19663-1-newren@gmail.com>
 <20180607050654.19663-2-newren@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <cec770a8-28ee-d546-8c27-905d2fcdb0c8@talktalk.net>
Date:   Sun, 10 Jun 2018 20:40:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607050654.19663-2-newren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJW6pSxSLPKmJooSSTZIW6uvuAMl1c4dukhPYkvZ9eP35TWhfF15V0OKrZ8V0gmu9CNd4I8TPR1d+Ys4CbWBFoQ9m6wbzOih62s9hVZ8EnJyjeIyxipk
 m3isA2OluazhHU5AL7r88Qt+0uQ+rqB1GjGtotEHLusf5/6Nc3KHtXdOtU/jESa8WtrTSiRS6sI/a/7XLeIuD8xqeTpupFt9/zw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/06/18 06:06, Elijah Newren wrote:
> git rebase has three different types: am, merge, and interactive, all of
> which are implemented in terms of separate scripts.  am builds on git-am,
> merge builds on git-merge-recursive, and interactive builds on
> git-cherry-pick.  We make use of features in those lower-level commands in
> the different rebase types, but those features don't exist in all of the
> lower level commands so we have a range of incompatibilities.  Previously,
> we just accepted nearly any argument and silently ignored whichever ones
> weren't implemented for the type of rebase specified.  Change this so the
> incompatibilities are documented, included in the testsuite, and tested
> for at runtime with an appropriate error message shown.

I think this is a great improvement, it has always bothered me that 
rebase silently ignored the am options when they're given with 
interactive ones.
> 
> Some exceptions I left out:
> 
>    * --merge and --interactive are technically incompatible since they are
>      supposed to run different underlying scripts, but with a few small
>      changes, --interactive can do everything that --merge can.  In fact,
>      I'll shortly be sending another patch to remove git-rebase--merge and
>      reimplement it on top of git-rebase--interactive.

Excellent I've wondered about doing that but never got round to it. One 
thing I was slightly concerned about was that someone maybe parsing the 
output of git-rebase--merge and they'll get a nasty shock when that 
output changes as a result of using the sequencer.

> 
>    * One could argue that --interactive and --quiet are incompatible since
>      --interactive doesn't implement a --quiet mode (perhaps since
>      cherry-pick itself does not implement one).  However, the interactive
>      mode is more quiet than the other modes in general with progress
>      messages, so one could argue that it's already quiet.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   Documentation/git-rebase.txt           | 15 +++++++++++++--
>   git-rebase.sh                          | 17 +++++++++++++++++
>   t/t3422-rebase-incompatible-options.sh | 10 +++++-----
>   3 files changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 0e20a66e73..451252c173 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -243,6 +243,10 @@ leave out at most one of A and B, in which case it defaults to HEAD.
>   --keep-empty::
>   	Keep the commits that do not change anything from its
>   	parents in the result.
> ++
> +This uses the `--interactive` machinery internally, and as such,
> +anything that is incompatible with --interactive is incompatible
> +with this option.
>   
>   --allow-empty-message::
>   	By default, rebasing commits with an empty message will fail.
> @@ -324,6 +328,8 @@ which makes little sense.
>   	and after each change.  When fewer lines of surrounding
>   	context exist they all must match.  By default no context is
>   	ever ignored.
> +	Incompatible with the --merge and --interactive options, or
> +	anything that implies those options or their machinery.

struct replay_opts has an allow_empty_message member so I'm not sure 
that's true.

>   -f::
>   --force-rebase::
> @@ -355,13 +361,15 @@ default is `--no-fork-point`, otherwise the default is `--fork-point`.
>   --whitespace=<option>::
>   	These flag are passed to the 'git apply' program
>   	(see linkgit:git-apply[1]) that applies the patch.
> -	Incompatible with the --interactive option.
> +	Incompatible with the --merge and --interactive options, or
> +	anything that implies those options or their machinery.

I wonder if it is better just to list the incompatible options it might 
be a bit long but it would be nicer for the user than them having to 
work out which options imply --interactive.

>   --committer-date-is-author-date::
>   --ignore-date::
>   	These flags are passed to 'git am' to easily change the dates
>   	of the rebased commits (see linkgit:git-am[1]).
> -	Incompatible with the --interactive option.
> +	Incompatible with the --merge and --interactive options, or
> +	anything that implies those options or their machinery.
>   
>   --signoff::
>   	Add a Signed-off-by: trailer to all the rebased commits. Note
> @@ -400,6 +408,9 @@ The `--rebase-merges` mode is similar in spirit to `--preserve-merges`, but
>   in contrast to that option works well in interactive rebases: commits can be
>   reordered, inserted and dropped at will.
>   +
> +This uses the `--interactive` machinery internally, but it can be run
> +without an explicit `--interactive`.
> ++

Without more context it's hard to judge but I'm not sure this adds 
anything useful

>   It is currently only possible to recreate the merge commits using the
>   `recursive` merge strategy; Different merge strategies can be used only via
>   explicit `exec git merge -s <strategy> [...]` commands.
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 40be59ecc4..f1dbecba18 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -503,6 +503,23 @@ then
>   	git_format_patch_opt="$git_format_patch_opt --progress"
>   fi
>   
> +if test -n "$git_am_opt"; then
> +	incompatible_opts=`echo "$git_am_opt" | sed -e 's/ -q//'`

I think the style guide recommends $() over ``

> +	if test -n "$interactive_rebase"
> +	then
> +		if test -n "$incompatible_opts"
> +		then
> +			die "$(gettext "error: cannot combine interactive options (--interactive, --exec, --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with am options ($incompatible_opts)")"
> +		fi
> +	fi
> +	if test -n "$do_merge"; then
> +		if test -n "$incompatible_opts"
> +		then
> +			die "$(gettext "error: cannot combine merge options (--merge, --strategy, --strategy-option) with am options ($incompatible_opts)")"
> +		fi
> +	fi
> +fi
> +
>   if test -n "$signoff"
>   then
>   	test -n "$preserve_merges" &&
> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
> index 04cdae921b..66a83363bf 100755
> --- a/t/t3422-rebase-incompatible-options.sh
> +++ b/t/t3422-rebase-incompatible-options.sh
> @@ -34,27 +34,27 @@ test_expect_success 'setup' '
>   test_run_rebase () {
>   	opt=$1
>   	shift
> -	test_expect_failure "$opt incompatible with --merge" "
> +	test_expect_success "$opt incompatible with --merge" "
>   		git checkout B^0 &&
>   		test_must_fail git rebase $opt --merge A
>   	"
>   
> -	test_expect_failure "$opt incompatible with --strategy=ours" "
> +	test_expect_success "$opt incompatible with --strategy=ours" "
>   		git checkout B^0 &&
>   		test_must_fail git rebase $opt --strategy=ours A
>   	"
>   
> -	test_expect_failure "$opt incompatible with --strategy-option=ours" "
> +	test_expect_success "$opt incompatible with --strategy-option=ours" "
>   		git checkout B^0 &&
>   		test_must_fail git rebase $opt --strategy=ours A
>   	"
>   
> -	test_expect_failure "$opt incompatible with --interactive" "
> +	test_expect_success "$opt incompatible with --interactive" "
>   		git checkout B^0 &&
>   		test_must_fail git rebase $opt --interactive A
>   	"
>   
> -	test_expect_failure "$opt incompatible with --exec" "
> +	test_expect_success "$opt incompatible with --exec" "
>   		git checkout B^0 &&
>   		test_must_fail git rebase $opt --exec 'true' A
>   	"
> 

