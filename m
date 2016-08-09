Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FDB31F859
	for <e@80x24.org>; Tue,  9 Aug 2016 22:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbcHIW3i (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 18:29:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51251 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932360AbcHIW3h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 18:29:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D1D1F34B6D;
	Tue,  9 Aug 2016 18:29:35 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ISkEpxZKmIsiQyccQ+kkM6kKBxU=; b=KRYdpe
	Ua3kPD0hdWRO6uBLK5IjvBQQuUpgkPgaJd/DxYsaB77c/PKbu/bMafrjdwBdZFfL
	d6H6jptxvY0sws4MldRzjqp2qo6RBuCoRIOUfKjxXa2fQZVkJyoRlA9MbX5xSun+
	lFrxooEt75hjJyRjEDF//TYrmDY5PGY5p/jA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aYe75yE3kIz3TzgrYNVHfAXLJe+63tyu
	vaqVQ7344yw2lQauRECTrv2CwvNEeqJA7QQ47T2FAC4DYPH35TqurO9utaa+/sxy
	+M++AKPkk6YlfmSvwZ0otP84CyKIMUX3r60a11fg82m/lAKOK+BeEWmmwmxJNBIx
	FO9BjA9BJZk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C9C8634B6C;
	Tue,  9 Aug 2016 18:29:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 538F034B6B;
	Tue,  9 Aug 2016 18:29:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 7/7] pack-objects: use mru list when iterating over packs
References: <20160729040422.GA19678@sigill.intra.peff.net>
	<20160729041524.GG22408@sigill.intra.peff.net>
	<20160729054536.GA27343@sigill.intra.peff.net>
	<xmqqr3acpjvo.fsf@gitster.mtv.corp.google.com>
	<20160808145042.uwrk2m6jq3m4li37@sigill.intra.peff.net>
	<xmqq8tw7gr82.fsf@gitster.mtv.corp.google.com>
	<20160808165127.fvhnkcfsj4vif7iu@sigill.intra.peff.net>
	<xmqqzionfafj.fsf@gitster.mtv.corp.google.com>
	<20160809140411.7745apztp36nwshx@sigill.intra.peff.net>
Date:	Tue, 09 Aug 2016 15:29:33 -0700
In-Reply-To: <20160809140411.7745apztp36nwshx@sigill.intra.peff.net> (Jeff
	King's message of "Tue, 9 Aug 2016 10:04:12 -0400")
Message-ID: <xmqq7fbp8tki.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0205BD4-5E80-11E6-81FB-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here's the code to do the cycle-breaking. Aside from the "hacky" bit,
> it's quite simple.  I added a new state enum to object_entry to handle
> the graph traversal. Since it only needs 2 bits, I _assume_ a compiler
> can fit it in with the bitfields above (or at the very least give it its
> own single byte so we just use what would otherwise be struct padding).
> But I didn't check; if it turns out not to be the case we can easily
> emulate it with two bitfields.  The write_object() check abuses the
> "idx.offset" field to keep the same state, but we could convert it to
> use these flags if we care.

> @@ -1516,6 +1577,13 @@ static void get_object_details(void)
>  			entry->no_try_delta = 1;
>  	}
>  
> +	/*
> +	 * This must happen in a second pass, since we rely on the delta
> +	 * information for the whole list being completed.
> +	 */
> +	for (i = 0; i < to_pack.nr_objects; i++)
> +		break_delta_cycles(&to_pack.objects[i]);
> +
>  	free(sorted_by_offset);
>  }

A potential cycle can only come from reusing deltas across packs in
an unstable order, that happens way before we do the find_delta()
thing, so this is a good place to have the new call.  While reading
break_delta_cycles(), I was wondering if what it does is safe under
multi-threading but there is no need to worry.

The recursiveness of break-delta-cycles is not too bad for the same
reason why it is OK to recurse in check_delta_limit(), I would guess?

This is not new with this change, but I am not quite sure what in
the current code prevents us from busting the delta limit for reused
ones, though.

> I think my preference is to clean up the "hacky" bit of this patch, and
> then apply the earlier MRU patch on top of it (which takes my repack
> from 44 minutes to 5 minutes for this particular test set).

Yup, with something like this to break the delta chain _and_ allow
an object to go through the usual deltify machinery, I'd say the MRU
patch is a wonderful thing to have.

