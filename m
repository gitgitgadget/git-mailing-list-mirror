Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97A531F461
	for <e@80x24.org>; Thu, 20 Jun 2019 18:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfFTSza (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 14:55:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52791 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfFTSza (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 14:55:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F29DA1673FC;
        Thu, 20 Jun 2019 14:55:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QgyGuQeBJVz6VpwRSROwQ/kRC88=; b=e8wqxs
        W6PidTFJ+wqdIN6PJs66HlZHTprzX5+f4CzzqVst8ojjwAhgRfuWhynV845TbRtZ
        pYPnf2jdZecmSbWjh1S2mNT66+GBxnTOBBee0ReUu1HHd2Kgs9uOjd3XY1bjFYh2
        1TanK8nBmIC+pt8DYVS2CAw8NKkzn7x3YBGko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P+zNF3UcZm+9/w8EpqmjXn3swYBJlXM4
        inceT5DV9FFV2/uJLV3MqXPgeDq/V53Lta2hg2Z9YQSkhCLsBt66JL0Tha8KutcH
        pNok7JRTJbexTpp9YKRiboN51IHf0h5Dj1BGP4jsOaYCVN6053YXcFIChxdho8nB
        EVTISEEDJGs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E37B81673FA;
        Thu, 20 Jun 2019 14:55:27 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F4EE1673F9;
        Thu, 20 Jun 2019 14:55:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH] gc: run more pre-detach operations under lock
References: <20190619094630.32557-1-pclouds@gmail.com>
        <20190619102601.24913-1-avarab@gmail.com>
        <CACsJy8AqA3TmNP62ko4c5Et39jsADYf9nKQByz28y-YQjNyKag@mail.gmail.com>
        <87k1dh8ne4.fsf@evledraar.gmail.com>
        <20190619191037.GE28145@sigill.intra.peff.net>
Date:   Thu, 20 Jun 2019 11:55:26 -0700
In-Reply-To: <20190619191037.GE28145@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 19 Jun 2019 15:10:37 -0400")
Message-ID: <xmqqef3onl29.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7CA0096-938C-11E9-8540-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think there may be room for both approaches. Yours fixes the repeated
> message in the more general case, but Duy's suggestion is the most
> efficient thing.

Yeah, not just the most efficient, but it is a low-hanging-fruit
that is very obvious.

> I agree that the "thousands of remotes" case means we might want to gc
> in the interim. But we probably ought to do that deterministically
> rather than hoping that the pattern of lock contention makes sense.

In the process chain starting from the topmost "git fetch
<multiple>", that calls multiple "git fetch <one>" for individual
remotes, that does network transfer and calls "git index-pack" (or
"git unpack-objects"), the bottommost layer knows how much cruft one
step among "thousands of remotes" created for a later "gc", but
there is no mechanism for them to report the information back to
their callers.  Unlike "git svn" that periodically calls the auto gc
every N commits and can claim to be aware of its cruft creation rate
;-), the information available to the topmost "git fetch" is only
the number of underlying fetches, counting a no-op fetch and a fetch
that is close to a full clone equally, which is not a good way to
gauge the cruft creation rate X-<.

A useful deteministic triggering would be a good thing to aim in the
longer run, but would be somewhat involved to design and implement,
I am afraid.
