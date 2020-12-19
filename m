Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D075C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 17:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D21A206CB
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 17:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgLSRev (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 12:34:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51039 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgLSRev (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 12:34:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C697C9F9B7;
        Sat, 19 Dec 2020 12:34:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JhUCz2S3orC/rtS/ouo/Zr/S3/Q=; b=oR/MZS
        DAoUY9RkQT8RCf67+v/tFnmPrUqhNor/QDut2IFSlqJrszR2JV1lgcPL/wB9ZaCP
        oBKVsWsBmpaWbRkHLw5OA8SVV0OmejIh9oaV5m9YzMwmhBVavWHXGzHmNu3cfj10
        iSz73d7gTcgEcz+3Jgh30QRV4sGtfwSlZCGUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F8fWBmP2VeClUR7Tgxw28r6YaeW/wJ2T
        j3FZCP2Dzv98AM/21ls+pZUrlRlDcFfqmlJByEyw/7VgWy9PmidnRKlxTF1UErC2
        Osol4XM9Tccwaq/Q8UA6PVphs7qjYlq9pczshCTfn+ckfIr7Zd0sLNT2/FQn7QXk
        9A66Wj215Dg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BEBED9F9B6;
        Sat, 19 Dec 2020 12:34:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3881B9F9B5;
        Sat, 19 Dec 2020 12:34:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] checkout -p: handle tree arguments correctly again
References: <pull.819.git.1608389760050.gitgitgadget@gmail.com>
        <X94WHmY3Cd30wqan@generichostname>
Date:   Sat, 19 Dec 2020 09:34:07 -0800
In-Reply-To: <X94WHmY3Cd30wqan@generichostname> (Denton Liu's message of "Sat,
        19 Dec 2020 07:02:54 -0800")
Message-ID: <xmqqczz5punk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65FE96D8-4220-11EB-BFCF-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Hi Dscho,
>
> On Sat, Dec 19, 2020 at 02:55:59PM +0000, Johannes Schindelin via GitGitGadget wrote:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> 
>> This fixes a segmentation fault.
>> 
>> The bug is caused by dereferencing `new_branch_info->commit` when it is
>> `NULL`, which is the case when the tree-ish argument is actually a tree,
>> not a commit-ish. This was introduced in 5602b500c3c (builtin/checkout:
>> fix `git checkout -p HEAD...` bug, 2020-10-07), where we tried to ensure
>> that the special tree-ish `HEAD...` is handled correctly.
>> 
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Argh, thanks for catching this. The patch looks obviously good.
>
> Since I'm the one who introduced the bug in the first place:
>
> 	Acked-by: Denton Liu <liu.denton@gmail.com>

The fix looks obviously correct to me.  Thanks, both.

Will queue for fast-tracking.

