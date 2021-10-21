Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21398C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 21:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09C5561215
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 21:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhJUVTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 17:19:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52296 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbhJUVTI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 17:19:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D5A41630AB;
        Thu, 21 Oct 2021 17:16:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2B/NzI3B12DRO4e4kksLq3Iv5khkN3J95FRBmT
        euj/U=; b=t9EVrJ3lrjjF/29DdUusQRIyWNkQ1jqN6HPIfJwVVreCnFI5nLtVH+
        ZwejhlcRWRW+CeSh6KbPrCKKc8FMhT0g4iXQ2SFJblVNoIO72j9Glzsm4ApxzBM9
        8puX0ik+9TalNpEmiptZxUz79JZG22yhMoqvhwMGxMpcUREj/3qbc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 770811630A9;
        Thu, 21 Oct 2021 17:16:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CAA131630A8;
        Thu, 21 Oct 2021 17:16:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 03/29] fsmonitor: config settings are
 repository-specific
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <882789b4dfebddb059f62b0b2edb95b92f3c69ee.1634826309.git.gitgitgadget@gmail.com>
        <xmqqlf2mjdgf.fsf@gitster.g>
Date:   Thu, 21 Oct 2021 14:16:48 -0700
In-Reply-To: <xmqqlf2mjdgf.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        21 Oct 2021 14:05:36 -0700")
Message-ID: <xmqqh7dajcxr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34876C76-32B4-11EC-99A7-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +enum fsmonitor_mode {
>> +	FSMONITOR_MODE_DISABLED = 0,
>> +	FSMONITOR_MODE_HOOK = 1, /* core.fsmonitor */
>> +	FSMONITOR_MODE_IPC = 2,  /* core.useBuiltinFSMonitor */
>> +};
>
> Please remind me why we need a new separate variable, instead of
> turning the core.fsmonitor variable into an extended bool <false,
> true, builtin>?

Ah, I see.

The vocabulary of the value for the existing variable is between
"unset means disabled" and "the path-to-hook means enabled", so
unless we forbid a bareword path "builtin" (which I do not think is
such a bad idea, by the way), it becomes a bit fuzzy what a
non-empty token means.

In any case, the "set to path to enable, leave unset to leave
disabled" is a cumbersome to use and may want to be rethought.  It
is unclear how one would override a configured path-to-hook, for
example.

Considering that we need to reserve a special word, say, "disabled",
that has to be distinguishable from a normal "here is a path to the
hook script" ANYWAY, in order to allow such a "last one wins"
configuration override (or "git -c core.fsmonitor=disabled cmd"), it
starts to sound more and more reasonable to reserve yet another word
"builtin" as a special value of core.fsmonitor, without having to
introduce a new configuration variable, no?

