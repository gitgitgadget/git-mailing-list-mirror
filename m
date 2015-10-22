From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] blame: allow blame --reverse --first-parent when it makes sense
Date: Wed, 21 Oct 2015 21:25:37 -0700
Message-ID: <xmqqfv13ttq6.fsf@gitster.mtv.corp.google.com>
References: <1445485872-21453-1-git-send-email-max@max630.net>
	<1445485872-21453-3-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Thu Oct 22 06:26:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zp7Rn-0003lP-Bu
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 06:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbbJVEZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 00:25:46 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59360 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750930AbbJVEZp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 00:25:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AF85E268E0;
	Thu, 22 Oct 2015 00:25:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rOczN+qsWoz2xdM4tMCbypShlH8=; b=pDP8VK
	g7twsAY7/pdaKmNgK954t1S+84BvpCQnfbCqBnYbNAiwDkAtjrzVkABjEO85MTF9
	iUYhskBU4UAyZt1/Z/i6yHhyXiHxDEB9qWIbFyId94YUJqUmJPtUosMB2XTGY/qk
	kF9YHiobEbFFyMYWSQpUTjCn24Leq92CV92TQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HhKEegjEEiqiqq/nVyd5H+TKZ9f9qjNn
	m343uOHCVEUg9Z33Iumm02RWn/FotA+ZMsM9Si0nUJa4tD3R5hbfzAGvLCfJ3Xms
	z8Vsk/DCsdtSozaS1IHkQsNOd3zNCOajPfH73vG3ii1vWHF9LazQdgH3ouOmtRtH
	BN8jtRLYq5w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A6CE4268DF;
	Thu, 22 Oct 2015 00:25:44 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2BAA9268DE;
	Thu, 22 Oct 2015 00:25:44 -0400 (EDT)
In-Reply-To: <1445485872-21453-3-git-send-email-max@max630.net> (Max
	Kirillov's message of "Thu, 22 Oct 2015 06:51:12 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F5E98698-7874-11E5-8BB1-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280039>

Max Kirillov <max@max630.net> writes:

> Do not die immediately when the two flags are specified. Instead
> check that the specified range is along first-parent chain. Exploit
> how prepare_revision_walk() handles first_parent_only flag: the commits
> outside of first-parent chain are either unknown (and do not have any
> children recorded) or appear as non-first parent of a commit along the
> first-parent chain.
>
> Since the check seems fragile, add test which verifies that blame dies
> in both cases.

It is not quite clear in what way the "check seems fragile".

It is either "correct" or "appears to have worked by chance and
nobody has any confidence that it would tell if 'it makes sense'
reliably", and the latter cannot be papered over with any number of
tests.

The logic you implemented feels solid to me, at least at a first
glance.  What kind of gotchas are you worried about?

> Signed-off-by: Max Kirillov <max@max630.net>
> ---
>  builtin/blame.c          | 11 +++++++++--
>  t/t8009-blame-reverse.sh |  7 ++++++-
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 295ce92..27de544 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2692,8 +2692,6 @@ parse_done:
>  	}
>  	else if (contents_from)
>  		die("--contents and --children do not blend well.");
> -	else if (revs.first_parent_only)
> -		die("combining --first-parent and --reverse is not supported");
>  	else {
>  		final_commit_name = prepare_initial(&sb);
>  		sb.commits.compare = compare_commits_by_reverse_commit_date;
> @@ -2721,6 +2719,15 @@ parse_done:
>  	if (prepare_revision_walk(&revs))
>  		die(_("revision walk setup failed"));
>  
> +	if (reverse && revs.first_parent_only) {
> +		struct commit_list *final_children = lookup_decoration(&revs.children,
> +								       &sb.final->object);
> +		if (!final_children ||
> +		    hashcmp(final_children->item->parents->item->object.sha1,
> +			    sb.final->object.sha1))
> +		    die("--reverse --first-parent together require range along first-parent chain");
> +	}
> +
>  	if (is_null_sha1(sb.final->object.sha1)) {
>  		o = sb.final->util;
>  		sb.final_buf = xmemdupz(o->file.ptr, o->file.size);
> diff --git a/t/t8009-blame-reverse.sh b/t/t8009-blame-reverse.sh
> index 9f40613..042863b 100755
> --- a/t/t8009-blame-reverse.sh
> +++ b/t/t8009-blame-reverse.sh
> @@ -24,11 +24,16 @@ test_expect_failure 'blame --reverse finds B1, not C1' '
>  	test_cmp expect actual
>  	'
>  
> -test_expect_failure 'blame --reverse --first-parent finds A1' '
> +test_expect_success 'blame --reverse --first-parent finds A1' '
>  	git blame --porcelain --reverse --first-parent A0..A3 -- file.t >actual_full &&
>  	head -1 <actual_full | sed -e "sX .*XX" >actual &&
>  	git rev-parse A1 >expect &&
>  	test_cmp expect actual
>  	'
>  
> +test_expect_success 'blame --reverse --first-parse dies if no first parent chain' '
> +	test_must_fail git blame --porcelain --reverse --first-parent B1..A3 -- file.t &&
> +	test_must_fail git blame --porcelain --reverse --first-parent B2..A3 -- file.t
> +	'
> +
>  test_done
