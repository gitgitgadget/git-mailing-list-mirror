Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9FFD20988
	for <e@80x24.org>; Sat, 15 Oct 2016 12:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752954AbcJOM2S (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Oct 2016 08:28:18 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:52834
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754109AbcJOM2P (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 15 Oct 2016 08:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1476534493;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=iwXHTntb0AdnN7qejP4KgzQe5hIbwrxu3C4uigoQ6xw=;
        b=Xf5kThTzjF37SE6AsMMt+4/8VpH83GMVY270QSPgqk20wPfXjibI0IhGDRcD7Ip8
        o6YDLwK6ShyShXGPG7E9U72mxYe8plIH6Ss13XKSY1aBaHR3SeMNREz28Cg9Ra36x8B
        V0Jo34F4Zt3Wy4fRoHemdcbHq44BTaE+N5nEMZm4=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020157c8505fc5-cb313aa8-0182-4e19-95fa-cb36c573ee4c-000000@eu-west-1.amazonses.com>
Subject: [PATCH] t0040: convert all possible tests to use
 `test-parse-options --expect`
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sat, 15 Oct 2016 12:28:13 +0000
X-SES-Outgoing: 2016.10.15-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use "test-parse-options --expect" to rewrite the tests to avoid checking
the whole variable dump by just testing what is required. This commit is
based on 8ca65aeb (t0040: convert a few tests to use test-parse-options;
Junio C Hamano; May 6, 2016).

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 t/t0040-parse-options.sh | 183 ++++-------------------------------------------
 1 file changed, 13 insertions(+), 170 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index db5f60d..74d2cd7 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -208,32 +208,15 @@ test_expect_success 'unambiguously abbreviated option' '
 '
 
 test_expect_success 'unambiguously abbreviated option with "="' '
-	test-parse-options --int=2 >output 2>output.err &&
-	test_must_be_empty output.err &&
-	test_cmp expect output
+	test-parse-options --expect="integer: 2" --int=2
 '
 
 test_expect_success 'ambiguously abbreviated option' '
 	test_expect_code 129 test-parse-options --strin 123
 '
 
-cat >expect <<\EOF
-boolean: 0
-integer: 0
-magnitude: 0
-timestamp: 0
-string: 123
-abbrev: 7
-verbose: -1
-quiet: 0
-dry run: no
-file: (not set)
-EOF
-
 test_expect_success 'non ambiguous option (after two options it abbreviates)' '
-	test-parse-options --st 123 >output 2>output.err &&
-	test_must_be_empty output.err &&
-	test_cmp expect output
+	test-parse-options --expect="string: 123" --st 123
 '
 
 cat >typo.err <<\EOF
@@ -256,24 +239,8 @@ test_expect_success 'detect possible typos' '
 	test_cmp typo.err output.err
 '
 
-cat >expect <<\EOF
-boolean: 0
-integer: 0
-magnitude: 0
-timestamp: 0
-string: (not set)
-abbrev: 7
-verbose: -1
-quiet: 0
-dry run: no
-file: (not set)
-arg 00: --quux
-EOF
-
 test_expect_success 'keep some options as arguments' '
-	test-parse-options --quux >output 2>output.err &&
-	test_must_be_empty output.err &&
-	test_cmp expect output
+	test-parse-options --expect="arg 00: --quux" --quux
 '
 
 cat >expect <<\EOF
@@ -350,54 +317,20 @@ test_expect_success 'OPT_NEGBIT() and OPT_SET_INT() work' '
 	test_cmp expect output
 '
 
-cat >expect <<\EOF
-boolean: 6
-integer: 0
-magnitude: 0
-timestamp: 0
-string: (not set)
-abbrev: 7
-verbose: -1
-quiet: 0
-dry run: no
-file: (not set)
-EOF
-
 test_expect_success 'OPT_BIT() works' '
-	test-parse-options -bb --or4 >output 2>output.err &&
-	test_must_be_empty output.err &&
-	test_cmp expect output
+	test-parse-options --expect="boolean: 6" -bb --or4
 '
 
 test_expect_success 'OPT_NEGBIT() works' '
-	test-parse-options -bb --no-neg-or4 >output 2>output.err &&
-	test_must_be_empty output.err &&
-	test_cmp expect output
+	test-parse-options --expect="boolean: 6" -bb --no-neg-or4
 '
 
 test_expect_success 'OPT_COUNTUP() with PARSE_OPT_NODASH works' '
-	test-parse-options + + + + + + >output 2>output.err &&
-	test_must_be_empty output.err &&
-	test_cmp expect output
+	test-parse-options --expect="boolean: 6" + + + + + +
 '
 
-cat >expect <<\EOF
-boolean: 0
-integer: 12345
-magnitude: 0
-timestamp: 0
-string: (not set)
-abbrev: 7
-verbose: -1
-quiet: 0
-dry run: no
-file: (not set)
-EOF
-
 test_expect_success 'OPT_NUMBER_CALLBACK() works' '
-	test-parse-options -12345 >output 2>output.err &&
-	test_must_be_empty output.err &&
-	test_cmp expect output
+	test-parse-options --expect="integer: 12345" -12345
 '
 
 cat >expect <<\EOF
@@ -435,118 +368,28 @@ test_expect_success '--no-list resets list' '
 	test_cmp expect output
 '
 
-cat >expect <<\EOF
-boolean: 0
-integer: 0
-magnitude: 0
-timestamp: 0
-string: (not set)
-abbrev: 7
-verbose: -1
-quiet: 3
-dry run: no
-file: (not set)
-EOF
-
 test_expect_success 'multiple quiet levels' '
-	test-parse-options -q -q -q >output 2>output.err &&
-	test_must_be_empty output.err &&
-	test_cmp expect output
+	test-parse-options --expect="quiet: 3" -q -q -q
 '
 
-cat >expect <<\EOF
-boolean: 0
-integer: 0
-magnitude: 0
-timestamp: 0
-string: (not set)
-abbrev: 7
-verbose: 3
-quiet: 0
-dry run: no
-file: (not set)
-EOF
-
 test_expect_success 'multiple verbose levels' '
-	test-parse-options -v -v -v >output 2>output.err &&
-	test_must_be_empty output.err &&
-	test_cmp expect output
+	test-parse-options --expect="verbose: 3" -v -v -v
 '
 
-cat >expect <<\EOF
-boolean: 0
-integer: 0
-magnitude: 0
-timestamp: 0
-string: (not set)
-abbrev: 7
-verbose: -1
-quiet: 0
-dry run: no
-file: (not set)
-EOF
-
 test_expect_success '--no-quiet sets --quiet to 0' '
-	test-parse-options --no-quiet >output 2>output.err &&
-	test_must_be_empty output.err &&
-	test_cmp expect output
+	test-parse-options --expect="quiet: 0" --no-quiet
 '
 
-cat >expect <<\EOF
-boolean: 0
-integer: 0
-magnitude: 0
-timestamp: 0
-string: (not set)
-abbrev: 7
-verbose: -1
-quiet: 0
-dry run: no
-file: (not set)
-EOF
-
 test_expect_success '--no-quiet resets multiple -q to 0' '
-	test-parse-options -q -q -q --no-quiet >output 2>output.err &&
-	test_must_be_empty output.err &&
-	test_cmp expect output
+	test-parse-options --expect="quiet: 0" -q -q -q --no-quiet
 '
 
-cat >expect <<\EOF
-boolean: 0
-integer: 0
-magnitude: 0
-timestamp: 0
-string: (not set)
-abbrev: 7
-verbose: 0
-quiet: 0
-dry run: no
-file: (not set)
-EOF
-
 test_expect_success '--no-verbose sets verbose to 0' '
-	test-parse-options --no-verbose >output 2>output.err &&
-	test_must_be_empty output.err &&
-	test_cmp expect output
+	test-parse-options --expect="verbose: 0" --no-verbose
 '
 
-cat >expect <<\EOF
-boolean: 0
-integer: 0
-magnitude: 0
-timestamp: 0
-string: (not set)
-abbrev: 7
-verbose: 0
-quiet: 0
-dry run: no
-file: (not set)
-EOF
-
 test_expect_success '--no-verbose resets multiple verbose to 0' '
-	test-parse-options -v -v -v --no-verbose >output 2>output.err &&
-	test_must_be_empty output.err &&
-	test_cmp expect output
+	test-parse-options --expect="verbose: 0" -v -v -v --no-verbose
 '
 
 test_done

--
https://github.com/git/git/pull/299
