Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7CFC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 22:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240920AbhLHW0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 17:26:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52645 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbhLHW0I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 17:26:08 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C3ABEC541;
        Wed,  8 Dec 2021 17:22:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gDaMg7NjBY+me3MDLbK0PsGwaNcZz+bYLOZgAx
        XY6gY=; b=j0iE8t4/wdh30W7z1/2UrC8fqOMZbpg8QHE/7IVHwtX0arHFbawhpD
        1fD5TKCJLafmlut/gGtykhfTevXRI3Zdo0qqclCNrwqlSkS+xx4N9VrVTWT0Cfu3
        +TYPuilP48lRXOyGeaKKAX7n1GBXVtX9+WN2mrWSkTz2wclh1jtE4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 935BCEC540;
        Wed,  8 Dec 2021 17:22:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 079DDEC53F;
        Wed,  8 Dec 2021 17:22:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC/PATCH] Makefile: add test-all target
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
        <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
        <xmqq4k7nmksi.fsf@gitster.g>
        <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
        <xmqqh7bi27o9.fsf@gitster.g> <xmqq8rwu278d.fsf_-_@gitster.g>
        <4dbca719-a1df-27e9-6e07-dea3f2e2638b@gmail.com>
Date:   Wed, 08 Dec 2021 14:22:33 -0800
In-Reply-To: <4dbca719-a1df-27e9-6e07-dea3f2e2638b@gmail.com> (Derrick
        Stolee's message of "Wed, 8 Dec 2021 16:30:06 -0500")
Message-ID: <xmqqilvyybx2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57E27D8C-5875-11EC-9072-C48D900A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> +test-extra: all
>> +	$(MAKE) -C contrib/diff-highlight test
>> +	$(MAKE) -C contrib/mw-to-git test
>> +	$(MAKE) -C contrib/subtree test
>
> I like how this is obviously extendible to include contrib/scalar
> in a later change, then remove it when Scalar moves.
>
>> +test-all:: test test-extra
>
> And this test-all implies that test runs before test-extra, so
> libgit.a is compiled appropriately.

I do not think this implies the ordering between the main test and
the extra test.  "make test-all" actually makes a confusing mess on
the terminal by conflating outputs from the main test and tests run
in contrib.

But because test-extra depends on all, we are keeping the assumption
that Makefiles in contrib/ may assume that the primary build has
already been done.

>> diff --git i/ci/run-build-and-tests.sh w/ci/run-build-and-tests.sh
>> index cc62616d80..9da0f26665 100755
>> --- i/ci/run-build-and-tests.sh
>> +++ w/ci/run-build-and-tests.sh
>> @@ -19,7 +19,7 @@ make
>>  case "$jobname" in
>>  linux-gcc)
>>  	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>> -	make test
>> +	make test-all
>
> Since we are now building and testing things that we have not been
> testing recently, it is worth checking that we don't have any work
> to do to make this pass. I assume that you've run 'make test-all'
> on your own machine. It will be good to see what the full action
> reports (probably all good).

Yes, I am tempted to queue this at the tip of 'seen'.



