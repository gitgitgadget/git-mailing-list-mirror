Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1331DFC4
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748138; cv=none; b=ttP35Qug2JMEer7t2c0mUV7JW93s+c9YbxTMkahw69+EbYa4/vc3R17KYBhbHkuRs21XZtiJv/7/Hwy0PHcqFyN6/rOJE+Ws4PZ5hbqqLD2V30+EfrUr7TTo9gULkUKyn5RQTZYAZ3QH+AAmjnkuphpMcYFwEHzbloDM2sNNqsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748138; c=relaxed/simple;
	bh=wVyHnajRldZdP7oj9bPvygtbs6iPNG9yOvnmxNl/fAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T3WVi8D2zrrbOj8BnaCTAXzjYXO42vVaPo+911Cs3tOo4Nv4VAKaY7XVlWl4vPvOEvtvqtEIj/VUqvREAUoQGNvKo88hn5am4jqGXX9SwQdy9yRgfxKUizgtex/bdxPT1uliOeLfMqNNxcJ8qIkZdZMVCP92niHvxcgg+myQ9c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=REINnlpU; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="REINnlpU"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E43171E7944;
	Fri, 29 Mar 2024 17:35:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wVyHnajRldZdP7oj9bPvygtbs6iPNG9yOvnmxN
	l/fAs=; b=REINnlpUX3//8EUUQjXEi17ZrHXwhg9xcohL3B1mzs+Vs2lMZjLHbg
	9YV/X+OvtOcr5by80fW7CU65iTB6bMW50wAVfjH9HL5ZsauSvGxyCUuQLKdvTl3M
	qaSTagmrc1p4OKbtVeDZyN4PijurjpXVNbJHFEk80BxAz4zLJ7ZT8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DCA551E7941;
	Fri, 29 Mar 2024 17:35:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 485FC1E7940;
	Fri, 29 Mar 2024 17:35:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] read-cache: optionally collect pathspec matching
 info
In-Reply-To: <20240329205649.1483032-3-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Sat, 30 Mar 2024 02:26:19 +0530")
References: <20240318155219.494206-2-shyamthakkar001@gmail.com>
	<20240329205649.1483032-3-shyamthakkar001@gmail.com>
Date: Fri, 29 Mar 2024 14:35:34 -0700
Message-ID: <xmqqjzlkwwk9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4701DFEE-EE14-11EE-8B94-25B3960A682E-77302942!pb-smtp2.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> The add_files_to_cache() adds files to the index. And
> add_files_to_cache() in turn calls run_diff_files() to perform this
> operation. The run_diff_files() uses ce_path_match() to match the
> pathspec against cache entries. However, it is called with NULL value
> for the seen parameter, which collects the pathspec matching
> information.

", which collects" -> ", which means we lose"

> Therefore, introduce a new parameter 'char *ps_matched' to 

"Therefore, introduce" -> "Introduce"

> add_files_to_cache() and in turn to run_diff_files(), to feed it to
> ce_path_match() to optionally collect the pathspec matching
> information. This will be helpful in reporting error in case of an
> untracked path being passed when the expectation is a known path. Thus,
> this will be used in the subsequent commits to fix 'commit -i' and 'add
> -u' not erroring out when given untracked paths.

A new parameter to run_diff_files() came as a bit of surprise to me.

When I responded to the previous round, I somehow thought that we'd
add a new member to the rev structure that points at an optional
.ps_matched member next to the existing .prune_data member.  

That way, it would hopefully be easy for a future code to see if a
"diff" invocation, not necessarily run_diff_files() that compares
the working tree and the index, consumed all the pathspec elements.
If such a new .ps_matched member is initialized to NULL, all the
patch noise we see in this patch will become unnecessary, no?

> diff --git a/diff-lib.c b/diff-lib.c
> index 5e8717c774..2dc3864abd 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -101,7 +101,8 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
>  	return changed;
>  }
>  
> -void run_diff_files(struct rev_info *revs, unsigned int option)
> +void run_diff_files(struct rev_info *revs, char *ps_matched,
> +		    unsigned int option)
>  {
>  	int entries, i;
>  	int diff_unmerged_stage = revs->max_count;
> @@ -127,7 +128,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
>  		if (diff_can_quit_early(&revs->diffopt))
>  			break;
>  
> -		if (!ce_path_match(istate, ce, &revs->prune_data, NULL))
> +		if (!ce_path_match(istate, ce, &revs->prune_data, ps_matched))
>  			continue;
>  
>  		if (revs->diffopt.prefix &&

This may be a non-issue, but after this point we see the beginning
of another filter to reject paths outside the hierarchy "--relative"
specifies.  It is possible that a pathspec element matches ce->name
but the matched cache entry is outside the current area.  Shouldn't
we then consider that the pathspec element did not match?  E.g., in
our project, what should happen if we did this?

    $ echo >>diff.h
    $ cd t
    $ git diff --relative \*.h

The command should show nothing.  Did the pathspec '*.h' match?  From
those who know how the machinery works, yes it did before the resulting
paths were further filtered out, but from the end-user's point of view,
because "--relative" limits the diff to the current directory and below,
and because 't' and below did not have any C header files, wouldn't it
be more natural and useful to say the pathspec wasn't used?

This does not matter right now because we are not planning to add a
new "--error-unmatch" option to "git diff", but when/if we do, it
starts to matter.  The hunk at least needs a NEEDSWORK comment,
summarizing the above.

	/*
	 * NEEDSWORK:
	 * Here we filter with pathspec but the result is further
	 * filtered out when --relative is in effect.  To end-users,
         * a pathspec element that matched only to paths outside the
         * current directory is like not matching anything at all;
         * the handling of ps_matched[] here may become problematic
	 * if/when we add the "--error-unmatch" option to "git diff".
	 */ 

A solution to that problem might be just a matter of swapping the
order of filtering, but it may have performance implications and I'd
rather not have to worry about it right now in the context of the
current topic, hence a NEEDSWORK comment without attempting to "fix"
it would be the most preferred approach to such a side issue.
