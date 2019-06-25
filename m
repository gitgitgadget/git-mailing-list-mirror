Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F38411F461
	for <e@80x24.org>; Tue, 25 Jun 2019 05:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfFYFNM (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 01:13:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54075 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfFYFNK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 01:13:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC30C160E58;
        Tue, 25 Jun 2019 01:13:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tyXJwcHheEfO5qOG8gh9/3TK1aQ=; b=BqvsTg
        T/y+tR7mTfWPzBl3gyDDlBOzDLO0yb3+3GR0j6Hja3S2PHbMFvTosI1BY904UQEI
        11WfAG47J2Mtmh+qVdIg6f6yNerKK0YfBMuJliQxgmFnSSt7xDJDigeuNxxop7ol
        3WDnuNWpjJyUWmHKNmCrcHEFfCAdomIJa26Ks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KehN+f3ZgLAY5L/7MLu6pwiFopHWqXdL
        7A0Qb3udUsdWz1clyS3YZdnOSvZknsNbvQfiOCZLsdKoMIvWu0Ol9oZyZQYngnRb
        h338ni1aeYTHw7sqGxCNEkK9m5t+cCaX+wvIxGpLsV/8VfV/RXliXo+ETPyltq0Z
        eQbJxAi3AqU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A51C3160E56;
        Tue, 25 Jun 2019 01:13:05 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 118DE160E55;
        Tue, 25 Jun 2019 01:13:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Pedro Larroy <pedro.larroy.lists@gmail.com>,
        git@vger.kernel.org
Subject: Re: git bisect should return 1 when the first bad commit is found
References: <CAC_CU1iWBCTt5jLQ0Zp2HoyA0oFgG3shDB2rLfOsmC+x67NdAw@mail.gmail.com>
        <xmqq5zp9wdjb.fsf@gitster-ct.c.googlers.com>
        <CAC_CU1hHK5n4GcETbWFLBeqT_Y9LV6N32Rv0F0+OCXH2G0qg8Q@mail.gmail.com>
        <20190623224935.GD1100@sigill.intra.peff.net>
        <xmqqo92mhlla.fsf@gitster-ct.c.googlers.com>
        <20190625045304.GA7626@sigill.intra.peff.net>
Date:   Mon, 24 Jun 2019 22:13:03 -0700
In-Reply-To: <20190625045304.GA7626@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 25 Jun 2019 00:53:04 -0400")
Message-ID: <xmqqv9wufdsw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9940A02-9707-11E9-BDBA-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do think that accessing the bisect/bad ref is a little intimate with
> the implementation (i.e., it implies knowing that there is only a single
> "bad" that we are moving around, unlike "good", where we may mark many
> such tips).

I actually do not think it is merely an implementation detail, but a
rather fundamental part of the "bisect" design.  After all, we are
trying to find *the* single transition point from "the old world" to
"the new world", and the primary assumption that makes "bisection"
work in the first place is that there is only one such transition
point from old to new.  Otherwise, there may be a stretch of history
where one transition from "old" to "new" is followed by another
transition from "new" back to "old" and then again another one from
"old" to "new"; in such a "stripe snake" part of the history, "find
the midpoint, if it is from the new world, then narrow to the world
before that midpoint", which is the central idea of the "bisection"
would not work, would it?

So, ... under that "single transition point" assumption, how would a
"bisect" that uses more than one "bad" would work?  "bad" is the one
that is known to belong to the "new" world that is topologically the
oldest and it moves backward in topology to find the boundary from
the "old" world.  If there were another "bad" (i.e. one that is
known to belong the the "new" world, that may not be the oldest),
shouldn't that have the other one as its ancestor, making it
redundant (i.e. we know we have inherited the badness from the other
one)?

Having said that ...

> So another option is to put the result in a new ref (bisect/result,
> perhaps), but with one twist: delete it at the beginning of a bisection,
> so its presence can be used as a marker that the bisection is complete.

... I kind of like this one exactly for the reasons you give below.

> I.e., you could do "git rev-parse --verify refs/bisect/result" as an
> alternative to "--exit-code". That gives you the added flexibility of
> asking "is the bisection done" separately from "do this next bisection
> step".
>
> -Peff
