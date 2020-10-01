Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62E1C4741F
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 15:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369EB20872
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 15:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DWXTbsJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbgJAPnD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 11:43:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50284 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731885AbgJAPnD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 11:43:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2933BE081E;
        Thu,  1 Oct 2020 11:43:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LurdlMI6VWwCOdTWP+DLYKUfjy8=; b=DWXTbs
        Jh6GCNqhVzPTKyz5Lo65cCZPLmf71eC4aMcgJ2iawFp6YqL5TFA7SFwtlCGcCV8L
        x2hidLRNUmae0g4BSUmaUz06u971PWCaQlI/wS/rV5GPns3bK6FKyyytX6x5MIcJ
        501hZEvTQ8jks1vHuaWNgUG4zd93wvA6/BP9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=getrlZ2C4Otfut50NUxp0FDA2py1iDnH
        i0DFFTZua5T3i62PPFnRhnKQRM4Yuh4leaspFJQXVVvJBdsjgFjmGor5PgtWOW1X
        MRGlNoYnPQmX5WJgNsVIQlMQcPIeByqjjQceBvtQ3UBjmc/TkoWzOKDrPXs8KDIT
        GbO0wmQW0Uk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 21E3CE081D;
        Thu,  1 Oct 2020 11:43:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 621D2E081B;
        Thu,  1 Oct 2020 11:42:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Nikita Leonov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nikita Leonov <nykyta.leonov@gmail.com>
Subject: Re: [PATCH v2 2/3] credentials: make line reading Windows compatible
References: <f69076036fe4dfe8b57fc1d4329c7be3f7346850.1601293224.git.gitgitgadget@gmail.com>
        <CAPUEspgW9CFO3WtbiuTUsmXp05fPqr2Cs81piDJFJ0g3KcTy3A@mail.gmail.com>
        <20200929003000.GA898702@coredump.intra.peff.net>
        <xmqqwo0difdh.fsf@gitster.c.googlers.com>
        <20200929004448.GD898702@coredump.intra.peff.net>
        <xmqqsgb1ier6.fsf@gitster.c.googlers.com>
        <20200929030043.GA905754@coredump.intra.peff.net>
        <xmqqeemigawq.fsf@gitster.c.googlers.com>
        <20200930223913.GB1908000@coredump.intra.peff.net>
        <xmqq5z7ug9gk.fsf@gitster.c.googlers.com>
        <20201001135417.GA3145610@coredump.intra.peff.net>
Date:   Thu, 01 Oct 2020 08:42:56 -0700
In-Reply-To: <20201001135417.GA3145610@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 1 Oct 2020 09:54:17 -0400")
Message-ID: <xmqqpn62c5q7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7D47EE8-03FC-11EB-A76A-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, I agree that just teaching git-credential's stdin to handle CR
> would be an OK stopping point. I don't have a strong opinion on
> credential-store's on disk format. At least allowing CRLF there is
> _plausibly_ useful, unlike credential-cache--daemon's pipe. And I doubt
> that making the change would hurt anybody.

I agree 100% with all of the above, including the part that says it
is also OK to let credential-store read from its files with line
ending converted to CRLF.

Thanks.

