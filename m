Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D25C433F5
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 17:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379086AbiD2Rmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 13:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236793AbiD2Rmf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 13:42:35 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E94D9F3B3
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 10:39:17 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61E7911A66A;
        Fri, 29 Apr 2022 13:39:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TLgj79W80sqTY7EVswEAULZiVwZTlgieBsWDEQ
        o7lUc=; b=b6Vzg0Dbrs9helA9My2WYltGnyolMpbaO5c8cDos6Q/NOZhplWn1fL
        XdIfKeexFZBtBImEMdfYGF8kFalj725s9jjkFBM2P9yAeHWPjJGRzBCFa0GnZVlG
        P1RdGQWXPSevX93FyiTNv9TvxAk2YSiP1DPK8XO7TM1EaZfNbwIKI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5730511A669;
        Fri, 29 Apr 2022 13:39:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C569E11A668;
        Fri, 29 Apr 2022 13:39:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Benedek Kozma <cyberbeni@gmail.com>
Subject: Re: Bugreport - submodules are fetched twice in some cases
References: <CAN8jHOgwVF5g=jM_KYT0Oh+j+Lk3qvdyA4zNRbzf8e1Xp5WAUw@mail.gmail.com>
Date:   Fri, 29 Apr 2022 10:39:12 -0700
In-Reply-To: <CAN8jHOgwVF5g=jM_KYT0Oh+j+Lk3qvdyA4zNRbzf8e1Xp5WAUw@mail.gmail.com>
        (Benedek Kozma's message of "Fri, 29 Apr 2022 16:46:36 +0200")
Message-ID: <xmqqczgzdc1r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49053D3A-C7E3-11EC-BAC9-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A simple and concrete reproduction 

    git init top
    cd top
    date >file1
    git init sub
    cd sub
    date >subfile1
    git add .
    git commit -m subinitial
    cd .. ;# back to top
    git submodule add ./sub sub
    git add file1
    git commit -m initial
    cd .. ;# out of top
    git clone --recurse-submodules top copy
    cd copy
    git config submodule.recurse true
    git config fetch.parallel 0
    GIT_TRACE2=$(pwd)/trace git fetch --all --prune --prune-tags

This throws the three lines to the output.

Fetching origin
Fetching submodule sub
Fetching submodule sub

The two "Fetching submodule" messages are coming from two separate
calls to get_fetch_task_from_index(), and the trace does show that
the code is doing "git-upload-pack" three times (one for the top
level, twice for the same top/sub).  We can see it by grepping
for "git-upload-pack" in the resulting 'trace' file above.

Glen, as submodule.c::fetch_submodules() was created in your heavy
refactoring quite recently, I thought I'd redirect this report in
your direction, as I expect you'd be the most clueful in this area
;-)

Thanks.




Benedek Kozma <cyberbeni@gmail.com> writes:

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> Run the following command with 1 remote:
> `git fetch --all --prune --prune-tags`
> I have the following in my config that could affect this:
> ```
> [submodule]
> recurse = true
> [fetch]
> parallel = 0
> ```
>
> What did you expect to happen? (Expected behavior)
> Submodules are only fetched once.
>
> What happened instead? (Actual behavior)
> Submodules are fetched twice.
>
> What's different between what you expected and what actually happened?
> The process takes longer
>
> Anything else you want to add:
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.36.0
> cpu: arm64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Darwin 21.4.0 Darwin Kernel Version 21.4.0: Fri Mar 18 00:46:32
> PDT 2022; root:xnu-8020.101.4~15/RELEASE_ARM64_T6000 arm64
> compiler info: clang: 13.1.6 (clang-1316.0.21.2)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
>
>
> [Enabled Hooks]
> pre-commit
