Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777DAC4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46021222C2
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420291AbgJYWmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420276AbgJYWmA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:42:00 -0400
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F3CC061755
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:42:00 -0700 (PDT)
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXr-0007u5-7O; Sun, 25 Oct 2020 22:27:19 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com
Subject: [PATCH 16/21] t7513: add failing test for configured trailing line classification
Date:   Sun, 25 Oct 2020 22:26:47 +0100
Message-Id: <20201025212652.3003036-17-anders@0x63.nu>
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
        id 1kWnXr-0007u5-7O; Sun, 25 Oct 2020 22:27:19 +0100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

); SAEximRunCond expanded to false

This testcases shows why prefix matching shouldn't be used when using
configured trailers to classify lines as trailers or not.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 t/t7513-interpret-trailers.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 4b3a2484b5..b1e9a9e6d1 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -239,6 +239,35 @@ test_expect_success 'with non-trailer lines mixed with a configured trailer' '
 	test_cmp expected actual
 '
 
+# This fails because "c:/windows/tmp/stuff/temp.txt" is classified as
+# a trailer line because "c" is a prefix of "Confirmed-By". Therefore
+# the new trailer is appended to that (non-trailer) block rather than
+# creating a new block. It also canonicalize the "trailer" to
+# "Confirmed-By: /windows/tmp/stuff/temp.txt"
+test_expect_failure 'with non-trailer lines mixed with prefix of configured trailer' '
+	cat >patch <<-\EOF &&
+		some subject
+
+		This is clearly not a trailer line. But
+		on next line there is a a windows path
+		c:/windows/tmp/stuff/temp.txt but that
+		should not make this classify as a trailer block
+	EOF
+	cat >expected <<-\EOF &&
+		some subject
+
+		This is clearly not a trailer line. But
+		on next line there is a a windows path
+		c:/windows/tmp/stuff/temp.txt but that
+		should not make this classify as a trailer block
+
+		t: v
+	EOF
+	test_config trailer.confirmedby.key "Confirmed-By" &&
+	git interpret-trailers --trailer "t: v" patch >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'with non-trailer lines mixed with a non-configured trailer' '
 	cat >patch <<-\EOF &&
 
-- 
2.25.1

