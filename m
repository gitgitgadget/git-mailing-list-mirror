Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF2EC4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 18:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E3B6610A6
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 18:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhHRSbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 14:31:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60387 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhHRSbT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 14:31:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 313C014F99D;
        Wed, 18 Aug 2021 14:30:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=281J+tWt3lyJQOQHAcJH8B7Y84uq8jA58nCpQl
        wBnbE=; b=d3ZGLpeJ7sGszt64gT7x+IMoZgXlDxlLkVK1uKKExDuvVOM1TTp5Uh
        8cHcz3hNczD/7QgVK8D9J0Iey7j1zt2UJCDG5hJMKoLtHJcA0DOg5Q2sLSdxWpad
        Mg0UuRWkkKi5DLfIzbUvTcRh3LPnXFmPOeSoobqedEsErJRV8tQ64=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2993114F99C;
        Wed, 18 Aug 2021 14:30:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 663DE14F99B;
        Wed, 18 Aug 2021 14:30:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH] fixup! propagate errno from failing read
References: <pull.1068.git.git.1629203489546.gitgitgadget@gmail.com>
        <xmqq4kbn7l3l.fsf@gitster.g>
        <CAFQ2z_Ni1bvj0Skgp_3p9htQfjn_M=3uF06pyZm_hkXgT_L61g@mail.gmail.com>
Date:   Wed, 18 Aug 2021 11:30:39 -0700
In-Reply-To: <CAFQ2z_Ni1bvj0Skgp_3p9htQfjn_M=3uF06pyZm_hkXgT_L61g@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 18 Aug 2021 11:00:36 +0200")
Message-ID: <xmqqo89u61ww.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6474E2A4-0052-11EC-89C5-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> I think the convention to assign errno to myerr in this codepath
>> originates in a0731250 (refs: explicitly return failure_errno from
>> parse_loose_ref_contents, 2021-07-20), and it forgot the part of the
>> code being fixed with this patch.  The commit being fixed is already
>> is in 'next' as part of the hn/refs-errno-cleanup topic.
>>
>> Usually, a flaw in a topic that is already in 'next' is corrected by
>> a follow-up patch, but then they won't say "fixup!" (none of our
>> bugfix patches do).  But a post-release is a special time, as we
>> will soon be rewinding 'next', restarting it from the latest release
>> and we have a choice to tentatively eject a topic, fix it up or
>> even replace it, before merging the corrected topic to 'next'.
>>
>> Do you mean that you want me to squash this change into that commit
>> before the topic graduates to 'master' during the new development
>> cycle?  If so please be a bit more explicit next time.  Using the
>> title of the commit after "fixup!" would be a good starting point.
>
> The problem fixed here affects anyone who uses git-repo (ie. does
> Android development) and runs "git-branch -m", which is a large group
> of people, so I think it should not be allowed to get into a release.

OK.  The problem already is in 'next' and we want to make sure it
won't graduate to 'master' for the next release as-is.  I agree with
that ;-)

> So it could be squashed into commit a0731250, or put on top of next as
> a separate commit (probably with 'fixup!' removed).

I'd try the former first and will fall back on the latter, then.

> Note that, even though commit a0731250 originates from a branch called
> "hn/XXX" and has me as Author, the BUG() call causing the crash was
> actually introduced by AEvar when he reworked the series.

Yup, I see his Sob after yours and it is quite understandable if a
new bug was introduced by his changes. It also would be
understandable if his change was only to add a call to BUG() in
order to assert that the original patch used myerr consistently, and
it uncovered a bug in the original version he took from you.

I do not care too much about how exactly the bug was introduced and
uncovered---it matters more that the end result has one fewer bug
thanks to the team effort.
