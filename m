Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F7B52018E
	for <e@80x24.org>; Tue, 23 Aug 2016 12:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757992AbcHWL7K (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 07:59:10 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:51307
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756635AbcHWL6K (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Aug 2016 07:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1471953233;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=4hN6EHOC0pTinCkaZfeb6n7SAJNUFfk3oKk326JofNM=;
        b=Vn/P0Gd3RI2hqZx8cYbV/1cIUjNaFof9YdYuiUgQ9lbRe9CTquKvhWVAyScMZSnv
        FCtw4aWyAsuR8E9U3EVpAoZL2IKZQvn7L2cRRa16oCPmW9epG9F+r9mHg6RLsg7O0dM
        B6LzHhuKLLsrdBXGNl4CGhOjf5ujFQTJPF/5VXXw=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020156b73fe666-a66817f8-949c-46a0-9eb7-937c5ecd3629-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
Subject: [PATCH v14 05/27] t6030: explicitly test for bisection cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Aug 2016 11:53:53 +0000
X-SES-Outgoing: 2016.08.23-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index 5e5370f..18e7998 100755
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
https://github.com/git/git/pull/287
