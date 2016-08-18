Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09095203EA
	for <e@80x24.org>; Fri, 19 Aug 2016 01:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754677AbcHSBFF (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:05:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62495 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754706AbcHSBEv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:04:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D23F336652;
        Thu, 18 Aug 2016 18:47:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ntUDhPqJBzb0mVBcbU6HkIbV0AM=; b=uqxaLR
        WFI5sDTjrdue97tCRkNqTPZSST7unOCYCtDGdbBONoxW//FKfK2BThcF0PaG3Tus
        ee/795QwFK/lAH2/C507qnpd8BkWAZ2hAfgUjcZr0wZrQqKIycv8/8myhb+LJsOm
        FGraQB1i9h/Zhm1S+sMK8qMaQxBVK/l2jXGxc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=flZI2U0VzrDYq/DnqMzJ9FvDYJ6uyv6u
        GL5IV9pjKcMow2rjUVLFJ6LKxsuum8QkRD2xtq2zZJm7kekR67pDfecN7yrJlwcP
        ftsCh2OL/208CHxvtacKTPbxvCVWKv7S5IFZ1W831Slc6t1pjf/llb7WUb/o+QH7
        AJSY/8q/9aY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C811036651;
        Thu, 18 Aug 2016 18:47:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4457036650;
        Thu, 18 Aug 2016 18:47:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/4] cat-file: support --textconv/--filters in batch mode
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
        <2315ae5ab6918a7c1567f11a64093a860983bc20.1471524357.git.johannes.schindelin@gmx.de>
        <20160818220530.2dcsag4qeitia4ao@sigill.intra.peff.net>
Date:   Thu, 18 Aug 2016 15:47:41 -0700
In-Reply-To: <20160818220530.2dcsag4qeitia4ao@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 18 Aug 2016 18:05:31 -0400")
Message-ID: <xmqqoa4p4rua.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C64E58B4-6595-11E6-BD6B-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Aug 18, 2016 at 02:46:28PM +0200, Johannes Schindelin wrote:
>
>> With this patch, --batch can be combined with --textconv or --filters.
>> For this to work, the input needs to have the form
>> 
>> 	<object name><single white space><path>
>> 
>> so that the filters can be chosen appropriately.
>
> The object name can have spaces in it, too. E.g.:
>
>   HEAD:path with spaces
>
> or even:
>
>   :/grep for this

When I wrote my review, I didn't consider this use case.

There is no -z format in --batch, which is unfortunate.  If we had
one, it would trivially make it possible to do so, and we can even
have paths with LF in them ;-).  On the other hand, producing a NUL
separated input is a chore.

Perhaps a new and separate option that is similar to "--batch" but
lacks support for %(rest) and accepts _ONLY_ 40-hex as object name
is the best we can do, then?

> (as was pointed out to me when I tried to turn on %(rest) handling by
> default, long ago). How do those work with your patch?
>
> It looks like the extra split isn't enabled unless one of those options
> is selected. Since --filters is new, that's OK for backwards
> compatibility. But --textconv isn't. So I think:
>
>   echo "HEAD:path with spaces" |
>   git cat-file --textconv --batch
>
> is regressed by this patch.
>
> I wonder if we need an option specifically to say "the object name can
> be split". Right now it kicks in automatically if you use "%(rest)" in
> your format, but you might not care about passing along that output
> (e.g., a lot of times I am piping "rev-list" straight to cat-file, and I
> have to use a separate "cut" to throw away the pathnames).
>
> -Peff
