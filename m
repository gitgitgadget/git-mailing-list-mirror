From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH v1] rebase -p: Command line option --no-ff is ignored
Date: Wed, 16 Jul 2014 18:01:16 +0200
Message-ID: <53C6A1CC.2000306@gmail.com>
References: <d8a1d5015e5562a706c1e8cf574d6011f1f1ac38.1404704884.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 18:01:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Re1-0006ke-2x
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 18:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965315AbaGPQBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 12:01:22 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:41376 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934509AbaGPQBU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 12:01:20 -0400
Received: by mail-we0-f174.google.com with SMTP id x48so1166437wes.5
        for <git@vger.kernel.org>; Wed, 16 Jul 2014 09:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=hJmyrVu9SO1g1CVv6J27uAanJL8TBxCdg/u8/RPm8Go=;
        b=i0OhVb8ISUD71sV7ytE3SLVNFxLK31uU93vBvXeip/wU3GpRVkopxQWpRdhMUS28Vo
         LjVCK0GpRRLbwRSHm3NKrll1wJx6LFGCo/mCc3RhneW6DxRQNa++wPwvnz+s2LvywOn8
         6CNvYofL6+5DaK/AbZbUu0qbcZhXy2oPqdyWxuVaLNuWfUAJJYGrcJuUP+VBF26FjVYv
         +viVaZtXaQoSy2bcfe3Cnjtw0wHsgOH7AC7qSLXLKeQ7wWXEneaF6G4QUKeKsUPoV5oS
         rV1r+p8ldR9swW14Gfxd9iufw07zmYUBAfBhZqPzGMcaElbb725NAMNkGvb28Jx6DKEN
         NRiQ==
X-Received: by 10.180.73.139 with SMTP id l11mr635098wiv.30.1405526479300;
        Wed, 16 Jul 2014 09:01:19 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id au7sm40576087wjc.41.2014.07.16.09.01.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Jul 2014 09:01:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <d8a1d5015e5562a706c1e8cf574d6011f1f1ac38.1404704884.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253670>

Hi Marc,

I forgot to cc your mailbox when I posted this patch last week. Do you
still remember whether there was a particular reason why
pick_one_preserving_merges wasn't touched by the commit b499549 ("Teach
rebase the --no-ff option."), by any chance?

Kind regards,
   Fabian

Fabian Ruch writes:
> The --no-ff option instructs git-rebase to always recreate commits as
> they are being replayed, even if fast-forwards are possible.
> 
> However, if git-rebase is asked to recreate merge commits (via the -p
> option), it suddenly ignores the --no-ff option and fast-forwards
> both normal and merge commits whenever possible.
> 
> git-rebase--interactive, which is responsible for recreating merge
> commits during a rebase, maintains a variable fast_forward to decide
> whether the current replay should be tried as a fast-forward.
> Previously, fast_forward was on by default and would get toggled only
> if a parent was rewritten or a squash was in effect. Also turn
> fast_forward off if --no-ff is in use, which is signalled by
> git-rebase through the variable force_rebase.
> 
> If --no-ff is not in use, try to fast-forward HEAD using git-reset as
> before. In contrast, if --no-ff is in use, replay normal commits
> using git-cherry-pick and merge commits using git-merge. Note that
> git-rebase--interactive already provides this machinery for enabling
> and disabling fast-forwards, controlled by fast_forward being
> assigned either t (for boolean true) or f (for boolean false).
> 
> As mentioned above, git-rebase--interactive needs to detect when a
> squash is in effect. If several commits are squashed into one, each
> of them is picked using the git-cherry-pick option -n and they get
> all rewritten to the same commit, the squash commit. Previously,
> fast_forward was assigned f if and only if -n was specified. This no
> longer holds for fast_forward might be turned off due to a use of
> --no-ff. To correctly notice squashes, explicitly check for -n.
> 
> Add test.
> 
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---
> Hi,
> 
> The code checking force_rebase is copied from pick_one, although
> using a ternary operator to initialise fast_forward might be more
> readable. Moreover, the code snippet used to detect squash mode is
> copied from the f arm of the fast_forward case switch, although the
> code base prefers to spell out test(1).
> 
> The test recreates a topic branch that merged a second topic branch.
> Therefore, the test case tests the recreation of both normal and
> merge commits.
> 
> Commit b499549 first introduced the --no-ff option to git-rebase and
> since then force_rebase seems to respected only by pick_one but not
> by its sibling pick_one_preserving_merges. I couldn't find a reason
> why. Was pick_one_preserving_merges merely overlooked?
> 
> Is it a usability issue that conflicting merges will have to be
> resolved again when being replayed now? The same applies to -p and
> the replay of merges with rewritten parents. Should the possibly
> required resolution be mentioned alongside git-rerere in the
> git-rebase manual page?
> 
>    Fabian
> 
>  git-rebase--interactive.sh        |  3 ++-
>  t/t3409-rebase-preserve-merges.sh | 12 ++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index f267d8b..264a768 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -266,10 +266,11 @@ pick_one_preserving_merges () {
>  		;;
>  	esac
>  	sha1=$(git rev-parse $sha1)
> +	case "$force_rebase" in '') ;; ?*) fast_forward=f ;; esac
>  
>  	if test -f "$state_dir"/current-commit
>  	then
> -		if test "$fast_forward" = t
> +		if [ "$1" != "-n" ]
>  		then
>  			while read current_commit
>  			do
> diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
> index 8c251c5..838937b 100755
> --- a/t/t3409-rebase-preserve-merges.sh
> +++ b/t/t3409-rebase-preserve-merges.sh
> @@ -81,6 +81,18 @@ test_expect_success 'setup for merge-preserving rebase' \
>  	git commit -a -m "Modify B2"
>  '
>  
> +test_expect_success '--no-ff records new commits' '
> +	(
> +	cd clone3 &&
> +	test_when_finished 'cd clone3 && git checkout topic' &&
> +	git checkout -b recreated-topic &&
> +	# recreate topic with merged topic2 (branching-off point A1)
> +	git rebase -p --no-ff HEAD~2 &&
> +	test $(git rev-parse new-topic^) != $(git rev-parse topic^) &&
> +	test $(git rev-parse new-topic) != $(git rev-parse topic)
> +	)
> +'
> +
>  test_expect_success '--continue works after a conflict' '
>  	(
>  	cd clone2 &&
