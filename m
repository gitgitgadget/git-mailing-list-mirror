Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A146DC433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 23:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbiCIXtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 18:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiCIXtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 18:49:09 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAECBE1FD
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 15:48:08 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11C6212556E;
        Wed,  9 Mar 2022 18:48:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9s1uIOmTWDGV7CG/WeSBihaNc3TzlJsxSaccsj
        sKPJw=; b=ra5OR410RES4dXKB1Cs1KEjn2Q8BfKBpkZE5HplvmLG19SBNPRlKPS
        f8jLsYugMMskekokQu2fzyhdyM2yxPXCkueHLJeUFZr82PcLb5iW6ChGRgblvt7D
        8aaDC77ZLs7CkkPmpOEX5Xthl9GoNxRYAD9PpfCtOsmADKRhyLCYc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E97F712556D;
        Wed,  9 Mar 2022 18:48:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 402A912556C;
        Wed,  9 Mar 2022 18:48:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        sandals@crustytoothpaste.net,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v5 2/5] core.fsyncmethod: add writeout-only mode
References: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
        <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
        <da8cfc10bb4bfa473619d8d737c3aa160643ccf7.1646866998.git.gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 15:48:06 -0800
In-Reply-To: <da8cfc10bb4bfa473619d8d737c3aa160643ccf7.1646866998.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Wed, 09 Mar 2022 23:03:15
        +0000")
Message-ID: <xmqqv8wmk7rd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E861B64-A003-11EC-B11D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> This commit introduces the `core.fsyncMethod` configuration
> knob, which can currently be set to `fsync` or `writeout-only`.
>
> The new writeout-only mode attempts to tell the operating system to
> flush its in-memory page cache to the storage hardware without issuing a
> CACHE_FLUSH command to the storage controller.
>
> Writeout-only fsync is significantly faster than a vanilla fsync on
> common hardware, since data is written to a disk-side cache rather than
> all the way to a durable medium. Later changes in this patch series will
> take advantage of this primitive to implement batching of hardware
> flushes.
>
> When git_fsync is called with FSYNC_WRITEOUT_ONLY, it may fail and the
> caller is expected to do an ordinary fsync as needed.
>
> On Apple platforms, the fsync system call does not issue a CACHE_FLUSH
> directive to the storage controller. This change updates fsync to do
> fcntl(F_FULLFSYNC) to make fsync actually durable. We maintain parity
> with existing behavior on Apple platforms by setting the default value
> of the new core.fsyncMethod option.
>
> Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> ---

OK.  This seems to be quite reasonable in that the pieces of code
that use fsync_or_die() do not have to change at all, and all of
them will keep behaving the same way.  In other words, the "how" of
fsync is very much well isolated.

Nice.
