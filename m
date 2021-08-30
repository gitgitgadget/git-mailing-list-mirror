Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBC0C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B81360F5B
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbhH3Uww (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:52:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60522 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbhH3Uwv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 16:52:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46763D4815;
        Mon, 30 Aug 2021 16:51:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SWt6SaI6yPbkGWw/wJwk7wopKZ+EcLZzA7xkqa
        LSJDk=; b=a6Iv3Oa3sgiW6RCDg6+cwh/3HcKlYoDxLF2tTDIFDBNHAfFxyqYDbh
        R34Eov1oUZ839rPzgAUBaFy4TTbjjSMzT4BIdiH9nOgpPYUfeXZR6o1bSr1gtc62
        kVOw0xhwbXnvDPrSOjDKTgCBXX5wqYYGwmV8oLmgzFsh1mdY1OEQQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D537D4814;
        Mon, 30 Aug 2021 16:51:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BBC77D4813;
        Mon, 30 Aug 2021 16:51:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 1/4] test-ref-store: tweaks to for-each-reflog-ent format
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
        <d48207d6858502f04fd501a24ff7c2a80062dfbe.1630334929.git.gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 13:51:56 -0700
In-Reply-To: <d48207d6858502f04fd501a24ff7c2a80062dfbe.1630334929.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 30 Aug 2021
        14:48:45 +0000")
Message-ID: <xmqqpmtu3bbn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D1E1976-09D4-11EC-9A9D-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Follow the reflog format more closely, so it can be used for comparing
> reflogs in tests without using inspecting files under .git/logs/

I find the above written in clear language that conveys what it
wants to say unclearly X-<.

I am guessing, from the patch text, that the callback function to
refs_for_each_reflog_ent() and its _reverse() variant takes a "msg"
parameter, which is expected to include a terminating LF at its end,
but some backends omits the LF, and this change is to work around it
by conditionally adding (or refraining from adding) LF in the
each_reflog() function that is used for testing.

Is that what is going on?  Or is it "even within a single backend,
sometimes we get message with terminating LF and sometimes without"?

In any case, it changes the output.  We used to spend two output
lines per record in tests for these two functions, but now we assume
we get one each line per one reflog entry.  Which may be OK as far
as these tests are concerned, but does this leave problems with the
real world callbacks?  Do the real callers to for_each_reflog_ent()
and for_each_reflog_ent_reverse() also now need to cater to this "we
sometimes get LF at the end, we sometimes don't" differences by
having a similar logic as we see in the updated each_reflog() in
this patch?

Shouldn't we be instead making sure that the callback functions get
the msg argument in a consistent way, whether it is with or without
terminating LF, instead of forcing the callers to cope with the
differences like this each_reflog() function does in this patch?

Thanks.
