Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C100B2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 17:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933957AbcKORnE (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 12:43:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59104 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933893AbcKORnA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 12:43:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D265D4EA48;
        Tue, 15 Nov 2016 12:42:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j5cE6Ppb8cNLubGV/dFBguntJgA=; b=FRw59+
        1iSugVGVXlYyBP+vR29m2jiQSzVFmHp4J4HC4ncRJv1V04hDkuFt6kobmwrJf9uN
        dQIomwgY1vML99p4Z5rMxbYTlszMSXds75qQJlR4fhGVX8G1I2R7n8M1MXM8d8uI
        gL71bxf5D6tSvI56cAOXhBsAA/o8lMnIeIJGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rHeGNRYYI5v5gb6ZWlpFaU6xN0z9G3pQ
        DZ56DHIw8CwIfvrSbsv87d7+trIZkJ7YREK6fSnb7F2WJsLiBE5dqbp7bFxB3R7v
        vquFxwN2KgOkeqJx8yPGwmaCFSIW8bm7mF3/frqsSb0O6dyQxx6cBdm+Hb330l/h
        2/fiJAFIXwY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA8444EA46;
        Tue, 15 Nov 2016 12:42:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 47D264EA45;
        Tue, 15 Nov 2016 12:42:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        spearce@spearce.org
Subject: Re: [PATCH] remote-curl: don't hang when a server dies before any output
References: <1478729910-26232-1-git-send-email-dturner@twosigma.com>
        <20161114182431.e7jjnq422c4xobdb@sigill.intra.peff.net>
        <20161114194049.mktpsvgdhex2f4zv@sigill.intra.peff.net>
        <20161115004426.unheihlmftlw6ex7@sigill.intra.peff.net>
        <xmqqa8d1v9lo.fsf@gitster.mtv.corp.google.com>
        <20161115035844.e6ehuy7uigqinbnv@sigill.intra.peff.net>
Date:   Tue, 15 Nov 2016 09:42:57 -0800
In-Reply-To: <20161115035844.e6ehuy7uigqinbnv@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 14 Nov 2016 22:58:44 -0500")
Message-ID: <xmqqzil0tza6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F25F11FE-AB5A-11E6-962B-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Nov 14, 2016 at 05:02:27PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Actually, I take it back. I think it works for a single round of ref
>> > negotiation, but not for multiple. Enabling GIT_TEST_LONG=1 causes it to
>> > fail t5551.
>> >
>> > I think I've probably made a mis-assumption on exactly when in the HTTP
>> > protocol we will see a flush packet (and perhaps that is a sign that
>> > this protocol-snooping approach is not a good one).
>> 
>> Hmph.  I think I tried David's original under GIT_TEST_LONG and saw
>> it got stuck; could be the same issue, I guess.
>
> It works OK here. I think it is just that the test is really slow (by
> design).

Yeah, I think what I recalled was my old attempt to run the
follow-up "any SHA-1" patch without this one.
