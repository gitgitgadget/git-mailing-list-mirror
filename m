Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF16EC43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 17:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiGARrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 13:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiGARrf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 13:47:35 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5A036B74
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 10:47:33 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF30213CB55;
        Fri,  1 Jul 2022 13:47:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O6A2TJOQ7XQRqCVqDo3dBBV2v2oRdQSaNZZDCt
        HvWik=; b=q9e5NzWqMVzHAFxoekoHiXKMuRm/YolIh9y9HhqMjOcjw1M8mBzo9o
        Fz9w6Pddvxk/50fwzIKhcj7eNF9zzdtg+28b0QTNUmjt2MTfOZeNy/anfpNo8SBd
        rGM962XPu6rn72v1hRBAs9wgokT3f4Oa/JZ5q+ZEO+5LP+8BrEtfM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E56EC13CB54;
        Fri,  1 Jul 2022 13:47:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 440E813CB53;
        Fri,  1 Jul 2022 13:47:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 0/5] Avoid spawning gzip in git archive
References: <pull.145.git.gitgitgadget@gmail.com>
        <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
        <nycvar.QRO.7.76.6.2206141043150.353@tvgsbejvaqbjf.bet>
        <0aa5c101-06bf-325c-efbc-6b4ef38616c5@web.de>
        <ps52p06s-01nr-4ss2-r802-6nsp5nqq5199@tzk.qr>
        <038r075o-5s5r-9sop-5o02-8s84428o0r54@tzk.qr>
        <Yr8gZT6dbCpzaR9n@coredump.intra.peff.net>
Date:   Fri, 01 Jul 2022 10:47:28 -0700
In-Reply-To: <Yr8gZT6dbCpzaR9n@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 1 Jul 2022 12:27:17 -0400")
Message-ID: <xmqqy1xc913j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E0F752BE-F965-11EC-80CD-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That will spend quite a lot of time doing hash-lookups for each tree
> entry. A better raw zlib test might be:
>
>   git cat-file --batch --batch-all-objects --unordered >/dev/null
>
> which will just dump each object, and should mostly be zlib and delta
> reconstruction (the --unordered is important to hit the deltas in the
> right order).

;-)

I like --unordered has the meaning "use the order Git likes" (which
is probably the packfile offset order, which we optimize for
minimizing seek during delta reconstruction).

