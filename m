Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0A2C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6549364F10
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhCQRyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 13:54:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:39678 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232847AbhCQRy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 13:54:26 -0400
Received: (qmail 26200 invoked by uid 109); 17 Mar 2021 17:54:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Mar 2021 17:54:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10020 invoked by uid 111); 17 Mar 2021 17:54:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Mar 2021 13:54:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Mar 2021 13:54:24 -0400
From:   Jeff King <peff@peff.net>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, jonathantanmy@google.com, gitster@pobox.com
Subject: Re: Tests failed with GIT_TEST_FAIL_PREREQS and/or
 GIT_TEST_PROTOCOL_VERSION
Message-ID: <YFJCUOCQGKHX2/So@coredump.intra.peff.net>
References: <CAL3xRKfSXDd0ucO4zaM5_WZeQfq10Hqpyk3nL+Zw8ttgfN0ZhA@mail.gmail.com>
 <YFC33vfLb36pRCO6@nand.local>
 <YFIGSo3U5u7zy9fq@C02YX140LVDN.corpad.adbkng.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFIGSo3U5u7zy9fq@C02YX140LVDN.corpad.adbkng.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 02:38:18PM +0100, Son Luong Ngoc wrote:

> 1. For t7810 and t5300 failing when GIT_TEST_FAIL_PREREQS=1:
> 
>     a926c4b904bdc339568c2898af955cdc61b31542 is the first bad commit
>     commit a926c4b904bdc339568c2898af955cdc61b31542
>     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>     Date:   Thu Feb 11 02:53:51 2021 +0100
> 
>         tests: remove most uses of C_LOCALE_OUTPUT
> 
>         As a follow-up to d162b25f956 (tests: remove support for
>         GIT_TEST_GETTEXT_POISON, 2021-01-20) remove those uses of the now
>         always true C_LOCALE_OUTPUT prerequisite from those tests which
>         declare it as an argument to test_expect_{success,failure}.
> 
>         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>         Signed-off-by: Junio C Hamano <gitster@pobox.com>

I looked at the one in t5300, and I don't think it _ever_ worked, nor
can it be made to work in this mode.

It is expecting that running:

  git index-pack --threads=2

will issue a warning in a build without pthread support. But in the fake
"pretend the pthread prereq is not satisfied" mode, it will of course
not do that, because the build itself is not aware that it's supposed to
be pretending that pthreads aren't supported!

Before the patch mentioned above, its prereqs were:

  !PTHREADS,C_LOCALE_OUTPUT

which would never be satisfied under the "pretend" mode, because
it would _also_ disable C_LOCALE_OUTPUT, and we'd always skip it.

So I think something like this creates a similar situation;

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index d586fdc7a9..87d26bb70c 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -427,7 +427,8 @@ test_expect_success 'index-pack --strict <pack> works in non-repo' '
 	test_path_is_file foo.idx
 '
 
-test_expect_success !PTHREADS 'index-pack --threads=N or pack.threads=N warns when no pthreads' '
+test_expect_success !PTHREADS,IGNORE_FAIL_PREREQS \
+	'index-pack --threads=N or pack.threads=N warns when no pthreads' '
 	test_must_fail git index-pack --threads=2 2>err &&
 	grep ^warning: err >warnings &&
 	test_line_count = 1 warnings &&
@@ -445,7 +446,8 @@ test_expect_success !PTHREADS 'index-pack --threads=N or pack.threads=N warns wh
 	grep -F "no threads support, ignoring pack.threads" err
 '
 
-test_expect_success !PTHREADS 'pack-objects --threads=N or pack.threads=N warns when no pthreads' '
+test_expect_success !PTHREADS,IGNORE_FAIL_PREREQS \
+	'pack-objects --threads=N or pack.threads=N warns when no pthreads' '
 	git pack-objects --threads=2 --stdout --all </dev/null >/dev/null 2>err &&
 	grep ^warning: err >warnings &&
 	test_line_count = 1 warnings &&

but I think this points to a failing of the FAIL_PREREQS mode. It is
generally OK to say "skip this test by pretending you do not have a
prereq satisfied" (and that is the point: to see if skipping a test
confuses later tests). But given a negated prereq here, it is not OK to
say "run this test that we usually wouldn't", because it is almost
certainly going to be mismatched with the actual build.

So I think the FAIL_PREREQS mode should probably be treating negated
prereqs differently (and always pretending that yes, we have them).

I hadn't investigated the t7810 case yet, but looking at it now, it
seems to be the exact same thing.

-Peff
