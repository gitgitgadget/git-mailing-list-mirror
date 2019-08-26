Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AA901F461
	for <e@80x24.org>; Mon, 26 Aug 2019 15:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbfHZPgR (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 11:36:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59679 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbfHZPgR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 11:36:17 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 27CDA1608D7;
        Mon, 26 Aug 2019 11:36:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iFm3Bhyef5o16T5khe6OJk5yub8=; b=ZHk64j
        /iWj2y6q/X+XB7B9sWZ+kPUjquTKXT7yCPf0CoG33p3Bjc9InBQxbl2CVnaeSqkp
        TKH/k4eaMNVumEwPuvpcOxbry1hH1L+rFr+k4WhxOO//JlR1iPCSCZPTrFNpzCo+
        cWftVhiHDuQwYAOL5C00i7X92MKj8CvEU0ML4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ft6i8KbQIls2SaksKyEtZ33UcLVuqOBU
        jO/f7iFf/E67ycejHJz6xK58dwnVkswUiKyXwBXprNL6tALtn4wy2chMwPIOtCgZ
        7CrUFZUrdLPwE4Nf9L0mvEe6ho9HVkrErFlzhUipKiRh8ls0eyXkMxGuLvdEWSqS
        5NBHWdQryd0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FBBF1608D6;
        Mon, 26 Aug 2019 11:36:15 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82A3E1608D4;
        Mon, 26 Aug 2019 11:36:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Mike Hommey <mh@glandium.org>, Elijah Newren <newren@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] fast-import input string handling bugs
References: <20190825041348.31835-1-mh@glandium.org>
        <20190825065747.GA23806@sigill.intra.peff.net>
        <20190825080640.GA31453@sigill.intra.peff.net>
Date:   Mon, 26 Aug 2019 08:36:13 -0700
In-Reply-To: <20190825080640.GA31453@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 25 Aug 2019 04:06:41 -0400")
Message-ID: <xmqqo90cj5w2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D0C8EA8-C817-11E9-8258-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Aug 25, 2019 at 02:57:48AM -0400, Jeff King wrote:
>
>> And I think this is actually a real bug in the current code! We keep a
>> pointer to the encoding string, which survives because of the history.
>> But that history is bounded, and we could have an indefinite number of
>> changed files in the middle. If I modify t9300 like this:
>
> Here are two patches. The first fixes the existing bug with "encoding",
> and the second uses the approach I suggested to fix the leak you
> noticed.
>
> The second one does carry a greater risk of regression than your patch,
> but I think it's worth it for the fact that it makes any other bugs
> (like the "encoding" one) more obvious.

Yeah, it may be worth the risk, given that this is quite early in
the cycle, so we have enough time to cook it in 'next' to see if
somebody screams ;-)

>
>   [1/2]: fast-import: duplicate parsed encoding string
>   [2/2]: fast-import: duplicate into history rather than passing ownership
>
>  fast-import.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> -Peff
