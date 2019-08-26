Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F5C1F4B7
	for <e@80x24.org>; Mon, 26 Aug 2019 01:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfHZBoG (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 21:44:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58270 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbfHZBoG (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Aug 2019 21:44:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4B02160737;
        Mon, 26 Aug 2019 01:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566783841;
        bh=t0czfkGDAFXzYqPCbU7uRCHt31/A/mAgC50mztHv+zI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=bILNVQz2FecYRkUwZo8MfTnuQx3ndnYAa2jVgDgfNqvA9BfcZDWEejraRucbnA7wR
         wWm7FzCtT6P/bXQEQCJ4PiZN/ntIvIeGLZSLx9a75xNzLTuDQx5M1AKvmVvVhTnFG6
         6SSS6jOX/7viUQO5/hVWiqJPFc/jSf66pAEdbQndvSu+ZQFpzLCJCEnKHD/PX7mGlR
         2TaYQO7XggnZvRvnK3A812czM3NFnz64re9DG1pycU+m8Z1tqFUqnD8ck8VEPM9jl6
         J7N5uxcPO1frGsm5ZE582NOF/BWCiwmOuuNaS7bWM4buQIQfXcVEO3c/kxryOoKoyq
         /G4phAHalUDNY+VR3XIxYes+EfkHtD530G47GYyZygzRh83N3XJDMUKOCw7UG/LZwd
         q2PljV0O2AvaB1TfjlGQ/q51Xw6EVMUOKLIWEzNgOt2fTVb1gOWSvc8PK4lI111rR4
         dyBsHunh0sdQn/+Xt8BMeg8IDJeRxUgqVvfC7IFIk8N2jGmL4UD
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 02/14] t3206: abstract away hash size constants
Date:   Mon, 26 Aug 2019 01:43:32 +0000
Message-Id: <20190826014344.16008-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c
In-Reply-To: <20190826014344.16008-1-sandals@crustytoothpaste.net>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
 <20190826014344.16008-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The various short object IDs in the range-diff output differ between
hash algorithms.  Use test_oid_cache to look up values for both SHA-1
and SHA-256.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3206-range-diff.sh | 227 +++++++++++++++++++++++++++++++-----------
 1 file changed, 167 insertions(+), 60 deletions(-)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index ec548654ce..0120f769f1 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -8,17 +8,124 @@ test_description='range-diff tests'
 # harm than good.  We need some real history.
 
 test_expect_success 'setup' '
-	git fast-import < "$TEST_DIRECTORY"/t3206/history.export
+	git fast-import < "$TEST_DIRECTORY"/t3206/history.export &&
+	test_oid_cache <<-EOF
+	# topic
+	t1 sha1:4de457d
+	t2 sha1:fccce22
+	t3 sha1:147e64e
+	t4 sha1:a63e992
+	t1 sha256:b89f8b9
+	t2 sha256:5f12aad
+	t3 sha256:ea8b273
+	t4 sha256:14b7336
+
+	# unmodified
+	u1 sha1:35b9b25
+	u2 sha1:de345ab
+	u3 sha1:9af6654
+	u4 sha1:2901f77
+	u1 sha256:e3731be
+	u2 sha256:14fadf8
+	u3 sha256:736c4bc
+	u4 sha256:673e77d
+
+	# reordered
+	r1 sha1:aca177a
+	r2 sha1:14ad629
+	r3 sha1:ee58208
+	r4 sha1:307b27a
+	r1 sha256:f59d3aa
+	r2 sha256:fb261a8
+	r3 sha256:cb2649b
+	r4 sha256:958577e
+
+	# removed (deleted)
+	d1 sha1:7657159
+	d2 sha1:43d84d3
+	d3 sha1:a740396
+	d1 sha256:e312513
+	d2 sha256:eb19258
+	d3 sha256:1ccb3c1
+
+	# added
+	a1 sha1:2716022
+	a2 sha1:b62accd
+	a3 sha1:df46cfa
+	a4 sha1:3e64548
+	a5 sha1:12b4063
+	a1 sha256:d724f4d
+	a2 sha256:1de7762
+	a3 sha256:e159431
+	a4 sha256:b3e483c
+	a5 sha256:90866a7
+
+	# rebased
+	b1 sha1:cc9c443
+	b2 sha1:c5d9641
+	b3 sha1:28cc2b6
+	b4 sha1:5628ab7
+	b5 sha1:a31b12e
+	b1 sha256:a1a8717
+	b2 sha256:20a5862
+	b3 sha256:587172a
+	b4 sha256:2721c5d
+	b5 sha256:7b57864
+
+	# changed
+	c1 sha1:a4b3333
+	c2 sha1:f51d370
+	c3 sha1:0559556
+	c4 sha1:d966c5c
+	c1 sha256:f8c2b9d
+	c2 sha256:3fb6318
+	c3 sha256:168ab68
+	c4 sha256:3526539
+
+	# changed-message
+	m1 sha1:f686024
+	m2 sha1:4ab067d
+	m3 sha1:b9cb956
+	m4 sha1:8add5f1
+	m1 sha256:31e6281
+	m2 sha256:a06bf1b
+	m3 sha256:82dc654
+	m4 sha256:48470c5
+
+	# renamed
+	n1 sha1:f258d75
+	n2 sha1:017b62d
+	n3 sha1:3ce7af6
+	n4 sha1:1e6226b
+	n1 sha256:ad52114
+	n2 sha256:3b54c8f
+	n3 sha256:3b0a644
+	n4 sha256:e461653
+
+	# added and removed
+	s1 sha1:096b1ba
+	s2 sha1:d92e698
+	s3 sha1:9a1db4d
+	s4 sha1:fea3b5c
+	s1 sha256:a7f9134
+	s2 sha256:b4c2580
+	s3 sha256:1d62aa2
+	s4 sha256:48160e8
+
+	# Empty delimiter (included so lines match neatly)
+	__ sha1:-------
+	__ sha256:-------
+	EOF
 '
 
 test_expect_success 'simple A..B A..C (unmodified)' '
 	git range-diff --no-color master..topic master..unmodified \
 		>actual &&
 	cat >expected <<-EOF &&
-	1:  4de457d = 1:  35b9b25 s/5/A/
-	2:  fccce22 = 2:  de345ab s/4/A/
-	3:  147e64e = 3:  9af6654 s/11/B/
-	4:  a63e992 = 4:  2901f77 s/12/B/
+	1:  $(test_oid t1) = 1:  $(test_oid u1) s/5/A/
+	2:  $(test_oid t2) = 2:  $(test_oid u2) s/4/A/
+	3:  $(test_oid t3) = 3:  $(test_oid u3) s/11/B/
+	4:  $(test_oid t4) = 4:  $(test_oid u4) s/12/B/
 	EOF
 	test_cmp expected actual
 '
@@ -38,10 +145,10 @@ test_expect_success 'simple A B C (unmodified)' '
 test_expect_success 'trivial reordering' '
 	git range-diff --no-color master topic reordered >actual &&
 	cat >expected <<-EOF &&
-	1:  4de457d = 1:  aca177a s/5/A/
-	3:  147e64e = 2:  14ad629 s/11/B/
-	4:  a63e992 = 3:  ee58208 s/12/B/
-	2:  fccce22 = 4:  307b27a s/4/A/
+	1:  $(test_oid t1) = 1:  $(test_oid r1) s/5/A/
+	3:  $(test_oid t3) = 2:  $(test_oid r2) s/11/B/
+	4:  $(test_oid t4) = 3:  $(test_oid r3) s/12/B/
+	2:  $(test_oid t2) = 4:  $(test_oid r4) s/4/A/
 	EOF
 	test_cmp expected actual
 '
@@ -49,10 +156,10 @@ test_expect_success 'trivial reordering' '
 test_expect_success 'removed a commit' '
 	git range-diff --no-color master topic removed >actual &&
 	cat >expected <<-EOF &&
-	1:  4de457d = 1:  7657159 s/5/A/
-	2:  fccce22 < -:  ------- s/4/A/
-	3:  147e64e = 2:  43d84d3 s/11/B/
-	4:  a63e992 = 3:  a740396 s/12/B/
+	1:  $(test_oid t1) = 1:  $(test_oid d1) s/5/A/
+	2:  $(test_oid t2) < -:  $(test_oid __) s/4/A/
+	3:  $(test_oid t3) = 2:  $(test_oid d2) s/11/B/
+	4:  $(test_oid t4) = 3:  $(test_oid d3) s/12/B/
 	EOF
 	test_cmp expected actual
 '
@@ -60,11 +167,11 @@ test_expect_success 'removed a commit' '
 test_expect_success 'added a commit' '
 	git range-diff --no-color master topic added >actual &&
 	cat >expected <<-EOF &&
-	1:  4de457d = 1:  2716022 s/5/A/
-	2:  fccce22 = 2:  b62accd s/4/A/
-	-:  ------- > 3:  df46cfa s/6/A/
-	3:  147e64e = 4:  3e64548 s/11/B/
-	4:  a63e992 = 5:  12b4063 s/12/B/
+	1:  $(test_oid t1) = 1:  $(test_oid a1) s/5/A/
+	2:  $(test_oid t2) = 2:  $(test_oid a2) s/4/A/
+	-:  $(test_oid __) > 3:  $(test_oid a3) s/6/A/
+	3:  $(test_oid t3) = 4:  $(test_oid a4) s/11/B/
+	4:  $(test_oid t4) = 5:  $(test_oid a5) s/12/B/
 	EOF
 	test_cmp expected actual
 '
@@ -72,10 +179,10 @@ test_expect_success 'added a commit' '
 test_expect_success 'new base, A B C' '
 	git range-diff --no-color master topic rebased >actual &&
 	cat >expected <<-EOF &&
-	1:  4de457d = 1:  cc9c443 s/5/A/
-	2:  fccce22 = 2:  c5d9641 s/4/A/
-	3:  147e64e = 3:  28cc2b6 s/11/B/
-	4:  a63e992 = 4:  5628ab7 s/12/B/
+	1:  $(test_oid t1) = 1:  $(test_oid b1) s/5/A/
+	2:  $(test_oid t2) = 2:  $(test_oid b2) s/4/A/
+	3:  $(test_oid t3) = 3:  $(test_oid b3) s/11/B/
+	4:  $(test_oid t4) = 4:  $(test_oid b4) s/12/B/
 	EOF
 	test_cmp expected actual
 '
@@ -84,11 +191,11 @@ test_expect_success 'new base, B...C' '
 	# this syntax includes the commits from master!
 	git range-diff --no-color topic...rebased >actual &&
 	cat >expected <<-EOF &&
-	-:  ------- > 1:  a31b12e unrelated
-	1:  4de457d = 2:  cc9c443 s/5/A/
-	2:  fccce22 = 3:  c5d9641 s/4/A/
-	3:  147e64e = 4:  28cc2b6 s/11/B/
-	4:  a63e992 = 5:  5628ab7 s/12/B/
+	-:  $(test_oid __) > 1:  $(test_oid b5) unrelated
+	1:  $(test_oid t1) = 2:  $(test_oid b1) s/5/A/
+	2:  $(test_oid t2) = 3:  $(test_oid b2) s/4/A/
+	3:  $(test_oid t3) = 4:  $(test_oid b3) s/11/B/
+	4:  $(test_oid t4) = 5:  $(test_oid b4) s/12/B/
 	EOF
 	test_cmp expected actual
 '
@@ -96,9 +203,9 @@ test_expect_success 'new base, B...C' '
 test_expect_success 'changed commit' '
 	git range-diff --no-color topic...changed >actual &&
 	cat >expected <<-EOF &&
-	1:  4de457d = 1:  a4b3333 s/5/A/
-	2:  fccce22 = 2:  f51d370 s/4/A/
-	3:  147e64e ! 3:  0559556 s/11/B/
+	1:  $(test_oid t1) = 1:  $(test_oid c1) s/5/A/
+	2:  $(test_oid t2) = 2:  $(test_oid c2) s/4/A/
+	3:  $(test_oid t3) ! 3:  $(test_oid c3) s/11/B/
 	    @@ file: A
 	      9
 	      10
@@ -108,7 +215,7 @@ test_expect_success 'changed commit' '
 	      12
 	      13
 	      14
-	4:  a63e992 ! 4:  d966c5c s/12/B/
+	4:  $(test_oid t4) ! 4:  $(test_oid c4) s/12/B/
 	    @@ file
 	     @@ file: A
 	      9
@@ -125,10 +232,10 @@ test_expect_success 'changed commit' '
 test_expect_success 'changed commit with --no-patch diff option' '
 	git range-diff --no-color --no-patch topic...changed >actual &&
 	cat >expected <<-EOF &&
-	1:  4de457d = 1:  a4b3333 s/5/A/
-	2:  fccce22 = 2:  f51d370 s/4/A/
-	3:  147e64e ! 3:  0559556 s/11/B/
-	4:  a63e992 ! 4:  d966c5c s/12/B/
+	1:  $(test_oid t1) = 1:  $(test_oid c1) s/5/A/
+	2:  $(test_oid t2) = 2:  $(test_oid c2) s/4/A/
+	3:  $(test_oid t3) ! 3:  $(test_oid c3) s/11/B/
+	4:  $(test_oid t4) ! 4:  $(test_oid c4) s/12/B/
 	EOF
 	test_cmp expected actual
 '
@@ -136,16 +243,16 @@ test_expect_success 'changed commit with --no-patch diff option' '
 test_expect_success 'changed commit with --stat diff option' '
 	git range-diff --no-color --stat topic...changed >actual &&
 	cat >expected <<-EOF &&
-	1:  4de457d = 1:  a4b3333 s/5/A/
+	1:  $(test_oid t1) = 1:  $(test_oid c1) s/5/A/
 	     a => b | 0
 	     1 file changed, 0 insertions(+), 0 deletions(-)
-	2:  fccce22 = 2:  f51d370 s/4/A/
+	2:  $(test_oid t2) = 2:  $(test_oid c2) s/4/A/
 	     a => b | 0
 	     1 file changed, 0 insertions(+), 0 deletions(-)
-	3:  147e64e ! 3:  0559556 s/11/B/
+	3:  $(test_oid t3) ! 3:  $(test_oid c3) s/11/B/
 	     a => b | 0
 	     1 file changed, 0 insertions(+), 0 deletions(-)
-	4:  a63e992 ! 4:  d966c5c s/12/B/
+	4:  $(test_oid t4) ! 4:  $(test_oid c4) s/12/B/
 	     a => b | 0
 	     1 file changed, 0 insertions(+), 0 deletions(-)
 	EOF
@@ -155,9 +262,9 @@ test_expect_success 'changed commit with --stat diff option' '
 test_expect_success 'changed commit with sm config' '
 	git range-diff --no-color --submodule=log topic...changed >actual &&
 	cat >expected <<-EOF &&
-	1:  4de457d = 1:  a4b3333 s/5/A/
-	2:  fccce22 = 2:  f51d370 s/4/A/
-	3:  147e64e ! 3:  0559556 s/11/B/
+	1:  $(test_oid t1) = 1:  $(test_oid c1) s/5/A/
+	2:  $(test_oid t2) = 2:  $(test_oid c2) s/4/A/
+	3:  $(test_oid t3) ! 3:  $(test_oid c3) s/11/B/
 	    @@ file: A
 	      9
 	      10
@@ -167,7 +274,7 @@ test_expect_success 'changed commit with sm config' '
 	      12
 	      13
 	      14
-	4:  a63e992 ! 4:  d966c5c s/12/B/
+	4:  $(test_oid t4) ! 4:  $(test_oid c4) s/12/B/
 	    @@ file
 	     @@ file: A
 	      9
@@ -184,8 +291,8 @@ test_expect_success 'changed commit with sm config' '
 test_expect_success 'renamed file' '
 	git range-diff --no-color --submodule=log topic...renamed-file >actual &&
 	sed s/Z/\ /g >expected <<-EOF &&
-	1:  4de457d = 1:  f258d75 s/5/A/
-	2:  fccce22 ! 2:  017b62d s/4/A/
+	1:  $(test_oid t1) = 1:  $(test_oid n1) s/5/A/
+	2:  $(test_oid t2) ! 2:  $(test_oid n2) s/4/A/
 	    @@ Metadata
 	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
 	    Z
@@ -198,7 +305,7 @@ test_expect_success 'renamed file' '
 	    Z@@
 	    Z 1
 	    Z 2
-	3:  147e64e ! 3:  3ce7af6 s/11/B/
+	3:  $(test_oid t3) ! 3:  $(test_oid n3) s/11/B/
 	    @@ Metadata
 	    Z ## Commit message ##
 	    Z    s/11/B/
@@ -210,7 +317,7 @@ test_expect_success 'renamed file' '
 	    Z 8
 	    Z 9
 	    Z 10
-	4:  a63e992 ! 4:  1e6226b s/12/B/
+	4:  $(test_oid t4) ! 4:  $(test_oid n4) s/12/B/
 	    @@ Metadata
 	    Z ## Commit message ##
 	    Z    s/12/B/
@@ -229,8 +336,8 @@ test_expect_success 'renamed file' '
 test_expect_success 'file added and later removed' '
 	git range-diff --no-color --submodule=log topic...added-removed >actual &&
 	sed s/Z/\ /g >expected <<-EOF &&
-	1:  4de457d = 1:  096b1ba s/5/A/
-	2:  fccce22 ! 2:  d92e698 s/4/A/
+	1:  $(test_oid t1) = 1:  $(test_oid s1) s/5/A/
+	2:  $(test_oid t2) ! 2:  $(test_oid s2) s/4/A/
 	    @@ Metadata
 	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
 	    Z
@@ -246,7 +353,7 @@ test_expect_success 'file added and later removed' '
 	    Z 7
 	    +
 	    + ## new-file (new) ##
-	3:  147e64e ! 3:  9a1db4d s/11/B/
+	3:  $(test_oid t3) ! 3:  $(test_oid s3) s/11/B/
 	    @@ Metadata
 	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
 	    Z
@@ -262,7 +369,7 @@ test_expect_success 'file added and later removed' '
 	    Z 14
 	    +
 	    + ## new-file (deleted) ##
-	4:  a63e992 = 4:  fea3b5c s/12/B/
+	4:  $(test_oid t4) = 4:  $(test_oid s4) s/12/B/
 	EOF
 	test_cmp expected actual
 '
@@ -275,8 +382,8 @@ test_expect_success 'no commits on one side' '
 test_expect_success 'changed message' '
 	git range-diff --no-color topic...changed-message >actual &&
 	sed s/Z/\ /g >expected <<-EOF &&
-	1:  4de457d = 1:  f686024 s/5/A/
-	2:  fccce22 ! 2:  4ab067d s/4/A/
+	1:  $(test_oid t1) = 1:  $(test_oid m1) s/5/A/
+	2:  $(test_oid t2) ! 2:  $(test_oid m2) s/4/A/
 	    @@ Metadata
 	    Z ## Commit message ##
 	    Z    s/4/A/
@@ -286,16 +393,16 @@ test_expect_success 'changed message' '
 	    Z ## file ##
 	    Z@@
 	    Z 1
-	3:  147e64e = 3:  b9cb956 s/11/B/
-	4:  a63e992 = 4:  8add5f1 s/12/B/
+	3:  $(test_oid t3) = 3:  $(test_oid m3) s/11/B/
+	4:  $(test_oid t4) = 4:  $(test_oid m4) s/12/B/
 	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'dual-coloring' '
-	sed -e "s|^:||" >expect <<-\EOF &&
-	:<YELLOW>1:  a4b3333 = 1:  f686024 s/5/A/<RESET>
-	:<RED>2:  f51d370 <RESET><YELLOW>!<RESET><GREEN> 2:  4ab067d<RESET><YELLOW> s/4/A/<RESET>
+	sed -e "s|^:||" >expect <<-EOF &&
+	:<YELLOW>1:  $(test_oid c1) = 1:  $(test_oid m1) s/5/A/<RESET>
+	:<RED>2:  $(test_oid c2) <RESET><YELLOW>!<RESET><GREEN> 2:  $(test_oid m2)<RESET><YELLOW> s/4/A/<RESET>
 	:    <REVERSE><CYAN>@@<RESET> <RESET>Metadata<RESET>
 	:      ## Commit message ##<RESET>
 	:         s/4/A/<RESET>
@@ -305,7 +412,7 @@ test_expect_success 'dual-coloring' '
 	:      ## file ##<RESET>
 	:    <CYAN> @@<RESET>
 	:      1<RESET>
-	:<RED>3:  0559556 <RESET><YELLOW>!<RESET><GREEN> 3:  b9cb956<RESET><YELLOW> s/11/B/<RESET>
+	:<RED>3:  $(test_oid c3) <RESET><YELLOW>!<RESET><GREEN> 3:  $(test_oid m3)<RESET><YELLOW> s/11/B/<RESET>
 	:    <REVERSE><CYAN>@@<RESET> <RESET>file: A<RESET>
 	:      9<RESET>
 	:      10<RESET>
@@ -315,7 +422,7 @@ test_expect_success 'dual-coloring' '
 	:      12<RESET>
 	:      13<RESET>
 	:      14<RESET>
-	:<RED>4:  d966c5c <RESET><YELLOW>!<RESET><GREEN> 4:  8add5f1<RESET><YELLOW> s/12/B/<RESET>
+	:<RED>4:  $(test_oid c4) <RESET><YELLOW>!<RESET><GREEN> 4:  $(test_oid m4)<RESET><YELLOW> s/12/B/<RESET>
 	:    <REVERSE><CYAN>@@<RESET> <RESET>file<RESET>
 	:    <CYAN> @@ file: A<RESET>
 	:      9<RESET>
