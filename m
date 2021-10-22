Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9A6C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 22:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2024B61059
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 22:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhJVWFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 18:05:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51503 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbhJVWFR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 18:05:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C312159EE2;
        Fri, 22 Oct 2021 18:02:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BiSJ2bbhNHWyKpAVqwptwNs2wMdRxt+MThf/ii
        yLEII=; b=NiJPs6nY9L/LObGpQEOnBtLH4VSpa88z6msmGy9tiaS+NI6Y+fOEf5
        ypsYT0JNsaFcvg5R35BxooET3s7tuFef9DO7Qstxq4s2dZz+BGPkcreZNz5VLYOP
        f60PTm8N1FXxnRSZI6XOCE1rSdkbnNygigUiJ2QUmaKSMkMtqXL3A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 55819159EE1;
        Fri, 22 Oct 2021 18:02:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 150EA159EE0;
        Fri, 22 Oct 2021 18:02:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kalyan Sriram" <kalyan@coderkalyan.com>
Cc:     "Matheus Tavares" <matheus.bernardino@usp.br>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git" <git@vger.kernel.org>
Subject: Re: Git submodule remove
References: <0101017ca3e30c39-f111f739-4db7-4c1e-aff2-3ee50f546591-000000@us-west-2.amazonses.com>
        <YXHdaQ98GJiFj0OK@camp.crustytoothpaste.net>
        <xmqqbl3ihu6l.fsf@gitster.g>
        <CAHd-oW5PfygyNsRWGg4_W2pxR_HbePvguKRf-bK9RtY3cuAX9g@mail.gmail.com>
        <xmqqee8egddw.fsf@gitster.g>
        <0101017ca60e5ffd-9563fafd-86f6-443d-9cbe-e07203caacba-000000@us-west-2.amazonses.com>
Date:   Fri, 22 Oct 2021 15:02:54 -0700
In-Reply-To: <0101017ca60e5ffd-9563fafd-86f6-443d-9cbe-e07203caacba-000000@us-west-2.amazonses.com>
        (Kalyan Sriram's message of "Fri, 22 Oct 2021 03:32:12 +0000")
Message-ID: <xmqq4k98en01.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CFC2E042-3383-11EC-BD7B-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kalyan Sriram" <kalyan@coderkalyan.com> writes:

> "git rm" deletes the submodule directory completely and modifies
> .gitmodules, effectively removing the submodule. However, it leaves the
> entry in .git/config dangling, which is annoying.

The entry is not dangling.  It is there to be used when you go back
in history.

> "git submodule deinit" (which I didn't know existed until I just read the man
> page) deletes all contents of submodule directory, but leaves the 
> (empty) submodule directory itself intact. It DOES delete the entry in
> .git/config, but leaves a dangling entry in .gitmodules, so the next
> "git submodule update --init --recursive" registers and populates the
> submodule again.

"deinit" is *not* about remove a submodule.  A project can be
checked out and used with or without its submodules instantiated,
and "git submodule init" is a way to instantiate it.  "deinit" is
its opposite.  As far as the history (which has already been
recorded in the repository, and the history that will be recorded
in the repository starting from that state) is concerned, the
submodule is there---it's just that you are not interested in it and
chose not to check it out.

So "git rm" seems to be doing exactly what "git submodule rm" should
be doing, nothing more, nothing less.
