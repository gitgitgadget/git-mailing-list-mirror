Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBF7E1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 14:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKLOF4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 09:05:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:45302 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726497AbfKLOFz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 09:05:55 -0500
Received: (qmail 483 invoked by uid 109); 12 Nov 2019 14:05:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Nov 2019 14:05:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14783 invoked by uid 111); 12 Nov 2019 14:09:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Nov 2019 09:09:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Nov 2019 09:05:54 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] test-lib: don't check prereqs of test cases that won't
 be run anyway
Message-ID: <20191112140554.GA13771@sigill.intra.peff.net>
References: <20191112122438.17057-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191112122438.17057-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 12, 2019 at 01:24:38PM +0100, SZEDER Gábor wrote:

> With './t1234-foo.sh -r 5,6' we can run only specific test cases in a
> test script, but our test framwork still evaluates all lazy prereqs
> that the excluded test cases might depend on.  This is unnecessary and
> produces verbose and trace output that can be distracting.  This has
> been an issue ever since the '-r|--run=' options were introduced in
> 0445e6f0a1 (test-lib: '--run' to run only specific tests, 2014-04-30),
> because that commit added the check of the list of test cases
> specified with '-r' after evaluating the prereqs.
> 
> Avoid this unnecessary prereq evaluation by checking the list of test
> cases specified with '-r' before looking at the prereqs.
> 
> Note that GIT_SKIP_TESTS has always been checked before the prereqs,
> so prereqs necessary for tests skipped that way were not evaluated.

Thanks. This definitely seems like an improvement. I verified that it
works in practice, and the patch itself looks obviously correct.

One of the things I had to double check is how to_skip is handled, since
we check it in the moved block. It's fine, but I wondered if the whole
thing would be easier as an if/else cascade with an early return. Like
the patch below (on top of your patch; try "diff -w" to quiet the
indentation noise).

But maybe it's not worth the churn (and if we pursue it at all, it
should not hold up your patch).

-Peff

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 24b541f494..a1784114cb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -993,49 +993,38 @@ test_finish_ () {
 }
 
 test_skip () {
-	to_skip=
 	skipped_reason=
 	if match_pattern_list $this_test.$test_count $GIT_SKIP_TESTS
 	then
-		to_skip=t
 		skipped_reason="GIT_SKIP_TESTS"
-	fi
-	if test -z "$to_skip" && test -n "$run_list" &&
+	elif test -n "$run_list" &&
 	   ! match_test_selector_list '--run' $test_count "$run_list"
 	then
-		to_skip=t
 		skipped_reason="--run"
-	fi
-	if test -z "$to_skip" && test -n "$test_prereq" &&
+	elif
+	if test -n "$test_prereq" &&
 	   ! test_have_prereq "$test_prereq"
 	then
-		to_skip=t
-
 		of_prereq=
 		if test "$missing_prereq" != "$test_prereq"
 		then
 			of_prereq=" of $test_prereq"
 		fi
 		skipped_reason="missing $missing_prereq${of_prereq}"
+	else
+		return 1
 	fi
 
-	case "$to_skip" in
-	t)
-		if test -n "$write_junit_xml"
-		then
-			message="$(xml_attr_encode "$skipped_reason")"
-			write_junit_xml_testcase "$1" \
-				"      <skipped message=\"$message\" />"
-		fi
+	if test -n "$write_junit_xml"
+	then
+		message="$(xml_attr_encode "$skipped_reason")"
+		write_junit_xml_testcase "$1" \
+			"      <skipped message=\"$message\" />"
+	fi
 
-		say_color skip >&3 "skipping test: $@"
-		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
-		: true
-		;;
-	*)
-		false
-		;;
-	esac
+	say_color skip >&3 "skipping test: $@"
+	say_color skip "ok $test_count # skip $1 ($skipped_reason)"
+	return 0
 }
 
 # stub; perf-lib overrides it
