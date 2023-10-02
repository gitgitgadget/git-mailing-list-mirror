Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE177E7490C
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 18:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjJBSzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 14:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJBSzE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 14:55:04 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A36AC
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 11:55:02 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 41C092871E;
        Mon,  2 Oct 2023 14:54:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=lNdF1ZemjxMEKOp/g1Qkp/5Ue5SWUVeNP51w9T
        PPzEM=; b=kWZfF2guhl9A8ayverQkdOaOjXSz8TLUQqocpAp4jusgOITPyHAqJK
        TVacPpyUAPRRIQByU4SDxC4lVqlbCry+0h+VqK0adVanoqsRdwQt3JivjtB44GS5
        QaL0mFDzW+/4ZepYS9ASIxLJ2zfRz+2uzTlLyQI/8flc7UmxYfL88=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3A7CD2871D;
        Mon,  2 Oct 2023 14:54:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 484A92871C;
        Mon,  2 Oct 2023 14:54:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH] diff: fix --merge-base with annotated tags
In-Reply-To: <20231001151845.3621551-1-hi@alyssa.is> (Alyssa Ross's message of
        "Sun, 1 Oct 2023 15:18:45 +0000")
References: <20231001151845.3621551-1-hi@alyssa.is>
Date:   Mon, 02 Oct 2023 11:54:52 -0700
Message-ID: <xmqq4jj84zyb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C948770-6155-11EE-8409-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alyssa Ross <hi@alyssa.is> writes:

> Checking early for OBJ_COMMIT excludes other objects that can be
> resolved to commits, like annotated tags.  If we remove it, annotated
> tags will be resolved and handled just fine by
> lookup_commit_reference(), and if we are given something that can't be
> resolved to a commit, we'll still get a useful error message, e.g.:
>
>> error: object 21ab162211ac3ef13c37603ca88b27e9c7e0d40b is a tree, not a commit
>> fatal: no merge base found

Interesting.  0f5a1d44 (builtin/diff-index: learn --merge-base,
2020-09-20) claims that it took inspiration from "git diff A...B"
but forgot that it needs to accept any commit-ish.

With a devil's advocate hat on, I have to wonder if it is really a
useful error message to spew a long hexadecimal string when the user
would certainly have gave a more mnemonic HEAD^{tree} or something,
but the original message does not say which command line argument it
did not like anyway, so the patch is a net improvement.

Will queue.  Thanks.

