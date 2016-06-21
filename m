Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44E561FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 22:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbcFUWuf (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 18:50:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50825 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751536AbcFUWuH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 18:50:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 41C2125093;
	Tue, 21 Jun 2016 18:49:21 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/pUqBvBh7wt8OUycTMfNJnXLQCo=; b=Cuf9jx
	WdXmRjMaj//9iceQcskdxqqn3SOzwBaE8ME29n6LYQC3EvjgBRFXF2xXt/gx7+a+
	5xt8HzKpqrWPVaq3jnSsXEqOsjS8WAgiHVoVjKp59UpMZ3GaZe56wGNTrt62T57j
	HopJpqSiOYvHiDksmenR98LG0BBPrmPBf73Dw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I4N/ca1lPYO6cCtE2xQmqQmknpZloPEG
	77LGAD66H6dKQoH7EVzM28qOtiEXctX6KUX4QNpk5UQ5QjbtllzFUK5YymvTXFYU
	EfcDXjh0Fdne9AhFO8xQSoRUGGE1RaxOtQKa4ysL/aWJArUXjvu5oxf7Py4FnsYE
	6MUd2PWGgDw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 395742508F;
	Tue, 21 Jun 2016 18:49:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A500F2508E;
	Tue, 21 Jun 2016 18:49:20 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Charles Bailey <charles@hashpling.org>
Cc:	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] grep: fix grepping for "intent to add" files
References: <20160621211412.28752-1-charles@hashpling.org>
	<20160621211412.28752-2-charles@hashpling.org>
Date:	Tue, 21 Jun 2016 15:49:18 -0700
In-Reply-To: <20160621211412.28752-2-charles@hashpling.org> (Charles Bailey's
	message of "Tue, 21 Jun 2016 14:14:12 -0700")
Message-ID: <xmqqinx2nonl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6465E556-3802-11E6-B2E3-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Charles Bailey <charles@hashpling.org> writes:

> Is "Helped-by" an appropriate attribution in this case?

Sure.

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 462e607..ae73831 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -386,7 +386,7 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int
>  
>  	for (nr = 0; nr < active_nr; nr++) {
>  		const struct cache_entry *ce = active_cache[nr];
> -		if (!S_ISREG(ce->ce_mode) || ce_intent_to_add(ce))
> +		if (!S_ISREG(ce->ce_mode))
>  			continue;
>  		if (!ce_path_match(ce, pathspec, NULL))
>  			continue;
> @@ -396,7 +396,7 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int
>  		 * cache version instead
>  		 */
>  		if (cached || (ce->ce_flags & CE_VALID) || ce_skip_worktree(ce)) {
> -			if (ce_stage(ce))
> +			if (ce_stage(ce) || ce_intent_to_add(ce))
>  				continue;
>  			hit |= grep_sha1(opt, ce->sha1, ce->name, 0, ce->name);
>  		}

OK, so this function handles searching in either the index or the
working tree.

The first hunk used to unconditionally discard paths marked as
i-t-a, even when we are looking at the working tree, which is
clearly useless, and we stop rejecting i-t-a paths too early, which
is good.

The second hunk is for "grep --cached" but also covers two other
cases.  What are these?

CE_VALID is used by "Assume unchanged".  Because the user promised
that s/he will take responsibility of keeping the working tree
contents in sync with what is in the index by not modifying it, even
when we are not doing "grep --cached", we pick up the contents from
the index and look for the string in there, instead of going to the
working tree.  In other words, even though at the mechanical level
we are looking into the index, logically we are searching in the
working tree.  Is it sensible to skip i-t-a entries in that case?

I think the same discussion would apply to CE_SKIP_WORKTREE (see
"Skip-worktree bit" in Documentation/git-update-index.txt).

So I wonder if a better change would be more like

	for (...) {
        	if (!S_ISREG(ce->ce_mode))
                	continue; /* not a regular file */
		if (!ce_path_match(ce, pathspec, NULL)
                	continue; /* uninteresting */
+		if (cached && ce_intent_to_add(ce))
+			continue; /* path not yet in the index */
		        
		if (cached || ...)
                	UNCHANGED FROM THE ORIGINAL

perhaps?

I actually think (ce->ce_flags & CE_VALID) case should go to working
tree for performance, but that is a separate topic.

> +test_expect_success 'grep can find things only in the work tree' '
> +	touch work-tree-only &&

Please do not use "touch" if the reason to use the command is *not*
to muck with the timestamp, e.g. to create an empty file.

> +	git add work-tree-only &&
> +	echo "find in work tree" >work-tree-only &&
> +	git grep --quiet "find in work tree" &&
> +	test_must_fail git grep --quiet --cached "find in work tree" &&
> +	test_must_fail git grep --quiet "find in work tree" HEAD &&
> +	git rm -f work-tree-only
> +'
> +
> +test_expect_success 'grep can find things only in the work tree (i-t-a)' '
> +	echo "intend to add this" >intend-to-add &&
> +	git add -N intend-to-add &&
> +	git grep --quiet "intend to add this" &&
> +	test_must_fail git grep --quiet --cached "intend to add this" &&
> +	test_must_fail git grep --quiet "intend to add this" HEAD &&
> +	git rm -f intend-to-add
> +'
> +
> +test_expect_success 'grep can find things only in the index' '
> +	echo "only in the index" >cache-this &&
> +	git add cache-this &&
> +	rm cache-this &&
> +	test_must_fail git grep --quiet "only in the index" &&
> +	git grep --quiet --cached "only in the index" &&
> +	test_must_fail git grep --quiet "only in the index" HEAD &&
> +	git rm --cached cache-this
> +'
> +
> +test_expect_success 'grep does not report i-t-a with -L --cached' '
> +	echo "intend to add this" >intend-to-add &&
> +	git add -N intend-to-add &&
> +	git ls-files | grep -v "^intend-to-add\$" >expected &&
> +	git grep -L --cached "nonexistent_string" >actual &&
> +	test_cmp expected actual &&
> +	git rm -f intend-to-add
> +'
> +
>  test_done
