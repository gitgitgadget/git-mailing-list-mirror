Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 377361FF6D
	for <e@80x24.org>; Thu, 22 Dec 2016 19:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965759AbcLVTHC (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 14:07:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58425 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965697AbcLVTHB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 14:07:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F37B58443;
        Thu, 22 Dec 2016 14:07:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bfJX0x9qUrmjzLFZcDiBjCtSTVE=; b=A/g+9F
        viRTkHbW3ASSoegmJFtrHUWHAS1atSw+dVM0E6wCBXdtle/9fOigkYSJViUXGdFb
        ym25D2nzxOd/HRHlZ7es8ylYRAHuItyt9zUPrL5fpYz3XuPXpeBjaTP7qRhUq29Q
        JwZ5M9Ny/ePZfhhyc9AOaDVi5e1VTNJdS9o5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bWO30yux6WZ2pxsVXvFM6K0p48eRW8ap
        zoyV7u4xLLCDUPoZSjgDwjPQOxUne0Jzh/6SWsb6pOGH8EgREseyPzGhUNMTnd/0
        gRPUBwafOrXMjdCi2zWTbgnJ1NO590bB1Suu6LNKO4tEJ0omNVXsda6F2seyhB/D
        nabttxjiJcc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1528B58442;
        Thu, 22 Dec 2016 14:07:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 773F958440;
        Thu, 22 Dec 2016 14:06:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] log: support 256 colors with --graph=256colors
References: <20161220123929.15329-1-pclouds@gmail.com>
        <20161220165754.hkmnsxiwbcgn6uin@sigill.intra.peff.net>
        <CACsJy8CnS1=_vA5xhbZ94Qyh7ySC5FvaALu1vhQwt_YJya4wHA@mail.gmail.com>
Date:   Thu, 22 Dec 2016 11:06:58 -0800
In-Reply-To: <CACsJy8CnS1=_vA5xhbZ94Qyh7ySC5FvaALu1vhQwt_YJya4wHA@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 22 Dec 2016 16:48:48 +0700")
Message-ID: <xmqqtw9vg4vh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D070C222-C879-11E6-B309-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> .... But I think I could approach it a different way:
> collect colors that have names. That reduces the number of colors so
> we can go back to "step 1 at a time" and still don't run into two
> similar colors often.

I suspect that there is a "cultural" bias that makes the idea
unworkable.  I haven't found a definitive source, but I think there
are a lot more hues and shades of red that have names than hues and
shades of blue, for example.

If I were doing this, I'd just prepare a table with 32 color slots
or so [*1*], start at a random spot (say 017:00005f) of

    https://en.wikipedia.org/wiki/File:Xterm_256color_chart.svg, 

and pick spots by jumping southeast like a chess knight
(i.e. 017->030->043->086->...) until the table is filled, wrapping
around at the edge of that color chart as necessary.


[Footnote]

*1* ...because I do not think the thin graph lines painted in too
many colours on the screen would be easily distinguishable from each
other anyway.
