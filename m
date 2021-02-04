Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3502EC433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 23:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC2B264E4E
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 23:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhBDXAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 18:00:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58769 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhBDXAH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 18:00:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 62E651242C5;
        Thu,  4 Feb 2021 17:59:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RrXEza+PUV8nuqXX7waI77PMVO4=; b=sxrOEo
        irDcBMvgr84J0l0SRW+1fRrCLPRhv5zPjQnim2joGNQY/a2ScQeC3efbkqDXmwAT
        Axuhe/q7FjVrFoDRZ0vjskP9yKaCKCkVphrUaXXpF7PF0omNvaTWNYVviEP/Uq7q
        J/R/pJLZfgaA1St23Kc8uFDjFKDGZKVmD4AN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dXsIDqp4S8upGy08mHOCT8/1ci3ZP/G4
        QNGy0BaZFAn3IJCbHw5uuViFrj6mrweXyZdFN+Ot84K/tRE1hZjdY9uvxOMPrTcs
        W5QCx/SyBPTBKhZtc6pzX72hOVsNqHOoI6YrtWLyiyXiXYb8qgaqTJLrKbiNxYxG
        qVNncqBxgEE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 473A81242C4;
        Thu,  4 Feb 2021 17:59:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7F7E01242C3;
        Thu,  4 Feb 2021 17:59:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 09/17] midx: return success/failure in chunk write
 methods
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <b3cc73c22567ed89e2537ffaaa04f82a436d9802.1611759716.git.gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 14:59:22 -0800
In-Reply-To: <b3cc73c22567ed89e2537ffaaa04f82a436d9802.1611759716.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 27 Jan 2021
        15:01:48 +0000")
Message-ID: <xmqqlfc34eyd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A005F6E6-673C-11EB-8EC0-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Historically, the chunk-writing methods in midx.c have returned the
> amount of data written so the writer method could compare this with the
> table of contents. This presents with some interesting issues:
>
> 1. If a chunk writing method has a bug that miscalculates the written
>    bytes, then we can satisfy the table of contents without actually
>    writing the right amount of data to the hashfile. The commit-graph
>    writing code checks the hashfile struct directly for a more robust
>    verification.
>
> 2. There is no way for a chunk writing method to gracefully fail.
>    Returning an int presents an opportunity to fail without a die().
>
> 3. The current pattern doesn't match chunk_write_fn type exactly, so we
>    cannot share code with commit-graph.c
>
> For these reasons, convert the midx chunk writer methods to return an
> 'int'. Since none of them fail at the moment, they all return 0.

OK, that makes sense.

In this step I see the same "f->total + f->offset" sprinkled in some
places, but they will all go away in the "midx: use chunk-format API
in write_midx_internal()" step, so it is not such a huge deal.

Thanks.
