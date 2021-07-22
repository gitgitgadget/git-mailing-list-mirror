Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BECAC4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4576F60C41
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhGVUpL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:45:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51908 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhGVUpK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 16:45:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A576E7B19;
        Thu, 22 Jul 2021 17:25:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RkndY/OJmMgjvQFiEJ2ghn9ngA+sTMTJmAfrb+
        zx12A=; b=lQS6f9XYHmLp61cL5ewuT5kI6giFNTr0ogVbrQcysV7v0SquY8zSZK
        b7dxWRe0OD7uZ0LHVoA0hZRRi4DmNOJYWXUVPTGaaH8Khibm1Pkc0y5R8y8avTYa
        Jj0srsFB5sqht2tOHbhC9FoDyuMksiixMCOgTAB8xllZ/Dk0NGQqk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3F36E7B18;
        Thu, 22 Jul 2021 17:25:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 71AF3E7B17;
        Thu, 22 Jul 2021 17:25:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] [GSOC] cherry-pick: fix bug when used with
 GIT_CHERRY_PICK_HELP
References: <pull.1001.git.1626962763373.gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 14:25:43 -0700
In-Reply-To: <pull.1001.git.1626962763373.gitgitgadget@gmail.com> (ZheNing Hu
        via GitGitGadget's message of "Thu, 22 Jul 2021 14:06:03 +0000")
Message-ID: <xmqqo8au82i0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F9C32CA-EB33-11EB-8C33-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> If we set the value of the environment variable GIT_CHERRY_PICK_HELP
> when using `git cherry-pick`, CHERRY_PICK_HEAD will be deleted, then
> we will get an error when we try to use `git cherry-pick --continue`
> or other cherr-pick command.

I think that the GIT_CHERRY_PICK_HELP is an implemention detail for
various forms of rebase to use cherry-pick as a backend and not for
use by end users.  

I strongly suspect that the right solution for the breakage is to
unsetenv(GIT_CHERRY_PICK_HELP) in cmd_cherry_pick() without touching
sequencer.c at all.

It _is_ ugly that a helper that is responsible for emitting an
advise message also makes a decision whether the pseudo-ref gets
deleted or not, but a fix to that problem should be done byy making
the logic for the decision less complex, not more.

So, I am not enthused to see this change.
