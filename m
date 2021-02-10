Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F930C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 21:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5491B64DE1
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 21:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhBJV4Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 16:56:25 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:38422 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230229AbhBJV4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 16:56:25 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 57CEC1F8C2;
        Wed, 10 Feb 2021 21:55:43 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] t1500: ensure current --since= behavior remains
Date:   Wed, 10 Feb 2021 21:55:43 +0000
Message-Id: <20210210215543.18960-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This behavior of git-rev-parse is observed since git 1.8.3.1
at least(*), and likely earlier versions.

At least one git-reliant project in-the-wild relies on this
current behavior of git-rev-parse being able to handle multiple
--since= arguments without squeezing identical results together.
So add a test to prevent the potential for regression in
downstream projects.

(*) 1.8.3.1 the version packaged for CentOS 7.x

Signed-off-by: Eric Wong <e@80x24.org>
---
 Said git-reliant project does use allow /optional/ use of libgit2
 via Perl Inline::C; but libgit2's git__date_parse() isn't part of
 the public API; and it's unlikely anybody using CentOS 7.x would
 run the latest libgit2 even if it were added today.

 t/t1500-rev-parse.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index abdda360d5..deae916707 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -243,4 +243,19 @@ test_expect_success 'showing the superproject correctly' '
 	test_cmp expect out
 '
 
+# at least one external project depends on this behavior:
+test_expect_success 'rev-parse --since= unsqueezed ordering' '
+	x1=--since=1970-01-01T00:00:01Z &&
+	x2=--since=1970-01-01T00:00:02Z &&
+	x3=--since=1970-01-01T00:00:03Z &&
+	git rev-parse $x1 $x1 $x3 $x2 >actual &&
+	cat >expect <<-EOF &&
+	--max-age=1
+	--max-age=1
+	--max-age=3
+	--max-age=2
+	EOF
+	test_cmp expect actual
+'
+
 test_done
