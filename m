Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB9FC433E9
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 01:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E28B964E45
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 01:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhBRBfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 20:35:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50278 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhBRBfk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 20:35:40 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3850C122870;
        Wed, 17 Feb 2021 20:34:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UBHZSXJ3LQtkPmyHL/SBfPUlkeg=; b=j1sHCS
        k0NuvI0A7AsDmTf3CNOGM8wHIEH0C+K8KTSnkwvAIbqX8jv+Y7E3fbPxjE03GFiF
        6i+BcXx0Pq7PeW8Xqs/pI3GgzXBoqNgNS8iDfxWYtB2tdm+flN8i7ALSycWySyuv
        HOZnlTsr4KyVHpnC4Xr/7Upia85B0qQkS/S/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BGz7broqoAlaUOPQsp4v3Gniu2QqZ9uL
        YXisNbfKsi3XGo4MqooAbAwB0kTFjH6z7ohW7hW2FMN82dfyQO2XJYJeODMgiDVN
        EcGDWCQXUBAoupNHcrWDZOsMFSA1Vgr45zexVw7D0uCf0qrbHwsMpTevic8Z38cq
        IUtTuvp3YRQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 327C712286F;
        Wed, 17 Feb 2021 20:34:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7C12512286E;
        Wed, 17 Feb 2021 20:34:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] push: perform negotiation before sending packfile
References: <20210218012100.928957-1-jonathantanmy@google.com>
Date:   Wed, 17 Feb 2021 17:34:53 -0800
In-Reply-To: <20210218012100.928957-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 17 Feb 2021 17:21:00 -0800")
Message-ID: <xmqqwnv6gnuq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81185A60-7189-11EB-83BB-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> The idea of adding negotiation to push has been floating around for a
> while. Here's my implementation of my idea of reusing a lot of the fetch
> mechanism to perform the negotiation.

Finally? Yay!

> The basic idea is that when a client pushes, the client will first
> perform the negotiation steps that it normally does during a fetch,
> except that it does not send any "want"s and it only uses the commits to
> be pushed as negotiation tips (instead of all refs). Once the client has
> received enough ACKs that all ancestral paths from all tips to the
> original orphans are blocked by ACKed commits, it will proceed with the
> push, using this information to determine the contents of the
> to-be-pushed packfile. (This check is done by the server when doing a
> user-triggered fetch.)

So when pushing 'HEAD' to some ref, we say "I have HEAD^{commit},
HEAD^^, HEAD^^^, ..." and they keep saying "never heard of it" for
each of them until they find "ah, I know that one" with an ACK, at
which point we can stop traversing our side of the history behind
that acked commit (because everything behind it is common between
us). And that way, we know what we do not have to send (i.e. what
we should use as the negative ends of "rev-list --objects A..B";
their ACK lets us discover "A").

Do we take advantage of the ref advertisement the other side
perform, or is this v2 only and we even skip ls-refs?

What do you mean by an "orphan", though?  Except for that part, I
think what you wrote the above makes quite a lot of sense.

When we have an "--allow-unrelated-histories" merge with a history
they've never heard of, we'd end up digging down to the root of the
unrelated side history with "have/nack" exchange.  On the fetch
side, we have "give up with too many nack" band-aid.  Do we inherit
the same from the fetch side?

>  - Do we need statistics in the commit message to show the performance
>    gains?

Not until we see the thing fully working, I would say.

>  - Anything else that comes up upon more scrutiny
>
> Any comments are welcome, especially if you have ideas about the overall
> design or implementation, and/or if you've thought about similar things
> before.

I'll have more comments after reading the code, but that will happen
much later tonight.

Thanks.
