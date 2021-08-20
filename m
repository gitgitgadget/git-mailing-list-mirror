Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC51C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 06:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2D660FDC
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 06:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbhHTGJy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 02:09:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58908 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbhHTGJx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 02:09:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ED6AD13BCFC;
        Fri, 20 Aug 2021 02:09:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DsYsDkjFiq83ZJtm68sXy/pssd9I47Ad4j4Pvg
        Zqs3Q=; b=FLa8f4jlUw9mfoolYMDBl8S2MgDuDg6GRYfUUrtiPZ7951ye2Af+Kr
        BoR/AVH/vgglF+ryD9AF/A+mTOTAYmG68F0rnRC1FAXJJHcFleuw7L9DGSTEMSCs
        0P2yhHHJV7ao/UUtT1tDSgdPjzuqWSx6FHDKac7zQBVV1NeM591Jk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E535D13BCFA;
        Fri, 20 Aug 2021 02:09:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3202C13BCF7;
        Fri, 20 Aug 2021 02:09:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Giving priority to the reftable topic
    (was Re: What's cooking in git.git (Aug 2021, #06; Mon, 16))
References: <xmqqv945ng61.fsf@gitster.g>
Date:   Thu, 19 Aug 2021 23:09:11 -0700
In-Reply-To: <xmqqv945ng61.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        16 Aug 2021 16:06:14 -0700")
Message-ID: <xmqqtujkwsu0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 243DBCFC-017D-11EC-B09A-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * hn/reftable (2021-08-16) 25 commits
>  - t1404: annotate test cases with REFFILES
>  ...
>  - hash.h: provide constants for the hash IDs
>
>  The "reftable" backend for the refs API.

As discussed in the thread that leads to [*1*], this topic has been
blocked by the "clean-up errno use in the refs subsystem" topic for
too long.  I think it deserves to have its own chance to be looked
at by more eyes.

I've reverted the three topics around "errno" out of 'next', while
rebasing them into a single strand of pearls, and queued them near
the tip of 'seen'.  The hn/reftable topic is merged into 'seen' 
earlier then these "errno" topics.

'seen' that has this topic, without merging known CI breakers (the
three "errno" topics are known to break when they are with the
hn/reftable topic, and the "builtin fsmonitor" also breaks CI),
passes the usual tests [*2*], except for the "pedantic" test we
recently added [*3*].

The breakage flagged by the compiler are all:

	char *fn = get_tmp_template(__FUNCTION__);

where the code expects that __FUNCTION__ is unconditionally
available.

With that problem fixed (which I would imagine should be easier than
brain surgery), we should be able to move the topic lower in 'seen',
hopefully touching 'next' soon to give it a wider exposure.

And when hn/reftable gets stable enough, the "errno clean-up" topic
can perhaps be rebased on top of it to work better together.

Thanks.


[Reference]

*1* https://lore.kernel.org/git/xmqqbl5syhiu.fsf@gitster.g/

*2* https://github.com/git/git/actions/runs/1148914175

*3* https://github.com/git/git/runs/3377289487?check_suite_focus=true#step:5:639
