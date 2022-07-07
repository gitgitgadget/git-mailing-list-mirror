Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F794C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 20:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbiGGUZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 16:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236518AbiGGUZk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 16:25:40 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AC320BEA
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 13:25:39 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 876BC1AF8CC;
        Thu,  7 Jul 2022 16:25:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nuU1McT/ln3qmNpvQwY6LKGezxAconb/gO+uPO
        RcyVA=; b=i71lZwup90AXHDvDp5CSFRnZB4YTuY6XSOq30uN2/iXs8t7n9RN4vZ
        0ZO7e/RPhEoSsJzi749Hkuqk/Jwz61s+lxvmY1xr21BYqNGqL6bjAdZop9a9zk08
        cSfSIk061KwWzMMGYTccdZ2wCclfS8CC0/0yk8XVesd0V2ry52St0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 732021AF8CB;
        Thu,  7 Jul 2022 16:25:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C24491AF8C9;
        Thu,  7 Jul 2022 16:25:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] builtin/mv.c: use correct type to compute size of an
 array element
References: <xmqq8rp54r4l.fsf@gitster.g>
        <YscpDTgwxUko/aZM@coredump.intra.peff.net>
Date:   Thu, 07 Jul 2022 13:25:33 -0700
In-Reply-To: <YscpDTgwxUko/aZM@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 7 Jul 2022 14:42:21 -0400")
Message-ID: <xmqqfsjczn42.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4A7F2C4-FE32-11EC-A1A5-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jul 06, 2022 at 07:02:18PM -0700, Junio C Hamano wrote:
>
>>    * Should we in general use sizeof(TYPE) in these cases, instead
>>      of the size of the zeroth element, e.g.
>> 
>>  		memmove(source + i, source + i + 1,
>> 			n * sizeof(source[i]));
>>     
>>      It would have been caught by the above Coccinelle rule (we are
>>      taking the size of *dst).
>
> I'm not sure I understand this. As you noted in a later email, using
> sizeof(TYPE) is less maintainable if the type of "source" changes.

Sorry for a typo or thinko, whichever one you like ;-)

> But
> later you mention using "*source" instead of "source[i]". I don't think
> there is a particular reason to prefer one over the other from the
> compiler perspective. I find "*source" more idiomatic (but better still
> of course is MOVE_ARRAY, which removes the choice entirely).

Yes, I wrote source[i] there only because I found it somewhat
awkward to write source[0] or *source there, when the moved
(sub)array is from the index 'i' to the end.  *(source + i) would
have matched the intention better but it still is awkward.
