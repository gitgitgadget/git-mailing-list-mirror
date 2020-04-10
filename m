Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0431AC2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 20:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70EE20732
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 20:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yScaEI1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgDJUVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 16:21:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55701 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgDJUVU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 16:21:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69C65498E1;
        Fri, 10 Apr 2020 16:21:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0EjeRvmZy2y0LeAw/1G4eVKX0G8=; b=yScaEI
        1zXT/8B/GuiNRob+3Gzi4Y3J3Vkxesz3WYY9l5EJTC15A38sM4pfpEqSkKGbetgl
        AbeRsnVClTyb95iZvJG+0FANis/QgItLLm7wshYFRdh8j8w89GmnB8mcNNDwXVu2
        7KsznuveiwHzRYSrlAc5DgH1y0mRu/HTZ6I5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EwmAHPe3FDVJQvjJociV7rf2rv1s2vBG
        fACdzBjMW4/gTaPDvC9vY+6oPM7+W28Dz4pYdYgLwku9VLps6nyhjSygqEvGKFnU
        VzLJaga+emS2mI5dv7Qvzb4j17fCLYT6gACZ+MQhsUEX8SbudR9++BYKdhS2v1I1
        oKljRma01+E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 607CC498DF;
        Fri, 10 Apr 2020 16:21:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D1CF8498DD;
        Fri, 10 Apr 2020 16:21:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nathan Sanders <spekbukkem@gmail.com>
Subject: Re: [PATCH v2] mingw: cope with the Isilon network file system
References: <pull.756.git.git.1586427853403.gitgitgadget@gmail.com>
        <pull.756.v2.git.git.1586518136956.gitgitgadget@gmail.com>
Date:   Fri, 10 Apr 2020 13:21:17 -0700
In-Reply-To: <pull.756.v2.git.git.1586518136956.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 10 Apr 2020
        11:28:56 +0000")
Message-ID: <xmqqy2r3hz2a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D59D0242-7B68-11EA-8F6B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Nathan Sanders <spekbukkem@gmail.com>
>
> On certain network filesystems (currently encountered with Isilon, but
> in theory more network storage solutions could be causing the same
> issue), when the directory in question is missing,
> `raceproof_create_file()` fails with an `ERROR_INVALID_PARAMETER`
> instead of an `ERROR_PATH_NOT_FOUND`.

Queued.
