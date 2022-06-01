Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78BFC433EF
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 18:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiFASuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 14:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiFASuL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 14:50:11 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658B3121CE6
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 11:50:10 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B6FD31A7427;
        Wed,  1 Jun 2022 14:50:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ydDZS3uLU5iM
        fIiOrxA7XyWbNhNc760ONvzalBloBUE=; b=gROeohu7ZdCwMAcDwnEh5JA7pOEl
        YNX4wo6fC5xe93x3mSVrFbQEenfniHRZ+wRbQRBZ232/JZmi1xdRzv60zU64BQP2
        gRUVawKFZY30nqxElaEjGNqYXxoMT7qPCv9IAHtBn9oLbAmDtXfwDvTE9HMItuBa
        ejVXfpQE9WalAPQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AF96A1A7426;
        Wed,  1 Jun 2022 14:50:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C37551A7425;
        Wed,  1 Jun 2022 14:50:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 2/6] usage.c: add a non-fatal bug() function to go
 with BUG()
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
        <patch-v2-2.6-2d0527f86dc-20220531T164806Z-avarab@gmail.com>
Date:   Wed, 01 Jun 2022 11:50:04 -0700
In-Reply-To: <patch-v2-2.6-2d0527f86dc-20220531T164806Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 31 May
 2022 18:58:44
        +0200")
Message-ID: <xmqqo7zcrzfn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A70A1D58-E1DB-11EC-80D6-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Unlike the code this replaces we'll log to trace2 with this new bug()
> function (as with other usage.c functions, including BUG()),

I do not terribly mind repeated fprintf(stderr, ...) or error() in a
loop, but this aspect of the change is probably among the two things
that make the series shine (the other obviously being bug_if() which
allows us to lose the "did we see any bug?" counter).

> Any caller to bug() can follow up such calls with BUG_if_bug(),
> which will BUG() out (i.e. abort()) if there were any preceding calls
> to bug(), callers can also decide not to call BUG_if_bug() and leave
> the resulting BUG() invocation until exit() time. There are currently
> no bug() API users that don't call BUG_if_bug() themselves after a
> for-loop, but allowing for not calling BUG_if_bug() keeps the API
> flexible. As the tests and documentation here show we'll catch missing
> BUG_if_bug() invocations in our exit() wrapper.

OK.

> I'd previously proposed this as part of another series[1], in that
> use-case we ended thinking a BUG() would be better (and eventually
> 96e41f58fe1 (fsck: report invalid object type-path combinations,
> 2021-10-01) ended up with neither). Here though we'll end up
> converting various existing code that was already doing what we're
> doing better with this new API.

I think the last paragraph is an after-three-dash material.
