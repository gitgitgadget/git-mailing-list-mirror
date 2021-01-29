Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACA0C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 22:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C684664DA1
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 22:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbhA2WPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 17:15:02 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56758 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbhA2WO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 17:14:27 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 354151085FC;
        Fri, 29 Jan 2021 17:13:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bO9k70h6u/u9ffWq/LYZsAhcmXw=; b=jg8URt
        aZrX0zvUsYeABrjIT+KNU9sBd0OjtFffXFBPXchV+6ZJq7Y1rBA0D1yC4RL/BGIK
        uEZJOq5uPxAMXOddHodfIkzbEXJgApNjjyG1/D7c31EnJGbNEVgiecJScCkOuXA3
        /6Q3kcAEXvR2VcRAtBg9tTqvKmBASVKcKKbq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EcPOTCNT9q0YxyvKZxHz7q5rSsMC2Evz
        QtHnUUrlw0x74gGcutUbA67w8kicmNqYnDrvB++nzUsahGcD8h4JFDo+ffr2Mt+P
        11Ne8SpuR5sF0iQviIwImIhzulFfylBmLgf2ebUBvwXiBCciTKAh3APr4rvUf8YS
        bxlootT1gqA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2EF021085FB;
        Fri, 29 Jan 2021 17:13:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 501701085F8;
        Fri, 29 Jan 2021 17:13:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 03/10] builtin/pack-objects.c: learn
 '--assume-kept-packs-closed'
References: <cover.1611098616.git.me@ttaylorr.com>
        <2da42e9ca26c9ef914b8b044047d505f00a27e20.1611098616.git.me@ttaylorr.com>
        <xmqqk0rwtom2.fsf@gitster.c.googlers.com>
        <YBRfvZh86Z8wAnxZ@coredump.intra.peff.net>
        <YBRprCmIX4IrHAi0@nand.local>
        <YBRvQdHoslnF0OXr@coredump.intra.peff.net>
Date:   Fri, 29 Jan 2021 14:13:39 -0800
In-Reply-To: <YBRvQdHoslnF0OXr@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 29 Jan 2021 15:25:37 -0500")
Message-ID: <xmqqpn1ns86k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E795D80-627F-11EB-B8C2-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I wonder if we need our assumption that the union of kept packs is
>> closed under reachability to be specified as an option. If the option is
>> passed, then we stop the traversal as soon as we hit an object in the
>> frozen packs. If not passed, then we do a full traversal but pass
>> --honor-pack-keep to drop out objects in the frozen packs after the
>> fact.
>> 
>> Thoughts?
>
> I'm confused. I thought the whole idea was to pass it as an option (the
> user telling Git "I know these packs are supposed to be closed; trust
> me")?

Yes, that is how I read these patches, and it sounds like an assumption
that we can make under many scenarios/repacking strategies.
