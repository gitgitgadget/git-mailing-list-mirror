Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551D6C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 22:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06035206DA
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 22:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pgZuwP0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbgHQWoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:44:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61239 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729777AbgHQWoP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 18:44:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 358D2DCD99;
        Mon, 17 Aug 2020 18:44:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fbd4ETjTth13gdsII6rSVUv+c5Q=; b=pgZuwP
        0nXeyM6ZiD9GslEZE1eHsex3607PYimzPkmryU2QwtMyrVqyE8fJThSGEyOwZQmq
        4TOZpldwRAvTkeYItUw1M32LeIJlx24cgsrV1bE2s95x7ORAhgH1YqjG6C7KZL9X
        MMmWNlv/xT21+OhCRTW3M50WatE/pF5i1VQMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ap93cIOPuFYqhgOc6nTHsxWs8pEFd6uO
        sA8Bwh9IO9CCpQyK1SXBAItgM2nfFHrCMRzokzEpJ7LWeSkbpC41B+pjTQkl5Igx
        aXJLHGmWn2Semz2SlVL/KskC8p3rCbYm7MlZBiCqp+bGbITSqJ1AxnhGyo+j8Md6
        BV98njZQp0M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D9BBDCD98;
        Mon, 17 Aug 2020 18:44:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 734C3DCD91;
        Mon, 17 Aug 2020 18:44:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] progress: create progress struct in 'verbose' mode
References: <20200710014242.1088216-1-emilyshaffer@google.com>
        <20200710014242.1088216-2-emilyshaffer@google.com>
        <xmqq365zro2u.fsf@gitster.c.googlers.com>
        <20200714001504.GI3189386@google.com>
        <20200817221938.GA331156@google.com>
Date:   Mon, 17 Aug 2020 15:44:08 -0700
In-Reply-To: <20200817221938.GA331156@google.com> (Emily Shaffer's message of
        "Mon, 17 Aug 2020 15:19:38 -0700")
Message-ID: <xmqqlficzydj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A90E07A-E0DB-11EA-BB2B-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> The main concern I saw here was "we are doing a lot of work that isn't
> used if the user doesn't want to log traces" - should I approach a
> reroll of this topic by trying to be smarter about whether to set
> 'quiet' or 'print' or 'verbose' or whatever it is renamed to, based on
> whether there is a trace destination? Then for systems which are logging
> traces the extra work is worth it, but for everyone else it can function
> as before.
>
> I don't love it from a design perspective - it feels a little like
> progress module is looking a little too closely at trace module
> internals.

Isn't that primarily due to the decision to tie progress and trace
too closely?  If so, perhaps that needs to be revisited?

I dunno.
