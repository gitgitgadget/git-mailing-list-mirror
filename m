Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA4BC12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 22:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A79FA6115B
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 22:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbhGPWQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 18:16:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60896 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhGPWQn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 18:16:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF5B7D3175;
        Fri, 16 Jul 2021 18:13:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zICbq8o+xI37GSu5mDK64xFLeveRJY52SwK0cM
        ov3+Y=; b=UOIIgJHP3tPa5JM6fOGkDNa7JOP8Q7JZzJD4VEyte6sR64pMWd9RYc
        8gknmKbvk7tKuaRO3fHacivYZPsbkcUHuE60+zsz+EkbAIEYsNBrrSngFVyvMqEQ
        K41kD2SX6p/i3BPC+nDx2jwryRRjuSGmaMDi0lcFx/ZGJFjSt31xg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D79E7D3174;
        Fri, 16 Jul 2021 18:13:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E074D3173;
        Fri, 16 Jul 2021 18:13:45 -0400 (EDT)
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
        <xmqq8s26q9ot.fsf@gitster.g>
        <YPH1qKMPOqhCzp4Y@coredump.intra.peff.net>
Date:   Fri, 16 Jul 2021 15:13:44 -0700
In-Reply-To: <YPH1qKMPOqhCzp4Y@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 16 Jul 2021 17:10:00 -0400")
Message-ID: <xmqqo8b1q547.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 164A8978-E683-11EB-9271-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> which would cover that case. But Phillip mentioned that our own
> fmt_merge_msg() does not include a newline. So it would not be the user
> feeding us an incomplete line, but rather Git feeding it.
>
> And that was
> what I suggested should be corrected (which I suppose would be in
> addition to correcting lines from the user).
>
> However, I see a call to strbuf_complete_line() at the end of
> fmt_merge_msg(), so I am puzzled about what he meant.

Whew.  You got me worried.  Yeah, if fmt_merge_msg() is not
terminating its output, we should fix that, but I do not see such a
breakage in the current code, either.

Thanks.
