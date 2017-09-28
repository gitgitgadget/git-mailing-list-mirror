Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B31F20A10
	for <e@80x24.org>; Thu, 28 Sep 2017 21:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbdI1V4b (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 17:56:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50135 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750881AbdI1V4a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 17:56:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D65FBAB21C;
        Thu, 28 Sep 2017 17:56:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W3ZrTWxRwzfEMHirRi/MlOkUqZY=; b=WMhIBo
        bfGFIKAkIBEzzX1s2R1xGtPJZfNkaU37wGHbLBDJXbXLins2+c7wLCIQ1NVyDWMK
        p8ZV1A1ebXrae9wf63xVXlBLqofTnneffp7oMvkEiDbW2frC0u3DdROH9fnFR/H+
        R0Ibi3KXTqFHBNrxanBZHXUfFO3mR1CPJO9yA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NeZWQdNztaPttogrDrNaEyeDjWmbammf
        eZYWJ5vEsr5XGTdx1kJcf/J+fMbmAjGzLiDCYgDJ0il//TyXG9LEpVRWIFkD6BY5
        x73Fuf/QXXsm+CAqSmkKS4iffYltas67Aha7ESLc/hCC01U6gAYwNDyu2FmUppbS
        eFmPcYisJSM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE10BAB21B;
        Thu, 28 Sep 2017 17:56:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4CA95AB21A;
        Thu, 28 Sep 2017 17:56:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH Outreachy] mru: use double-linked list from list.h
References: <CAP8UFD24A8rxMfLMFmSStWnBMMeB58SqUdNoo3niQuc7LqRMMg@mail.gmail.com>
        <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
        <xmqq8tgz13x7.fsf@gitster.mtv.corp.google.com>
        <20170928204705.7ixxspiflmhsdh7d@sigill.intra.peff.net>
Date:   Fri, 29 Sep 2017 06:56:28 +0900
In-Reply-To: <20170928204705.7ixxspiflmhsdh7d@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 28 Sep 2017 16:47:05 -0400")
Message-ID: <xmqq4lrm1o8j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1CB0CD0-A497-11E7-8A7F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But I also think this patch may be a stepping stone to dropping "struct
> mru" entirely, and just pushing a "struct list_head mru" into the
> packed_git object itself (or of course any object you like). At which
> point we'd just directly use the list iterators anyway.

The endgame state implied by your statement would mean that we won't
have mru_mark() and instead have these open-coded in terms of the
two calls into the list API.  There only are two callers of it in
the current system, so it is not the end of the world, so I guess I
can agree that this is a good preparation step toward the longer
term goal, which says "mru API is over-engineered and what it offers
over the plain vanilla list API is almost never used except for a
few callsite; let's remove it and use the bare list API instead".

> I'd make the same claims here as above (both that I agree your proposed
> interface looks nicer, but also that I think we eventually do want to
> expose that this is tightly coupled with list.h).

I agree.  I just do not yet know if I fully embrace the idea that we
just should use bare list API, getting rid of the mru API.

