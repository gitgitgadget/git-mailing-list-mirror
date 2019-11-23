Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58696C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 02:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2234020707
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 02:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GOzDOspZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfKWCCg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 21:02:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62593 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfKWCCg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 21:02:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5083919E10;
        Fri, 22 Nov 2019 21:02:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HBieYuK2muKD/gci5NLsb603Ny8=; b=GOzDOs
        pZwznAbf+HZYBS+rWDvKwsi7AUZlJRYvDaQv8p9oSSvpwNIDhxb3mht6fLom9+cL
        UGKcQmJPnk7x1xZmMLTxn+Owej7SSVGUEv4EuaKvjlKIz4kKRFUUM9pqXvCcqKk1
        Un31rdkVtAypNCseuIPT/DXW/NKPhiDLIhI1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Pwws4J6ZsA5r1ujsqhL1ZI0lYCLToyft
        L5vxcWihQxFKaJZYyXqh/MMI2h4eeNqB1AzPQNpH28xA3hJ1GWWdpkYXm6K8+nmb
        IeJkrPdEdYHGKAdPEZD8t54hpa9zfpe+vGhGq0ubvWT+VU/C4WKcVLIKE5JgR1eL
        2NRKN0fPU7k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 47E5919E0F;
        Fri, 22 Nov 2019 21:02:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A760C19E0E;
        Fri, 22 Nov 2019 21:02:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/1] sequencer: fix empty commit check when amending
References: <pull.467.git.1574345181.gitgitgadget@gmail.com>
        <pull.467.v2.git.1574451783.gitgitgadget@gmail.com>
        <037f2b2975e06847443aef46939e3c712053dedf.1574451783.git.gitgitgadget@gmail.com>
Date:   Sat, 23 Nov 2019 11:02:32 +0900
In-Reply-To: <037f2b2975e06847443aef46939e3c712053dedf.1574451783.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 22 Nov 2019 19:43:03
        +0000")
Message-ID: <xmqqa78n2vuv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5051F854-0D95-11EA-B372-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This fixes a regression introduced in 356ee4659b ("sequencer: try to
> commit without forking 'git commit'", 2017-11-24). When amending a
> commit try_to_commit() was using the wrong parent when checking if the
> commit would be empty. When amending we need to check against HEAD^ not
> HEAD.

Thanks.  Will queue.
