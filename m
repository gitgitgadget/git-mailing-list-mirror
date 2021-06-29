Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DEEC11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 06:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40ED661DB3
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 06:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhF2GVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 02:21:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61834 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhF2GVu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 02:21:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8CC9C6CD3;
        Tue, 29 Jun 2021 02:19:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=EF64UCD5hu/zWnryIxi2Oq+YL+J3IL4T+UDTNMc8E5w=; b=sHc1
        fCu7qbzDmYigrbK7JKS1fCUl9rV6V8bRHALGeD7dyX+ndrBYq2/fQuUEdfTwOzEZ
        eGqTIH47cipGx96jzy7WnhdFM++vQlBxEViBmpS58T/MS56KK/vfvxbqrWEsrWWa
        TlUJ643F0pnCzEbngIJlH06gSPh65rWEqjZMPTo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CFBF9C6CD2;
        Tue, 29 Jun 2021 02:19:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 57C92C6CCF;
        Tue, 29 Jun 2021 02:19:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
        <YNIBRboFiCRAq3aA@nand.local> <8735t93h0u.fsf@evledraar.gmail.com>
        <YNI3WVu5SK7pHI7T@coredump.intra.peff.net>
        <87r1gs1hfx.fsf@evledraar.gmail.com>
        <YNOz1GD/8+CaUvRz@coredump.intra.peff.net>
        <871r8r1hwe.fsf@evledraar.gmail.com>
        <YNSbe0At6SaQu1Z4@coredump.intra.peff.net>
        <87fsx6xn0b.fsf@evledraar.gmail.com>
        <YNqE8BIRF6NeYQcd@coredump.intra.peff.net>
Date:   Mon, 28 Jun 2021 23:19:21 -0700
Message-ID: <xmqqfsx1yyza.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1D8B0EA-D8A1-11EB-9358-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, I can see the view that running the test suite as a basic sanity
> check may have value, if it's backed by more careful testing later (and
> certainly while I'm developing, I wouldn't hesitate to run a subset of
> the test suite to see how my work is progressing).
>
> My main point was that I don't see much reason to do work to make that
> kind of continuous "make test" work with simultaneous recompiles and
> test-runs, if we can encourage people to do it more robustly with a
> single compile-and-test-run loop. Maybe adding in the extra workdir
> there makes it too heavy-weight? (Certainly my "ci" script is overkill,
> but it seems like a loop of "reset to the current branch tip, compile,
> run" in a worktree would be the minimal thing).

I actually do use such a "runs tests in the background while I am
not watching", so I am sympathetic to the higher-level goal, but I
find any execution of the idea that requires "let's reduce the
window where freshly built 'git' or any other things are not ready
by forcing 'mv $@+ $@' trick for added atomicity" simply insane and
not worth supporting.

Tests are run to find cases where things go wrong, and it is a waste
of cycles if that background task is not being run in isolation and
on a stable state.  A separate working tree is so easy to set up
these days, I do not see a point in complicating the build procedure
to avoid using it.
