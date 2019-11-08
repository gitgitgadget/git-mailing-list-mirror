Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEB7D1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 05:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfKHFBM (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 00:01:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50116 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfKHFBM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 00:01:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F7369BD8A;
        Fri,  8 Nov 2019 00:01:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h/h1Wkp91k6vQm/vsVNjybbVQCg=; b=Zn6J6E
        llgcO105zylsYQXWQYSvoO/gcGi2G/uXrpVxhlDritdrG4a1yMxr9UtrcMo7KXgD
        lwPVErgMC9mrQs1qnwFiFHnTjpQq8BCz55EE6VxHBkTOKQsSs9m7HJtpkTD9Jx61
        q35gTAKbYcsni1DHRQxfxWqHaGZWpJWaE+DYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aGdDJYqome34eNuHB1eACKMQiV9sQXlQ
        T9h2B68fw0cBItUX2Qfi7PyVY77PYljLAQaRsh5ZcVjcsh/Cr0zjxPfcXqUst/a7
        nAT/dmm5IyCL/djYH5kkbYQKLtdHsJLQqhuk+WeZzrHowMAfaRRhqi/F/Oig6WJX
        1pqVpqU/VgE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 77D449BD89;
        Fri,  8 Nov 2019 00:01:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A60F19BD88;
        Fri,  8 Nov 2019 00:01:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Daniel Ferreira <bnmvco@gmail.com>
Subject: Re: [PATCH v5 3/9] built-in add -i: implement the `status` command
References: <pull.170.v4.git.gitgitgadget@gmail.com>
        <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
        <6aaa0de4f4564b1d8da0691851dac0d22f87e565.1572869730.git.gitgitgadget@gmail.com>
Date:   Fri, 08 Nov 2019 14:01:05 +0900
In-Reply-To: <6aaa0de4f4564b1d8da0691851dac0d22f87e565.1572869730.git.gitgitgadget@gmail.com>
        (Daniel Ferreira via GitGitGadget's message of "Mon, 04 Nov 2019
        12:15:23 +0000")
Message-ID: <xmqq8sorner2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C628E0C2-01E4-11EA-B7EB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Daniel Ferreira <bnmvco@gmail.com>
>
> This implements the `status` command of `git add -i`. The data
> structures introduced in this commit will be extended later, as needed.
>
> At this point, we re-implement only part of the `list_and_choose()`
> function of the Perl script `git-add--interactive.perl` and call it
> `list()`. It does not yet color anything, or do columns, or allow user
> input.

OK, so that is why we unconditionally do the status thing directly
inside run_add_i() and nothing else.  Makes sense.

> Over the course of the next commits, we will introduce a
> `list_and_choose()` function that uses `list()` to display the list of
> options and let the user choose one or more of the displayed items. This
> will be used to implement the main loop of the built-in `git add -i`, at
> which point the new `status` command can actually be used.

Very well written.
