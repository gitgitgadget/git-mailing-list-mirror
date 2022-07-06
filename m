Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BB0C43334
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 21:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiGFVG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 17:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiGFVG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 17:06:26 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1054286E1
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 14:06:24 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BC4B13EBF0;
        Wed,  6 Jul 2022 17:06:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ezOFmnaPf6SeL/914XYxK9kpKLGbkUNE6srD+7
        GiHio=; b=NF1lVZc90MugKTVc9+/XguLZfSIb7m+cFUuyPtm0SIM1oCV1HGm1yV
        rYZmfkFlR2KORORaKLsaqBAwLTxt7EtIV9v3R0tvAPUhF3EQ+kvmoMLh/KFg8ZvB
        UI2OWGInlfQYMDAU417iQL5pUbCfyCO0bi34llQQvQDJgyC60qTss=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8311713EBEF;
        Wed,  6 Jul 2022 17:06:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E159B13EBEE;
        Wed,  6 Jul 2022 17:06:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org,
        Adam Zethraeus <adam.zethraeus@includedhealth.com>
Subject: Re: bug report: pre-commit & pre-push hook output is redirected
 differently
References: <CAP4e5TNdvE1gmt9bERT5sL+D3r4Fbypk57KJJ+wYHD=M=T+uWA@mail.gmail.com>
Date:   Wed, 06 Jul 2022 14:06:21 -0700
In-Reply-To: <CAP4e5TNdvE1gmt9bERT5sL+D3r4Fbypk57KJJ+wYHD=M=T+uWA@mail.gmail.com>
        (Adam Zethraeus's message of "Wed, 6 Jul 2022 13:40:45 -0700")
Message-ID: <xmqqa69mgdde.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D715FCE-FD6F-11EC-BCAF-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Zethraeus <adam.zethraeus@includedhealth.com> writes:

> What did you do before the bug happened? (Steps to reproduce your issue)
>
> Installed identical pre-commit and pre-push hooks:
>
> ```
> #!/bin/bash
>
>>&1 echo "stdout"
>>&2 echo "stderr"
> exit 1
> ```
>
> What did you expect to happen? (Expected behavior)
>
> `git push` and `git commit` should have the same hook behavior.
>
> What happened instead? (Actual behavior)
>
> The pre-commit hook was run with stdout redirected to stderr but the
> pre-push hook's output was unaltered.

Without looking into it very much, the output of hooks is an area
with known regression at 2.36, so let me redirect it to those who
are likely to know it ;-)

Thanks for a report.

>
> ```
>> git commit -m "-" 1>/dev/null
> stdout
> stderr
>> git commit -m "-" 2>/dev/null
>> git commit -m "-" --no-verify
>> git push 1>/dev/null
> stderr
> error: failed to push some refs to 'github.com:org/repo.git'
>> git push 2>/dev/null
> stdout
> ```
>
> What's different between what you expected and what actually happened?
>
> There was inconsistency in the behavior when I expected consistency.
>
> Anything else you want to add:
>
> ```
>> /bin/bash --version
> GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin21)
> ```
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.37.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Darwin 21.5.0 Darwin Kernel Version 21.5.0: Tue Apr 26 21:08:22
> PDT 2022; root:xnu-8020.121.3~4/RELEASE_X86_64 x86_64
> compiler info: clang: 13.1.6 (clang-1316.0.21.2.5)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
>
>
> [Enabled Hooks]
> pre-commit
> pre-push
