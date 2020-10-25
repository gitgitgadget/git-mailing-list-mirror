Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365BEC4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02852222EC
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420259AbgJYWlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1418775AbgJYWls (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:41:48 -0400
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA7AC061755
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:41:48 -0700 (PDT)
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXs-0007u5-8E; Sun, 25 Oct 2020 22:27:20 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com
Subject: [PATCH 20/21] trailer: add failing tests for matching trailers against input
Date:   Sun, 25 Oct 2020 22:26:51 +0100
Message-Id: <20201025212652.3003036-21-anders@0x63.nu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201025212652.3003036-1-anders@0x63.nu>
References: <20201025212652.3003036-1-anders@0x63.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on st.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXs-0007u5-8E; Sun, 25 Oct 2020 22:27:20 +0100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

); SAEximRunCond expanded to false

These tests shows problematic cases where input trailers matches
config.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 t/t7513-interpret-trailers.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 6ddc2f5573..a99d6d7e3b 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -151,6 +151,41 @@ test_expect_success 'spelling and separators are not canonicalized with --parse
 	test_cmp expected actual
 '
 
+# Matching currently is prefix matching, causing "This-trailer" to be normalized too
+test_expect_failure 'config option matches exact only' '
+	cat >patch <<-\EOF &&
+
+		This-trailer: a
+		 b
+		This-trailer-exact: b
+		 c
+		This-trailer-exact-plus-some: c
+		 d
+	EOF
+	cat >expected <<-\EOF &&
+		This-trailer: a b
+		THIS-TRAILER-EXACT: b c
+		This-trailer-exact-plus-some: c d
+	EOF
+	git -c "trailer.tte.key=THIS-TRAILER-EXACT" interpret-trailers --only-input --only-trailers --unfold patch >actual &&
+	test_cmp expected actual
+'
+
+# Matching currently uses the config key even if key value is different
+test_expect_failure 'config option matches exact only' '
+	cat >patch <<-\EOF &&
+
+		Ticket: 1234
+		Reference-ticket: 99
+	EOF
+	cat >expected <<-\EOF &&
+		Ticket: 1234
+		Reference-Ticket: 99
+	EOF
+	git -c "trailer.ticket.key=Reference-Ticket" interpret-trailers --only-input --only-trailers patch >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'with only a title in the message' '
 	cat >expected <<-\EOF &&
 		area: change
-- 
2.25.1

