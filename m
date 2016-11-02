Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16B3620193
	for <e@80x24.org>; Wed,  2 Nov 2016 18:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756480AbcKBSS2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 14:18:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:37585 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756412AbcKBSS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 14:18:27 -0400
Received: (qmail 8664 invoked by uid 109); 2 Nov 2016 18:18:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 18:18:27 +0000
Received: (qmail 4795 invoked by uid 111); 2 Nov 2016 18:18:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 14:18:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2016 14:18:25 -0400
Date:   Wed, 2 Nov 2016 14:18:25 -0400
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 2/4] t0021: put $TEST_ROOT in $PATH
Message-ID: <20161102181824.mi6lmfnfckvrav7n@sigill.intra.peff.net>
References: <20161102181625.e2uprqdlzl7z2xrz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161102181625.e2uprqdlzl7z2xrz@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We create a rot13.sh script in the trash directory, but need
to call it by its full path when we have moved our cwd to
another directory. Let's just put $TEST_ROOT in our $PATH so
that the script is always found.

This is a minor convenience for rot13.sh, but will be a
major one when we switch rot13-filter.pl to a script in the
same directory, as it means we will not have to deal with
shell quoting inside the filter-process config.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0021-conversion.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index dfde22549..c1ad20c61 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -5,6 +5,7 @@ test_description='blob conversion via gitattributes'
 . ./test-lib.sh
 
 TEST_ROOT="$(pwd)"
+PATH=$TEST_ROOT:$PATH
 
 write_script <<\EOF "$TEST_ROOT/rot13.sh"
 tr \
@@ -64,7 +65,7 @@ test_cmp_exclude_clean () {
 # is equal to the committed content.
 test_cmp_committed_rot13 () {
 	test_cmp "$1" "$2" &&
-	"$TEST_ROOT/rot13.sh" <"$1" >expected &&
+	rot13.sh <"$1" >expected &&
 	git cat-file blob :"$2" >actual &&
 	test_cmp expected actual
 }
@@ -513,7 +514,7 @@ test_expect_success PERL 'required process filter should process multiple packet
 		for FILE in "$TEST_ROOT"/*.file
 		do
 			cp "$FILE" . &&
-			"$TEST_ROOT/rot13.sh" <"$FILE" >"$FILE.rot13"
+			rot13.sh <"$FILE" >"$FILE.rot13"
 		done &&
 
 		echo "*.file filter=protocol" >.gitattributes &&
@@ -616,7 +617,7 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 
 		# Smudge failed
 		! test_cmp smudge-write-fail.o smudge-write-fail.r &&
-		"$TEST_ROOT/rot13.sh" <smudge-write-fail.o >expected &&
+		rot13.sh <smudge-write-fail.o >expected &&
 		git cat-file blob :smudge-write-fail.r >actual &&
 		test_cmp expected actual
 	)
-- 
2.11.0.rc0.258.gf434c15

