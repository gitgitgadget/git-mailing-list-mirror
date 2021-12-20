Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD2CC433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 19:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240688AbhLTTHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 14:07:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55952 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbhLTTGr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 14:06:47 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F0AC10F108;
        Mon, 20 Dec 2021 14:06:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pmlFux0s9sTnFwoUDWXMia/ds8t+7huHsoHp8B
        kXMOE=; b=tTGVOzlnBDp9io4ZykIVtBoWeyh9r5o2LRGdbhDYaTdyIIPDiUMuLa
        gGbl6K8e7oBtYavCQeoFqFzvFcx7fD+aWVHXZ3rpzAR2WNheacnydwFYwlP4DRli
        rT95yACG57u4HZgc56bYdWCd81vONNgRiy5cadITUbrRjw5CwyiHk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 038C110F107;
        Mon, 20 Dec 2021 14:06:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5FDC410F106;
        Mon, 20 Dec 2021 14:06:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/13] init: unconditionally create the "info" directory
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
        <patch-03.13-784b7947512-20211212T201308Z-avarab@gmail.com>
        <db6f47a3-0df3-505b-b391-6ca289fd61b5@gmail.com>
        <211220.86tuf3utv9.gmgdl@evledraar.gmail.com>
        <d2399072-ce9d-b654-42b4-d08d973c488e@gmail.com>
Date:   Mon, 20 Dec 2021 11:06:43 -0800
In-Reply-To: <d2399072-ce9d-b654-42b4-d08d973c488e@gmail.com> (Derrick
        Stolee's message of "Mon, 20 Dec 2021 12:39:53 -0500")
Message-ID: <xmqq1r27xfi4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9825FC6-61C7-11EC-BA92-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> What I _am_ saying is important is that if we are trying to write
> a file to a known location and its parent directory doesn't exist,
> then we should create it. Not doing so is a bug and should be
> fixed, no matter how rare such a thing is to occur. As you've
> shown, it is not required to have an info directory until we need
> one (e.g. for sparse-checkout or an excludes file).
>
> If you're not planning to add that to this series, then I'll add it
> to my list. I do think it would fit well into this one, though.

Historically, "git init" relied on the templates to create necessary
directories, and the subcommands in turn learned to depend on the
presence of these directories.

At the same time we allowed that the templates can be customized by
the end users.  It was a bug, exactly for the reason you said above.

Before we talk about creating 'info' directory directly in "git
init" or anything done in this topic, we should fix the existing
bug, and the right fix is to use safe-create-leading-directories.

With that, it may become unnecessary to have this "create 'info' in
'init'".



