Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00368C433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 20:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9863964DE5
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 20:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhA1Uxm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 15:53:42 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53761 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhA1Uwf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 15:52:35 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 57B0AFA03C;
        Thu, 28 Jan 2021 15:51:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bF5L4J1J+35rQ+DQlo4xRe38rJ4=; b=te9dYS
        BUvjDB8yUaeZiuF+dD0eyDpSlBGANzJl5Bd4DWyPVJ0rSoci0NSmdkdosfm81omF
        jB19fTO0VW+jjdZNuAiNgGKAOzlmuw60qZzedzkCvId0sf1cIEs5ZZjTAanziX7N
        Spc8v7B74BgX3QLxa/jrXe8b+Kr5ELRohPRro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Jn8d6JVhAYmvggLQHcQI/OlvXLPGQEfU
        OgIiiXEO1EirBRlzBcBYInyU+BhAzsoCaPafhAPu6HLRG5Ge4e79zxDmhbIbBGLc
        EkuKtC1mejjikMkxA0pO8bHfYgq8HIjbrtuqA66xUC9JiQqxHOsgiqedzy4kwjSO
        I+SV9H0e4E0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4FCE7FA039;
        Thu, 28 Jan 2021 15:51:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9594EFA037;
        Thu, 28 Jan 2021 15:51:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        me@ttaylorr.com, peff@peff.net,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] commit-reach: use one walk in remove_redundant()
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
        <3fe74e339fc5b7083398f2df51baae5a4a008060.1611851095.git.gitgitgadget@gmail.com>
Date:   Thu, 28 Jan 2021 12:51:45 -0800
In-Reply-To: <3fe74e339fc5b7083398f2df51baae5a4a008060.1611851095.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 28 Jan 2021
        16:24:52 +0000")
Message-ID: <xmqqtur0vl7i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A34254A4-61AA-11EB-9242-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	/* Mark all parents of the input as STALE */
> +	for (i = 0; i < cnt; i++) {
> +		struct commit_list *parents;
> +		timestamp_t generation;
>  
>  		repo_parse_commit(r, array[i]);
> +		parents = array[i]->parents;
> +
> +		while (parents) {
> +			repo_parse_commit(r, parents->item);
> +			if (!(parents->item->object.flags & STALE)) {
> +				parents->item->object.flags |= STALE;
> +				prio_queue_put(&queue, parents->item);
> +			}
> +			parents = parents->next;
> +		}
> +
> +		generation = commit_graph_generation(array[i]);
> +
> +		if (generation < min_generation)
> +			min_generation = generation;
> +	}
> +
> +	/* push the STALE bits up to min generation */
> +	while (queue.nr) {
> +		struct commit_list *parents;
> +		struct commit *c = prio_queue_get(&queue);
> +
> +		repo_parse_commit(r, c);
>  
> +		if (commit_graph_generation(c) < min_generation)
>  			continue;
>  
> +		parents = c->parents;
> +		while (parents) {
> +			if (!(parents->item->object.flags & STALE)) {
> +				parents->item->object.flags |= STALE;
> +				prio_queue_put(&queue, parents->item);
> +			}
> +			parents = parents->next;
> +		}
> +	}

So, the inner loop makes sure we won't revisit STALE parent, but
keep digging parents we haven't seen, and stop when the generation
is old enough.  What happens when there is no generation number
computed yet, I wonder...  We'll keep getting infinity and dig all
the way down to root?

> +	/* rearrange array */
> +	dup = xcalloc(cnt, sizeof(struct commit *));
> +	COPY_ARRAY(dup, array, cnt);
> +	for (i = 0; i < cnt; i++) {
> +		if (dup[i]->object.flags & STALE) {
> +			int insert = cnt - 1 - (i - count_non_stale);
> +			array[insert] = dup[i];
> +		} else {
> +			array[count_non_stale] = dup[i];
> +			count_non_stale++;
> +		}
> +	}
> +	free(dup);

The "fill stale ones from the end, non-stale ones from the
beginning" in the loop looks unnecessarily complex to me.  I wonder
if we can do only the "fill non-stale ones from the beginning" half,
i.e.

	for (i = count_non_stale = 0; i < cnt; i++) {
		if (dup[i] is not stale)
			array[count_non_stale++] = dup[i];
	}

without the "keep the stale one at the end of array[]", and clear
marks using what is in dup[] as starting points before discarding
dup[]?

Or do the callers still look at the entries beyond count_non_stale?

Other than that, nicely done.

> +	/* clear marks */
> +	for (i = 0; i < cnt; i++) {
> +		struct commit_list *parents;
> +		parents = array[i]->parents;
> +
> +		while (parents) {
> +			clear_commit_marks(parents->item, STALE);
> +			parents = parents->next;
>  		}
> -		common = paint_down_to_common(r, array[i], filled,
> -					      work, min_generation);
> -		if (array[i]->object.flags & PARENT2)
> -			redundant[i] = 1;
> -		for (j = 0; j < filled; j++)
> -			if (work[j]->object.flags & PARENT1)
> -				redundant[filled_index[j]] = 1;
> -		clear_commit_marks(array[i], all_flags);
> -		clear_commit_marks_many(filled, work, all_flags);
> -		free_commit_list(common);
>  	}
>  
> -	/* Now collect the result */
> -	COPY_ARRAY(work, array, cnt);
> -	for (i = filled = 0; i < cnt; i++)
> -		if (!redundant[i])
> -			array[filled++] = work[i];
> -	for (j = filled, i = 0; i < cnt; i++)
> -		if (redundant[i])
> -			array[j++] = work[i];
> -	free(work);
> -	free(redundant);
> -	free(filled_index);
> -	return filled;
> +	return count_non_stale;
>  }
>  
>  static struct commit_list *get_merge_bases_many_0(struct repository *r,
