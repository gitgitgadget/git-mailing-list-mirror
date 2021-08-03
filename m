Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F51AC4320A
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 21:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6060360EB9
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 21:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhHCV5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 17:57:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59700 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhHCV5F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 17:57:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CC6201480C0;
        Tue,  3 Aug 2021 17:56:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BT/C1hYraxDgxlmY78ho9kbe7SSy4++SK2X0fQ
        UFMqM=; b=ski5NRAnMeNLvwki+lxY/x4SCkp32qVTy6AUKqHxgbjOPgV4SNsewW
        8ThGHHwnvgd5Tsye3PaG/ewmX283EtX2U0L+3LzpX6t41h6c6vkRFIIscwCyTBy5
        y0yjjYlQgAdN85ryhvoSJ5sdI5iAyq2vq9/EqMf3zRSJ2GK/pzf84=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C548C1480BF;
        Tue,  3 Aug 2021 17:56:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 128811480BE;
        Tue,  3 Aug 2021 17:56:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 4/4] revision: avoid hitting packfiles when commits
 are in commit-graph
References: <cover.1624858240.git.ps@pks.im> <cover.1627896460.git.ps@pks.im>
        <f6fc2a5e6d94befa915fb59b6296ce3153820c13.1627896460.git.ps@pks.im>
        <xmqqwnp3vcow.fsf@gitster.g> <YQkJdDvRtyOPzszU@ncase>
Date:   Tue, 03 Aug 2021 14:56:49 -0700
In-Reply-To: <YQkJdDvRtyOPzszU@ncase> (Patrick Steinhardt's message of "Tue, 3
        Aug 2021 11:16:36 +0200")
Message-ID: <xmqqmtpytcny.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B52691B0-F4A5-11EB-B8FA-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> I wonder what our stance on this is. I can definitely understand the
> angle that this would be a deal breaker given that we now claim commits
> exist which don't anymore.

An optimization that produces a wrong result very fast is a useless
optimization that has no place in our codebase.  But don't we have
some clue recorded in the commit graph file that tells us with what
packfile the graph is to be used (iow, if the named packfile still
exists there, the objects recorded in the graph file are to be found
there) or something?
