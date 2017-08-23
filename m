Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A97B1F4DD
	for <e@80x24.org>; Wed, 23 Aug 2017 21:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751102AbdHWVzy (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 17:55:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65325 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751003AbdHWVzx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 17:55:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A11F3ABC31;
        Wed, 23 Aug 2017 17:55:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hJ2pzh8QKfu/zYo7FMK0vr0KqWw=; b=LbcH74
        JAy4HtMSR/Y0PgWCNAKu2/9rQFjkmIo+zT+gxiM2z3vFUzzvLUul+KE+sbJLwkyH
        vHe26wLMgabkX8o9X+X0tvE0q7lOiiQzwY8WGLZcK+Bf7nudjRlJDI99mIXTkX8w
        n7CT947KH0KlJLVSqtgUKi9LVOmghx5j2eRPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RRRwg+WC5t2eW630S4jEam4tPNiDzRX7
        k0xIQwnKDe+kkEFC/Qxta70Ie2mE05BY/bgGVBhtowvl/RxWwZy01PTi2EYDDsF3
        GeFj4RiSxq5lERdo1gKD9k0NqQi0xtjXb253L+DkBOSS5h/OGfRtDFViSii0qkhK
        3t4OvbcZKwQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 900CFABC30;
        Wed, 23 Aug 2017 17:55:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9FF0ABC2F;
        Wed, 23 Aug 2017 17:55:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] Retry acquiring reference locks for 100ms
References: <030b6bb22973df429ddbb64a079b9cdc1fbcb1b7.1503313472.git.mhagger@alum.mit.edu>
Date:   Wed, 23 Aug 2017 14:55:50 -0700
In-Reply-To: <030b6bb22973df429ddbb64a079b9cdc1fbcb1b7.1503313472.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Mon, 21 Aug 2017 13:51:34 +0200")
Message-ID: <xmqqd17mx82h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4A86B62-884D-11E7-B25A-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The philosophy of reference locking has been, "if another process is
> changing a reference, then whatever I'm trying to do to it will
> probably fail anyway because my old-SHA-1 value is probably no longer
> current". But this argument falls down if the other process has locked
> the reference to do something that doesn't actually change the value
> of the reference, such as `pack-refs` or `reflog expire`. There
> actually *is* a decent chance that a planned reference update will
> still be able to go through after the other process has released the
> lock.

The reason why these 'read-only' operations take locks is because
they want to ensure that other people will not mess with the
anchoring points of the history they base their operation on while
they do their work, right?

> So when trying to lock an individual reference (e.g., when creating
> "refs/heads/master.lock"), if it is already locked, then retry the
> lock acquisition for approximately 100 ms before giving up. This
> should eliminate some unnecessary lock conflicts without wasting a lot
> of time.
>
> Add a configuration setting, `core.filesRefLockTimeout`, to allow this
> setting to be tweaked.

I suspect that this came from real-life needs of a server operator.
What numbers should I be asking to justify this change? ;-) 

"Without this change, 0.4% of pushes used to fail due to losing the
race against periodic GC, but with this, the rate went down to 0.2%,
which is 50% improvement!" or something like that?



