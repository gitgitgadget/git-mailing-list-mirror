Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A88C31F991
	for <e@80x24.org>; Wed,  9 Aug 2017 18:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbdHISMW (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 14:12:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62684 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750770AbdHISMV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 14:12:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CFA258D01B;
        Wed,  9 Aug 2017 14:12:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WMS0zAaIARI38IlxErVUwb1RibU=; b=SSP5yG
        lXLAqf0eV+bq10HlSEHsFNU7+d6fR4vOZGZSPN1peYKOKSUbMxSZ2QJehFTw9sPD
        gTawyzchtXbogo+c2Lj/vkdUtWxiyO1FXq6gqAN5BP5rZBl+gTP0JAXeNAygB+TT
        a9NkcUC1EmU4i1JaA+sE0xvxU0pN+7GbADI7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F6DPa06QX82bAr+sMrUyzWygNxWFqLhh
        ReYc7Gixt2jsQEBb7kHQFH0digiQPa9ELAunR7j9NgBHNS3b+PdWTtZ5hwW8w+Y8
        JTdjySs269BTa4QqMavDLcAkEanqwbrgIrEbz42Y4BzFHV4IOnhPeOImjQOoAO/i
        wKa7i3/5hck=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7DEA8D01A;
        Wed,  9 Aug 2017 14:12:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B96D8D016;
        Wed,  9 Aug 2017 14:12:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 1/2] sha1_file: drop experimental GIT_USE_LOOKUP search
References: <20170809101106.p45y34uk6wcruqxv@sigill.intra.peff.net>
        <20170809101432.6jquwmev423o56pb@sigill.intra.peff.net>
Date:   Wed, 09 Aug 2017 11:12:19 -0700
In-Reply-To: <20170809101432.6jquwmev423o56pb@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 9 Aug 2017 06:14:32 -0400")
Message-ID: <xmqqshh06264.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48D43370-7D2E-11E7-BEE5-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This lets us remove sha1_entry_pos() entirely, as the .idx
> lookup code was the only caller.  Note that sha1-lookup.c
> still contains sha1_pos(), which differs from
> sha1_entry_pos() in two ways:
>
>   - it has a different interface; it uses a function pointer
>     to access sha1 entries rather than a size/offset pair
>     describing the table's memory layout
>
>   - it only scales the initial selection of "mi", rather
>     than each iteration of the search
>
> We can't get rid of this function, as it's called from
> several places. It may be that we could replace it with a
> simple binary search, but that's out of scope for this patch
> (and would need benchmarking).

Thanks for reducing the count of binary search functions by one.

I think the "just one round of newton-raphson" in sha1_pos() comes
from [*1*]; I agree that it needs benchmarking before tweaking it.

We may want to tell libgit2 folks about this change, though [*2*].
I think they too are carrying dead code that is only used under CPP
macro GIT_USE_LOOKUP, which they do not seem to define.


[Reference]

*1* https://public-inbox.org/git/7v38vso8kz.fsf@alter.siamese.dyndns.org/
*2* https://github.com/libgit2/libgit2/commit/dd453c4dbf9a1fa38530b1f51e079852736b8f66
