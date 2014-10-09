From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] rebase -m: Use empty tree base for parentless commits
Date: Thu, 09 Oct 2014 12:05:05 -0700
Message-ID: <xmqq1tqh6p3y.fsf@gitster.dls.corp.google.com>
References: <5434312E.6040407@redhat.com>
	<bf0e177fbaac91f8c55526729e580fade9f0f395.1412879523.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 21:05:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcJ1W-0001Kb-BK
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 21:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbaJITFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 15:05:11 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53818 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751065AbaJITFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 15:05:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 528471497E;
	Thu,  9 Oct 2014 15:05:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/6eCZ8V1h3U+7uqL7k2w9rCzzBc=; b=qv6xz0
	1JgbnsgvB/R/4VBcDCmn++uNGK4wVWrnzKI//Nt1bRmi0vl3XG3JPbEbnXWBFJM8
	JlL9p2qTOJzakGO4fPCFAJ5PFSag4Tgc0Gu1+GbqtvoBrlhIULWHDffEpD0bIqsh
	UKsIE6QhMHe8C/OkJqtNXOdkhwZJhiOGpdKL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tcwSNbrE3Ezxanoyauwt2EQHi6GGc6sx
	870LbqCTijDPDJxeNtC8p0kbJ2025BjadiW3hVpcrdLZphDryvAuRjHo8ozBshM/
	To8AnUb3gW0NLBunLARpvBHKloOJMMSn88JMygFSPp8qkDWNTWlbbIEudhFRWSbX
	wqBpbk5gQe8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 49CA01497D;
	Thu,  9 Oct 2014 15:05:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 042891497C;
	Thu,  9 Oct 2014 15:05:06 -0400 (EDT)
In-Reply-To: <bf0e177fbaac91f8c55526729e580fade9f0f395.1412879523.git.bafain@gmail.com>
	(Fabian Ruch's message of "Thu, 9 Oct 2014 20:50:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2EDDA8CE-4FE7-11E4-9F45-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Ruch <bafain@gmail.com> writes:

> diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
> index d3fb67d..3f754ae 100644
> --- a/git-rebase--merge.sh
> +++ b/git-rebase--merge.sh
> @@ -67,7 +67,13 @@ call_merge () {
>  		GIT_MERGE_VERBOSITY=1 && export GIT_MERGE_VERBOSITY
>  	fi
>  	test -z "$strategy" && strategy=recursive
> -	eval 'git-merge-$strategy' $strategy_opts '"$cmt^" -- "$hd" "$cmt"'
> +	base=$(git rev-list --parents -1 $cmt | cut -d ' ' -s -f 2 -)
> +	if test -z "$base"
> +	then
> +		# the empty tree sha1
> +		base=4b825dc642cb6eb9a060e54bf8d69288fbee4904
> +	fi
> +	eval 'git-merge-$strategy' $strategy_opts '"$base" -- "$hd" "$cmt"'

This looks wrong.

The interface to "git-merge-$strategy" is designed in such a way
that each strategy should be capable of taking _no_ base at all.

See how unquoted $common is given to git-merge-$strategy in
contrib/examples/git-merge.sh, i.e.

    eval 'git-merge-$strategy '"$xopt"' $common -- "$head_arg" "$@"'

where common comes from

	common=$(git merge-base ...)

which would be empty when you are looking at disjoint histories.

Also rev-list piped to cut is too ugly to live in our codebase X-<.

Wouldn't it be sufficient to do something like this instead?

	eval 'git-merge-$strategy' $strategy_opts \
        	$(git rev-parse --quiet --verify "$cmt^") -- "$hd" "$cmt"
