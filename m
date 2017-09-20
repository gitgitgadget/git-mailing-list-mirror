Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D92D2047F
	for <e@80x24.org>; Wed, 20 Sep 2017 05:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbdITFMk (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 01:12:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51739 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751011AbdITFMj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 01:12:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 176FF963F6;
        Wed, 20 Sep 2017 01:12:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8RhpIxL7IqJBars6UXzzKTw+4hA=; b=iM8kpg
        Ak/UQzCnqicppE5S+7bWoQ3cH3G+ziUj7IBZly8ynvGQh4ZWPPJDeani2VJXdCv4
        xKYXVWT7HG/cUnmaeErR6fbE9ZHCteJiaZFJ++SeE3KzRIpmOZJeUSV5ZK5T6usI
        q2jIzURtgV6x5H4BXHU25KPkryvMWNZPpwdPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VTJhvem2cJSUDjM26ZkxdMA/4yBLAeiB
        EiaNbpxZ4SFNnENlWXl/rL9afJZ9koZempO1/VmOU0WWOjklTxVvPv94AyatjrCp
        Sqmr3j9aF/8y6fEVGANEYOzm53NkYA9I6l2dYURqm2Md12jUCRd9qegIJ0sU5x0D
        C0sv9Ims4W0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C2DE963F5;
        Wed, 20 Sep 2017 01:12:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 69FA4963F4;
        Wed, 20 Sep 2017 01:12:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 10/10] add UNLEAK annotation for reducing leak false positives
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
        <20170908063841.wb23ibs2ancdct2v@sigill.intra.peff.net>
        <20170919134552.7845f021@twelve2.svl.corp.google.com>
        <20170919210300.cbrdjqor6xuwd7bs@sigill.intra.peff.net>
        <xmqqzi9qp2hq.fsf@gitster.mtv.corp.google.com>
        <20170920022838.tlkb5qlmctlstqb6@sigill.intra.peff.net>
Date:   Wed, 20 Sep 2017 14:12:37 +0900
In-Reply-To: <20170920022838.tlkb5qlmctlstqb6@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 19 Sep 2017 22:28:38 -0400")
Message-ID: <xmqqo9q6nebe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 521675F6-9DC2-11E7-94B8-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> At any rate, I think Jonathan's point is that writing:
>
>   UNLEAK(foo)
>
> will silently pass in a normal build, and only much later will somebody
> run a leak-checking build and see the compile error.

Yeah, I think I understand that concern.

	#if SOME_CONDITION
	#define X(y) do_x(y)
	#else
	#define X(y) /* nothing */
	#endif

is something we quite often use, and I just found it a bit unusual
that all of a sudden we start to be extra careful only with this
macro.
