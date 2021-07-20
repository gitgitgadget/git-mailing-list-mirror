Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90646C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 16:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A7461004
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 16:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhGTPps (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 11:45:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62706 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237252AbhGTPkm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 11:40:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7CE5D13C3EA;
        Tue, 20 Jul 2021 12:21:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e3I8nnGN2aCGLpkNNEGNHqLBADgCZ9ydOyzTD4
        /prpI=; b=fD8eb+xt+3jiJbJjkiouR4dS7BmgNThwJNLhZl7soD2rD2jTXwVkN2
        PPs54gmtA4TBUr/jTqUWMgcufzkue8v7mbqBRzZDp551VjNOWU27bzxdWcru0Hrp
        7S/QIE/qfpaLTlkZcImcAn4uJwTz8jJCoDlwwwPZobhE2SMQxBE7w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 76ECC13C3E9;
        Tue, 20 Jul 2021 12:21:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BD10E13C3E5;
        Tue, 20 Jul 2021 12:21:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] t0000: fix test if run with TEST_OUTPUT_DIRECTORY
References: <60f5d923848d3_145c71208cc@natae.notmuch>
        <44006e7b0bdda50dc51153cc2efb6ae954d4eecb.1626762728.git.ps@pks.im>
        <YPZ3JmWKLrUldK4R@coredump.intra.peff.net>
Date:   Tue, 20 Jul 2021 09:21:10 -0700
In-Reply-To: <YPZ3JmWKLrUldK4R@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 20 Jul 2021 03:11:34 -0400")
Message-ID: <xmqq7dhlhs7d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8000BA7C-E976-11EB-96B9-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jul 20, 2021 at 08:32:26AM +0200, Patrick Steinhardt wrote:
>
>> Fix the issue by adding a new TEST_OUTPUT_DIRECTORY_OVERRIDE variable.
>> If set, then we'll always override the TEST_OUTPUT_DIRECTORY with its
>> value after sourcing GIT-BUILD-OPTIONS.
>
> Thanks, I like this approach much better than removing
> TEST_OUTPUT_DIRECTORY entirely (and I confirmed that it fixes the
> problem).

Yup, and it combines with your subtests-skip fix rather nicely to
solve both problems.  Thanks for working well together.

> I do wish we had a more generic way of overriding stuff in
> GIT-BUILD-OPTIONS, rather than introducing manual _OVERRIDE variables
> for each. But there's not an easy solution here (see the earlier thread
> for some discussion), so this seems like a good immediate step to take.
>
> One small note on the commit message:
>
>> While this works as expected in the general case, it falls apart when
>> the developer has TEST_OUTPUT_DIRECTORY explicitly defined either via
>> the environment or via config.mak.
>
> The mention of the environment confused me for a moment, since:
>
>   TEST_OUTPUT_DIRECTORY=/tmp/foo ./t0000-basic.sh
>
> is already OK. But you probably meant that:
>
>   TEST_OUTPUT_DIRECTORY=/tmp/foo make test
>
> would fail, since "make" would pick up the variable and then write it
> into GIT-BUILD-OPTIONS (just as it would if you put it in config.mak, or
> on the command-line of make).
>
> I don't think it's sufficiently confusing to rewrite the commit message,
> but just something I noted while reading it.

I'll just insert "and runs 'make test'" after "via config.mak" while
queuing.

Again, thanks, both.
