Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 717B420193
	for <e@80x24.org>; Wed,  2 Nov 2016 18:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756524AbcKBSUZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 14:20:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:37588 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754674AbcKBSUY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 14:20:24 -0400
Received: (qmail 8796 invoked by uid 109); 2 Nov 2016 18:20:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 18:20:24 +0000
Received: (qmail 4817 invoked by uid 111); 2 Nov 2016 18:20:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 14:20:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2016 14:20:22 -0400
Date:   Wed, 2 Nov 2016 14:20:22 -0400
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 3/4] t0021: use $PERL_PATH for rot13-filter.pl
Message-ID: <20161102182022.zalzmc6rcwmvrgqq@sigill.intra.peff.net>
References: <20161102181625.e2uprqdlzl7z2xrz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161102181625.e2uprqdlzl7z2xrz@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The rot13-filter.pl script hardcodes "#!/usr/bin/perl", and
does not respect $PERL_PATH at all. That is a problem if the
system does not have perl at that path, or if it has a perl
that is too old to run a complicated script like the
rot13-filter (but PERL_PATH points to a more modern one).

We can fix this by using write_script() to create a new copy
of the script with the correct #!-line. In theory we could
move the whole script inside t0021-conversion.sh rather than
having it as an auxiliary file, but it's long enough that
it just makes things harder to read.

As a bonus, we can stop using the full path to the script in
the filter-process config we add (because the trash
directory is in our PATH). Not only is this shorter, but it
sidesteps any shell-quoting issues. The original was broken
when $TEST_DIRECTORY contained a space, because it was
interpolated in the outer script.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0021-conversion.sh   | 19 +++++++++++--------
 t/t0021/rot13-filter.pl |  1 -
 2 files changed, 11 insertions(+), 9 deletions(-)
 mode change 100755 => 100644 t/t0021/rot13-filter.pl

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index c1ad20c61..a8fa52148 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -13,6 +13,9 @@ tr \
   'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM'
 EOF
 
+write_script rot13-filter.pl "$PERL_PATH" \
+	<"$TEST_DIRECTORY"/t0021/rot13-filter.pl
+
 generate_random_characters () {
 	LEN=$1
 	NAME=$2
@@ -341,7 +344,7 @@ test_expect_success 'diff does not reuse worktree files that need cleaning' '
 '
 
 test_expect_success PERL 'required process filter should filter data' '
-	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
 	test_config_global filter.protocol.required true &&
 	rm -rf repo &&
 	mkdir repo &&
@@ -434,7 +437,7 @@ test_expect_success PERL 'required process filter should filter data' '
 
 test_expect_success PERL 'required process filter takes precedence' '
 	test_config_global filter.protocol.clean false &&
-	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean" &&
+	test_config_global filter.protocol.process "rot13-filter.pl clean" &&
 	test_config_global filter.protocol.required true &&
 	rm -rf repo &&
 	mkdir repo &&
@@ -459,7 +462,7 @@ test_expect_success PERL 'required process filter takes precedence' '
 '
 
 test_expect_success PERL 'required process filter should be used only for "clean" operation only' '
-	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean" &&
+	test_config_global filter.protocol.process "rot13-filter.pl clean" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -494,7 +497,7 @@ test_expect_success PERL 'required process filter should be used only for "clean
 '
 
 test_expect_success PERL 'required process filter should process multiple packets' '
-	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
 	test_config_global filter.protocol.required true &&
 
 	rm -rf repo &&
@@ -554,7 +557,7 @@ test_expect_success PERL 'required process filter should process multiple packet
 '
 
 test_expect_success PERL 'required process filter with clean error should fail' '
-	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
 	test_config_global filter.protocol.required true &&
 	rm -rf repo &&
 	mkdir repo &&
@@ -573,7 +576,7 @@ test_expect_success PERL 'required process filter with clean error should fail'
 '
 
 test_expect_success PERL 'process filter should restart after unexpected write failure' '
-	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -624,7 +627,7 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 '
 
 test_expect_success PERL 'process filter should not be restarted if it signals an error' '
-	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -663,7 +666,7 @@ test_expect_success PERL 'process filter should not be restarted if it signals a
 '
 
 test_expect_success PERL 'process filter abort stops processing of all further files' '
-	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
old mode 100755
new mode 100644
index ae4c50f5c..e3ea58e1e
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -1,4 +1,3 @@
-#!/usr/bin/perl
 #
 # Example implementation for the Git filter protocol version 2
 # See Documentation/gitattributes.txt, section "Filter Protocol"
-- 
2.11.0.rc0.258.gf434c15

