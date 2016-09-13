Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EC0B207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 03:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbcIMDXQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 23:23:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:42265 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750953AbcIMDXP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 23:23:15 -0400
Received: (qmail 20209 invoked by uid 109); 13 Sep 2016 03:23:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 03:23:15 +0000
Received: (qmail 18410 invoked by uid 111); 13 Sep 2016 03:23:25 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 23:23:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2016 20:23:12 -0700
Date:   Mon, 12 Sep 2016 20:23:12 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 01/16] t1007: factor out repeated setup
Message-ID: <20160913032312.yheky2o25lmibvmb@sigill.intra.peff.net>
References: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a series of 3 CRLF tests that do exactly the same
(long) setup sequence. Let's pull it out into a common setup
test, which is shorter, more efficient, and will make it
easier to add new tests.

Note that we don't have to worry about cleaning up any of
the setup which was previously per-test; we call pop_repo
after the CRLF tests, which cleans up everything.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1007-hash-object.sh | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 7d2baa1..c89faa6 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -101,7 +101,7 @@ test_expect_success 'git hash-object --stdin file1 <file0 first operates on file
 	test "$obname1" = "$obname1new"
 '
 
-test_expect_success 'check that appropriate filter is invoke when --path is used' '
+test_expect_success 'set up crlf tests' '
 	echo fooQ | tr Q "\\015" >file0 &&
 	cp file0 file1 &&
 	echo "file0 -crlf" >.gitattributes &&
@@ -109,7 +109,10 @@ test_expect_success 'check that appropriate filter is invoke when --path is used
 	git config core.autocrlf true &&
 	file0_sha=$(git hash-object file0) &&
 	file1_sha=$(git hash-object file1) &&
-	test "$file0_sha" != "$file1_sha" &&
+	test "$file0_sha" != "$file1_sha"
+'
+
+test_expect_success 'check that appropriate filter is invoke when --path is used' '
 	path1_sha=$(git hash-object --path=file1 file0) &&
 	path0_sha=$(git hash-object --path=file0 file1) &&
 	test "$file0_sha" = "$path0_sha" &&
@@ -117,38 +120,19 @@ test_expect_success 'check that appropriate filter is invoke when --path is used
 	path1_sha=$(cat file0 | git hash-object --path=file1 --stdin) &&
 	path0_sha=$(cat file1 | git hash-object --path=file0 --stdin) &&
 	test "$file0_sha" = "$path0_sha" &&
-	test "$file1_sha" = "$path1_sha" &&
-	git config --unset core.autocrlf
+	test "$file1_sha" = "$path1_sha"
 '
 
 test_expect_success 'check that --no-filters option works' '
-	echo fooQ | tr Q "\\015" >file0 &&
-	cp file0 file1 &&
-	echo "file0 -crlf" >.gitattributes &&
-	echo "file1 crlf" >>.gitattributes &&
-	git config core.autocrlf true &&
-	file0_sha=$(git hash-object file0) &&
-	file1_sha=$(git hash-object file1) &&
-	test "$file0_sha" != "$file1_sha" &&
 	nofilters_file1=$(git hash-object --no-filters file1) &&
 	test "$file0_sha" = "$nofilters_file1" &&
 	nofilters_file1=$(cat file1 | git hash-object --stdin) &&
-	test "$file0_sha" = "$nofilters_file1" &&
-	git config --unset core.autocrlf
+	test "$file0_sha" = "$nofilters_file1"
 '
 
 test_expect_success 'check that --no-filters option works with --stdin-paths' '
-	echo fooQ | tr Q "\\015" >file0 &&
-	cp file0 file1 &&
-	echo "file0 -crlf" >.gitattributes &&
-	echo "file1 crlf" >>.gitattributes &&
-	git config core.autocrlf true &&
-	file0_sha=$(git hash-object file0) &&
-	file1_sha=$(git hash-object file1) &&
-	test "$file0_sha" != "$file1_sha" &&
 	nofilters_file1=$(echo "file1" | git hash-object --stdin-paths --no-filters) &&
-	test "$file0_sha" = "$nofilters_file1" &&
-	git config --unset core.autocrlf
+	test "$file0_sha" = "$nofilters_file1"
 '
 
 pop_repo
-- 
2.10.0.230.g6f8d04b

