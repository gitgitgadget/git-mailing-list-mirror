Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0D6C636C9
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 23:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 967A161178
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 23:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhGTWax (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 18:30:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57151 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhGTWak (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 18:30:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54BB2E97EB;
        Tue, 20 Jul 2021 19:11:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CWucLuRTyezjUJEec+aKq6/o4JER+Wl0CuKzfU
        gyxdI=; b=wgv+0c1s1xiwVDjM8ZbGyr2NlK73s7kOkgk+My7K3Iy17B/KkFPIga
        ch3rkvc/VtUDRPGeomRCX1bKK5K6Q/jFmtqNx7ayrmHKEF1aWMfPhbfmYlZ+/yIo
        PG/4ti4jfEN/94lFh5YMAbUY+MGSFiajppjiPFr67zFHvG/VsqDS8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A023E97EA;
        Tue, 20 Jul 2021 19:11:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC1F9E97E9;
        Tue, 20 Jul 2021 19:11:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/9] t7601: add tests of interactions with multiple
 merge heads and config
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
        <329802382bfa24241c2333bd38284aa77e3eb9f0.1626536508.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 16:11:13 -0700
In-Reply-To: <329802382bfa24241c2333bd38284aa77e3eb9f0.1626536508.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 17 Jul 2021
        15:41:40 +0000")
Message-ID: <xmqq4kcoh97y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7616DE2-E9AF-11EB-BEF5-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_expect_failure 'Multiple heads does not warn about fast forwarding' '
> +	git reset --hard c1 &&
> +	git pull . c2 c3 2>err &&
> +	test_i18ngrep ! "Pulling without specifying how to reconcile" err
> +'

This does not look like "warning about fast-forwarding".

But more importantly, are we sure we want to expect this outcome?

We are at c1 and try to integrate with c2 and c3 at the same time,
neither of which is a descendant of c1.

We know that the only possible action is to create an octopus in
this case, and that it is pretty much fundamental (i.e. it is not
like "rebase" with further development will be able to handle this
case).  I however do not know if it is also obvious to total newbies
who haven't even chosen between merge and rebase.  I can see them
complaining "why didn't I get asked to choose between rebase and
merge" if we went ahead and created an octopus merge, especially the
ones who would choose pull.rebase=yes once they learned Git a bit
more.

> +test_expect_success 'Cannot fast-forward with multiple heads' '
> +	git reset --hard c0 &&
> +	test_must_fail git -c pull.ff=only pull . c1 c2 c3 2>err &&
> +	test_i18ngrep ! "Pulling without specifying how to reconcile" err &&
> +	test_i18ngrep "Not possible to fast-forward, aborting" err
> +'

This one looks sensible to me.

> +test_expect_success 'Cannot rebase with multiple heads' '
> +	git reset --hard c0 &&
> +	test_must_fail git -c pull.rebase=true pull . c1 c2 c3 2>err &&
> +	test_i18ngrep ! "Pulling without specifying how to reconcile" err &&
> +	test_i18ngrep "Cannot rebase onto multiple branches." err
> +'

This one, too.

Thanks.
