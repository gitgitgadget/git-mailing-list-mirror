Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957DDC433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 08:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhLMImn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 03:42:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55854 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhLMImk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 03:42:40 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB3E2F8126;
        Mon, 13 Dec 2021 03:42:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Io4CF9mIubzrHycIw5g6zFwgmCKyfMAbxPnnM4CqMjg=; b=Q3rx
        HwsPqa72jwQp9Fu9B0OHirvBETMS8VASgOGvDx3uAbhv9aDQUsNMEpzLn/dQA//p
        EgdC+3D97r/nxQh2T3OlBXvW8fZ9I93F8a9qt8lQVSZ1SuWEOUWjv6rmxq0xDHAC
        Vcf7n+mryxxJnhuEGJJQnS+dFCQXqwDudp6O0LY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0EBDF8125;
        Mon, 13 Dec 2021 03:42:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 507D8F8123;
        Mon, 13 Dec 2021 03:42:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>
Subject: Re: [RFC/PATCH] Makefile: add test-all target
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
        <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
        <xmqq4k7nmksi.fsf@gitster.g>
        <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
        <xmqqh7bi27o9.fsf@gitster.g> <xmqq8rwu278d.fsf_-_@gitster.g>
        <nycvar.QRO.7.76.6.2112110003530.90@tvgsbejvaqbjf.bet>
Date:   Mon, 13 Dec 2021 00:42:37 -0800
Message-ID: <xmqqh7bcgaki.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A06E53C2-5BF0-11EC-9124-C48D900A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Teach the main Makefile a "test-extra" target, which goes into each
>> package in contrib/ whose Makefile has its own "test" target and
>> runs "make test" there.  Add a "test-all" target to make it easy to
>> drive both the primary tests and these contrib tests from CI and use
>> it.
>
> That sends a strong message that the stuff in contrib/ is now fully under
> your maintenance, i.e. first-class supported.

I do not think running tests on stuff in contrib/ sends any such
message.  It primarily helps _us_ to catch more regressions than we
may otherwise miss.  By the way, this is not limited to contrib/; if
we had tests for gitk, we would have caught the recent regression in
"diff -m" before it got inflicted on the general public, but that
would not have been just to help "gitk", but to help keep "diff -m"
sane and stable [*].

By running tests on in-tree contrib/ like scalar, at least we would
notice when we are making breaking changes.  At least, the need for
scalar (either for the API broken by such a change to be kept
unchanged or done in a different way, or the code that uses the API
on the scalar side to be updated) would be noticed earlier than
stuff totally outside and not even in contrib/.

Of course, you have to bear the burden of (A) changing the way
scalar uses the API, or (B) participating in the design of the
change to the API that may break scalar's use so that everybody
including scalar would be happy, or both.  It's not like I am
responsible for everything that happens in the tree, and it is our
shared responsibility to maintain the health of the codebase.  It is
not limited to stuff inside or outside contrib/.

There are projects that want to use libgit.a by binding us as a
submodule and without interacting with us very much.  And they are
on their own when we change the internals.  Do you mean that you
want to make scalar into the same status as they are?

> Not that it needs more review, I don't think, as both Stolee and Elijah
> gave their thumbs-up already, and I've not received any feedback that
> would require further changes to `scalar.c`, at least as of _this_ patch
> series.

So that argues even more to have a way to make sure we catch
unintended breakages by any future mindless tree-wide "clean-ups"
and interface changes, no?


[Footnote]

* I just double checked the candidates for "test-extra" to see if
  they are meant to run with a random Git they happen to see on the
  $PATH, or they are designed to test with the version of Git we
  just built, and it seems it is the latter for the ones nominated
  in the test-extra patch.  Otherwise it would indeed reduce the
  benefit in half---we are not helping to catch regressions in the
  core stuff in such a case.
