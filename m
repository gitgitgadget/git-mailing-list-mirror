Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBBAC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 03:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8B76147E
	for <git@archiver.kernel.org>; Tue, 11 May 2021 03:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhEKDjS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 23:39:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61027 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhEKDjR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 23:39:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85400BF5FB;
        Mon, 10 May 2021 23:38:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DOoXDXan7urFEWCBSS0upW8Z1U06uhA0SXu27c
        k/7Yo=; b=hYCpSONc4e5TBGTZpM9TJ2mE/ODmpEcgqUIqTkpZxRbA4TBwoQAQ2d
        xv16ax4obWggKEv+W8NsR1PYljZhfnSAM+iHKWUwZ2hZjE1uTDl+x/cUFYPFs5qD
        cPWRDeKVB1tW0AWdiKsFDbBapMaZBvUfYwMuwAossnmqU5WbujiNY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BF0EBF5FA;
        Mon, 10 May 2021 23:38:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D1918BF5F9;
        Mon, 10 May 2021 23:38:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v1 1/8] compat/terminal: let prompt accept input from pipe
References: <20210506165102.123739-1-firminmartin24@gmail.com>
        <20210506165102.123739-2-firminmartin24@gmail.com>
        <xmqqr1ijwi0i.fsf@gitster.g>
        <YJTH+sTP/O5Nxtp9@coredump.intra.peff.net>
        <875yzrgr1f.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
        <YJmmXZdwSoR+vxjw@coredump.intra.peff.net>
Date:   Tue, 11 May 2021 12:38:10 +0900
In-Reply-To: <YJmmXZdwSoR+vxjw@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 10 May 2021 17:32:13 -0400")
Message-ID: <xmqq1raeos7x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4EF18EFA-B20A-11EB-8105-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, May 10, 2021 at 06:18:36AM +0200, Firmin Martin wrote:
>
>> > Looking at the second patch, the motivation here seems to be to use
>> > git_prompt() for another run-of-the-mill prompt. But the right answer
>> > is: don't do that. In fact, we recently-ish removed a similar case in
>> > 97387c8bdd (am: read interactive input from stdin, 2019-05-20) that was
>> > likewise causing problems with the test suite.
>> 
>> I actually inspired myself from the two occurrences of git_prompt in
>> builtin/bisect--helper.c introduced in 09535f056b (bisect--helper:
>> reimplement `bisect_autostart` shell function in C, 2020-09-24).
>> Not sure if they should also be converted to a simple fgets.
>
> Yes, I think they should be switched.

OK, that is because in the context of a "bisect" session, we won't
be feeding any real data from its standard input, unlike "git am"
that may well be eating a patch stream from its standard input
stream.  If so, makes sense.

