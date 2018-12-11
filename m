Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8035320A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 04:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbeLKEI6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 23:08:58 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:54780 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbeLKEI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 23:08:58 -0500
Received: from c-76-24-253-1.hsd1.nh.comcast.net ([76.24.253.1] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <yoh@onerussian.com>)
        id 1gWZLs-0004zj-E5; Mon, 10 Dec 2018 23:08:56 -0500
From:   Yaroslav Halchenko <debian@onerussian.com>
To:     git@vger.kernel.org
Cc:     Yaroslav Halchenko <debian@onerussian.com>
Date:   Mon, 10 Dec 2018 23:08:39 -0500
Message-Id: <20181211040839.17472-2-debian@onerussian.com>
X-Mailer: git-send-email 2.20.0.rc2.8.g0a3bec4a1c.dirty
In-Reply-To: <20181211040839.17472-1-debian@onerussian.com>
References: <CAGZ79kYDa27EFk4A9uEzCnoW7scjb1U8fKwCo0P7rUZESto+Qg@mail.gmail.com>
 <20181211040839.17472-1-debian@onerussian.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 76.24.253.1
X-SA-Exim-Rcpt-To: git@vger.kernel.org, yoh@onerussian.com
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: [PATCH 2/2] RF+ENH(TST): compare the entire list of submodule status --recursive to stay intact
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For submodule update --reset-hard the best test is comparison of the
entire status as shown by submodule status --recursive.  Upon update
--reset-hard we should get back to the original state, with all the
branches being the same (no detached HEAD) and commits identical to
original  (so no merges, new commits, etc).

For that, I have introduced two helpers: {record,compare}_submodules_status and
an additional test for --reset-hard in nested submodule.

I have kept this as a separate PATCH to demonstrate the diff from the original
test composition as introduced in the prior patch, and this one where
all tests could be of the same type:

    record_submodule_status &&
    perform evil actions &&
    ! compare_submodule_status &&   # to double check that evil was done
    git submodule --reset-hard . &&
    compare_submodule_status        # assure that we are all good

Signed-off-by: Yaroslav Halchenko <debian@onerussian.com>
---
 t/t7406-submodule-update.sh | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 2e08e0047c..1927424f47 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -21,6 +21,17 @@ compare_head()
     test "$sha_master" = "$sha_head"
 }
 
+record_submodules_status()
+{
+	git submodule status --recursive >expect
+}
+
+compare_submodules_status()
+{
+	git submodule status --recursive >actual &&
+	test_i18ncmp expect actual
+}
+
 
 test_expect_success 'setup a submodule tree' '
 	echo file > file &&
@@ -294,7 +305,7 @@ test_expect_success 'submodule update --rebase staying on master' '
 
 test_expect_success 'submodule update --merge staying on master' '
 	(cd super/submodule &&
-	  git reset --hard HEAD~1
+	 git reset --hard HEAD~1
 	) &&
 	(cd super &&
 	 (cd submodule &&
@@ -307,16 +318,28 @@ test_expect_success 'submodule update --merge staying on master' '
 '
 
 test_expect_success 'submodule update --reset-hard staying on master' '
-	(cd super/submodule &&
-	  git reset --hard HEAD~1
-	) &&
 	(cd super &&
+	 record_submodules_status &&
 	 (cd submodule &&
-	  compare_head
+	  git reset --hard HEAD~1
 	 ) &&
+	 ! compare_submodules_status &&
 	 git submodule update --reset-hard submodule &&
-	 cd submodule &&
-	 compare_head
+	 compare_submodules_status
+	)
+'
+
+test_expect_success 'submodule update --reset-hard in nested submodule' '
+	(cd recursivesuper &&
+	 git submodule update --init --recursive &&
+	 record_submodules_status &&
+	 (cd super/submodule &&
+	  echo 123 >> file &&
+	  git commit -m "new commit" file
+	 ) &&
+	 ! compare_submodules_status &&
+	 git submodule update --reset-hard --recursive &&
+	 compare_submodules_status
 	)
 '
 
-- 
2.20.0.rc2.8.g0a3bec4a1c.dirty

