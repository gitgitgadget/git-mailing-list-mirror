Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B0FC433E6
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 00:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1974D64EF0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 00:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhCIAri (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 19:47:38 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55862 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhCIArX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 19:47:23 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 307CC11321E;
        Mon,  8 Mar 2021 19:47:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=mjJF8GvzVBEx/v7gsq9oGtn5M
        sc=; b=qno70h/PXT7ki/8PFr0H+CBAj928pNuQRfKGpg/1GdNnO2lKgJ3jSA6bX
        lhloBDyN1D8VrETzqx0KshRwSn5nn4mhH/3aznexTtHJeJWxUFmXhJ//BgsPbHL2
        vVmTYjd1q5EcV0lyOifaz0ENLkTTK3GKO0sVN37UF/1VRGCVx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=XJUNM+9MoPE1FfYSqAw
        bdIrW9phwiwXXrGaFbml4u6BhK34R/uXm8O+zc+RSciYnSF4UlLPHZbcRmH5nNkc
        GFbZFIN0Us7jNNEp6MgRufjzGprdmieczjPqlUplXlYsYwpLxTdxtuzx213t0EiP
        ziSP0FjYfKifNp/CP6ASUcQM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A47311321D;
        Mon,  8 Mar 2021 19:47:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6F47911321C;
        Mon,  8 Mar 2021 19:47:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 00/10] describe tests: refactor & fix recent broken tests
References: <20200223125102.6697-1-benno@bmevers.de>
        <20210228195414.21372-1-avarab@gmail.com>
Date:   Mon, 08 Mar 2021 16:47:18 -0800
Message-ID: <xmqqtupl2lwp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0132D216-8071-11EB-B0DC-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> While looking at the "git describe" tests due to the on-list
> %(describe) discussion I discovered that the feature added in
> 30b1c7ad9d (describe: don't abort too early when searching tags,
> 2020-02-26) has never been tested for.
>
> This is because it defined a custom test function that called
> test_expect_success, which then got called inside another top-level
> test_expect_success. Thus even if it failed we'd pass the test.

Thanks.  I think I've seen something similar recently.  I wonder if
it is an easy mistake our test linter can catch.

> This series fixes that issue, and makes some general improvements to
> the "describe" tests. I then make test_expect_{success,failure} return
> 1 to catch these sorts of issues in the future, which required fixes
> to a couple of svn tests that ran with "set -e".

OK.

> I was on the fence about whether to send this after the recent rc0,
> but figured that since it's test-only Junio might want to pick it up,

Even if it is too late, giving earlier exposure would by itself be a
good thing (just don't forget to resend after the dust settles, so
that it would land eventually).

> and possibly for the next rc in case we'd like to do some pre-release
> testing for this never-before-tested feature added in 2.26.0 (although
> the actual implementation looks fine to me).

Thanks; it obviously is a lower priority as we have survived with
the broken test for a long time since 2.26 ;-)

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (10):
>   describe tests: improve test for --work-tree & --dirty
>   describe tests: refactor away from glob matching
>   describe tests: always assert empty stderr from "describe"
>   test-lib functions: add an --annotated-tag option to "test_commit"
>   describe tests: convert setup to use test_commit
>   describe tests: fix nested "test_expect_success" call
>   describe tests: support -C in "check_describe"
>   svn tests: remove legacy re-setup from init-clone test
>   svn tests: refactor away a "set -e" in test body
>   test-lib: return 1 from test_expect_{success,failure}
>
>  t/t1403-show-ref.sh           |   6 +-
>  t/t6120-describe.sh           | 193 +++++++++++++++-------------------
>  t/t9117-git-svn-init-clone.sh |   6 --
>  t/t9148-git-svn-propset.sh    |  27 ++---
>  t/test-lib-functions.sh       |  20 +++-
>  5 files changed, 122 insertions(+), 130 deletions(-)
