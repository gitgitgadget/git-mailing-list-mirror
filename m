Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2FCC433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 21:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8462075B
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 21:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgGGVlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:41:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:51754 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgGGVlx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 17:41:53 -0400
Received: (qmail 23373 invoked by uid 109); 7 Jul 2020 21:41:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jul 2020 21:41:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32057 invoked by uid 111); 7 Jul 2020 21:41:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2020 17:41:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Jul 2020 17:41:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] Make some commit hashes in tests reproducible
Message-ID: <20200707214151.GA2300036@coredump.intra.peff.net>
References: <pull.816.git.git.1594149804313.gitgitgadget@gmail.com>
 <xmqqfta33y0m.fsf@gitster.c.googlers.com>
 <20200707205418.GB1396940@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200707205418.GB1396940@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 07, 2020 at 04:54:18PM -0400, Jeff King wrote:

> Note that the patch above does seem to cause two tests to fail. One of
> them I _suspect_ is a raciness problem (order of commits output changes,
> which implies the original was expecting the time to increment between
> two commits without running test_tick).

It turns out this does depend on the system clock, but isn't racy in the
traditional sense. See the explanation below (which might be worth doing
even if we don't switch to a deterministic time everywhere else).

-- >8 --
Subject: [PATCH] t6000: use test_tick consistently

The first two commits created in t6000 are done without test_tick,
meaning they use the current system clock. After that, we create one
with test_tick, which means it uses a deterministic time in the past.

The result of the "symleft flag bit is propagated down from tag" test
relies on the output order of commits from git-log, which in turn
depends on these timestamps. So this test is technically dependent on
the system clock time, though in practice it would only matter if your
system clock was set before test_tick's default time (which is in 2005).

However, let's use test_tick consistently for those early commits (and
update the expected output to match). This makes the test deterministic,
which is in turn easier to reason about and debug.

Note that there's also a fourth commit here, and it does not use
test_tick. It does have a deterministic timestamp because of the prior
use of test_tick in the script, but it will always be the same time as
the third commit. Let's use test_tick here, too, for consistency.  The
matching timestamps between the third and fourth commit are not an
important part of the test.

We could also use test_commit in all of these cases, as it runs
test_tick under the hood. But it would be awkward to do so, as these
tests diverge from the usual test_commit patterns (e.g., by creating
multiple files in a single commit).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t6000-rev-list-misc.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 3dc1ad8f71..3bb0e4ff8f 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -8,6 +8,7 @@ test_expect_success setup '
 	echo content1 >wanted_file &&
 	echo content2 >unwanted_file &&
 	git add wanted_file unwanted_file &&
+	test_tick &&
 	git commit -m one
 '
 
@@ -21,6 +22,7 @@ test_expect_success 'rev-list --objects with pathspecs and deeper paths' '
 	mkdir foo &&
 	>foo/file &&
 	git add foo/file &&
+	test_tick &&
 	git commit -m two &&
 
 	git rev-list --objects HEAD -- foo >output &&
@@ -69,6 +71,7 @@ test_expect_success '--no-object-names and --object-names are last-one-wins' '
 '
 
 test_expect_success 'rev-list A..B and rev-list ^A B are the same' '
+	test_tick &&
 	git commit --allow-empty -m another &&
 	git tag -a -m "annotated" v1.0 &&
 	git rev-list --objects ^v1.0^ v1.0 >expect &&
@@ -84,10 +87,10 @@ test_expect_success 'propagate uninteresting flag down correctly' '
 test_expect_success 'symleft flag bit is propagated down from tag' '
 	git log --format="%m %s" --left-right v1.0...master >actual &&
 	cat >expect <<-\EOF &&
-	> two
-	> one
 	< another
 	< that
+	> two
+	> one
 	EOF
 	test_cmp expect actual
 '
-- 
2.27.0.730.gcc195a083d

