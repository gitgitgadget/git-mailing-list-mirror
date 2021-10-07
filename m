Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A319C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 17:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00FD86121F
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 17:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243314AbhJGRk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 13:40:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64464 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242882AbhJGRk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 13:40:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 084AA162BA3;
        Thu,  7 Oct 2021 13:38:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1m2rFzlOiJ33oVxkT3mbvM4qLrgwrKQW0AAE5X
        PiE6A=; b=IsOJkWFWBly9TkxzPwDZ1EY6K4m5DxN7sZdrMRCXWzMnFDUlQz3WwG
        3whymhFkPa9P3eUG2WDfd8Kqn9GbA2RJd4yPf0Pt1qi2LQ9uotq+kdSIR87Z/43G
        8S4HnYJwLMpBOh/J81eRKzTXDpRSsYh9JtbYGaHHbMYLScNAZcGW4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 00F1E162BA2;
        Thu,  7 Oct 2021 13:38:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 68060162BA1;
        Thu,  7 Oct 2021 13:38:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 0/7] Gets rid of "if reflog exists, append to it
 regardless of config settings"
References: <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
        <pull.1067.v3.git.git.1631021808.gitgitgadget@gmail.com>
        <CAFQ2z_PAs3fG1h31KWVXJ=02t1i9UvWPuD4tCK-ZWfewkPQJEw@mail.gmail.com>
        <xmqqk0iqrp4q.fsf@gitster.g> <xmqqfsterotr.fsf@gitster.g>
Date:   Thu, 07 Oct 2021 10:38:27 -0700
In-Reply-To: <xmqqfsterotr.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        06 Oct 2021 11:27:28 -0700")
Message-ID: <xmqqbl40razw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61B32AFC-2795-11EC-A191-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Not really.  I think the comment on the RFC still stands, and I do
> not recall seeing a response to the point.
>
>     One potential harm this change will bring to us is what happens to
>     people who disable core.logAllRefUpdates manually after using the
>     repository for a while.  Their @{4} will point at the same commit no
>     matter how many operations are done on the current branch after they
>     do so.  I wouldn't mind if "git reflog disable" command is given to
>     the users prominently and core.logAllRefUpdates becomes a mere
>     implementation detail nobody has to care about---in such a world, we
>     could set the configuration and drop the existing reflog records at
>     the same time and nobody will be hurt.
>
>     If we keep the current behaviour, what are we harming instead?
>     Growth of diskspace usage is an obvious one, but disks are cheaper
>     compared to human brainwave cycles cost.

IIRC, the only reason why reftable implementation may want to change
the behaviour we have to avoid getting blamed for breaking is
because it cannot implement "a reflog exists, and we need to record
further ref movements by appending to it, no matter what the
configuration says" when the existing reflog is empty, because its
data structure lacks support for expressing "exists but empty".

I think the behaviour change described in the title of this message
can be limited in the scope to hurt users a lot less, and can still
satisfy the goal of helping reftable not getting blamed for
breakage, perhaps by making the behaviour for an empty but existing
reflog unspecified or implementation defined per backend.

That would allow us to avoid situation where a user can say foo@{1}
but it does not refer to the point where the branch's tip pointed
just before the most recent update to it. As an empty but existing
reflog would not give foo@{$n} for any value of $n, there is much
less risk of confusing users if we did not append new entries to it,
I would hope.

