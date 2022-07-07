Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5E1C433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 18:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbiGGSqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 14:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbiGGSqg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 14:46:36 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099284D4CE
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 11:46:35 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E39C113D5B2;
        Thu,  7 Jul 2022 14:46:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QQZj2N39OJI+NI38fZj+y2718JNa2OmOj4wopP
        da1wE=; b=EFAXKwGtFvr2Vk/5a9nikFvTMWUiMFTVD7LoTt5DtghK7Eo9+Zri35
        X0MWOnWPtjFwSaavKF4AX43Wsa2mXPfKyo42GZkldZIZLf1UVcKjh6jV8wT6RC/S
        n6ryXzKfy2+yTO3wAPqRL5uoVEhCnfgsuRqe6H2ztSPWqeNrKA8mc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAABD13D5B1;
        Thu,  7 Jul 2022 14:46:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4239413D5B0;
        Thu,  7 Jul 2022 14:46:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew Klein <mklein994@gmail.com>,
        Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org
Subject: Re: Bug with splits in new nvimdiff layout
References: <CACRpdvnuAYY0U1_3uD8zKgtq05+bgwjzXpZKomro6gqYDNrjGg@mail.gmail.com>
Date:   Thu, 07 Jul 2022 11:46:32 -0700
In-Reply-To: <CACRpdvnuAYY0U1_3uD8zKgtq05+bgwjzXpZKomro6gqYDNrjGg@mail.gmail.com>
        (Matthew Klein's message of "Thu, 7 Jul 2022 11:58:48 -0500")
Message-ID: <xmqqo7y0zrp3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F3BB89E-FE25-11EC-BD94-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew Klein <mklein994@gmail.com> writes:

> Hi,
>
> I encountered a bug when using the new vimdiff layout format.

Thanks for a report.

Fernando (the author of the layout engine)?  Can you take a look?

> To recreate this, start with a merge conflict, and merge with this command:
>
>     git mergetool --tool=nvimdiff
>
> I expected the layout to be:
>
>     ------------------------------------------
>     |             |           |              |
>     |   LOCAL     |   BASE    |   REMOTE     |
>     |             |           |              |
>     ------------------------------------------
>     |                                        |
>     |                MERGED                  |
>     |                                        |
>     ------------------------------------------
>
> The layout when I ran the command was:
>
>     ------------------------------------------
>     |                                        |
>     |                LOCAL                   |
>     |                                        |
>     ------------------------------------------
>     |             |           |              |
>     |   LOCAL     |   LOCAL   |   MERGED     |
>     |             |           |              |
>     ------------------------------------------
>
> I expected the layout to be the same as what was documented to be the default
> for "nvimdiff".
>
> In my init.vim configuration file, I have these lines set:
>
>     set splitbelow
>     set splitright
>
> These options globally change the behaviour of the "split" command so that
> instead of "split" creating a new window above the current window, or to the
> left when used with "vertical", it does the opposite. Docs:
> https://neovim.io/doc/user/options.html#'splitbelow'
>
> I recommend using the "leftabove" (a.k.a "aboveleft") command together with
> "split". Since these windows are positioned absolutely (according to
> "mergetool.nvimdiff.layout"), it shouldn't depend on the user's configuration.
> Docs: https://neovim.io/doc/user/windows.html#:leftabove
>
> The previous invocation (i.e. "4wincmd w | wincmd J") didn't run into this
> issue, since its not affected by the "splitbelow" and "splitright" options.
>
> Hope this helps,
>
> Matthew
>
> [System Info]
> git version:
> git version 2.37.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.18.9-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 02 Jul 2022
> 21:03:06 +0000 x86_64
> compiler info: gnuc: 12.1
> libc info: glibc: 2.35
> $SHELL (typically, interactive shell): /bin/bash
>
>
> [Enabled Hooks]
