Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45AA02021E
	for <e@80x24.org>; Thu,  3 Nov 2016 20:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756184AbcKCUWb (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 16:22:31 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:5900 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751352AbcKCUWa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 16:22:30 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t8xGW2s2Fz5tlH;
        Thu,  3 Nov 2016 21:22:27 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 8EC60149;
        Thu,  3 Nov 2016 21:22:26 +0100 (CET)
Subject: [PATCH (optional)] t0021: use arithmetic expansion to trim whitespace
 from wc -c output
To:     Lars Schneider <larsxschneider@gmail.com>
References: <20161016232038.84951-1-larsxschneider@gmail.com>
 <20161016232038.84951-14-larsxschneider@gmail.com>
 <3b09d218-33bd-dc7c-235c-8954a46afc41@kdbg.org>
 <3763DDDB-9D53-4877-8399-32DF1780CAB7@gmail.com>
 <fb4d62de-fbb5-a2b4-8eba-b135125dafa9@kdbg.org>
Cc:     git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
        peff@peff.net, ramsay@ramsayjones.plus.com, tboegi@web.de
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3b58b90d-5435-1503-d052-413a947a5ab5@kdbg.org>
Date:   Thu, 3 Nov 2016 21:22:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <fb4d62de-fbb5-a2b4-8eba-b135125dafa9@kdbg.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of a pipeline with sed and a useless use of cat, return the
unmodified text of wc -c from function file_size, but substitute the
result with arithmetic expansion to get rid of the leading whitespace
that some version of wc -c print.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
This is a pure optimization that reduces the number of forks, which
helps a bit on Windows.

There would be a solution with perl that does not require trimming
of whitespace, but perl startup times are unbearable on Windows.
wc -c is better.

 t/t0021-conversion.sh | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index db71acacb3..42b529f615 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -22,7 +22,7 @@ generate_random_characters () {
 }
 
 file_size () {
-	cat "$1" | wc -c | sed "s/^[ ]*//"
+	wc -c <"$1"
 }
 
 filter_git () {
@@ -369,10 +369,10 @@ test_expect_success PERL 'required process filter should filter data' '
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: clean test.r $S [OK] -- OUT: $S . [OK]
-			IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
+			IN: clean test.r $(($S)) [OK] -- OUT: $(($S)) . [OK]
+			IN: clean test2.r $(($S2)) [OK] -- OUT: $(($S2)) . [OK]
 			IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
-			IN: clean testsubdir/test3 '\''sq'\'',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
+			IN: clean testsubdir/test3 '\''sq'\'',\$x.r $(($S3)) [OK] -- OUT: $(($S3)) . [OK]
 			STOP
 		EOF
 		test_cmp_count expected.log rot13-filter.log &&
@@ -381,14 +381,14 @@ test_expect_success PERL 'required process filter should filter data' '
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: clean test.r $S [OK] -- OUT: $S . [OK]
-			IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
+			IN: clean test.r $(($S)) [OK] -- OUT: $(($S)) . [OK]
+			IN: clean test2.r $(($S2)) [OK] -- OUT: $(($S2)) . [OK]
 			IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
-			IN: clean testsubdir/test3 '\''sq'\'',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
-			IN: clean test.r $S [OK] -- OUT: $S . [OK]
-			IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
+			IN: clean testsubdir/test3 '\''sq'\'',\$x.r $(($S3)) [OK] -- OUT: $(($S3)) . [OK]
+			IN: clean test.r $(($S)) [OK] -- OUT: $(($S)) . [OK]
+			IN: clean test2.r $(($S2)) [OK] -- OUT: $(($S2)) . [OK]
 			IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
-			IN: clean testsubdir/test3 '\''sq'\'',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
+			IN: clean testsubdir/test3 '\''sq'\'',\$x.r $(($S3)) [OK] -- OUT: $(($S3)) . [OK]
 			STOP
 		EOF
 		test_cmp_count expected.log rot13-filter.log &&
@@ -399,8 +399,8 @@ test_expect_success PERL 'required process filter should filter data' '
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
-			IN: smudge testsubdir/test3 '\''sq'\'',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
+			IN: smudge test2.r $(($S2)) [OK] -- OUT: $(($S2)) . [OK]
+			IN: smudge testsubdir/test3 '\''sq'\'',\$x.r $(($S3)) [OK] -- OUT: $(($S3)) . [OK]
 			STOP
 		EOF
 		test_cmp_exclude_clean expected.log rot13-filter.log &&
@@ -409,7 +409,7 @@ test_expect_success PERL 'required process filter should filter data' '
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: clean test.r $S [OK] -- OUT: $S . [OK]
+			IN: clean test.r $(($S)) [OK] -- OUT: $(($S)) . [OK]
 			STOP
 		EOF
 		test_cmp_exclude_clean expected.log rot13-filter.log &&
@@ -418,10 +418,10 @@ test_expect_success PERL 'required process filter should filter data' '
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
-			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
+			IN: smudge test.r $(($S)) [OK] -- OUT: $(($S)) . [OK]
+			IN: smudge test2.r $(($S2)) [OK] -- OUT: $(($S2)) . [OK]
 			IN: smudge test4-empty.r 0 [OK] -- OUT: 0  [OK]
-			IN: smudge testsubdir/test3 '\''sq'\'',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
+			IN: smudge testsubdir/test3 '\''sq'\'',\$x.r $(($S3)) [OK] -- OUT: $(($S3)) . [OK]
 			STOP
 		EOF
 		test_cmp_exclude_clean expected.log rot13-filter.log &&
@@ -451,7 +451,7 @@ test_expect_success PERL 'required process filter takes precedence' '
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: clean test.r $S [OK] -- OUT: $S . [OK]
+			IN: clean test.r $(($S)) [OK] -- OUT: $(($S)) . [OK]
 			STOP
 		EOF
 		test_cmp_count expected.log rot13-filter.log
@@ -474,7 +474,7 @@ test_expect_success PERL 'required process filter should be used only for "clean
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: clean test.r $S [OK] -- OUT: $S . [OK]
+			IN: clean test.r $(($S)) [OK] -- OUT: $(($S)) . [OK]
 			STOP
 		EOF
 		test_cmp_count expected.log rot13-filter.log &&
@@ -603,11 +603,11 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge smudge-write-fail.r $SF [OK] -- OUT: $SF [WRITE FAIL]
+			IN: smudge smudge-write-fail.r $(($SF)) [OK] -- OUT: $(($SF)) [WRITE FAIL]
 			START
 			init handshake complete
-			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
-			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
+			IN: smudge test.r $(($S)) [OK] -- OUT: $(($S)) . [OK]
+			IN: smudge test2.r $(($S2)) [OK] -- OUT: $(($S2)) . [OK]
 			STOP
 		EOF
 		test_cmp_exclude_clean expected.log rot13-filter.log &&
@@ -649,9 +649,9 @@ test_expect_success PERL 'process filter should not be restarted if it signals a
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge error.r $SE [OK] -- OUT: 0 [ERROR]
-			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
-			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
+			IN: smudge error.r $(($SE)) [OK] -- OUT: 0 [ERROR]
+			IN: smudge test.r $(($S)) [OK] -- OUT: $(($S)) . [OK]
+			IN: smudge test2.r $(($S2)) [OK] -- OUT: $(($S2)) . [OK]
 			STOP
 		EOF
 		test_cmp_exclude_clean expected.log rot13-filter.log &&
@@ -688,7 +688,7 @@ test_expect_success PERL 'process filter abort stops processing of all further f
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge abort.r $SA [OK] -- OUT: 0 [ABORT]
+			IN: smudge abort.r $(($SA)) [OK] -- OUT: 0 [ABORT]
 			STOP
 		EOF
 		test_cmp_exclude_clean expected.log rot13-filter.log &&
-- 
2.11.0.rc0.55.gd967357

