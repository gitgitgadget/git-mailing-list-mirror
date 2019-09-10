Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DE101F463
	for <e@80x24.org>; Tue, 10 Sep 2019 01:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390458AbfIJBJ6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 21:09:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52323 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfIJBJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 21:09:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 271E66D351;
        Mon,  9 Sep 2019 21:09:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zT2KBFxrxwaK98nG2NHj443BNrI=; b=uIr0Ho
        hzghgCfgPwGgmVGMCiDZDEt2Kr33JtZq5V6wlIIFj/z555peakGv6C5j99oZouvA
        n0z04fe5uUddagJaZrYXGf67xkxyEO0TBAScTRTRuM9Jvxyl/txI0d0tPv4Hu1LN
        51H9qIsLp9YGbbIJ+TpijshJmj21S9OkXRfpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R5v7gdf8nOSPbGWr7jWiQXqYoQGtowqA
        2sK2E+zUwOQFc2JtKwvklcetamXar6k5YZzuZzNrJmgYUSG5vHXTEfq50czIUNoa
        jCCVz54w/l9UQFGfRJct96+lPy8KSvpkP7D4fC0MZqcmiPMpVyqDvRgPr+dFVZVs
        qZrsNTBWddw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1FCD16D34F;
        Mon,  9 Sep 2019 21:09:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 512486D34E;
        Mon,  9 Sep 2019 21:09:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        stolee@gmail.com
Subject: Re: [PATCH v2] cache-tree: do not lazy-fetch merge tree
References: <20190903194247.217964-1-jonathantanmy@google.com>
        <20190909190130.146613-1-jonathantanmy@google.com>
        <xmqqsgp5i6s1.fsf@gitster-ct.c.googlers.com>
        <xmqqef0pi3im.fsf@gitster-ct.c.googlers.com>
        <20190909222101.GB31319@sigill.intra.peff.net>
Date:   Mon, 09 Sep 2019 18:09:51 -0700
In-Reply-To: <20190909222101.GB31319@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 9 Sep 2019 18:21:01 -0400")
Message-ID: <xmqqwoehgdnk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B208160E-D367-11E9-95FE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I wondered also if this means we should be using OBJECT_INFO_QUICK.
> I.e., do we expect to see a "miss" here often, forcing us to re-scan the
> packed directory?

As a performance optimization hack, it is OK if we did not notice
that the tree object, which corresponds to what is currently
prepared for a directory in the index, does exist in the object
store.  It is not worth rescanning the packs to "protect" against
races, I think, in the "repair" codepath.

When the user actually wants to write the index out as a tree, we
would write it out as a loose object (or omit doing so if we know
there are already copies), but because it is not a crime to create a
duplicate loose object when we already have a packed copy, I do not
think we need to rescan in that context, either.  But I do not think
the codepath Jonathan's patch touches is about that operation.
