Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C7F71FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 22:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbcHJWTN (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 18:19:13 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:36573
	"EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932427AbcHJWTM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 18:19:12 -0400
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1470866239;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=YySkfJnwkrmYozOxZ+NZ/2HlfSKtqHX54Ee+BS4n/hk=;
	b=LHLyDC40X4SrDCeMiUpgacQS7MNweCN/OWrt6TKBkdo6d7uF34BLeQPJ2wP8BeAC
	gmcvMepX7liXmO6batPke3BDIZ+MHFdAItAfNmB7iaIifq0qjbeagNmypqx0NYF3zlu
	svsIJ7WINY2HJCuTHLgAe7DNG0F0pUlF5hqaJneY=
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Message-ID: <010201567675ae4c-1fd14181-7d42-4099-ac1c-1fb5c1902ce4-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201567675adc1-17e27495-6b36-40d1-836d-814da029fcc4-000000@eu-west-1.amazonses.com>
References: <010201567675adc1-17e27495-6b36-40d1-836d-814da029fcc4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v12 05/13] t6030: explicitly test for bisection cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:	Wed, 10 Aug 2016 21:57:19 +0000
X-SES-Outgoing:	2016.08.10-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Add test to explicitly check that 'git bisect reset' is working as
expected. This is already covered implicitly by the test suite.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
I faced this problem while converting `bisect_clean_state` and the tests
where showing breakages but it wasn't clear as to where exactly are they
breaking. This will patch  will help in that. Also I tested the test
coverage of the test suite before this patch and it covers this (I did
this by purposely changing names of files in git-bisect.sh and running
the test suite).
---
 t/t6030-bisect-porcelain.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index e74662b..a17f7a6 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -894,4 +894,21 @@ test_expect_success 'bisect start takes options and revs in any order' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git bisect reset cleans bisection state properly' '
+	git bisect reset &&
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	git bisect reset &&
+	test -z "$(git for-each-ref "refs/bisect/*")" &&
+	test_path_is_missing "$GIT_DIR/BISECT_EXPECTED_REV" &&
+	test_path_is_missing "$GIT_DIR/BISECT_ANCESTORS_OK" &&
+	test_path_is_missing "$GIT_DIR/BISECT_LOG" &&
+	test_path_is_missing "$GIT_DIR/BISECT_RUN" &&
+	test_path_is_missing "$GIT_DIR/BISECT_TERMS" &&
+	test_path_is_missing "$GIT_DIR/head-name" &&
+	test_path_is_missing "$GIT_DIR/BISECT_HEAD" &&
+	test_path_is_missing "$GIT_DIR/BISECT_START"
+'
+
 test_done

--
https://github.com/git/git/pull/281
