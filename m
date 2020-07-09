Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F84C433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 20:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D443520774
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 20:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgGIUmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:42:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:53558 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgGIUmF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 16:42:05 -0400
Received: (qmail 5842 invoked by uid 109); 9 Jul 2020 20:42:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jul 2020 20:42:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25092 invoked by uid 111); 9 Jul 2020 20:42:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jul 2020 16:42:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Jul 2020 16:42:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 4/4] test-lib: set deterministic default author/committer date
Message-ID: <20200709204204.GD661064@coredump.intra.peff.net>
References: <20200709203336.GA2748777@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200709203336.GA2748777@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We always set the name and email for committer and author idents to make
the test suite more deterministic, but not timestamps. Many scripts use
test_tick to get consistent and sensibly incrementing timestamps as they
create commits. But other scripts don't particularly care about the
timestamp, and are happy to use whatever the current system time is.

This non-determinism can be annoying:

  - when debugging a test, comparing results between two runs can be
    difficult, because the commit ids change

  - this can sometimes cause tests to be racy. E.g., traversal order
    depends on timestamp order. Even in a well-ordered set of commands,
    because our timestamp granularity is one second, two commits might
    sometimes have the same timestamp and sometimes differ.

Let's set a default timestamp for all scripts to use. Any that use
test_tick already will be unaffected (because their first test_tick call
will overwrite our default), but it will make things a bit more
deterministic for those that don't.

We should be able to choose any time we want here. I picked this one
because:

  - it differs from the initial test_tick default, which may make it
    easier to distinguish when debugging tests. I picked "April 1st
    13:14:15" in the hope that it might stand out.

  - it's slightly before the test_tick default. Some tests create some
    commits before the first call to test_tick, so using an older
    timestamps for those makes sense chronologically. Note that this
    isn't how things currently work (where system times are usually more
    recent than test_tick), but that also allows us to flush out a few
    hidden timestamp dependencies (like the one recently fixed in
    t5539).

  - we could likewise pick any timezone we want. Choosing +0000 would
    have required fixing up fewer tests, but we're more likely to turn
    up interesting cases by not matching $TZ exactly. And since
    test_tick already checks "-0700", let's try something in the "+"
    zone range for variety.

It's possible that the non-deterministic times could help flush out bugs
(e.g., if something broke when the clock flipped over to 2021, our test
suite would let us know). But historically that hasn't been the case;
all time-dependent outcomes we've seen turned out to be accidentally
flaky tests (which we fixed by using test_tick). If we do want to cover
handling the current time, we should dedicate one script to doing so,
and have it unset GIT_COMMITTER_DATE explicitly.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 618a7c8d5b..ba224c86f5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -441,15 +441,18 @@ TEST_AUTHOR_LOCALNAME=author
 TEST_AUTHOR_DOMAIN=example.com
 GIT_AUTHOR_EMAIL=${TEST_AUTHOR_LOCALNAME}@${TEST_AUTHOR_DOMAIN}
 GIT_AUTHOR_NAME='A U Thor'
+GIT_AUTHOR_DATE='1112354055 +0200'
 TEST_COMMITTER_LOCALNAME=committer
 TEST_COMMITTER_DOMAIN=example.com
 GIT_COMMITTER_EMAIL=${TEST_COMMITTER_LOCALNAME}@${TEST_COMMITTER_DOMAIN}
 GIT_COMMITTER_NAME='C O Mitter'
+GIT_COMMITTER_DATE='1112354055 +0200'
 GIT_MERGE_VERBOSITY=5
 GIT_MERGE_AUTOEDIT=no
 export GIT_MERGE_VERBOSITY GIT_MERGE_AUTOEDIT
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
+export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
 export EDITOR
 
 # Tests using GIT_TRACE typically don't want <timestamp> <file>:<line> output
-- 
2.27.0.730.gcc195a083d
