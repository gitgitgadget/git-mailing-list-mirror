Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A37C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 22:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CCA223D20
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 22:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389021AbgLIWh5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 17:37:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61928 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388604AbgLIWhv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 17:37:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48C5C88F94;
        Wed,  9 Dec 2020 17:37:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xjJZuQf9Ys72Xp9TFUUC72mlOjA=; b=ruFPUz
        pKH27hYTD8yIwJKEz5ZZ8oBuu5nYTaeBgfnKz7epL/CHd8dRzdA9CHSkgyH3KKLR
        6NApkB9CYgeYKvJ39s+nyeIl18oGAIvnPkIEx/W0hSpOw74EyfgpnfoT4z1Yjp6T
        JoqHrtj4YRzmebsPw2WqFL1QCBdQxft/+Owik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rEoOvwhnsArdzqH8MiYRMsWN0zgLoima
        XfsLlU82fYOlvyl1DXdrMhSv0t3SWE3iF9wi4af7n4q6NXSmMs1zj6LwUU+RoITK
        5qJnZL2DZOjzGhX/2N1WTrARVUjGPPgxf390fdsqwIxOPSrmzK+budi2o+ALPg/o
        8syU9Gh3lAU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D87388F92;
        Wed,  9 Dec 2020 17:37:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A8FA888F90;
        Wed,  9 Dec 2020 17:37:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 2/2] hooks: allow input from stdin for commit-related
 hooks
References: <pull.790.v4.git.1605819390.gitgitgadget@gmail.com>
        <pull.790.v5.git.1607544408.gitgitgadget@gmail.com>
        <25db4da3cd5fc7e81141078261086c392541c5d1.1607544408.git.gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 14:37:05 -0800
In-Reply-To: <25db4da3cd5fc7e81141078261086c392541c5d1.1607544408.git.gitgitgadget@gmail.com>
        (Orgad Shaneh via GitGitGadget's message of "Wed, 09 Dec 2020 20:06:48
        +0000")
Message-ID: <xmqq360e1u9a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10798F8C-3A6F-11EB-B419-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> It's important to note that the hook author should be aware that stdin
> is not always applicable. For example, when running from IDE. This can
> be checked by isatty on stdin. The hooks should handle cases of closed
> input, and possibly fall-back to GUI input, or have sane defaults with
> a message to the user on this case.

I think this point was already brought up in the review on previous
rounds, but when the hook needs to check the standard input anyway,
it probably is a better design to close and have the hook open tty
if needed, isn't it?  I do not recall I saw a satisfactory answer to
that question.

> Allow stdin only for commit-related hooks. Some of the other hooks pass
> their own input to the hook, so don't change them.
>
> Note: If pre-commit reads from stdin, and git commit is executed with
> -F - (read message from stdin), stdin cannot be passed to the hook,
> since it will consume it before reaching the point where it is read for
> the commit message.

It is unclear what that Note is trying to achieve.  Is it describing
a known-bug in this implementation (if so, we'd probably need to
update the documentation to mention this known regression)?  Is it
describing a reason why certain part of patch was done in a certain
way that is not described in this message (e.g. when -F option is in
effect the standard input stream is closed when invoking a hook)?

Thanks.
