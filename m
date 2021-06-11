Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B32C48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 01:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C2261076
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 01:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhFKBW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 21:22:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58819 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFKBWY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 21:22:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2151C147EF7;
        Thu, 10 Jun 2021 21:20:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bqVjmbXXAlfbcvO591Y3Tn77oadvl0MyBtCW3L
        O/VGo=; b=vZwY4+W/rl73uDu/2dDgkM4ecHp61fnhKb/jSsZRI9CL9OAHHOVffJ
        7HDwE7ZyQdffkVoeFBSXXn9bsljp5qom/JsPA7Bv8L87AEbJhqbnOwUkUtnr79Cq
        mfeDw+N4ANgAgeYfkHsWoJAmDSwNnJ6KRhGrtsSngWDbVRqBzYOSM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 185A3147EF6;
        Thu, 10 Jun 2021 21:20:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5CBBD147EE8;
        Thu, 10 Jun 2021 21:20:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
        <20210609192842.696646-8-felipe.contreras@gmail.com>
        <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
        <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net>
Date:   Fri, 11 Jun 2021 10:20:22 +0900
In-Reply-To: <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 10 Jun 2021 09:49:06 -0400")
Message-ID: <xmqqh7i5ci3t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 328AD0F8-CA53-11EB-9141-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I didn't look too deeply at your example, but I suspect it may be
> related to the fact that diff3 does not try to minimize the conflicts as
> much (and then the recursive merge on top of that piles on extra layers
> of confusion).
>
> There's a lot more discussion in this old thread:
>
>   https://lore.kernel.org/git/20130306150548.GC15375@pengutronix.de/

Yes, it does not help that the given sample involves conflicts in
the inner merge, which is unfortunately almost unreadable.  For less
confusing merges, diff3 style is often a lifesaver necessary for
avoiding mismerges by showing what the common ancestor looked like,
so that the reader/merger/integrator can tell what each side wanted
to do to the conflicted section.

Rejecting diff3 style output because of the way a conflicted part in
the inner merge appears as a common ancestor version may be throwing
the baby out with the bathwater.  A different way to say it is that
until we improve the way the conflicted inner merge is shown, diff3
style is not something we can recommend to new users as a default, I
would think.

