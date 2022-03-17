Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF39C433FE
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 12:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbiCQM7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 08:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiCQM53 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 08:57:29 -0400
X-Greylist: delayed 514 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Mar 2022 05:54:44 PDT
Received: from mailproxy06.manitu.net (mailproxy06.manitu.net [IPv6:2a00:1828:1000:1111::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E864132EA1
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 05:54:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2001:9e8:6a71:2d00:4a0a:6bb:5995:d38e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy06.manitu.net (Postfix) with ESMTPSA id 9645D580115;
        Thu, 17 Mar 2022 13:46:07 +0100 (CET)
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] tests: test show --word-diff --color-moved
Date:   Thu, 17 Mar 2022 13:46:06 +0100
Message-Id: <a5e5cdd4658d457ffbd80f7263e352cbf3141a1a.1647520853.git.git@grubix.eu>
X-Mailer: git-send-email 2.35.1.981.gd72fe90d09
In-Reply-To: <220304.861qzhftzc.gmgdl@evledraar.gmail.com>
References: <220304.861qzhftzc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

a18d66cefb ("diff.c: free "buf" in diff_words_flush()", 2022-03-04)
introduced a breakage to `show --word-diff --color-moved` which gives

free(): double free detected in tcache 2
Aborted (core dumped)

on every incarnation. This was not caught by the test suite because we
test `diff --word-diff --color-moved` only so far.

Therefore, add a test for `show`, too.

Reverting a18d66cefb makes the test pass, but there might be a better
fix.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 t/t4015-diff-whitespace.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 9babf13bc9..ff8a0426ca 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1622,7 +1622,7 @@ test_expect_success 'cmd option assumes configured colored-moved' '
 	test_cmp expected actual
 '
 
-test_expect_success 'no effect from --color-moved with --word-diff' '
+test_expect_success 'no effect on diff from --color-moved with --word-diff' '
 	cat <<-\EOF >text.txt &&
 	Lorem Ipsum is simply dummy text of the printing and typesetting industry.
 	EOF
@@ -1636,6 +1636,12 @@ test_expect_success 'no effect from --color-moved with --word-diff' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'no effect on show from --color-moved with --word-diff' '
+	git show --color-moved --word-diff >actual &&
+	git show --word-diff >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'set up whitespace tests' '
 	git reset --hard &&
 	# Note that these lines have no leading or trailing whitespace.
-- 
2.35.1.981.gd72fe90d09

