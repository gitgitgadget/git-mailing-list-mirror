From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] rebase: omit patch-identical commits with --fork-point
Date: Wed, 16 Jul 2014 13:26:32 -0700
Message-ID: <xmqqa989rqx3.fsf@gitster.dls.corp.google.com>
References: <xmqqmwcatgza.fsf@gitster.dls.corp.google.com>
	<47e67c62fb2a8c8846f5d3a12d71aebf8fa875d7.1405538598.git.john@keeping.me.uk>
	<374b26180807c67f7bd152ce5a2f52e34397e3a6.1405538598.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ted Felix <ted@tedfelix.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jul 16 22:26:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Vmv-0001K8-MI
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 22:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbaGPU0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 16:26:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56696 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbaGPU0p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 16:26:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BEEDE296C7;
	Wed, 16 Jul 2014 16:26:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8wLd7cGiiEfBwRGM+g1acQGDwBY=; b=X58Nhw
	v7PO6on38/jf3jRq4ohEHj/1Rpj/QI4wShdPuiJUV7Qh7bMWMUnQGSERCBWnuS7F
	fBiUuRy9gdHtWekHYDu0RUg4bOwW+HrY1FCNw22rz5PX+Pe7S5TKOY0yJh+aItLg
	+Ym+jLOQQuMDapllUr6SExSq0CmmLP6mPhntQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TI5drvF2qssW7D7NwraaliTIF2OQLsm2
	p9E2sbZq4a8CYLv3V+DCehBEsir7jGLpKhYmOeeq7QQZcvRNZC/S/Cr3b8NJBPnr
	c2U1+wMAqahl0dknCNYl1ihqud611uZ9XbjE85xvW82YXl12HtN7idwwrymTX4aK
	ba9r45h8Ltk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B5377296C6;
	Wed, 16 Jul 2014 16:26:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 17268296B8;
	Wed, 16 Jul 2014 16:26:34 -0400 (EDT)
In-Reply-To: <374b26180807c67f7bd152ce5a2f52e34397e3a6.1405538598.git.john@keeping.me.uk>
	(John Keeping's message of "Wed, 16 Jul 2014 20:23:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7AAEC592-0D27-11E4-BFBE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253689>

John Keeping <john@keeping.me.uk> writes:

> When the `--fork-point` argument was added to `git rebase`, we changed
> the value of $upstream to be the fork point instead of the point from
> which we want to rebase.  When $orig_head..$upstream is empty this does
> not change the behaviour, but when there are new changes in the upstream
> we are no longer checking if any of them are patch-identical with
> changes in $upstream..$orig_head.
>
> Fix this by introducing a new variable to hold the fork point and using
> this to restrict the range as an extra (negative) revision argument so
> that the set of desired revisions becomes (in fork-point mode):
>
> 	git rev-list --cherry-pick --right-only \
> 		$upstream...$orig_head ^$fork_point
>
> This allows us to correctly handle the scenario where we have the
> following topology:
>
> 	    C --- D --- E  <- dev
> 	   /
> 	  B  <- master@{1}
> 	 /
> 	o --- B' --- C* --- D*  <- master
>
> where:
> - B' is a fixed-up version of B that is not patch-identical with B;
> - C* and D* are patch-identical to C and D respectively and conflict
>   textually if applied in the wrong order;
> - E depends textually on D.
>
> The correct result of `git rebase master dev` is that B is identified as
> the fork-point of dev and master, so that C, D, E are the commits that
> need to be replayed onto master; but C and D are patch-identical with C*
> and D* and so can be dropped, so that the end result is:
>
> 	o --- B' --- C* --- D* --- E  <- dev
>
> If the fork-point is not identified, then picking B onto a branch
> containing B' results in a conflict and if the patch-identical commits
> are not correctly identified then picking C onto a branch containing D
> (or equivalently D*) results in a conflict.
>
> This change allows us to handle both of these cases, where previously we
> either identified the fork-point (with `--fork-point`) but not the
> patch-identical commits *or* (with `--no-fork-point`) identified the
> patch-identical commits but not the fact that master had been rewritten.
>
> Reported-by: Ted Felix <ted@tedfelix.com>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>
> Change from v1:
>     - add a test case

> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 80e0a95..47b5682 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -169,6 +169,29 @@ test_expect_success 'default to common base in @{upstream}s reflog if no upstrea
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'cherry-picked commits and fork-point work together' '
> +	git checkout default-base &&
> +	echo Amended >A &&
> +	git commit -a --no-edit --amend &&
> +	test_commit B B &&
> +	test_commit new_B B "New B" &&
> +	test_commit C C &&
> +	git checkout default &&
> +	git reset --hard default-base@{4} &&
> +	test_commit D D &&
> +	git cherry-pick -2 default-base^ &&
> +	test_commit final_B B "Final B" &&
> +	git rebase &&

mental note: this rebases default (i.e. the current branch) on
default-base; it depends on branch.default.{remote,merge} being set
by the previous test piece.

> +	echo Amended >expect &&
> +	test_cmp A expect &&
> +	echo "Final B" >expect &&
> +	test_cmp B expect &&
> +	echo C >expect &&
> +	test_cmp C expect &&
> +	echo D >expect &&
> +	test_cmp D expect
> +'

Thanks.  Do these labels on the commits have any relation to the
topology illustrated in the log message?

It looks like the above produces this:

      a'---D---B'--new_B'---final_B (default)
     /
    o----a---B---new_B---C (default-base)
                          \
                           D''---final_B''

where 'a' is "Modify A." from the original set-up and B and new_B
are the cherry-picks to be filtered out during the rebase.  Am I
reading the test correctly?

>  test_expect_success 'rebase -q is quiet' '
>  	git checkout -b quiet topic &&
>  	git rebase -q master >output.out 2>&1 &&
