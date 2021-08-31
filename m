Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAB8C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 17:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A0C610E9
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 17:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbhHaRpg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 13:45:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62847 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhHaRpf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 13:45:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BEDECED807;
        Tue, 31 Aug 2021 13:44:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iIc843vk3b/DSC341sw2dCgNfQQa6xdFBNBPlG
        HdrvE=; b=TZjSo5DlIPUbDS6zY7J4xdzFjSi2ku09n6OVddHWbnx7RgvRBKBySA
        kVXIRHw74VvYr7ldPgynPgXhOmhhGvyWNq2NnrPIlMjlacMJZlVY5exoPNnxzdpG
        +97pBBuK/Wwv5jYsUIukFDHsbOzr2GEXnaSeq2E3N7+B/GxN2wfVs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B67DCED806;
        Tue, 31 Aug 2021 13:44:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 45393ED805;
        Tue, 31 Aug 2021 13:44:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
References: <xmqqo89jbf49.fsf@gitster.g> <YSko4OwwPb7MwEMa@nand.local>
        <xmqq4kb797xc.fsf@gitster.g> <YSwhNxqAS8JajA7p@nand.local>
        <xmqqfsur7otx.fsf@gitster.g> <YSwpsp/hQsPFnj+I@nand.local>
        <YS1XOMtj94BcI9HM@camp.crustytoothpaste.net>
        <xmqqmtoy1s9s.fsf@gitster.g> <YS1croR3etCfMQhR@nand.local>
        <xmqqmtoxwpad.fsf@gitster.g> <YS5bWMcXbODi+KmS@nand.local>
Date:   Tue, 31 Aug 2021 10:44:38 -0700
In-Reply-To: <YS5bWMcXbODi+KmS@nand.local> (Taylor Blau's message of "Tue, 31
        Aug 2021 12:39:52 -0400")
Message-ID: <xmqq8s0hv795.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D77A496-0A83-11EC-A769-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> After (the rerolled version of) this series, we'll be in a state where:
>
>   - `git multi-pack-index` will not run when outside of a Git
>     repository.
>   - The `--object-dir` argument will only recognize object directories
>     belonging to an alternate of the current repository.
>   - Using `--object-dir` to point to a repository which uses a
>     different hash than the repository in the current working directory
>     will continue to not work (as was the case before this series).

Hmph, re-reading the document for midx:

    --object-dir=<dir>::
            Use given directory for the location of Git objects. We check
            `<dir>/packs/multi-pack-index` for the current MIDX file, and
            `<dir>/packs` for the pack-files to index.

why does it matter if we are in a repository in the first place?
It's not like we combine the objects from the specified object dir
and our local object store (if that were the case, these two object
stores must be compatible).

How old is --object-dir option and how widely is it used?  Can we
just remove it and have users go to the repository that uses it
as its object store with "git -C <there>" mechanism, or have we come
too far with this (apparently broken) design to make such a fix
infeasible?

Thanks.
