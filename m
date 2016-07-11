Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9262018F
	for <e@80x24.org>; Mon, 11 Jul 2016 23:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbcGKXyZ (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 19:54:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:43166 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751423AbcGKXyY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 19:54:24 -0400
Received: (qmail 30688 invoked by uid 102); 11 Jul 2016 23:54:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jul 2016 19:54:24 -0400
Received: (qmail 3272 invoked by uid 107); 11 Jul 2016 23:54:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jul 2016 19:54:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jul 2016 19:54:18 -0400
Date:	Mon, 11 Jul 2016 19:54:18 -0400
From:	Jeff King <peff@peff.net>
To:	Andreas Schwab <schwab@linux-m68k.org>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
Message-ID: <20160711235417.GA26163@sigill.intra.peff.net>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
 <87lh17kgdy.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lh17kgdy.fsf@linux-m68k.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 11, 2016 at 11:35:05PM +0200, Andreas Schwab wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >       local_tzoffset: detect errors from tm_to_time_t
> 
> not ok 19 - show date (iso:5758122296 -0400)
> #      
> #                      echo "$time -> $expect" >expect &&
> #                      test-date show:$format "$time" >actual &&
> #                      test_cmp expect actual
> #              
> not ok 20 - show date (iso-local:5758122296 -0400)
> #      
> #                      echo "$time -> $expect" >expect &&
> #                      test-date show:$format "$time" >actual &&
> #                      test_cmp expect actual
> 
> This is outside the range of 32bit time_t.

Yes, that's somewhat the point of the test.

How does it fail for you (what does it look like with "-v")? We may be
able to check for an outcome that matches both cases.

Otherwise, we'll have to skip the test, perhaps with something like the
patch below. I suspect the problem is actually the size of "unsigned
long", not time_t, as we use that internally for a bunch of time
computation.

---
diff --git a/help.c b/help.c
index 19328ea..0cea240 100644
--- a/help.c
+++ b/help.c
@@ -419,6 +419,13 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 	 * with external projects that rely on the output of "git version".
 	 */
 	printf("git version %s\n", git_version_string);
+	while (*++argv) {
+		if (!strcmp(*argv, "--build-options")) {
+			printf("sizeof-unsigned-long: %d",
+			       (int)sizeof(unsigned long));
+			/* maybe also save and output GIT-BUILD_OPTIONS? */
+		}
+	}
 	return 0;
 }
 
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 04ce535..a0b8497 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -31,7 +31,7 @@ check_show () {
 	format=$1
 	time=$2
 	expect=$3
-	test_expect_${4:-success} "show date ($format:$time)" '
+	test_expect_success $4 "show date ($format:$time)" '
 		echo "$time -> $expect" >expect &&
 		test-date show:$format "$time" >actual &&
 		test_cmp expect actual
@@ -50,8 +50,8 @@ check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
 
 # arbitrary time absurdly far in the future
 FUTURE="5758122296 -0400"
-check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400"
-check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000"
+check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" 64BIT
+check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" 64BIT
 
 check_parse() {
 	echo "$1 -> $2" >expect
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0055ebb..d592bdc 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1111,3 +1111,12 @@ run_with_limited_cmdline () {
 }
 
 test_lazy_prereq CMDLINE_LIMIT 'run_with_limited_cmdline true'
+
+build_option () {
+	git version --build-options |
+	sed -ne "s/^$1: //p"
+}
+
+test_lazy_prereq 64BIT '
+	test 8 -le "$(build_option sizeof-unsigned-long)"
+'
