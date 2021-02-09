Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39869C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 19:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2C964EC8
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 19:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhBITOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 14:14:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50254 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbhBITFe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 14:05:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09C0BAFE49;
        Tue,  9 Feb 2021 13:59:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ujclM2M191oD2puA6tl6lY2o6L4=; b=L1iSKp
        My5FyYzgJQNCZvKYetVqBoBiI78ja/yIFN6AgwvwwBRnxLvNmSz/WFiB/clnZZUq
        9h/uZAsIU7Z4GrbMZ39h7/UJoOUJZRoMSObNdkuxz9Ye82MaCQVtph5RFIDqlnzA
        yMKThLN5QMFVUzWT+OYP4kZOG72naRe32vzAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EBtJblCBF0gabLkNTsaWPMWuVV9KkEeF
        3KM3KIUw3NL3+9Qy+13yT6aV03OGHjq5onkhdP/Fdzrl2qks0SASc6rmlzLqr8pC
        zY7l2hDQwxiaGMkIo3/uOdgu2bR9blbEYbGwJIX9+y5lcVr1DblcuGG1N1c2wpLo
        ZknbtOIsz74=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 00C80AFE48;
        Tue,  9 Feb 2021 13:59:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7E024AFE47;
        Tue,  9 Feb 2021 13:59:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/4] diffcore-rename: guide inexact rename detection
 based on basenames
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
        <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
        <ce2173aa1fb7ac3830bf8856a14558446e16a3dd.1612870326.git.gitgitgadget@gmail.com>
        <48a208c2-75fe-773e-aa2a-12a90dd06ddd@gmail.com>
        <CABPp-BFfF5rxbHwP1xnr63fPmp2=NkTZ-r0=FVZ1oVhAZD_s9w@mail.gmail.com>
Date:   Tue, 09 Feb 2021 10:59:40 -0800
In-Reply-To: <CABPp-BFfF5rxbHwP1xnr63fPmp2=NkTZ-r0=FVZ1oVhAZD_s9w@mail.gmail.com>
        (Elijah Newren's message of "Tue, 9 Feb 2021 09:41:16 -0800")
Message-ID: <xmqqa6sd2hk3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F726EF82-6B08-11EB-A7D2-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Since I didn't know what to use, though, and I didn't want to get a
> different set of numbers for the final commit message on the speedup
> achieved if I'm just going to throw them away and recompute once I
> find out what Junio wants here, I did intentionally set the
> computation to just give us minimum_score, for now.

I thought Derrick earlier suggested "half-way", which I found was
probably a reasonable starting point.  So instead of 5, divide by 8
and multiply both by 4 or something and perhaps allow a debugging
knob to tweak to see what works the best in the real histories
during the refinement phase of the feature?



