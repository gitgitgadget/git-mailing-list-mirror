Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B75C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 00:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbhLBBBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 20:01:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61332 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbhLBBB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 20:01:29 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1B1C1039A9;
        Wed,  1 Dec 2021 19:58:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6OkakEJ9bVA+
        jB2hRPooQxXElIk7m12tV7QoMDLbEkw=; b=HKVHam8zRagCCtrbR0OE+3YKWtpK
        funPhaIYS9/T71SAoj/wG1csoEOzlihCXut2cs0Y1DLmeeTvO/uzarU4IVfBSDNh
        CgmcNuMojLn7vGtb9ODQQRVTjZJSuZV3KyfZZKNuLYJ6HN3I3n0sCQuhHGEpQmfu
        D6EOSM/l8JvKwlQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7A631039A8;
        Wed,  1 Dec 2021 19:58:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 39D1C1039A7;
        Wed,  1 Dec 2021 19:58:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?IiLlvpDmspvmloc=?= (Aleen) " via GitGitGadget" 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v14 3/3] am: support --allow-empty to record specific
 empty patches
References: <pull.1076.v13.git.1638266115.gitgitgadget@gmail.com>
        <pull.1076.v14.git.1638329848.gitgitgadget@gmail.com>
        <cbd822d4340f8f3d832e9d6209ee8db6e538fca1.1638329848.git.gitgitgadget@gmail.com>
Date:   Wed, 01 Dec 2021 16:58:05 -0800
In-Reply-To: <cbd822d4340f8f3d832e9d6209ee8db6e538fca1.1638329848.git.gitgitgadget@gmail.com>
        (=?utf-8?B?IlwiXCLlvpDmspvmloc=?= (Aleen)\" via GitGitGadget\""'s message
 of "Wed, 01 Dec
        2021 03:37:28 +0000")
Message-ID: <xmqqy253x1pe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E96BCCE2-530A-11EC-BF3F-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

""=E5=BE=90=E6=B2=9B=E6=96=87 (Aleen)" via GitGitGadget"  <gitgitgadget@g=
mail.com>
writes:

> +test_expect_success 'skip an empty patch in the middle of an am sessio=
n' '
> +	git checkout empty-commit^ &&
> +	test_must_fail git am empty-commit.patch >err &&
> +	grep "Patch is empty." err &&
> +	grep "If you want to record it as an empty commit, run \"git am --all=
ow-empty\"." err &&
> +	git am --skip &&
> +	test_path_is_missing .git/rebase-apply &&
> +	git rev-parse empty-commit^ >expected &&
> +	git rev-parse HEAD >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'record an empty patch as an empty commit in the m=
iddle of an am session' '
> +	git checkout empty-commit^ &&
> +	test_must_fail git am empty-commit.patch >err &&
> +	grep "Patch is empty." err &&
> +	grep "If you want to record it as an empty commit, run \"git am --all=
ow-empty\"." err &&
> +	git am --allow-empty &&
> +	test_path_is_missing .git/rebase-apply &&
> +	git show empty-commit --format=3D"%s" >expected &&
> +	git show HEAD --format=3D"%s" >actual &&
> +	test_cmp actual expected
> +'

These two are "positive" tests, i.e. the feature does the right
thing when used in the expected situation.

I am worried about the cases where "--allow-empty" is used and
creates a commit that is empty, when it is reasonably expected to
either create a non-empty commit or still fail the same way to give
the user another chance to try.

For example, when "git am -3" fails on such an email message (there
are two failure modes: (a) one results in an unmerged index due to
merge conflicts, (b) the other results in a clean index due to not
finding the blob object recorded as a preimage), what happens when
the user runs "git am --allow-empty", after:

 (1) doing nothing since the failed "git am -3" application,
 (2) resolving the conflicts in working tree, or
 (3) resolving the conflicts in working tree and recording the
     resolution in the index.

There are 6 cases in the above matrix, and "git am --allow-empty"
should not create an empty commit in any one of them.  In 1a and 1b,
"git am --allow-empty" should continue to fail ("git am --skip"
would be a way to ignore and proceed).  3a and 3b should record a
non-empty commit as the result.

Similarly, when an email message with a patch is given to "git am"
and the application fails, and the user runs "git am --allow-empty"
without doing anything in the working tree, what happens?  It should
not happily create an empty commit with only the log message,
without the change, but continue to fail.  If the user resolves and
registers the resolution to the index before "git am --allow-empty",
then the command should create a non-empty commit.

Having positive tests are of course important to avoid regression in
the future, but negative tests, the new and shiny feature does not
misbehave when it shouldn't even kick in, is even more important.

Thanks.
