Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF05A1F424
	for <e@80x24.org>; Mon, 18 Dec 2017 18:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936189AbdLRSYK (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 13:24:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64835 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932506AbdLRSYH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 13:24:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3509EC391B;
        Mon, 18 Dec 2017 13:24:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kABwiX3Dp4M0J1ixLxV+ud43/Wo=; b=JZnxYe
        HWmvb+IfvVsX5pf+0ZEim+VtI5imjOT9ZT85hteF7kdNyUOYeNk0uYtsA+CGBX0J
        CsvWvWnOxVnd14QA/V52iE9q6JAfrxfx+ybVrGE94AajBskq72sxzznmnCHZQMxW
        5NaTsMWO95wqcYGzBd59A6FQ0uF6OEJ4oANeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sbtSNSslSGJMEySnMGZr4T6rQeo+WsO4
        GEdU2T+ZW/vR31DOWqmfY6ap3UWUeafiH5nIA+eDyeksBrIt7n6Clv4N1Zh/67jd
        p850Cl4qdW6I8qxjghDcjvKLzsIUAWZWYOE6mLkXaBrR/wfVHrppZUIXYwEeB0Rw
        JokyHjvpB3Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D91FC391A;
        Mon, 18 Dec 2017 13:24:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A30A7C3919;
        Mon, 18 Dec 2017 13:24:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Reid Price <reid.price@gmail.com>, git@vger.kernel.org
Subject: Re: Apparent bug in 'git stash push <subdir>' loses untracked files
References: <CA+HNv10i7AvWXjrQjxxy1LNJTmhr7LE4TwxhHUYBiWtmJCOf_A@mail.gmail.com>
        <20171213230547.GC24597@hank>
        <xmqq4loqplou.fsf@gitster.mtv.corp.google.com>
        <20171217180511.GA2641@hank>
Date:   Mon, 18 Dec 2017 10:24:04 -0800
In-Reply-To: <20171217180511.GA2641@hank> (Thomas Gummerer's message of "Sun,
        17 Dec 2017 18:05:11 +0000")
Message-ID: <xmqqpo7byjwb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1731AA6-E420-11E7-822B-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Ah interesting, what you have below looks good to me indeed, it
> matches what I'd expect it to do and fixes the bug that was reported.
> Thanks! 
>
> I've taken the liberty to take what you have below and turned into a
> proper patch, giving you authorship of it, as you wrote the code for
> the fix.  Hope that's the appropriate credit for you for this patch.

Not so fast.

I know why the updated code works like "--hard -- <pathspec>", but I
do not quite get what the original was trying to do and how it is
different.  Even with your proposed log message, which describes a
symptom (i.e. "untracked files ... be deleted"), it is unclear why
this deletion was happening in the first place.  Specifically, it is
unclear why that "clean --force -q -d" was in there, and are we
breaking other cases by rewriting this codepath without it?

In any case, instead of the 

	ls-files -z -- "$@" | checkout-index -z --force --stdin
	diff-index -p HEAD -- "$@" | apply --index -R

sequence, a shorter variant that should work is

	add -u -- "$@"
	diff-index -p --cached HEAD -- "$@" | apply --index -R

Both of these share the same idea.  

 - The first step is to match what is in the index and what is in
   the working tree (i.e. make "diff-files" silent).  The version
   you have does so by checking out what is in the index to the
   working tree.  The shorter one goes the other way and updates the
   index with what is in the working tree.

 - Once that is done, we ask diff-index what got changed since the
   HEAD in the working tree (or in the index in the updated
   one---after the first step that makes the two match, comparing
   with the working tree and comparing with the index should result
   in the same diff; I have a suspicion that "--cached" is faster,
   but we need to benchmark to pick), and ask apply to get rid of
   all these changes, which includes removal of added files, and
   resurrection of removed files.

I think the original that did 'git reset -- "$@"' upfront lost new
paths from the index (without removing it from the working tree), I
am guessing that it is why "clean" was there to get rid of them, and
if that is the reason, I can understand why the original code was
behaving incorrectly---it would get rid of new files that did not
exist in HEAD correctly, but it also would remove untracked ones,
because after that first 'reset', the code couldn't tell between
them.

And I think that is what we want, i.e. why the original was wrong
and how the new one fixes it, to describe in the log message to
justify this change.

One thing that I didn't think through and you need to verify is if
we need to do anything extra to deal with binary files (in the old
days, we needed --full-index and --binary options to produce and
apply a binary patch; I do not offhand know if that is still the
case) in the final "diff-index piped to apply -R --index" dance.

So I am asking you to fill in quite a lot of gaps that I didn't do
with only the above two-liner ;-)  You should take the authorship
and, if you like, credit me with helped-by: or something.

Thanks.


>
> [...]
>
> --- >8 ---
> From: Junio C Hamano <gitster@pobox.com>
> Subject: [PATCH] stash: don't delete untracked files that match pathspec
>
> Currently when 'git stash push -- <pathspec>' is used, untracked files
> that match the pathspec will be deleted, even though they do not end up
> in a stash anywhere.
>
> Untracked files should be left along by 'git stash push -- <pathspec>'
> unless the --untracked or --all flags are given.  Fix that.
>
> Reported-by: Reid Price <reid.price@gmail.com>
> Test-by: Thomas Gummerer <t.gummerer@gmail.com>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  git-stash.sh     |  5 ++---
>  t/t3903-stash.sh | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 1114005ce2..a979bfb665 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -322,10 +322,9 @@ push_stash () {
>  
>  		if test $# != 0
>  		then
> -			git reset -q -- "$@"
> -			git ls-files -z --modified -- "$@" |
> +			git ls-files -z -- "$@" |
>  			git checkout-index -z --force --stdin
> -			git clean --force -q -d -- "$@"
> +			git diff-index -p HEAD -- "$@" | git apply --index -R
>  		else
>  			git reset --hard -q
>  		fi
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 39c7f2ebd7..6952a031b2 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1064,4 +1064,20 @@ test_expect_success 'stash -k -- <pathspec> leaves unstaged files intact' '
>  	test foo,bar = $(cat foo),$(cat bar)
>  '
>  
> +test_expect_success 'stash -- <subdir> leaves untracked files in subdir intact' '
> +	git reset &&
> +	>subdir/untracked &&
> +	>subdir/tracked1 &&
> +	>subdir/tracked2 &&
> +	git add subdir/tracked* &&
> +	git stash -- subdir/ &&
> +	test_path_is_missing subdir/tracked1 &&
> +	test_path_is_missing subdir/tracked2 &&
> +	test_path_is_file subdir/untracked &&
> +	git stash pop &&
> +	test_path_is_file subdir/tracked1 &&
> +	test_path_is_file subdir/tracked2 &&
> +	test_path_is_file subdir/untracked
> +'
> +
>  test_done
