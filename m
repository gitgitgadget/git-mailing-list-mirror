Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2D7C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 02:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 744D8610A1
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 02:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbhIVCZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 22:25:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:52314 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhIVCZi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 22:25:38 -0400
Received: (qmail 7463 invoked by uid 109); 22 Sep 2021 02:24:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Sep 2021 02:24:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8600 invoked by uid 111); 22 Sep 2021 02:24:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Sep 2021 22:24:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Sep 2021 22:24:08 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 1/3] Makefile: make the "sparse" target non-.PHONY
Message-ID: <YUqTyJQ8euArYeVn@coredump.intra.peff.net>
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
 <patch-1.3-e03fde1b642-20210921T224944Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.3-e03fde1b642-20210921T224944Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 12:55:13AM +0200, Ævar Arnfjörð Bjarmason wrote:

> On my box with -j8 it was fast before, or around 5 seconds, now it
> only takes that long the first time, and the common case is <100ms, or
> however long it takes GNU make to stat the *.sp file and see that all
> the corresponding *.c files are older.

Sort of side note, but I think the main culprit here is all of the
$(shell) invocations, etc, we run. Try:

  make SHELL_PATH='sh -x'

to get a taste (do it twice, because the first one will actually rebuild
everything due to the changed shell; the second one _should_ be a noop
but still runs a bunch of stuff).

Though even that doesn't tell the whole story, as it doesn't make clear
which shells are invoked by make directly. Try this:

	cat >/tmp/foo <<-\EOF
	#!/bin/sh
	echo >&2 "==> shell $*"
	exec sh "$@"
	EOF

	make SHELL_PATH=/tmp/foo

There's lots of low-hanging fruit like:

==> shell -c echo TEST_SHELL_PATH=\''/tmp/foo'\' >>GIT-BUILD-OPTIONS+
==> shell -c echo PERL_PATH=\''/usr/bin/perl'\' >>GIT-BUILD-OPTIONS+
==> shell -c echo DIFF=\''diff'\' >>GIT-BUILD-OPTIONS+
==> shell -c echo PYTHON_PATH=\''/usr/bin/python'\' >>GIT-BUILD-OPTIONS+
[...and over a dozen more...]

Those could easily be a single shell invocation, rather than one per
echo. Another culprit is GIT-VERSION-GEN, which we run whether it's
needed or not, and takes something like 25ms.

It's probably not worth spending too much time micro-optimizing here
(and certainly it's orthogonal to your series), but there may be some
low-hanging fruit (although a hacky attempt at minimizing the shell
calls for GIT-BUILD-OPTIONS didn't seem to show any speedup, so maybe
it's not so low-hanging after all).

-Peff
