Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309A1C433DB
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 23:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1FD12251F
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 23:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbhAQXes (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 18:34:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51478 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbhAQXeq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 18:34:46 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DEF499A83E;
        Sun, 17 Jan 2021 18:34:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V2nvVZSZQkfCRbF9nBc51ENbXck=; b=LoOup7
        mCFqKRVPBvoLTZ6FIYMrKlgL83wP4ExZ2ZayV1fIRJOR+H44PGb5aADgDklJE0MM
        fO5wLf7Gn4Qtjhh7mLAauyeEcqxanlhrRgpu2qPbJe0r5Y2mr3Pn4K/kU9/Yrtpa
        A9yBKDZV9YYS1RobwN078p9sHha9NIBrOw7fc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VqlEtZ7a/s+WffH5TW3b5sl0W2x7PJ6C
        njIGZOswRf2+1/oAMQjWQw+d/gX52FYf0Cjder9Xy+I1J+qvvpYHVJidrcDqljNH
        qoxCVajOVOVarkWldtaGbYd9mAIsxoMR/NO+JQTR31mNS+QQsADG/JN7T2zHLt7F
        gSAVGq8rRIs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6CC09A83D;
        Sun, 17 Jan 2021 18:34:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D3879A83C;
        Sun, 17 Jan 2021 18:34:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Subject: Re: [PATCH v4 3/3] ls-files: add --deduplicate option
References: <pull.832.v3.git.1610626942677.gitgitgadget@gmail.com>
        <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
        <0c7830d07db0aa1ec055b97de52bd873d05e3ab1.1610856136.git.gitgitgadget@gmail.com>
Date:   Sun, 17 Jan 2021 15:34:01 -0800
In-Reply-To: <0c7830d07db0aa1ec055b97de52bd873d05e3ab1.1610856136.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Sun, 17 Jan 2021 04:02:16
        +0000")
Message-ID: <xmqqbldnkuja.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B211924-591C-11EB-8DDA-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/t3012-ls-files-dedup.sh b/t/t3012-ls-files-dedup.sh
> new file mode 100755
> index 00000000000..75877255c2c
> --- /dev/null
> +++ b/t/t3012-ls-files-dedup.sh
> @@ -0,0 +1,57 @@
> +#!/bin/sh
> +
> +test_description='git ls-files --deduplicate test'
> +
> +. ./test-lib.sh

We should already have a ls-files test so that we can add a handful
new tests to it, instead of dedicating a whole new test script.

Also, don't do everything in a single 'setup'.  There are various
scenarios you want to make sure ls-files to work (grep for ls-files
in the following you added---I count 4 of them), and when a future
developer touches the code, he or she may break one but not other
three.  The purpose you write tests is to protect your new feature
from such a developer *AND* help such a developer to debug and fix
his or her changes.  For that, it would be a lot more sensible to
have one set-up that is common, and then four separate tests.

> +test_expect_success 'setup' '
> +	>a.txt &&
> +	>b.txt &&
> +	>delete.txt &&
> +	git add a.txt b.txt delete.txt &&
> +	git commit -m master:1 &&

Needless use of the word "master".  Observe what is going on in the
project around you and avoid stepping other peoples' toes.  One of
the ongoing effort is to grep for the phrase master in t/ directory
and examine what happens when the default initial branch name
becomes something other than 'master', so adding a needless hit like
this is most unwelcome.

> +	echo a >a.txt &&
> +	echo b >b.txt &&
> +	echo delete >delete.txt &&
> +	git add a.txt b.txt delete.txt &&
> +	git commit -m master:2 &&

> +	git checkout HEAD~ &&
> +	git switch -c dev &&

Needless mixture of checkout/switch.  If you switch branches using
"git checkout", for example, consistently do so, i.e.

	git checkout -b dev HEAD~1 

It's not like these new tests are to test checkout and switch; your
mission is to protect "ls-files --dedup" feature here.

> +	test_when_finished "git switch master" &&
> +	echo change >a.txt &&
> +	git add a.txt &&
> +	git commit -m dev:1 &&

I'd consider all of the above to be 'setup' that is common for
subsequent tests.  It may make sense to actually do everything
on the initial branch, i.e. after creating two commits, do

	git tag tip &&
	git reset --hard HEAD^ &&
	echo change >a.txt &&
	git commit -a -m side &&
	git tag side

You are always on the initial branch without ever switching, so
there is no need for the when_finished stuff.

Then the first of your test is to show the index with conflicts.

> +	test_must_fail git merge master &&

This will become "git merge tip" instead of 'master'.

> +	git ls-files --deduplicate >actual &&
> +	cat >expect <<-\EOF &&
> +	a.txt
> +	b.txt
> +	delete.txt
> +	EOF
> +	test_cmp expect actual &&

And up to this point is the first test after 'setup'.

The next test should begin with:

	git reset --hard side &&
	test_must_fail git merge tip &&

so that even when the first test is skipped, or left unmerged,
you'll begin with a known state.

> +	rm delete.txt &&
> +	git ls-files -d -m --deduplicate >actual &&
> +	cat >expect <<-\EOF &&
> +	a.txt
> +	delete.txt
> +	EOF
> +	test_cmp expect actual &&
> +	git ls-files -d -m -t  --deduplicate >actual &&
> +	cat >expect <<-\EOF &&
> +	C a.txt
> +	C a.txt
> +	C a.txt
> +	R delete.txt
> +	C delete.txt
> +	EOF
> +	test_cmp expect actual &&
> +	git ls-files -d -m -c  --deduplicate >actual &&
> +	cat >expect <<-\EOF &&
> +	a.txt
> +	b.txt
> +	delete.txt
> +	EOF
> +	test_cmp expect actual &&

These three can be kept in the same test_expect_success, as they are
exercising read-only operation on the same state but with different
display options.

But in this case, the preparation is not too tedious (just a failed
merge plus a deletion), so you probably would prefer to split it
into 3 independent tests---that may make it more helpful to future
developers.

> +	git merge --abort
> +'
> +test_done
