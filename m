Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD49C433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 17:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245129AbhLORFZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 12:05:25 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53689 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245123AbhLORFX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 12:05:23 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0BDB31700A8;
        Wed, 15 Dec 2021 12:05:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qPe/mSN+Nhty
        2fulvTBrDaeK1Ah67JzKdwpm6dFWX1w=; b=aSgdz88EOAmTj02w2PHVVVLBf7Jy
        O6z92GYH2QkTKmwFi0Wn5+PlvqShxBqSjBkV/gTUnKDVNSpe1C+1rjI/BbqxgDxR
        /ssT+DsxW1EQf4O4ZZMVxBkT2ucgNRG7/IDVbRx9NifCesTyqI3MoU6pjaPgT5UL
        icfh+LFooL50vHQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E21921700A7;
        Wed, 15 Dec 2021 12:05:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 35D4F1700A6;
        Wed, 15 Dec 2021 12:05:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/2] test-lib.sh: remove the now-unused
 "test_untraceable" facility
References: <cover-v2-0.2-00000000000-20211201T200801Z-avarab@gmail.com>
        <cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com>
        <patch-v3-2.2-a7fc794e20d-20211210T100512Z-avarab@gmail.com>
        <20211212163207.GA3400@szeder.dev>
        <211212.865yrtbvl1.gmgdl@evledraar.gmail.com>
        <20211212201441.GB3400@szeder.dev> <xmqqo85kcp99.fsf@gitster.g>
        <YbjJuh4dVijL7jw4@coredump.intra.peff.net>
Date:   Wed, 15 Dec 2021 09:05:15 -0800
In-Reply-To: <YbjJuh4dVijL7jw4@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 14 Dec 2021 11:43:38 -0500")
Message-ID: <xmqqh7b994tw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2D5AE640-5DC9-11EC-9481-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think the method for handling this in the test scripts _is_ worse to
> write, understand, and maintain. The problem to me is less that it's
> ugly to workaround (which as you note in this case is not great, but no=
t
> _too_ bad), but that it's a subtle friction point that may jump up and
> bite any test-writer who does something like:
>
>   (foo && bar) 2>stderr

Yeah, that is a simple example that clearly shows how removal of
BASH_XTRACEFD makes developer's life horrible.

> So my view had always been that BASH_XTRACEFD is the good solution, and
> if people want to make "-x" work reliably under other shells, then I
> won't stop them. But somewhere along the way G=C3=A1bor did a bunch of =
fixes
> to get things mostly running, and the use of dash with "-x" got added t=
o
> CI, so now it's a de facto requirement (if you care about CI
> complaining, which we increasingly do).
> ...
> My vision was that we'd leave BASH_XTRACEFD so people using it could
> remain oblivious if they chose, but if the ship has sailed via CI, then
> that might have less value.

Yeah, that matches my understanding.  Unfortunately we cannot easily
remove "dash -x" from CI while keeping "dash" without "-x" X-<.

Still.  I wonder if keeping BASH_XTRACEFD helps developers, when
they need to diagnose a new breakage?  If their new test fails only
in the "dash -x" run but not "bash -x" at the CI, for example?
