Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A949EC433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 19:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E9A2310A
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 19:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392213AbhALTNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 14:13:54 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65526 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbhALTNx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 14:13:53 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 78CDAFF614;
        Tue, 12 Jan 2021 14:13:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QKMY3cqO/lv2HQuV0wom2wQtIfQ=; b=C02oNO
        LyTirn1UT0qE/I76j49PYsz+jdk2pVu5lKPtGEcGXRFWBCZlixn8QqokUXBpqR5r
        b+sN+iaxDUV82DqQEHpRoMOi2AA27x+/yDQdVXkAS0ZV8r3Gf7m/LMIn6OAYyAZB
        hLg1hdYHZXoKD/PaF2IdsWZZw7nxTBzJIGYzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bUQs3ymt1e9iDBCEFO7Wa0au2II21PVx
        ShVaELgSuLMGGbmtzoQDldA9KJ0Zpwf7nFgSikFJapoAhfGCjQWhQRvyBZ4GyyD3
        y3b241hadmlGv0JOwzfaG3gX5WaLG/UGTbACENsgONUaYEmEKpO0X1LsTC6fFui4
        plhOm3t+7Qw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 71D3FFF613;
        Tue, 12 Jan 2021 14:13:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B692EFF60E;
        Tue, 12 Jan 2021 14:13:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Arnaud Morin <arnaud.morin@gmail.com>, git@vger.kernel.org,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH] patch-ids: handle duplicate hashmap entries
References: <20210109162440.GM31701@sync>
        <X/2vgbnxWSmst5yB@coredump.intra.peff.net>
        <X/28IXBpse2dNZQH@coredump.intra.peff.net>
        <20210112153438.GC32482@sync>
        <X/3FwNPHqZqY+hv0@coredump.intra.peff.net>
Date:   Tue, 12 Jan 2021 11:13:06 -0800
In-Reply-To: <X/3FwNPHqZqY+hv0@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 12 Jan 2021 10:52:32 -0500")
Message-ID: <xmqqy2gy3r5p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34BAFA38-550A-11EB-9BA7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> At the end, we'll have eliminated commits from both sides that have a
> matching patch-id on the other side. But there's a subtle assumption
> here: for any given patch-id, we must have exactly one struct
> representing it. If two commits from A both have the same patch-id and
> we allow duplicates in the hashmap, then we run into a problem:

In practical terms, for one side of the history to have two
identical patches, the most likely scenerio for that to happen is to
have a patch, its reversion, and its reapplication, intermixed in
its history with other commits, e.g.

    ---o---o---M---o---o---W---o---o---M---o--- ...
        \
         o---o---o---M---o--- ...

where "M" are commits that does an identical change, and "W"
(upside-down "M") is its reversion.  On the top history, "M" was
introduced, the bottom history cherry-picked, the top history found
problems in it and reverted with "W", and later (perhaps with the
help of preparatory patches on top of "W"), the top history now
considers that "M" is safe, so reapplies it.

And a "--cherry-pick" output that excludes "identical patches" that
appear on both sides on such a history would hide all "M"'s, leaving
a history like

    ---o---o-------o---o---W---o---o-------o--- ...
        \
         o---o---o-------o--- ...

But is this result what the user really wanted to see, I have to
wonder.

I do not see any problem in the patch itself.  We used to hide only
one "M" from the history on the top half in the picture, leaving one
"M" and "W", while hiding the sole "M" from the bottom half.  Now if
we want to no longer show any "M", the updated code would correctly
hide all of them.

It just feels to me that the resulting view of the history look
weird, leaving only the reversion of a patch that has never been
applied in the first place.
