From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase--merge: don't include absent parent as a base
Date: Wed, 20 Apr 2016 14:13:49 -0700
Message-ID: <xmqq1t60ugoi.fsf@gitster.mtv.corp.google.com>
References: <0102015434e7556a-2d9848cb-93c3-4883-96ec-c0c70098796b-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ben Woosley <Ben.Woosley@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 23:13:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aszRd-0006hb-6h
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 23:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbcDTVNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 17:13:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750998AbcDTVNw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 17:13:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E9DF15547;
	Wed, 20 Apr 2016 17:13:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dhEyVeiVFdI/WGJiw9HehqlTL7o=; b=X0Zz4L
	oS3VpsiiHb2yoekwUGVCjaKP/OvZfcbr/NP7lbKilB1O9fFUuG0pzKJj/DhU6zty
	K8Hz3KxFeKeiLcShHW0YBKELRKC/0bxCb0wQeCTrc/Yuiykqi9GGpuf342SMcIyR
	FSQ9BfpFoOMzmMFnq84uvxxCjZU/Yi4i7nf88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e9vHHXYK3+P9Kb1AkXHBE5bUHguJWyIj
	4XzjxGco6cMNTA5410g/zWoBZsps4LChkTq/5ckQFqYvo6z7RQMuM9shvjyYsSAh
	diBMvaffQJKhT+fSFwllRWepF4yEbMUWJjO3nI4EiebP3kn/59QUOHyVfyUiNrwD
	2WFTEHG7pDs=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1506D15546;
	Wed, 20 Apr 2016 17:13:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 663E715545;
	Wed, 20 Apr 2016 17:13:50 -0400 (EDT)
In-Reply-To: <0102015434e7556a-2d9848cb-93c3-4883-96ec-c0c70098796b-000000@eu-west-1.amazonses.com>
	(Ben Woosley's message of "Wed, 20 Apr 2016 18:20:56 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C74A6C2E-073C-11E6-8A63-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292080>

Ben Woosley <Ben.Woosley@gmail.com> writes:

> From: Ben Woosley <ben.woosley@gmail.com>
>
> Absent this fix, attempts to rebase an orphan branch with --strategy recursive
> will fail with:
>
>     $ git rebase ORPHAN_TARGET_BASE -s recursive
>     First, rewinding head to replay your work on top of it...
>     fatal: Could not parse object 'ORPHAN_ROOT_SHA^'
>     Unknown exit code (128) from command: git-merge-recursive ORPHAN_ROOT_SHA^ -- HEAD ORPHAN_ROOT_SHA
>
> To fix, this will only include the rebase root's parent as a base if it exists,
> so that in cases of rebasing an orphan branch, it is a simple two-way merge.
>
> Note the default rebase behavior does not fail:
>
>     $ git rebase ORPHAN_TARGET_BASE
>     First, rewinding head to replay your work on top of it...
>     Applying: ORPHAN_ROOT_COMMIT_MSG
>     Using index info to reconstruct a base tree...
>
> Signed-off-by: Ben Woosley <ben.woosley@gmail.com>
> ---
>  git-rebase--merge.sh    | 4 +++-
>  t/t3402-rebase-merge.sh | 9 +++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
> index 2cc2a6d..8d43db9 100644
> --- a/git-rebase--merge.sh
> +++ b/git-rebase--merge.sh
> @@ -67,7 +67,9 @@ call_merge () {
>  		GIT_MERGE_VERBOSITY=1 && export GIT_MERGE_VERBOSITY
>  	fi
>  	test -z "$strategy" && strategy=recursive
> -	eval 'git-merge-$strategy' $strategy_opts '"$cmt^" -- "$hd" "$cmt"'
> +	# If cmt doesn't have a parent, don't include it as a base
> +	base=$(git rev-parse --verify --quiet $cmt^)
> +	eval 'git-merge-$strategy' $strategy_opts $base ' -- "$hd" "$cmt"'

Makes sense to me.  It is not clear if such a merge without common
ancestor is all that useful, but as it is mechanically possible,
I do not see a reason to forbid it.

>  	rv=$?
>  	case "$rv" in
>  	0)
> diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
> index 8f64505..488945e 100755
> --- a/t/t3402-rebase-merge.sh
> +++ b/t/t3402-rebase-merge.sh
> @@ -85,6 +85,15 @@ test_expect_success 'rebase -Xtheirs' '
>  	! grep 11 original
>  '
>  
> +test_expect_success 'rebase -Xtheirs from orphan' '
> +	git checkout --orphan orphan-conflicting master~2 &&
> +	echo "AB $T" >> original &&
> +	git commit -morphan-conflicting original &&
> +	git rebase -Xtheirs master &&
> +	grep AB original &&
> +	! grep 11 original
> +'
> +
>  test_expect_success 'merge and rebase should match' '
>  	git diff-tree -r test-rebase test-merge >difference &&
>  	if test -s difference
>
> --
> https://github.com/git/git/pull/228
