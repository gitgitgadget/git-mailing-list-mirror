Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1D9C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 21:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 050412313A
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 21:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbhAFVCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 16:02:53 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60004 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbhAFVCx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 16:02:53 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B4BC115A87;
        Wed,  6 Jan 2021 16:02:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6hZrFK/w9pnlDhlpGlbPPGce3hM=; b=dEj8rI
        VOXsjPOC9CDhwQA354Hxyy4BQmGXQG/H+dndKtpEriiK4jDbELNQFKMFvHVvrAFc
        lyAJ2HEIN9BYBl3LX/ur8j/pEuFLHHN6ZBAOrfLZA23owwc8LcyEZYmDsGHVRgkj
        KO1LiQrzLvj6Dal00IcgQJX+4yfGc4TF3qzvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H+wTw4/ONMdJaVIBgZM6lQ5QBNErTNfm
        RX3eefx6dGB5htzQ6d3fg9n98QAjNaE5jNIiYlideQYeKoZmNHDdKv3XxuCzKT5n
        K3HQ9E3ltncE9vy4wXYkEkwVH5ZRvzsx9fLr7DQOPwujTs8LDPr0ebB1LETwTph7
        unJQ0upbx+w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 23432115A86;
        Wed,  6 Jan 2021 16:02:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 18225115A85;
        Wed,  6 Jan 2021 16:02:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] refs: allow @{n} to work with n-sized reflog
References: <0c6885f15f5ce0be28142d9c69724362e72481a9.1609551262.git.liu.denton@gmail.com>
        <xmqqk0sqvcby.fsf@gitster.c.googlers.com>
        <X/V0DU+CD6mS36dK@generichostname>
Date:   Wed, 06 Jan 2021 13:02:05 -0800
In-Reply-To: <X/V0DU+CD6mS36dK@generichostname> (Denton Liu's message of "Wed,
        6 Jan 2021 00:25:49 -0800")
Message-ID: <xmqqft3drd82.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F69B27A-5062-11EB-AB8B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> > -	if (timestamp <= cb->at_time || cb->cnt == 0) {
>> > +	if (cb->cnt > 0)
>> > +		cb->cnt--;
>> > +	at_indexed_ent = cb->cnt == 0 && !is_null_oid(ooid);
>> 
>> The code treats two cases identically (i.e. the case where cb->cnt
>> was originally zero, and one).  Is that intended?
>
> It shouldn't be possible for cb->cnt == 0 on the first iteration
> because there's a special-case check at [0]. As a result, it can only be
> -1 or >= 1 on the first iteration.
>
> The -1 case happens when we're doing date-based lookup and that's what
> this if is intended to handle.

I knew about -1; it wasn't apparent that the caller won't call us
with cnt==0.  Perhaps it deserves a mention in an in-code comment.

> "at_indexed_ent" is meant to signal when we are indexing the reflog
> numerically (as opposed to by date), we have arrived at the correct
> entry. If you have a more fitting name, I'm open to suggestions.

When querying for <ref>@{24}, all the entries are indexed
numerically (counted), not just the 24th one, and that contributed
to my puzzlement.

I offhand do not think of a "name", but "at target", "found",
"reached count", are phrases that come to my mind as starting
points.

Thanks.
