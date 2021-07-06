Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E9AC07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E834A61C7A
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhGFTT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 15:19:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53156 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhGFTT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 15:19:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85136C1165;
        Tue,  6 Jul 2021 15:16:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UOz8zmZnlKydLWzUZT64OEeR6CmawaWUS1gI9u
        3aAY8=; b=eTiQQ1AdMtBTh4GC58+7VgjOoooDRUsP3BNT8flXVJovi/f98yQO5a
        oEimvMK4JKLuIMnKPg2EMmhj16bSBs1k2ft/hXRGVc40cCi9taG1eC6BzNJm/3XK
        QoXyFgfyAfUgXt/9j6zYwh6vtBPBO0P/75Qwgq9j98loHneNyoNKs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AF07C1164;
        Tue,  6 Jul 2021 15:16:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E43D0C1159;
        Tue,  6 Jul 2021 15:16:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 1/7] ci: use the new GitHub Action to download
 git-sdk-64-minimal
References: <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
        <pull.878.v3.git.1625439315.gitgitgadget@gmail.com>
        <2e4db688deb938592257882c06b658cf3b8463f8.1625439315.git.gitgitgadget@gmail.com>
Date:   Tue, 06 Jul 2021 12:16:47 -0700
In-Reply-To: <2e4db688deb938592257882c06b658cf3b8463f8.1625439315.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Sun, 04 Jul 2021
        22:55:08 +0000")
Message-ID: <xmqqwnq3jlr4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5AAD07E-DE8E-11EB-8276-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This Action not only downloads and extracts git-sdk-64-minimal _outside_
> the worktree (making it no longer necessary to meddle with
> `.gitignore` or `.git/info/exclude`), it also adds the `bash.exe` to the
> `PATH` and sets the environment variable `MSYSTEM` (an implementation
> detail that Git's workflow should never have needed to know about).
>
> This allows us to convert all those funny PowerShell tasks that wanted
> to call git-sdk-64-minimal's `bash.exe`: they all are now regular `bash`
> scriptlets.
>
> This finally lets us get rid of the funny quoting and escaping where we
> had to pay attention not only to quote and escape the Bash scriptlets
> properly, but also to add a second level of escaping (with backslashes
> for double quotes and backticks for dollar signs) to stop PowerShell
> from doing unintended things.
>
> Further, this Action uses a fast caching strategy native to GitHub
> Actions that should accelerate the download across CI runs:
> git-sdk-64-minimal is usually updated once per 24h, and needs to be
> cached only once within that period. Caching it (unfortunately only on
> a per-branch basis) speeds up the download step, and makes it much more
> robust at the same time by virtue of accessing a cache location that is
> closer in the network topology.

So nice.
