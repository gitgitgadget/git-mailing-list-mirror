Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398D9C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E4AE611BD
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbhIJOix (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 10:38:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:43936 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233120AbhIJOiw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 10:38:52 -0400
Received: (qmail 5899 invoked by uid 109); 10 Sep 2021 14:37:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 14:37:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25649 invoked by uid 111); 10 Sep 2021 14:37:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 10:37:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 10:37:40 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 0/8] post-v2.33 "drop support for ancient curl"
 follow-up
Message-ID: <YTtttIuur0JvcPub@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 01:04:25PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Version 1 of this had a really bad bug where we'd effectively make all
> supported curl versions act like 7.19.4, i.e. the oldest supported
> version except for a couple of our supported features. This is because
> most of the things checked with the "ifdef" checks are enum fields,
> not macros. So basically the "devil's advocate" Jeff King pointed out
> in [2] was already the case. Oops!

Oops. :)

Well, I'm glad I mentioned it, then (I really was just playing devil's
advocate). It does seem a little scary that we'd compile without all of
these features and not even notice it.

I guess it's hard to test for those features when we don't know for sure
that our libcurl supports them. We could perhaps make the tests
optional, but how do we set up the prereqs?

Version checks based on "curl --version" or even "pkg-config
--modversion libcurl" seems error-prone. The curl binary might not match
the library we used, or the user might have given us a specific libcurl
to use rather than the pkg-config version. We could teach Git to tell us
which features it thinks curl supports, but that's depending on the very
thing we're trying to test. We could have Git output the
LIBCURL_VERSION_NUM it saw at build time, but then we're just
implementing the same "if version > X, we have this feature" logic now
in the test suite.

So I dunno. I do not have any clever solution that would have caught
this automatically without creating an even bigger maintenance headache.

(Though for other reasons, it might be nice to report the curl version
from "git version --build-options". This is a bit tricky because we
avoid linking at libcurl at all in the main binary. Definitely
orthogonal to your series, anyway).

> This means that anyone on an older distro with backported features
> will need to -DGIT_CURL_HAVE_* if their version of curl supports some
> of these via a backport, not ideal, but an acceptable trade-off. If we
> cared about this we could have some "detect-curl" script similar to my
> proposed "detect-compiler"[3] (or another homegrown autoconf
> replacement).

I think that's acceptable. This should be rare, and they can always set
CFLAGS appropriately.

-Peff
