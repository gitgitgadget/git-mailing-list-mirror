Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18D6C433E6
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 22:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9746764F2A
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 22:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhCQWrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 18:47:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:40632 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhCQWrE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 18:47:04 -0400
Received: (qmail 27954 invoked by uid 109); 17 Mar 2021 22:47:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Mar 2021 22:47:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14934 invoked by uid 111); 17 Mar 2021 22:47:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Mar 2021 18:47:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Mar 2021 18:47:03 -0400
From:   Jeff King <peff@peff.net>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH] t: annotate !PTHREADS tests with !FAIL_PREREQS
Message-ID: <YFKG52H090l/GbP7@coredump.intra.peff.net>
References: <CAL3xRKfSXDd0ucO4zaM5_WZeQfq10Hqpyk3nL+Zw8ttgfN0ZhA@mail.gmail.com>
 <YFC33vfLb36pRCO6@nand.local>
 <YFIGSo3U5u7zy9fq@C02YX140LVDN.corpad.adbkng.com>
 <YFJCUOCQGKHX2/So@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFJCUOCQGKHX2/So@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 01:54:25PM -0400, Jeff King wrote:

> -test_expect_success !PTHREADS 'pack-objects --threads=N or pack.threads=N warns when no pthreads' '
> +test_expect_success !PTHREADS,IGNORE_FAIL_PREREQS \
> +	'pack-objects --threads=N or pack.threads=N warns when no pthreads' '
>  	git pack-objects --threads=2 --stdout --all </dev/null >/dev/null 2>err &&
>  	grep ^warning: err >warnings &&
>  	test_line_count = 1 warnings &&
> 
> but I think this points to a failing of the FAIL_PREREQS mode. It is
> generally OK to say "skip this test by pretending you do not have a
> prereq satisfied" (and that is the point: to see if skipping a test
> confuses later tests). But given a negated prereq here, it is not OK to
> say "run this test that we usually wouldn't", because it is almost
> certainly going to be mismatched with the actual build.
> 
> So I think the FAIL_PREREQS mode should probably be treating negated
> prereqs differently (and always pretending that yes, we have them).
> 
> I hadn't investigated the t7810 case yet, but looking at it now, it
> seems to be the exact same thing.

It looks like the problem is indeed somewhat widespread, and there is a
magic prereq already to skip such tests.

I do still think that this is a fundamental failing of the FAIL_PREREQS
mode, but it probably makes sense to annotate these tests in the
meantime (I don't plan on looking further into it myself).

Another rough edge I noticed: if you set GIT_TEST_HTTPD or
GIT_TEST_GIT_DAEMON to "yes" in your config.mak, these play quite badly
with GIT_TEST_FAIL_PREREQS. We think NOT_ROOT is not satisfied, so
refuse to start httpd, and then complain that the setup fails (and the
point of "yes" for those values is to loudly complain when setup fails,
rather than quietly skipping the tests).

-- >8 --
Subject: [PATCH] t: annotate !PTHREADS tests with !FAIL_PREREQS

Some tests in t5300 and t7810 expect us to complain about a "--threads"
argument when Git is compiled without pthread support. Running these
under GIT_TEST_FAIL_PREREQS produces a confusing failure: we pretend to
the tests that there is no pthread support, so they expect the warning,
but of course the actual build is perfectly happy to respect the
--threads argument.

We never noticed before the recent a926c4b904 (tests: remove most uses
of C_LOCALE_OUTPUT, 2021-02-11), because the tests also were marked as
requiring the C_LOCALE_OUTPUT prerequisite. Which means they'd never
have run in FAIL_PREREQS mode, since it would always pretend that the
locale prereq was not satisfied.

These tests can't possibly work in this mode; it is a mismatch between
what the tests expect and what the build was told to do. So let's just
mark them to be skipped, using the special prereq introduced by
dfe1a17df9 (tests: add a special setup where prerequisites fail,
2019-05-13).

Reported-by: Son Luong Ngoc <sluongng@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5300-pack-object.sh | 6 ++++--
 t/t7810-grep.sh        | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index d586fdc7a9..e830a37a38 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -427,7 +427,8 @@ test_expect_success 'index-pack --strict <pack> works in non-repo' '
 	test_path_is_file foo.idx
 '
 
-test_expect_success !PTHREADS 'index-pack --threads=N or pack.threads=N warns when no pthreads' '
+test_expect_success !PTHREADS,!FAIL_PREREQS \
+	'index-pack --threads=N or pack.threads=N warns when no pthreads' '
 	test_must_fail git index-pack --threads=2 2>err &&
 	grep ^warning: err >warnings &&
 	test_line_count = 1 warnings &&
@@ -445,7 +446,8 @@ test_expect_success !PTHREADS 'index-pack --threads=N or pack.threads=N warns wh
 	grep -F "no threads support, ignoring pack.threads" err
 '
 
-test_expect_success !PTHREADS 'pack-objects --threads=N or pack.threads=N warns when no pthreads' '
+test_expect_success !PTHREADS,!FAIL_PREREQS \
+	'pack-objects --threads=N or pack.threads=N warns when no pthreads' '
 	git pack-objects --threads=2 --stdout --all </dev/null >/dev/null 2>err &&
 	grep ^warning: err >warnings &&
 	test_line_count = 1 warnings &&
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index edfaa9a6d1..5830733f3d 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -969,7 +969,8 @@ do
 	"
 done
 
-test_expect_success !PTHREADS 'grep --threads=N or pack.threads=N warns when no pthreads' '
+test_expect_success !PTHREADS,!FAIL_PREREQS \
+	'grep --threads=N or pack.threads=N warns when no pthreads' '
 	git grep --threads=2 Hello hello_world 2>err &&
 	grep ^warning: err >warnings &&
 	test_line_count = 1 warnings &&
-- 
2.31.0.559.g509d4a088b

