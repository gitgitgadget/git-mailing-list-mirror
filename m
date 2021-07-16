Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642E9C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 20:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA0E613E3
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 20:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhGPUh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 16:37:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53861 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhGPUh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 16:37:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 313C914567A;
        Fri, 16 Jul 2021 16:35:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=duXvgWd3/tZRjNjAjYxNrG/iBQ/tvmY54AoSTd
        vG/ng=; b=RCPIJ00BK+3OWJzfy6tH+uoBm2oY9mQBzeXbSDUgXWNWu+wzGK3M0M
        aBkqGtKo7u4iWxKzAhC7LMqaYqtUE7Nr3P0L5D/lB5wofmTZywThLG9k9lry+6mU
        rp8NJaswbjsYDI3CXGgzSHwfI6fCEpj6LIrxABeaLnpeat6rfmtU8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2AF99145679;
        Fri, 16 Jul 2021 16:35:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 50C28145674;
        Fri, 16 Jul 2021 16:35:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     phillip.wood@dunelm.org.uk, Luca Weiss <luca@z3ntu.xyz>,
        Luca Weiss via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 2/2] merge: make sure to terminate message with newline
References: <pull.1048.git.git.1626421416.gitgitgadget@gmail.com>
        <31371c25743e1001b4fac89e80e7206ff477ac8a.1626421416.git.gitgitgadget@gmail.com>
        <8678772b-dd5d-9188-8b63-98d05cedb323@gmail.com>
        <AB048897-F70A-4388-B2A6-56BFEA40B303@z3ntu.xyz>
        <16229b1d-e4a6-7a8d-8ea0-ae7c3f13075d@gmail.com>
        <YPHe/W7+Oh63NpB0@coredump.intra.peff.net>
Date:   Fri, 16 Jul 2021 13:34:58 -0700
In-Reply-To: <YPHe/W7+Oh63NpB0@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 16 Jul 2021 15:33:17 -0400")
Message-ID: <xmqq8s26q9ot.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4AAF58FA-E675-11EB-B159-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think we still end up calling cleanup_message() on the result before
> using it as the final message, and that will fix any missing newline.
> But we feed the intermediate state before then to the hooks (which is
> exactly where one might expect to use interpret-trailers).
>
> I'm not sure if we should be doing a preemptive call to
> cleanup_message() before feeding the hooks (we'd still need to do the
> final one, to clean up whatever the hooks return to us). I guess
> probably not, because I think that would remove comments, as well. So
> adding in just the missing newline is probably better.

To be quite honest, I think this patch is a half-way solution and I
am not sure if it is better than either of the two "purist"
extremes:

 * If the hooks want to see messages with as little loss of
   information from the original as possible, we should give them
   without clean-up (which you pointed out above) *and* without this
   patch.

 * If the hooks want to see messages as canonicalized as people
   would see in normal "git log" output, we should be passing the
   full clean-up to lose even comments and in such a case there is
   no need for this "always terminate" patch (we'd instead do far
   more).

Between the two approaches, both are purists' view, I'd prefer the
former, but from that stance, the conclusion would become that there
is no need to do anything, which may be a bit unsatisfactory.

> Since it will usually be added back in by cleanup_message() anyway, I
> think it's OK to just add it preemptively. The exception would be if the
> user asked for no cleanup at all. So making it conditional on
> cleanup_mode would work, whether -F or not.
>
> I suppose that does mean people turning off cleanup mode would get a
> message without a newline from fmt_merge_msg(), though, which is perhaps
> unexpected.
>
> So maybe just keeping the newline there, as you suggest, is the best
> way.

Hmph.

If the user tells us "refrain from touching my message as much as
possible" and feeds us a proposed log message that ends with an
incomplete line, I would think they expect us not to turn it into a
complete line, and I would think doing this change only when cleanup
is in effect would make sense.  This is especially true for users
who do not let any hooks to interfere.  They used to get their
incomplete lines intact, now their incomplete lines will
unconditionally get completed.  I am not sure if I would want to
defend this change from their complaints.
