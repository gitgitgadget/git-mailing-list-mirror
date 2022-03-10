Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1743C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 22:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbiCJW4R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 17:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiCJW4P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 17:56:15 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856F418461D
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:55:13 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 253DF118992;
        Thu, 10 Mar 2022 17:55:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9f7hLDrNeuT59o/1uYv47t2fIZ6uSdRB2C0vmN
        gdRXo=; b=NK01ZVRU9s/22gomgwZ/VSyn7aYQpP6lhnDfHpwULqO08RchGa7XqJ
        cf5/TkwnzsUqR11KqZtKL++uM6x3Mc+D+niN/mlbrjffo7FFF3wL5Lds4uFRUFRQ
        VCK8EcnVO+o4Jwm+bKFgSrbJaAgiE8YTzcpYdiqJen53sle/GB+NQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DD7D118991;
        Thu, 10 Mar 2022 17:55:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 77A61118990;
        Thu, 10 Mar 2022 17:55:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Cai <johncai86@gmail.com>
Cc:     Michael McClimon <michael@mcclimon.org>, git@vger.kernel.org
Subject: Re: Bug with rebase and commit hashes
References: <YiokTm3GxIZQQUow@newk>
        <C92B297B-0634-40CC-B1C6-B2A7325BF7DA@gmail.com>
Date:   Thu, 10 Mar 2022 14:55:10 -0800
In-Reply-To: <C92B297B-0634-40CC-B1C6-B2A7325BF7DA@gmail.com> (John Cai's
        message of "Thu, 10 Mar 2022 17:25:16 -0500")
Message-ID: <xmqqsfrpbepd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 240738CA-A0C5-11EC-939F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Cai <johncai86@gmail.com> writes:

>> I hit this in production on git 2.30.2 (debian bullseye), but reproduced
>> locally using the latest git main, which is git version 2.35.1.415.gc2162907.
>> In both cases I wiped my user gitconfig, so I'm using only the defaults. (If
>> it helps: with my rebase.autosquash = true, the bad case above does not behave
>> badly and leaves me in detached head as I'd expect.) It's totally possible
>> this isn't _meant_ to work, in which case I think the docs could use an
>> update.

A quick bisect session leads us to 176f5d96 (built-in rebase
--autostash: leave the current branch alone if possible,
2018-11-07), but I do not know how much commonality exists in the
current code (read: we may well have inherited the bug from there,
or we rewrote it completely away but reinvented the same bug in the
current code).

with this test script dropped as t/x9999-c.sh
--- >8 ---
#!/bin/sh

test_description='rebase???'

. ./test-lib.sh

test_expect_success setup '
	git init &&
	>file &&
	git add file &&
	git commit -m initial &&
	git checkout -b side &&
	echo >>file &&
	git commit -a -m side &&
	git checkout master &&
	git tag hold
'

test_expect_success rebase '
	git checkout -B master hold &&
	git rev-parse master >pre &&
	git rebase $(git rev-parse master) $(git rev-parse side) &&
	git rev-parse master >post &&
	test_cmp pre post
'

test_done
--- 8< ---

and this as "git bisect run ./runme.sh" script:

--- >8 ---
#!/bin/sh

make -j16 NO_OPENSSL=Yes CFLAGS="-g -O" || exit 125
cd t && sh -v ./x9999-c.sh -i -v
--- 8< ---

The NO_OPENSSL thing is there only because I started bisecting from
an ancient version that no longer compiles out of the box in my
environment.
