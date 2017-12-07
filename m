Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 937C720954
	for <e@80x24.org>; Thu,  7 Dec 2017 22:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbdLGWbl (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 17:31:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58933 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750862AbdLGWbk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 17:31:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F9A7C5EE6;
        Thu,  7 Dec 2017 17:31:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O0ASfsA8mYXPFblIXwe2axyd840=; b=JIIrvA
        oQM3snv2vm4PpaeCjuTk/Bg9bUeikfKOMKfpkdFysC0s7FNaqDtns7rMKbmfc+00
        P62qjaqpXSm0tOIzTvp2278uKa4urpnNNoWT7jiyPdNYOK/ut1xkXWOfobBWhVz7
        LUKDtTM5xK/2rM/hH3n6k8Fz+XqLdjNYyM1Kg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OvvgUz6gS2hvjQfv7I6yyGDRJzpjZ2u1
        DX3FVPcLbiSUUi0cmJIKtytcI7MZu7xl156GJ18TVpvvBNKV8khxs67k7gtasjao
        TOJEAee2wQ9SWq+fYBMRUtVI9kZuSPx4zg09RGcA5w8uoAQz9WaZOfGdV3dnSRWx
        YWJAx3voZak=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48056C5EE5;
        Thu,  7 Dec 2017 17:31:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B61F1C5EE3;
        Thu,  7 Dec 2017 17:31:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        jacob.e.keller@intel.com
Subject: Re: [PATCH v2 5/7] diff: use skip-to-optional-val in parsing --relative
References: <20171207003517.11729-1-jacob.e.keller@intel.com>
        <20171207173034.12865-1-gitster@pobox.com>
        <20171207173034.12865-2-gitster@pobox.com>
        <20171207211102.GA12850@sigill.intra.peff.net>
        <xmqqpo7qb3n8.fsf@gitster.mtv.corp.google.com>
        <20171207222143.GA14845@sigill.intra.peff.net>
Date:   Thu, 07 Dec 2017 14:31:38 -0800
In-Reply-To: <20171207222143.GA14845@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 7 Dec 2017 17:21:43 -0500")
Message-ID: <xmqqlgieb25x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 649FFCFA-DB9E-11E7-9AE9-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Dec 07, 2017 at 01:59:39PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > On Thu, Dec 07, 2017 at 09:30:32AM -0800, Junio C Hamano wrote:
>> >
>> >> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> >> ---
>> >
>> > It might be worth mentioning why this conversion is pulled out from the
>> > others (because its "default" case is "do not touch the pointer").
>> 
>> I am not sure what you mean by "pulled out from the others".  I did
>> not intend to keep these 3 additional patches permanently; rather, I
>> did them to help Christian's rerolling the series, and I do not think
>> this one should be separate from other ones that use the _default()
>> variant when that happens.
>
> Ah, I see. I had thought you meant these to be applied on top.

Ah, I do not particularly mind doing things incrementally, either.

If this goes on top as a standalone patch, then the reason why it is
separate from the other users of _default() is not because the way
it uses the null return is special, but because it was written by a
different author, I would think.  

The reason why _default() variant exists is because its callers want
to react differently to "--foo" from the way they react to "--foo="
(with an empty string as its value), and from that point of view,
this caller is not all that different from other ones, like the one
that parses --color-words Christian wrote in his initial round.

