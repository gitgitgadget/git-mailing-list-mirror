Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D43C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 16:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243995AbiEYQkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 12:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239407AbiEYQku (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 12:40:50 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101DA57B2D
        for <git@vger.kernel.org>; Wed, 25 May 2022 09:40:49 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B553188CB4;
        Wed, 25 May 2022 12:40:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=7vpbgLxras+eeswKFktHCa5IvrDjevdqPPbB7QIEvCg=; b=KSlb
        S2ozlrOgzkt+A1R6bR4o8G2AulJEUlp8xT5JC73TyVKtMe/6mduwVoKNb4EmpC9k
        1nJM7oPvxNtee3DR3+WjrXZAYl1IO5fNeSvaN6bg4ZJcg/eAIiUFqFFUy4melYhV
        QgKtfxBpTXdQVFy0WrrCSlJvb6u6KUU213QmZiQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 85645188CB2;
        Wed, 25 May 2022 12:40:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 83857188CB1;
        Wed, 25 May 2022 12:40:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done
 with it
References: <cover.1651859773.git.git@grubix.eu>
        <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
        <xmqqtua2jtr0.fsf@gitster.g> <xmqqczgqjr8y.fsf_-_@gitster.g>
        <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet>
        <xmqqr14jluu4.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205240124280.352@tvgsbejvaqbjf.bet>
        <xmqqa6b7lrw6.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205241258510.352@tvgsbejvaqbjf.bet>
        <xmqqleuqj1gy.fsf@gitster.g>
        <220524.86r14ivewt.gmgdl@evledraar.gmail.com>
        <xmqqleuqefa4.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205251111300.352@tvgsbejvaqbjf.bet>
Date:   Wed, 25 May 2022 09:40:43 -0700
Message-ID: <xmqqr14h8t10.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C132C04-DC49-11EC-AADC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This same analysis, of course, also puts a nail into the coffin of the
> `reserved_for_use` idea because while it would fix the reuse bug, it would
> unnecessarily squat on slots that might well be needed.

It is like that an in-kernel structure that represents a process has
to stay around in the zombie state until its exit status is culled.
With s/reserved_for_use/zombie/ the name of the new member would
make more sense ;-)

With the "slot->finished" trick, compared to the approach to delay
the reuse, we can reuse them a bit earlier, but because I do not
think we accumulate unbounded number of these zombie requests, and
when we run out the active slots in the active queue, and because
get_active_slot() will allocate a new one, the wastage might not be
too bad.

So, I am not sure if it is that bad to be called a nail in the
coffin.

In any case, https://github.com/git/git/actions/runs/2381379417 is
the run with the single liner "clear slot->finished before leaving"
with your other 3 gcc12 fixes.  The tests are not clean because we
have linux-leaks complaining on ds/bundle-uri-more RFC patches and
win test (9) seems to have issues with t7527 (fsmonitor), but I am
taking the fact that any of the "win test" jobs even start as an
evidence that we have pleased gcc12 enough to get there?

Thanks.
