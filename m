Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300E8E9371F
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 23:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378998AbjJIXfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 19:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbjJIXfN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 19:35:13 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EE4A6
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 16:35:12 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4S4Fkh30tFz9sny;
        Tue, 10 Oct 2023 01:35:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
        t=1696894508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26KheS83dEowkinWRd7ozsP5i/oCz2R04s7j1n5R3CE=;
        b=cWMtat/ntnGh5CSubNQIPptwSysPKxOiVoQmpYj1EWZyPPjbp22o3zDQGiWdsYetmGE72a
        P2DDoHCyRdmQGnPHgq/pzcKDTCSRlReo2oVbGfTRf1LY7PbbMsr3+8Ov+B/AfGIbr2nD/J
        1wdnaePa0z9ascvv3wrCXnsefzjCyeoD2zH1XgPa0cRNnFJ5sf9vK9f0gEBJaec7nrT/KP
        n0MnfR1MfaBEU/t9tn6Z2fJev4nUhEd7xuibkRyxbnYt5OP2g2VkmyQiMooH6vbAa0MO8U
        jbMpouVwEfcTWBNfiUJCtz5VNEZILcGhk2PatbvQvdBm6B3LGS0YpoGc2nha2g==
From:   Hugo Sales <hugo@hsal.es>
To:     git@vger.kernel.org
Cc:     Hugo Sales <hugo@hsal.es>
Subject: [PATCH 2/3] mv: Add tests for new -p flag
Date:   Tue, 10 Oct 2023 00:34:57 +0100
Message-ID: <20231009233458.1371351-3-hugo@hsal.es>
In-Reply-To: <20231009233458.1371351-1-hugo@hsal.es>
References: <20231009233458.1371351-1-hugo@hsal.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4S4Fkh30tFz9sny
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 t/t7009-mv-parents.sh | 79 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100755 t/t7009-mv-parents.sh

diff --git a/t/t7009-mv-parents.sh b/t/t7009-mv-parents.sh
new file mode 100755
index 0000000000..cc1d9dae08
--- /dev/null
+++ b/t/t7009-mv-parents.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+
+test_description='git mv -p'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'mv fails to move a file if the target directory does not exist' '
+	echo test >test1 &&
+	git add test1 &&
+	test_must_fail git mv test1 foo/
+'
+
+test_expect_success 'mv fails to move multiple files if the target directory does not exist' '
+	echo test >test2-1 &&
+	echo test >test2-2 &&
+	git add test2-1 test2-2 &&
+	test_must_fail git mv test2-1 test2-2 foo/
+'
+
+test_expect_success 'mv fails to move a file if the target refers to a file in a directory that does not exist' '
+	echo test >test3 &&
+	git add test3 &&
+	test_must_fail git mv test3 foo/test3.txt
+'
+
+test_expect_success 'mv succeeds to move a file even if the target directory does not exist' '
+	echo test >test4 &&
+	git add test4 &&
+	git commit -m test4-commit1 &&
+	git mv -p test4 dir4/ &&
+	git commit -m test4-commit2 &&
+	git diff-tree -r -M --name-status HEAD^ HEAD >test4-actual &&
+	grep "^R100..*test4..*dir4/test4" test4-actual
+'
+
+test_expect_success 'mv succeeds to move multiple files even if the target directory does not exist' '
+	echo test >test5-1 &&
+	echo test >test5-2 &&
+	git add test5-1 test5-2 &&
+	git commit -m test5-commit1 &&
+	git mv -p test5-1 test5-2 dir5/ &&
+	git commit -m test5-commit2 &&
+	git diff-tree -r -M --name-status HEAD^ HEAD >test5-actual &&
+	grep -e "^R100..*test5-1..*dir5/test5-1" -e "^R100..*test5-2..*dir5/test5-2" test5-actual
+'
+
+test_expect_success 'mv succeeds to move a file even if the target refers to a file in a directory that does not exist' '
+	echo test >test6 &&
+	git add test6 &&
+	git commit -m test6-commmit-1 &&
+	git mv -p test6 dir6/test6.txt &&
+	git commit -m test6-commit2 &&
+	git diff-tree -r -M --name-status HEAD^ HEAD >test6-actual &&
+	grep "^R100..*test6..*dir6/test6.txt" test6-actual
+'
+
+test_expect_success 'mv succeeds to move a file even if the target refers to a file in a directory inside a directory that does not exist' '
+	echo test >test7 &&
+	git add test7 &&
+	git commit -m test7-commit1 &&
+	git mv -p test7 dir7/dir7/test7.txt &&
+	git commit -m test7-commit2 &&
+	git diff-tree -r -M --name-status HEAD^ HEAD >test7-actual &&
+	grep "^R100..*test7..*dir7/dir7/test7.txt" test7-actual
+'
+
+test_expect_success 'mv succeeds to move a file even if the target refers to a file in a directory inside a directory inside a directory that does not exist' '
+	echo test >test8 &&
+	git add test8 &&
+	git commit -m test8-commit1 &&
+	git mv -p test8 dir8/dir8/dir8/test8.txt &&
+	git commit -m test8-commit2 &&
+	git diff-tree -r -M --name-status HEAD^ HEAD >test8-actual &&
+	grep "^R100..*test8..*dir8/dir8/dir8/test8.txt" test8-actual
+'
+
+test_done
-- 
2.42.0

