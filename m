Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBD851F404
	for <e@80x24.org>; Mon, 22 Jan 2018 23:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbeAVX1C (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 18:27:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60790 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeAVX1C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 18:27:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 814F4D88EA;
        Mon, 22 Jan 2018 18:27:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Cnnno1DesseOnOgnJkmsP/dLBGc=; b=sN2I69
        874ixaESLzw2sibM/2BtEWrrRaman5v3WJFYJJyTlFrDwecpUfL1QfrtHtj1Nhon
        6pQTA/2ett1/DQDS654WOU/v5tUDdQZ1rf/MuXxwVXHnNyNGmokzxudYaggEFLBq
        PzR4/0FTk/9JiJ2tplDRLBrHAcFIoGyyc194k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qchxy6WKpNctSTLvseUb+MjL4j3/3WMy
        dGLCxvOlGye2Ti+8Bby3fGCL9jsljHD55FOjrwUIhWH8HGYovZhjDyiV/eVpHEzX
        kDcqw4bBY7BtWqhnKfuvWiqKM79JTnTcnASVzalv8wngIcj4pKXFjOTVPVzG3LqZ
        /m/Sc6cdpmk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2820DD88E9;
        Mon, 22 Jan 2018 18:27:01 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25C50D88E7;
        Mon, 22 Jan 2018 18:27:00 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Rene Scharfe <l.s.r@web.de>,
        Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Use MOVE_ARRAY
References: <d81743e5-d5ba-a565-23f7-072007493499@web.de>
        <20180122175009.20178-1-szeder.dev@gmail.com>
        <20180122224410.GA21604@sigill.intra.peff.net>
Date:   Mon, 22 Jan 2018 15:26:59 -0800
In-Reply-To: <20180122224410.GA21604@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 22 Jan 2018 17:44:10 -0500")
Message-ID: <xmqq372xjwzg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BEC85FBE-FFCB-11E7-9BE4-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Most of these are "shift part of the array". I wonder if it would make
> sense to encapsulate that pattern in a helper, like:
>
>   #define SHIFT_ARRAY(a, nr, pos, slots) \
>     MOVE_ARRAY(a + pos + slots, a + pos, nr - pos - slots)
>   ...
>   SHIFT_ARRAY(it->down, it->subtree_nr, pos, 1);

Exactly my thought when I was queuing it, but I was wondering about
this more from "can we use the higher level abstraction for reducing
errors?" point of view.  If we are shifting an array by 3 slots to
the right, we should at least have enough slots allocated to hold
them (i.e. a->nr - a->alloc must be 3 or more).  But after realizing
that the level these macros operate at is still a bit too low to do
something like that, I quickly lost interest ;-)

> I'm not sure if that's more readable because it describes a higher-level
> operation, or if it's less because it adds yet another non-standard
> helper for the reader to learn.

Yeah, conflicting goals.  It indeed is easier to see what is going
on when reading the code, once the reader gets used to them.

Thanks.
