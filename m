Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C3EE1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 20:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934859AbcHJUR3 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 16:17:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64502 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934866AbcHJUR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 16:17:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 04E5833A7D;
	Wed, 10 Aug 2016 16:17:25 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AeEAdfxnDw1Dqrewy6Yp8CAwIbY=; b=UOx3VC
	tSr+L0uPsecNEoY97QIhX1ZpoYm7z0Q7ebPQC47gB9t8uknv1HA0eOlaMHc90nt2
	HFIOPLtQQe3VZb4GFOhtjq/ZWgApbjHFhttgyaAomyalHA4LpOQwrRy1cBrerx87
	hxo+6IXanBW7zy9N2krmJXdEfApHyY6Z0mx2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YyNWzXj4/jL7fyZe9H3BQ4Uzq1LCvwXu
	R/7HlGJ1lxFaHI80zplJXoZklUw2NE+uDZjBuQBzHFO47BzpWyGnqjkNaj4VOMx3
	3VA/H3RtRJT8q1xPQsZZS8tuVTcH1w7JAiQ1nuGxZZoA2sm1vPDy01ty5tjg51Nd
	yQPYHHOgBIE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F0AA233A7C;
	Wed, 10 Aug 2016 16:17:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 48ED333A7B;
	Wed, 10 Aug 2016 16:17:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 1/2] pack-objects: break delta cycles before delta-search phase
References: <20160810115206.l57qpehpabthnl6c@sigill.intra.peff.net>
	<20160810120248.i2hvm2q6ag3rvsk4@sigill.intra.peff.net>
Date:	Wed, 10 Aug 2016 13:17:22 -0700
In-Reply-To: <20160810120248.i2hvm2q6ag3rvsk4@sigill.intra.peff.net> (Jeff
	King's message of "Wed, 10 Aug 2016 08:02:49 -0400")
Message-ID: <xmqqr39w4bvx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7344D0DA-5F37-11E6-B367-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ...
> We could do analysis on any cycles that we find to
> distinguish the two cases (i.e., it is a bogus pack if and
> only if every delta in the cycle is in the same pack), but
> we don't need to. If there is a cycle inside a pack, we'll
> run into problems not only reusing the delta, but accessing
> the object data at all. So when we try to dig up the actual
> size of the object, we'll hit that same cycle and kick in
> our usual complain-and-try-another-source code.

I agree with all of the above reasoning.

> Actually, skimming the sha1_file code, I am not 100% sure that we detect
> cycles in OBJ_REF_DELTA (you cannot have cycles in OBJ_OFS_DELTA since
> they always point backwards in the pack). But if that is the case, then
> I think we should fix that, not worry about special-casing it here.

Yes, but sha1_file.c?  It is the reading side and it is too late if
we notice a problem, I would think.

> +/*
> + * Drop an on-disk delta we were planning to reuse. Naively, this would
> + * just involve blanking out the "delta" field, but we have to deal
> + * with two extra pieces of book-keeping:
> + *
> + *   1. Removing ourselves from the delta_sibling linked list.
> + *
> + *   2. Updating our size; check_object() will have filled in the size of our
> + *      delta, but a non-delta object needs it true size.

Excellent point.

> +/*
> + * Follow the chain of deltas from this entry onward, throwing away any links
> + * that cause us to hit a cycle (as determined by the DFS state flags in
> + * the entries).
> + */
> +static void break_delta_cycles(struct object_entry *entry)
> +{
> +	/* If it's not a delta, it can't be part of a cycle. */
> +	if (!entry->delta) {
> +		entry->dfs_state = DFS_DONE;
> +		return;
> +	}
> +
> +	switch (entry->dfs_state) {
> +	case DFS_NONE:
> +		/*
> +		 * This is the first time we've seen the object. We mark it as
> +		 * part of the active potential cycle and recurse.
> +		 */
> +		entry->dfs_state = DFS_ACTIVE;
> +		break_delta_cycles(entry->delta);
> +		entry->dfs_state = DFS_DONE;
> +		break;
> +
> +	case DFS_DONE:
> +		/* object already examined, and not part of a cycle */
> +		break;
> +
> +	case DFS_ACTIVE:
> +		/*
> +		 * We found a cycle that needs broken. It would be correct to
> +		 * break any link in the chain, but it's convenient to
> +		 * break this one.
> +		 */
> +		drop_reused_delta(entry);
> +		break;
> +	}
> +}

Do we need to do anything to the DFS state of an entry when
drop_reused_delta() resets its other fields?  If we had this and
started from A (read "A--->B" as "A is based on B"):

    A--->B--->C--->A

we paint A as ACTIVE, visit B and then C and paint them as active,
and when we visit A for the second time, we drop it (i.e. break the
link between A and B), return and paint C as DONE, return and paint
B as DONE, and leaving A painted as ACTIVE, while the chain is now

         B--->C--->A

If we later find D that is directly based on A, wouldn't we end up
visiting A and attempt to drop it again?  drop_reused_delta() is
idempotent so there will be no data structure corruption, I think,
but we can safely declare that the entry is now DONE after calling
drop_reused_delta() on it (either in the function or in the caller
after it calls the function), no?

> + 2. Picking the next pack to examine based on locality (i.e., where we found
> +    something else recently).
> +
> +    In this case, we want to make sure that we find the delta versions of A and
> +    B and not their base versions. We can do this by putting two blobs in each
> +    pack. The first is a "dummy" blob that can only be found in the pack in
> +    question.  And then the second is the actual delta we want to find.
> +
> +    The two blobs must be present in the same tree, not present in other trees,
> +    and the dummy pathname must sort before the delta path.

> +# Create a pack containing the the tree $1 and blob $1:file, with
> +# the latter stored as a delta against $2:file.
> +#
> +# We convince pack-objects to make the delta in the direction of our choosing
> +# by marking $2 as a preferred-base edge. That results in $1:file as a thin
> +# delta, and index-pack completes it by adding $2:file as a base.

Tricky but clever and correct ;-)

> +make_pack () {
> +	 {
> +		 echo "-$(git rev-parse $2)"

Is everybody's 'echo' happy with dash followed by unknown string?

> +		 echo "$(git rev-parse $1:dummy) dummy"
> +		 echo "$(git rev-parse $1:file) file"
> +	 } |
> +	 git pack-objects --stdout |
> +	 git index-pack --stdin --fix-thin

An alternative

	git pack-objects --stdout <<-EOF |
	-$(git rev-parse $2)
        $(git rev-parse $1:dummy) dummy
        $(git rev-parse $1:file) file
	EOF
        git index-pack --stdin --fix-thin

looks somewhat ugly, though.

> +}
