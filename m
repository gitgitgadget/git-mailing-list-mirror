Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5421D209F1
	for <e@80x24.org>; Sat,  8 Apr 2017 10:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbdDHKLt (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 06:11:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:58454 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751772AbdDHKLr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 06:11:47 -0400
Received: (qmail 3247 invoked by uid 109); 8 Apr 2017 10:11:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Apr 2017 10:11:44 +0000
Received: (qmail 10505 invoked by uid 111); 8 Apr 2017 10:12:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Apr 2017 06:12:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Apr 2017 06:11:42 -0400
Date:   Sat, 8 Apr 2017 06:11:42 -0400
From:   Jeff King <peff@peff.net>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 1/3] read-cache: add strcmp_offset function
Message-ID: <20170408101142.iztq3lxcaayw2w6q@sigill.intra.peff.net>
References: <20170407212047.64950-1-git@jeffhostetler.com>
 <20170407212047.64950-2-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170407212047.64950-2-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 07, 2017 at 09:20:45PM +0000, git@jeffhostetler.com wrote:

> diff --git a/t/helper/test-strcmp-offset.c b/t/helper/test-strcmp-offset.c
> new file mode 100644
> index 0000000..03e1eef
> --- /dev/null
> +++ b/t/helper/test-strcmp-offset.c
> @@ -0,0 +1,64 @@
> +#include "cache.h"
> +
> +struct test_data {
> +	const char *s1;
> +	const char *s2;
> +	size_t expected_first_change; /* or strlen() when equal */
> +};
> +
> +static struct test_data data[] = {
> +	{ "abc", "abc", 3 },
> +	{ "abc", "def", 0 },
> +
> +	{ "abc", "abz", 2 },
> +
> +	{ "abc", "abcdef", 3 },
> +
> +	{ "abc\xF0zzz", "abc\xFFzzz", 3 },
> +
> +	{ NULL, NULL, 0 }
> +};

I've been thinking a bit on the comments on earlier rounds regarding C
tests. I think in the early days, we generally had plumbing that exposed
the C interfaces in a pretty transparent way. I.e., it was reasonable to
unit-test update-index, because you pretty much know how input to it
will map to the code and data structures used.

These days we have more C infrastructure, and it's sometimes hard to
tickle the exact inputs to those modules through plumbing commands. So I
don't really object to adding module-specific helpers that make it easy
to unit test these underlying modules.

I'm not sure how I feel about sticking test data in the helpers, though.
A higher level language like shell is actually pretty good for passing
data around. Passing in the input makes it much easier to prod a helper
with new test cases, see its output, run it in a debugger for a specific
case, etc.

It also integrates better with our test suite. For instance, here:

> +	if (r_tst_sign != r_exp_sign) {
> +		error("FAIL: '%s' vs '%s', result expect %d, observed %d\n",
> +			  sa, sb, r_exp_sign, r_tst_sign);
> +		failed = 1;
> +	}
> +
> +	if (offset != expected_first_change) {
> +		error("FAIL: '%s' vs '%s', offset expect %lu, observed %lu\n",
> +			  sa, sb, expected_first_change, offset);
> +		failed = 1;
> +	}
> +
> +	return failed;
> +}

You're essentially rebuilding a test harness just for this one function,
and the regular test harness only knows "did anything fail", and nothing
about specific tests.

Perhaps something like:

 t/helper/test-strcmp-offset.c | 66 +++++++----------------------------
 t/t0065-strcmp-offset.sh      | 17 +++++++--
 2 files changed, 26 insertions(+), 57 deletions(-)

diff --git a/t/helper/test-strcmp-offset.c b/t/helper/test-strcmp-offset.c
index 03e1eef8a..1fdf4d137 100644
--- a/t/helper/test-strcmp-offset.c
+++ b/t/helper/test-strcmp-offset.c
@@ -1,64 +1,22 @@
 #include "cache.h"
 
-struct test_data {
-	const char *s1;
-	const char *s2;
-	size_t expected_first_change; /* or strlen() when equal */
-};
-
-static struct test_data data[] = {
-	{ "abc", "abc", 3 },
-	{ "abc", "def", 0 },
-
-	{ "abc", "abz", 2 },
-
-	{ "abc", "abcdef", 3 },
-
-	{ "abc\xF0zzz", "abc\xFFzzz", 3 },
-
-	{ NULL, NULL, 0 }
-};
-
-int try_pair(const char *sa, const char *sb, size_t expected_first_change)
+int cmd_main(int argc, const char **argv)
 {
-	int failed = 0;
-	int r_exp, r_tst, r_exp_sign, r_tst_sign;
+	int result;
 	size_t offset;
 
+	if (!argv[1] || !argv[2])
+		die("usage: %s <string1> <string2>", argv[0]);
+
+	result = strcmp_offset(argv[1], argv[2], &offset);
+
 	/*
 	 * Because differnt CRTs behave differently, only rely on signs
 	 * of the result values.
 	 */
-	r_exp = strcmp(sa, sb);
-	r_exp_sign = ((r_exp < 0) ? -1 : ((r_exp == 0) ? 0 : 1));
-
-	r_tst = strcmp_offset(sa, sb, &offset);
-	r_tst_sign = ((r_tst < 0) ? -1 : ((r_tst == 0) ? 0 : 1));
-
-	if (r_tst_sign != r_exp_sign) {
-		error("FAIL: '%s' vs '%s', result expect %d, observed %d\n",
-			  sa, sb, r_exp_sign, r_tst_sign);
-		failed = 1;
-	}
-
-	if (offset != expected_first_change) {
-		error("FAIL: '%s' vs '%s', offset expect %lu, observed %lu\n",
-			  sa, sb, expected_first_change, offset);
-		failed = 1;
-	}
-
-	return failed;
-}
-
-int cmd_main(int argc, const char **argv)
-{
-	int failed = 0;
-	int k;
-
-	for (k=0; data[k].s1; k++) {
-		failed += try_pair(data[k].s1, data[k].s2, data[k].expected_first_change);
-		failed += try_pair(data[k].s2, data[k].s1, data[k].expected_first_change);
-	}
-
-	return failed;
+	result = result < 0 ? -1 :
+		 result > 0 ? 1 :
+		 0;
+	printf("%d %"PRIuMAX"\n", result, (uintmax_t)offset);
+	return 0;
 }
diff --git a/t/t0065-strcmp-offset.sh b/t/t0065-strcmp-offset.sh
index 0176c8c92..8c167d24b 100755
--- a/t/t0065-strcmp-offset.sh
+++ b/t/t0065-strcmp-offset.sh
@@ -4,8 +4,19 @@ test_description='Test strcmp_offset functionality'
 
 . ./test-lib.sh
 
-test_expect_success run_helper '
-	test-strcmp-offset
-'
+while read s1 s2 expect
+do
+	test_expect_success "strcmp_offset($s1, $s2)" '
+		echo "$expect" >expect &&
+		test-strcmp-offset "$s1" "$s2" >actual &&
+		test_cmp expect actual
+	'
+done <<-EOF
+abc abc 0 3
+abc def -1 0
+abc abz -1 2
+abc abcdef -1 3
+$(printf "abc\360zzz") $(printf "abc\377zzz") -1 3
+EOF
 
 test_done
