Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA3FC6369E
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 17:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545F8246AD
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 17:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgKSR4K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 12:56:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:35814 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbgKSR4K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 12:56:10 -0500
Received: (qmail 31458 invoked by uid 109); 19 Nov 2020 17:56:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Nov 2020 17:56:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30393 invoked by uid 111); 19 Nov 2020 17:56:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Nov 2020 12:56:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Nov 2020 12:56:08 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] tests: make sure nested lazy prereqs work reliably
Message-ID: <20201119175608.GA132922@coredump.intra.peff.net>
References: <20201118190414.32616-1-szeder.dev@gmail.com>
 <20201119155824.GB25426@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201119155824.GB25426@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 19, 2020 at 10:58:24AM -0500, Jeff King wrote:

> > +if test -z "$GIT_TEST_FAIL_PREREQS_INTERNAL" && test "$nestedworks" != yes
> > +then
> > +	say 'bug in test framework: nested lazy prerequisites do not work'
> > +	exit 1
> > +fi
> 
> I was surprised to see this bare exit, because I know we have some
> functions (run_sub_test_*) to help with testing the framework itself. It
> looks like the other prereq tests don't use it either, though. I wonder
> if there is a technical reason, or if they were simply added at a
> different time. (Either way, I am OK for your new test to match the
> surrounding ones like you have here).

I took a look at converting some of the existing tests. This seems to
work. It's a bit longer to read, perhaps, but I kind of like that the
expected outcome is all laid out. It also pollutes the test output less
(e.g., if you wanted to count up skipped tests in the whole suite, you'd
get a bunch of noise from t0000 for these uninteresting skips).

Thoughts? I think this is something I'd do on top of your patch.

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index f4ba2e8c85..f369af76be 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -759,43 +759,50 @@ test_expect_success '--run invalid range end' "
 	EOF_ERR
 "
 
-
-test_set_prereq HAVEIT
-haveit=no
-test_expect_success HAVEIT 'test runs if prerequisite is satisfied' '
-	test_have_prereq HAVEIT &&
-	haveit=yes
-'
-donthaveit=yes
-test_expect_success DONTHAVEIT 'unmet prerequisite causes test to be skipped' '
-	donthaveit=no
-'
-if test -z "$GIT_TEST_FAIL_PREREQS_INTERNAL" -a $haveit$donthaveit != yesyes
-then
-	say "bug in test framework: prerequisite tags do not work reliably"
-	exit 1
-fi
-
-test_set_prereq HAVETHIS
-haveit=no
-test_expect_success HAVETHIS,HAVEIT 'test runs if prerequisites are satisfied' '
-	test_have_prereq HAVEIT &&
-	test_have_prereq HAVETHIS &&
-	haveit=yes
-'
-donthaveit=yes
-test_expect_success HAVEIT,DONTHAVEIT 'unmet prerequisites causes test to be skipped' '
-	donthaveit=no
-'
-donthaveiteither=yes
-test_expect_success DONTHAVEIT,HAVEIT 'unmet prerequisites causes test to be skipped' '
-	donthaveiteither=no
+test_expect_success 'tests respect prerequisites' '
+	run_sub_test_lib_test prereqs "tests respect prereqs" <<-\EOF &&
+
+	test_set_prereq HAVEIT
+	haveit=no
+	test_expect_success HAVEIT "prereq is satisfied" "
+		test_have_prereq HAVEIT &&
+		haveit=yes
+	"
+
+	donthaveit=yes
+	test_expect_success DONTHAVEIT "prereq not satisfied" "
+		donthaveit=no
+	"
+
+	test_set_prereq HAVETHIS
+	haveit=no
+	test_expect_success HAVETHIS,HAVEIT "multiple prereqs" "
+		test_have_prereq HAVEIT &&
+		test_have_prereq HAVETHIS &&
+		haveit=yes
+	"
+
+	donthaveit=yes
+	test_expect_success HAVEIT,DONTHAVEIT "mixed prereqs (yes,no)" "
+		donthaveit=no
+	"
+
+	donthaveiteither=yes
+	test_expect_success DONTHAVEIT,HAVEIT "mixed prereqs (no,yes)" "
+		donthaveiteither=no
+	"
+	test_done
+	EOF
+	check_sub_test_lib_test prereqs <<-\EOF
+	ok 1 - prereq is satisfied
+	ok 2 # skip prereq not satisfied (missing DONTHAVEIT)
+	ok 3 - multiple prereqs
+	ok 4 # skip mixed prereqs (yes,no) (missing DONTHAVEIT of HAVEIT,DONTHAVEIT)
+	ok 5 # skip mixed prereqs (no,yes) (missing DONTHAVEIT of DONTHAVEIT,HAVEIT)
+	# passed all 5 test(s)
+	1..5
+	EOF
 '
-if test -z "$GIT_TEST_FAIL_PREREQS_INTERNAL" -a $haveit$donthaveit$donthaveiteither != yesyesyes
-then
-	say "bug in test framework: multiple prerequisite tags do not work reliably"
-	exit 1
-fi
 
 test_lazy_prereq LAZY_TRUE true
 havetrue=no
