Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFB8720988
	for <e@80x24.org>; Tue, 18 Oct 2016 15:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938148AbcJRP4p (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 11:56:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65484 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935562AbcJRP4n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 11:56:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09D4F476C0;
        Tue, 18 Oct 2016 11:56:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+ANh2l6Gi17+QyW20pi6AmT1Vic=; b=whUx5G
        XKSnV1XLhcbsFZE6L9LfAiAMyM6u1+I6FjzkZN9pyHqeyWo+EaGl+rd6jYpjKdsM
        agYZxG4C04t5CFE4cs0TIrV8XjA1PnE5016ePreoFuBDBvHfnYgLb11cw3OsVvrn
        xrQgT/rQBvPg4vztVjxMYWGzMMCOlx7YlXVTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jHGJkj13frbMzbDClxcPw9GD8OWA72Zy
        slw4mOBJxEOuHYHtD8Zphh2ndNoAYFpdie/gaG9etJkBsk/u/EJWG1tMBd8stHgS
        3mdLQg2ZhgCUTIL8wSoX+MbR/3MvFJMemojE8ngBByjbXRrBcor1K7ycLdb8lFdD
        IXpX8Gz51FI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01C51476BE;
        Tue, 18 Oct 2016 11:56:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E249476BD;
        Tue, 18 Oct 2016 11:56:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 16/25] sequencer: support amending commits
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
        <cover.1476120229.git.johannes.schindelin@gmx.de>
        <ec146dc2f3a3698bd433bbec4d7ecbab762c1bfb.1476120229.git.johannes.schindelin@gmx.de>
        <xmqqinsqx54y.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610181352010.197091@virtualbox>
Date:   Tue, 18 Oct 2016 08:56:39 -0700
In-Reply-To: <alpine.DEB.2.20.1610181352010.197091@virtualbox> (Johannes
        Schindelin's message of "Tue, 18 Oct 2016 13:53:10 +0200 (CEST)")
Message-ID: <xmqqlgxlr6q0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75DED1C0-954B-11E6-948E-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 17 Oct 2016, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > This teaches the run_git_commit() function to take an argument that will
>> > allow us to implement "todo" commands that need to amend the commit
>> > messages ("fixup", "squash" and "reword").
>> 
>> Likewise to 15/25, i.e. Good, though the growth by these two steps
>> starts to make me wonder if these three options should be crammed
>> into an unsigned "flags" bitword.
>
> After looking at the diff with the added complications of ORing and ANDing
> the flags, I'd much rather prefer to stay with the three flags being kept
> separately. It's not like we need to save bits, but we need to preserve
> readability as much as possible, I'd wager.

That's OK.  I just wanted to make sure pros-and-cons have been
already considered.

The primary merit of using flags bitword is not to save bits; it is
done to limit the damage to the codebase when we need to add yet
another knob, by the way.
