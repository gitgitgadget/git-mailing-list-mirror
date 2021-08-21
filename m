Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F74AC4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 04:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1590F611C4
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 04:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhHUEVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Aug 2021 00:21:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52519 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhHUEVW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Aug 2021 00:21:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E63F1144D83;
        Sat, 21 Aug 2021 00:20:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FVyoXsndrPEX4+q29kTyQEPOStUsi20uUYA10Y
        joXCE=; b=o6MOmG9E0Y24qi4awTq39+UxJGS5t4wFryXgnpFgXn0NS6M1x3YZ/g
        3l/KOsbcVabJU05MDy0lX+2YRtmPCsaGt0QcnRXFVDhJAdpqjoLzvlyg9fkh2c7F
        hmqk0ZTBPeYmbFOi7wk9YvV3im0S+4dEHrYLgkqhJAhQBp5RyzQGg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DE71C144D81;
        Sat, 21 Aug 2021 00:20:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 24C5E144D80;
        Sat, 21 Aug 2021 00:20:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/6] t1092: use ORT merge strategy
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
        <7cad9eee90bcee3cb98be5c7a2edaca5e855c157.1629220124.git.gitgitgadget@gmail.com>
        <xmqqzgte62ud.fsf@gitster.g>
        <b3c7e700-f36c-d58f-0c49-450444df8c63@gmail.com>
        <CABPp-BEtOWUGCcn3B0On80=tMZ_Re9ScHnBiwPPPFY=x2TwG5Q@mail.gmail.com>
        <xmqq7dgfu1zb.fsf@gitster.g>
        <CABPp-BHLw-h0oQLNwT+DAXeHZZfJRaiyoM+kDuqx_aT80-zM3w@mail.gmail.com>
Date:   Fri, 20 Aug 2021 21:20:35 -0700
In-Reply-To: <CABPp-BHLw-h0oQLNwT+DAXeHZZfJRaiyoM+kDuqx_aT80-zM3w@mail.gmail.com>
        (Elijah Newren's message of "Fri, 20 Aug 2021 17:20:34 -0700")
Message-ID: <xmqqwnofsa24.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22C84DD2-0237-11EC-A373-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> It seems that merge_recursive() and merge_ort_recursive() are
>> interface compatible and the latter can serve as a drop-in
>> replacement for the former?
>
> Yes, merge_ort_recursive() and merge_ort_nonrecursive() were meant as
> interface compatible drop-in replacements for merge_recursive() and
> merge_trees(), to make it easy to switch callers over.
>
> There is no such replacement for merge_recursive_generic(), though,
> and builtin/{am, merge-recursive, stash}.c will all need to be
> modified to work with merge-ort.

But merge_recursive_generic() eveantually calls into merge_recursive();
as long as you hook into the latter, you're covered, no?
