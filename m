Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C09C720281
	for <e@80x24.org>; Sun, 24 Sep 2017 00:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbdIXAwJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 20:52:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61745 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750839AbdIXAwI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 20:52:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BBDDA169A;
        Sat, 23 Sep 2017 20:52:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/m3bRzzhY/pBvTQ8vj9Wh5Xq/nM=; b=CN2QdP
        2aAoPovUsvIkkFcncwgMkk8GGnb3SrsjI3ehkUs0mckVxNRJbh9xmoL9xFQxPjI3
        2RVq/o6p6SD3wyNFM4xCnkFucQLs48uZfx2ssIMMlhJlR/OmxYxu4Fs8Tug5cIMz
        +OiXyrAJbSGeSW9HUSULl6536B2NwYlPs33bw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GtpyWghFy6E+r6HzI8mb5YQyosWn/OTO
        ERLXdsH4FZHRH4AWI9XLR061qykb6lapk0VNr+l8unX+Dto4ECP0Wr+UQN+GfgTl
        CcX+8GBO5NfwSKP/DETnVVQ92oxZHQ3lTwAOIswNSrmcgFKtwFPwHy3G/QDpzQFx
        uD+SBhpPjQY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73CD6A1699;
        Sat, 23 Sep 2017 20:52:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D8A66A1698;
        Sat, 23 Sep 2017 20:52:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        bmwill@google.com
Subject: Re: [PATCH v4] connect: in ref advertisement, shallows are last
References: <20170922164504.GD77641@google.com>
        <20170922201551.15012-1-jonathantanmy@google.com>
Date:   Sun, 24 Sep 2017 09:52:05 +0900
In-Reply-To: <20170922201551.15012-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Fri, 22 Sep 2017 13:15:51 -0700")
Message-ID: <xmqqefqwj4ui.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 969C76C8-A0C2-11E7-A70C-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Currently, get_remote_heads() parses the ref advertisement in one loop,
> allowing refs and shallow lines to intersperse, despite this not being
> allowed by the specification. Refactor get_remote_heads() to use two
> loops instead, enforcing that refs come first, and then shallows.
>
> This also makes it easier to teach get_remote_heads() to interpret other
> lines in the ref advertisement, which will be done in a subsequent
> patch.
>
> As part of this change, this patch interprets capabilities only on the
> first line in the ref advertisement, ignoring all others.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> I've updated state transitions to occur in get_remote_heads() instead,
> as suggested. I didn't want to do that previously because each step in
> the state machine needed to communicate if (i) the line is "consumed"
> and (ii) the state needed to be advanced, but with Junio's suggestion to
> reorganize the methods, that is no longer true.
>
> As Junio said, the free(server_capabilities) can be removed.
>
> As for whether how capabilities on subsequent lines are handled, I think
> it's better to ignore them - they are behind NULs, after all.

Not even a diagnosis?  When the other side clearly wants to tell us
something and we deliberately ignore, I'd think we want to at least
know about it---that may lead us to notify the implementators of the
other side of a protocol violation, or rethink the design decision
(i.e. only the first one matters) ourselves.

> This change does have the side effect that if the server sends a ref
> advertisement with "shallow"s only (and no refs), things will still
> work, and the server can even tuck capabilities on the first "shallow"
> line. I think that's fine, and it does make the client code cleaner.

I am ambivalent on this aspect of the change.

The change makes the resulting state transition logic quite easy to
follow.  Very nicely done.

> +	while ((len = read_remote_ref(in, &src_buf, &src_len, &responded))) {
> +		switch (state) {
> +		case EXPECTING_FIRST_REF:
> +			process_capabilities(len);
> +			if (process_dummy_ref()) {
> +				state = EXPECTING_SHALLOW;
> +				break;
> +			}
> +			state = EXPECTING_REF;
> +			/* fallthrough */
> +		case EXPECTING_REF:
> +			if (process_ref(&list, flags, extra_have))
> +				break;
> +			state = EXPECTING_SHALLOW;
> +			/* fallthrough */
> +		case EXPECTING_SHALLOW:
> +			if (process_shallow(shallow_points))
> +				break;
> +			die("protocol error: unexpected '%s'", packet_buffer);
> +		default:
> +			die("unexpected state %d", state);
>  		}
>  	}

