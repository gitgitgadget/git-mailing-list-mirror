Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBC3C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 16:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbiHBQR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 12:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238027AbiHBQQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 12:16:56 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A233341A
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 09:16:22 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 917E619F12E;
        Tue,  2 Aug 2022 12:16:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mnqcFGE9yrShTtKmU9mp8WKNpqNsU/C0f8VzAb
        XqS14=; b=vw95zALLmES+yaeplzjN4vU20eAniot5Mlz2UdhNVz22twEcVXhNFF
        wBSLdjRAR9GE2jKJ+ZeIwSgrI3ieb7zcd6oWelZ6thmEJGd+2R27BE34XjctEzcG
        qzOoaaY4fyX/4+ikgyWgJ89u9Hhu+gwp1+o2gFD2Pxb/iaHyr+7pQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8905519F12D;
        Tue,  2 Aug 2022 12:16:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 351B719F124;
        Tue,  2 Aug 2022 12:16:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] pipe_command(): mark stdin descriptor as non-blocking
References: <YuikU//9OrdpKQcE@coredump.intra.peff.net>
        <YulFTSTbVaTwuQtt@coredump.intra.peff.net>
Date:   Tue, 02 Aug 2022 09:16:17 -0700
In-Reply-To: <YulFTSTbVaTwuQtt@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 2 Aug 2022 11:39:57 -0400")
Message-ID: <xmqq5yjahb8u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7094CCC2-127E-11ED-A166-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It looks like we'd have the option of either adding F_GETFL/F_SETFL
> support to compat/mingw.c's fake fcntl() function, or adding a
> compat/nonblock.c that abstracts the whole thing. I'd prefer the latter,
> as it makes the interface a bit narrower.

I agree that "make this non-blocking" is the preferred interface
over "emuilate fcntl".

> But I'm not sure what should go on the Windows side of that #ifdef.
> Unlike some other spots, I don't think we can just make it a noop, or
> Windows will be subject to the same deadlock (unless for some reason its
> write() does behave differently?).

Let them deadlock so that they can fix it, and until then leave it a
noop?  That may break the CI tests for them so we could hide the
known-to-be-broken test behind prerequisite to buy them time,
perhaps?
