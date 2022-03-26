Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38769C433EF
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 05:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiCZF0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Mar 2022 01:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiCZF0L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Mar 2022 01:26:11 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B554422453E
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 22:24:34 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F3B88195794;
        Sat, 26 Mar 2022 01:24:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=EOKigKwSBqQJwjoMgPQ2OmwOy
        FhGnaCAoFCEH5+PMek=; b=q0061L76sq8v6/CrsSBEQwbjmeYg4NFpxc+nDlusG
        D4y+rJ9Nz7dMGpyM0LVDHFFnRFBEKphP4fs4ae8wnI+NzCVnTAInXuzFs1IjguZW
        xQGGqcHtgVwSwOXuaiKO6wY2tNBjIMLelPc3waalVduUFQ32oYVGPMj13E8bDOa6
        ak=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EBE2C195793;
        Sat, 26 Mar 2022 01:24:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5E1EF195792;
        Sat, 26 Mar 2022 01:24:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 08/27] revisions API users: add "goto cleanup" for
 "rev_info" early exit
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
        <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
        <patch-v3-08.27-f8a9443fe6f-20220325T171340Z-avarab@gmail.com>
        <xmqqtubl93n3.fsf@gitster.g>
        <220326.86ee2pleua.gmgdl@evledraar.gmail.com>
Date:   Fri, 25 Mar 2022 22:24:30 -0700
Message-ID: <xmqqee2p70c1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 03CDE278-ACC5-11EC-A535-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Because I don't see how it makes any sense to have a REV_INFO_INIT if i=
t
> doesn't actually give you an init'd "struct rev_info" that's ready for
> use. I.e. if you still need to call repo_init_revisions() it's just a
> misleading interface.

You can say

	struct something *foo =3D NULL;

	if (some condition)
		foo =3D alloc_and_init_foo();

	...

	free_and_destruct(foo);

and it is correct that "initialize with NULL" alone would not let
you use the thing as full fledged 'foo', but you can still safely
pass it to free_and_destruct() (or if "something" does not hold
external resources, it could just be free()).  A flow like this:

	struct rev_info revs =3D REV_INFO_INIT;

	if (!some condition)
		goto leave;
	init(&revs);
	... use revs ...
leave:
        release(&revs);

would exactly be the same thing.

In other words, you say "I do not see how it makes any sense" but to
me it looks more like what does not make sense is your argument
against what was suggested.

