Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D86EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 18:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjFTSte (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 14:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFTStd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 14:49:33 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCD710FB
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 11:49:32 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 50B4D226AD;
        Tue, 20 Jun 2023 14:49:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L/YqgptsYODYE9AKP4PZMHWIdnWkG2TBATETce
        nVi3w=; b=svgVvSAtbPtxSy8bak852EAoRsSpL/AezOvCRsXU2cmq3Cr4pSpfLQ
        LG+jyQR/5g3fwnDA1KpqjOgUnXrssN4Lpg7ld7iIXCTGugV1V2J7qWYp3TF20OKf
        ff7S7g9mv75XgmwimkFmRwUqARlT8CZc+D2RUhOY+x1O63N+biw9o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 48DB7226AC;
        Tue, 20 Jun 2023 14:49:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5F26C226AB;
        Tue, 20 Jun 2023 14:49:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 09/16] refs/packed-backend.c: implement jump lists to
 avoid excluded pattern(s)
References: <cover.1683581621.git.me@ttaylorr.com>
        <cover.1686134440.git.me@ttaylorr.com>
        <8066858bf59386eeec68f0f1e4247eeebb6482f7.1686134440.git.me@ttaylorr.com>
        <xmqq352u3n3a.fsf@gitster.g> <ZJGV/bYDN9Dn4V8S@nand.local>
Date:   Tue, 20 Jun 2023 11:49:25 -0700
In-Reply-To: <ZJGV/bYDN9Dn4V8S@nand.local> (Taylor Blau's message of "Tue, 20
        Jun 2023 08:05:17 -0400")
Message-ID: <xmqqedm6m0ju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E2BE62A-0F9B-11EE-A6C5-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> > +static const char *ptr_max(const char *x, const char *y)
>> > +{
>> > +	if (x > y)
>> > +		return x;
>> > +	return y;
>> > +}
>>
>> Hopefully the compiler would inline the function without being told.
>>
>> These pointers point into the same mmapped region of contiguous
>> memory that holds the contents of the packed-refs file, so
>> comparison between them is always defined.  Good.
>>
>> I wondered if
>>
>> 	return (x > y) ? x : y;
>>
>> is easier to read, simply because it treats both cases more equally
>> (in other words, as written, (x>y) appears more "special"), but that
>> is minor.
>
> Yeah, I think that any reasonable compiler would almost certainly inline
> this, especially at higher optimization levels. But I agree with your
> suggestion nonetheless, thanks.

Having seen how this is used (only at a single callsite), I actually
think that special casing (x>y) is the right thing to do, especially
if you inline it in the caller.  That is,

	if (last_disjoint->end < ours->end)
		last_disjoint->end = ours->end;

reads much more naturally than

	last_disjoint->end = (last_disjoint->end > ours->end)
		? last_disjoint->end : ours_end;

as a way to say "if ours is larger, record it as the largest
position we have seen so far".
