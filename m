Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33888C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 01:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbiEZBKl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 21:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbiEZBKi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 21:10:38 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB3291590
        for <git@vger.kernel.org>; Wed, 25 May 2022 18:10:36 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B74D137687;
        Wed, 25 May 2022 21:10:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W7wZdsicjUbQte6UOROoKnYf7bbVUP1xrHUKD9
        2rBsc=; b=Udqj8ivYdyUqJpkYsRHvl0Hp28PD+842ifeI7hPMhOjVOL4OD3MskG
        4kyn94+fZUFFbbyFuimTpQYCg+UdkxvLSsKlJEqL3rsVcEpTZceHt9qYy/Bgap8q
        kZ5FlWuwQRKzGy41aOwrvYxTm9FXdhgtNbAjxbzG+rCta2zULSIeI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60B95137686;
        Wed, 25 May 2022 21:10:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6CA81137685;
        Wed, 25 May 2022 21:10:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/8] hook API: connect hooks to the TTY again, fixes
 a v2.36.0 regression
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2205251308381.352@tvgsbejvaqbjf.bet>
        <xmqqbkvl8s88.fsf@gitster.g>
Date:   Wed, 25 May 2022 18:10:33 -0700
In-Reply-To: <xmqqbkvl8s88.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        25 May 2022 09:57:59 -0700")
Message-ID: <xmqqczg13xpy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A514E7BC-DC90-11EC-8185-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Absolutely.  I wonder how involved is would be to revert the merge
> of the whole thing from 'master'.  It may give us a clean slate to
> rethink the whole mess and redo it without breaking the existing
> users' hooks.

I tried the revert, and the result compiled and tested OK, but I am
tempted to say that it looks as if the topic was deliberately
designed to make it hard to revert by taking as much stuff hostage
as possible.

At least one fix that depends on the run_hooks_opt structure
introduced by c70bc338 (Merge branch 'ab/config-based-hooks-2',
2022-02-09) needs to be discarded.  7431379a (Merge branch
'ab/racy-hooks', 2022-03-16) did address an issue worth addressing,
so even if we revert the whole c70bc338, we would want to redo the
fix, possibly in some other way.  But it also needed an "oops that
was wrong, here is an attempt to fix it again" by cb3b3974 (Merge
branch 'ab/racy-hooks', 2022-03-30).  The situation is quite ugly.

As you hinted in the message I responded to in the message I am
responding to, if we can make a surgical fix to make the new and
improved run_hooks_opt() API build on top of run_command(), instead
on top of run_processes_parallel(), that would give us a cleaner way
out than discarding everything and redoing them "the right way".  At
least, the external interface into the API (read: the impression you
would get by "less hook.h") does not look too bad.

Thanks.
