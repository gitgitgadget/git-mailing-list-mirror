Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52367C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259B0611AD
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhHTRTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 13:19:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62892 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbhHTRTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 13:19:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 80B5015DFD2;
        Fri, 20 Aug 2021 13:18:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BP+vSXnp08KwOBHRAE3G7ZneEhZY+dWQlLbt2X
        wWoQ8=; b=LTEgTwvrjMBPIFb3Wt6w26IPO4ycxzfB648Em1AvFOnKrLEb+lVbPT
        p212dL73umG2QDFhoNEiKFYhCst2G4ORLUfLBjH0d881yB7yie/Ds0ywAD9H0U16
        uHNj7tlbZTwFTVnWE5ccDXrPHpucr521zlvt//Hqxyd9ojNVACP3k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 79C5215DFD1;
        Fri, 20 Aug 2021 13:18:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BDC1B15DFD0;
        Fri, 20 Aug 2021 13:18:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/6] fetch: speed up lookup of want refs via commit-graph
References: <cover.1629452412.git.ps@pks.im>
        <6872979c4557204821d788dc3f5e1c8bef0a773c.1629452412.git.ps@pks.im>
        <fce98460-eed6-c874-8c42-bf3a6f5f93a8@gmail.com>
Date:   Fri, 20 Aug 2021 10:18:22 -0700
In-Reply-To: <fce98460-eed6-c874-8c42-bf3a6f5f93a8@gmail.com> (Derrick
        Stolee's message of "Fri, 20 Aug 2021 10:27:59 -0400")
Message-ID: <xmqq7dggvxup.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A071BF50-01DA-11EC-8412-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I do worry about the case where annotated tags greatly outnumber
> branches, so this binary search is extra overhead and the performance
> may degrade. Would it be worth checking the ref to see if it lies
> within "refs/heads/" (or even _not_ in "refs/tags/") before doing
> this commit-graph check?

Ah, clever.
