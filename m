Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A39C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 21:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241105AbiCWV3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 17:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344905AbiCWV3e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 17:29:34 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4604BD4
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 14:27:59 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93984122B55;
        Wed, 23 Mar 2022 17:27:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gzmjn3brGv5Y
        WUSGzppSQcwArgVZq3mmxShYpLXG0k4=; b=OKNfF/hhERFaqlUy31MRKaTp2O6a
        KSoS463+bz1Np1HK7aC8sgfTVt15bj5SZWz86sTRUgMWbn9yrtsAkLQSQ1nESkCx
        GdRuAKk4lh1LGphnujTeQoWC0SAyHRtMu+zLXXPzhf5iCe1YICs+MCA0AB7RxAd1
        P09Y55s98Lxz43c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BB8B122B54;
        Wed, 23 Mar 2022 17:27:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F0520122B53;
        Wed, 23 Mar 2022 17:27:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/5] Partial bundle follow ups
References: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
Date:   Wed, 23 Mar 2022 14:27:56 -0700
In-Reply-To: <pull.1186.git.1647970119.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Tue, 22 Mar 2022 17:28:34 +0000")
Message-ID: <xmqqlex0qrz7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1BFBC1CA-AAF0-11EC-AC2B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is based on master, which recently took ds/partial-bundles.
>
> There are a couple conflicts with 'seen':
>
>  * rc/fetch-refetch adds the "--refetch" option right next to where I r=
emove
>    an instance of CL_ARG__FILTER.
>  * tb/cruft-packs updates the add_unseen_recent_objects_to_traversal()
>    method, but this series changes one call from using "&revs" to using
>    "revs".

Demonstrating that the submitter has already made an effort to make
sure the new topic plays well with other topics in flight this way
is very much appreciated.

> These are a few cleanups that were discussed as part of ds/partial-bund=
les.
>
>  * Patch 1 removes the CL_ARG__FILTER macro.
>  * Patches 2-3 help parse --filter directly into a revs.filter member
>    instead of copying it from another filter_options.
>  * Patches 4-5 add output of the hash function capability in 'git bundl=
e
>    verify'. It also moves the capability output to the end, since it lo=
oks a
>    bit strange in the current location when there are boundary commits.

OK.

>  * create_bundle() in bundle.c does two commit walks: first to discover=
 the
>    boundary commits to write into the bundle header, and then another t=
hat
>    happens when constructing the pack-file. It looks like this could be
>    avoided if there will not be any boundary, but there are additional
>    checks in write_bundle_refs() that look for the SHOWN bit on the com=
mit
>    objects in order to determine if a requested ref would be excluded b=
y the
>    rev-list options. This behavior seems important, so I did not remove=
 it.

Good thinking.  Thanks.

>  * 'git clone --bare partial.bdl" should work when partial.bdl is a par=
tial
>    bundle. However, this requires changing the way we configure partial
>    cloned repositories to not rely on a remote in order to understand a=
n
>    object filter. I'm working on this as a parallel series that will li=
kely
>    require more discussion than these small cleanups.

Leaving it outside the topic, saying that you cannot yet clone from
such a bundle, is perfectly fine, I would think.  Thanks.

>  * =C3=86var pointed out some newly-visible memory leaks due to moving =
the filter
>    out of a static global. After looking at the recommended change, it =
seems
>    that we actually need to be more careful about freeing the revs and =
not
>    just revs.filter.

OK.

