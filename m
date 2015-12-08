From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] contrib/subtree: fix "subtree split" skipped-merge bug
Date: Tue, 08 Dec 2015 13:23:21 -0800
Message-ID: <xmqqk2ook52u.fsf@gitster.mtv.corp.google.com>
References: <CAPig+cR36772YDc5RQRwXP3+ucVWumim9HYTXVMuGXN2cnQ7Ow@mail.gmail.com>
	<1449607160-20608-1-git-send-email-davidw@realtimegenomics.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dave Ware <davidw@realtimegenomics.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 22:23:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6PjM-0006Mc-FE
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 22:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbbLHVXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 16:23:24 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56977 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752594AbbLHVXY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 16:23:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0D40D3009B;
	Tue,  8 Dec 2015 16:23:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6LagDROyo7A5yKbrKjrN+lLuuZU=; b=lTjaun
	AsCvqr9ifALtHGqFPsnTEvaH/Sj6LZhu7sYdBtLWQSRVYzlEVcE/3DV8LcHwass2
	o1c8+LGBxkqZOVeaADXdjemnv+f0VUNZTMrutMl7eyYe1211i4nIV7QHaLXx8pge
	+7I1PqJMDu7VoTpwCV7MROzkDXQe41MP95VyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v7xWObVoQ+6ISz58QRN0Gr7H1G4KhqGu
	i4yA+7YqlI5uyQ73cA4EDDCAooy+rnWxFmkEG0Bu6DVZkO7YwHxZqpWAW3fAF7at
	8p5Mz0/5GJYnFwyjoV4jU3VLXWS11H/jC6sja6q++9SeEdBlg+71BWU65yvEC5Pi
	DJz4zXcipe0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F0FAC3009A;
	Tue,  8 Dec 2015 16:23:22 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6254230097;
	Tue,  8 Dec 2015 16:23:22 -0500 (EST)
In-Reply-To: <1449607160-20608-1-git-send-email-davidw@realtimegenomics.com>
	(Dave Ware's message of "Wed, 9 Dec 2015 09:39:20 +1300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E8DD0F04-9DF1-11E5-97BA-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282177>

Dave Ware <davidw@realtimegenomics.com> writes:

> A bug occurs in 'git-subtree split' where a merge is skipped even when
> both parents act on the subtree, provided the merge results in a tree
> identical to one of the parents. Fix by copying the merge if at least
> one parent is non-identical, and the non-identical parent is not an
> ancestor of the identical parent.
>
> Also, add a test case which checks that a descendant can be pushed to
> its ancestor in this case.
>
> Signed-off-by: Dave Ware <davidw@realtimegenomics.com>
> ---

The first sentence may be made clearer if you rephrased the early
part of the sentence this way:

	'git subtree split' can incorrectly skip a merge even when
        both parents ...

> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 9f06571..b837531 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -479,8 +479,16 @@ copy_or_skip()
>  			p="$p -p $parent"
>  		fi
>  	done
> -	
> -	if [ -n "$identical" ]; then
> +
> +	copycommit=
> +	if [ -n "$identical" ] && [ -n "$nonidentical" ]; then
> +		extras=$(git rev-list --boundary $identical..$nonidentical)
> +		if [ -n "$extras" ]; then
> +			# we need to preserve history along the other branch
> +			copycommit=1
> +		fi

What is the significance of "--boundary" here?  I think for the
purpose of "is the identical one part of the nonidentical one?" you
do not need it, but there may be something subtle I missed.  I am
asking this because use of "rev-list --boundary" in scripts is
almost always a bug.

Also, depending on how huge the output from the rev-list could be,
you might want to use "rev-list --count $i..$n" and compare it with
0 instead--that way, you would not have to be worried about having
to carry around a huge string that you would otherwise not use, only
to see if that string is empty.

Thanks.

> +	fi
> +	if [ -n "$identical" ] && [ -z "$copycommit" ]; then
>  		echo $identical
>  	else
>  		copy_commit $rev $tree "$p" || exit $?
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index 9051982..710278c 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -468,4 +468,56 @@ test_expect_success 'verify one file change per commit' '
>  	))
>  '
>  
> +test_expect_success 'subtree descendent check' '
> +	mkdir git_subtree_split_check &&
> +	(
> +		cd git_subtree_split_check &&
> +		git init &&
> +
> +		mkdir folder &&
> +
> +		echo a >folder/a &&
> +		git add . &&
> +		git commit -m "first commit" &&
> +
> +		git branch branch &&
> +
> +		echo 0 >folder/0 &&
> +		git add . &&
> +		git commit -m "adding 0 to folder" &&
> +
> +		echo b >folder/b &&
> +		git add . &&
> +		git commit -m "adding b to folder" &&
> +		cherry=$(git rev-parse HEAD) &&
> +
> +		git checkout branch &&
> +		echo text >textBranch.txt &&
> +		git add . &&
> +		git commit -m "commit to fiddle with branch: branch" &&
> +
> +		git cherry-pick $cherry &&
> +		git checkout master &&
> +		git merge -m "merge" branch &&
> +
> +		git branch noop_branch &&
> +
> +		echo d >folder/d &&
> +		git add . &&
> +		git commit -m "adding d to folder" &&
> +
> +		git checkout noop_branch &&
> +		echo moreText >anotherText.txt &&
> +		git add . &&
> +		git commit -m "irrelevant" &&
> +
> +		git checkout master &&
> +		git merge -m "second merge" noop_branch &&
> +
> +		git subtree split --prefix folder/ --branch subtree_tip master &&
> +		git subtree split --prefix folder/ --branch subtree_branch branch &&
> +		git push . subtree_tip:subtree_branch
> +	)
> +	'
> +
>  test_done
