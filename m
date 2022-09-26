Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903D0C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 22:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiIZWIC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 18:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiIZWIC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 18:08:02 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549B69FAAC
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 15:08:01 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A7C115D3F9;
        Mon, 26 Sep 2022 18:08:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lvOVJup+V5wyIPepjyJimoQrcuVMs8y253GZi9
        qiYTQ=; b=sig9hvKBQrXago+/9timULxfPSWU9GLut+cMNmiFl45wAJe/H/cKJX
        tOoeo42rtumlLOQ8z0QmhVvTDeBjC71l6/Smcm8pmuj5bQzq4EOIMhgj1Cl2wAi0
        v5bLHSZSGKhYeAQ9B8p6oqUR3U/Ws7QTWS74kZHGkBcaa7lutJMZg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D62515D3F8;
        Mon, 26 Sep 2022 18:08:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6AD9515D3F7;
        Mon, 26 Sep 2022 18:07:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 2/2] merge-ort: return early when failing to write a
 blob
References: <pull.1362.v3.git.1663875999939.gitgitgadget@gmail.com>
        <pull.1362.v4.git.1664229348.gitgitgadget@gmail.com>
        <087207ae0b0932fcec9aa25e97bbe9227eff81cb.1664229348.git.gitgitgadget@gmail.com>
Date:   Mon, 26 Sep 2022 15:07:58 -0700
In-Reply-To: <087207ae0b0932fcec9aa25e97bbe9227eff81cb.1664229348.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 26 Sep 2022
        21:55:48 +0000")
Message-ID: <xmqq5yh9bxhd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE9BF24A-3DE7-11ED-B26C-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In the previous commit, we fixed a segmentation fault when a tree object
> could not be written.
>
> However, before the tree object is written, `merge-ort` wants to write
> out a blob object (except in cases where the merge results in a blob
> that already exists in the database). And this can fail, too, but we
> ignore that write failure so far.

Nice find.

As long as we create at least one "new" blob the repository has not
seen, we have a chance to exit before we attempt to write a tree
object (and notice a failure).  Checking the return value of
process_entry() for failures is a good thing to do.

Will replace.  Thanks.
