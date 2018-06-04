Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4277D1F517
	for <e@80x24.org>; Mon,  4 Jun 2018 23:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbeFDXws (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 19:52:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33192 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751290AbeFDXwq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Jun 2018 19:52:46 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:54a4:7f2e:59a2:6beb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2756460745;
        Mon,  4 Jun 2018 23:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528156365;
        bh=txXGz9/Ze3DWHc4PEhHRbO53WqgzgZz+BWV6Y3m1SQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=gLoUihcPe+vxdkNxr+uREXbHWUqIeBGsUo74KKAEvSbsek5nbn6wr8DOq0ykbq6L/
         e9XtZDzN8YO6BNyPrXwQQzi62jOgOBqe+b3YHTWmwXKOB2t1nwZSqaM07PaY9USwqi
         19qVTp7YycnoTfwwAVA2VVqhy+qYOjkzeM9wDPYYNSbH8nuChFuEnszDF1dFHNLMPf
         wBHghIobyCvPdPaJcLag40mbOZVzWeUybzJbmSlWXgH6//EidAKLae68PBHeOHIcyt
         8m0SDC9/J6c5cNCaFhWGo3IWQ0GKjOevnNo3mk1aAo50cfK/oyfMfkzTE+SP1YKIYI
         3cU4ELHgVOUU2T0awNyfhAYAb9TWhz+SiioCMWBAQYPtNkDOfOYozVabS++PXy1cMP
         bZRd70rkBH2WgrTSCuu5E8xlFQBp+OiVEuo3UmKx+v/6zQsv1Unpy7hlDBMP8demnP
         3iEbO5CkIhvtgqJDgKsp1VPpHy4mmjzCa+xKtV64xS0VYMWspG4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 03/10] t0002: abstract away SHA-1-specific constants
Date:   Mon,  4 Jun 2018 23:52:22 +0000
Message-Id: <20180604235229.279814-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.1.1185.g55be947832
In-Reply-To: <20180604235229.279814-1-sandals@crustytoothpaste.net>
References: <20180604235229.279814-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0002-gitfile.sh | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 3691023d51..020af4c53c 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -89,14 +89,16 @@ test_expect_success 'enter_repo non-strict mode' '
 		cd enter_repo &&
 		test_tick &&
 		test_commit foo &&
+		git rev-parse HEAD >head-revision &&
 		mv .git .realgit &&
 		echo "gitdir: .realgit" >.git
 	) &&
+	head=$(cat enter_repo/head-revision) &&
 	git ls-remote enter_repo >actual &&
-	cat >expected <<-\EOF &&
-	946e985ab20de757ca5b872b16d64e92ff3803a9	HEAD
-	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/heads/master
-	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/tags/foo
+	cat >expected <<-EOF &&
+	$head	HEAD
+	$head	refs/heads/master
+	$head	refs/tags/foo
 	EOF
 	test_cmp expected actual
 '
@@ -107,20 +109,20 @@ test_expect_success 'enter_repo linked checkout' '
 		git worktree add  ../foo refs/tags/foo
 	) &&
 	git ls-remote foo >actual &&
-	cat >expected <<-\EOF &&
-	946e985ab20de757ca5b872b16d64e92ff3803a9	HEAD
-	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/heads/master
-	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/tags/foo
+	cat >expected <<-EOF &&
+	$head	HEAD
+	$head	refs/heads/master
+	$head	refs/tags/foo
 	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'enter_repo strict mode' '
 	git ls-remote --upload-pack="git upload-pack --strict" foo/.git >actual &&
-	cat >expected <<-\EOF &&
-	946e985ab20de757ca5b872b16d64e92ff3803a9	HEAD
-	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/heads/master
-	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/tags/foo
+	cat >expected <<-EOF &&
+	$head	HEAD
+	$head	refs/heads/master
+	$head	refs/tags/foo
 	EOF
 	test_cmp expected actual
 '
