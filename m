Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F84A1FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 17:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337AbcFTRWM (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 13:22:12 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33912 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbcFTRWK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 13:22:10 -0400
Received: by mail-pa0-f46.google.com with SMTP id bz2so52727021pad.1
        for <git@vger.kernel.org>; Mon, 20 Jun 2016 10:21:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0fPW5a0so8t1xnieQBskyeaIhN0tP6s0Fk+ktr1EB1w=;
        b=Of09BIEXJcwgodsXGsLkZUogDvyrF1E6fa7r2scYzjJZ0F4GLSo3nm6UtNc4U5L0ib
         pDOLxDF61JDvTt6KT7zUSzbSOuyrt8mAlgQXpBSsOsAB96/GHHYZgtQi19AZ3YMyLkbd
         MtkY7OnyL5LKDP2b6v9AH2ed2lnE+7JpnC0j7eIK17btv43wDhS00rSO8VmmC7pYJ0p1
         geUdS/paJWXRbqJT5t0eSp+LMVHjbMubCGAn+0TNTM6hXO7I6uZuuDLM4CTY3m3BMDD4
         pt+6FWwhLox338BdBaA9akibZQaFKuDtGTgsNfaiy5vXqeOs9ewWriSs5Y8FpURVPt7V
         ToIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0fPW5a0so8t1xnieQBskyeaIhN0tP6s0Fk+ktr1EB1w=;
        b=IVzO+JIG1j6sYr2rUJOiYLroaB/eVY6ivDL3/bMtJ0mdnSyxdrTsb3L9pyHsnJP+3P
         nLA2QNIMSFkdB2fNaWmTdNQcx7vavE3OJlJ/eGeeXCu6WuO5S+x1bVbEf3FJzncDSc07
         Frzw2w+Eq5eIMBXy5VQIaiaP23797V3XmY467srwvOI2UowO8BwCgwNBUtMQRSybcd70
         iWH7+e5ybharyuAbljdQV0/pX7yP48ic3qcR5kV6gVeWw4qaN5fvapBXnZ1OqSd/QTBe
         RuaimS4ICxAZzqUzcdmuuZjNutVgn6nLqMHO8rhjAA80I7Rt+FKMJS91pLMyfHk1bx2Q
         GSaA==
X-Gm-Message-State: ALyK8tKrwf8KC2wMd3RJVhRqsUTtfSbnlVcAu5rbxHQf1gPrMWi+C3IREYQdoJSrNlOxPwNF
X-Received: by 10.66.199.66 with SMTP id ji2mr23159702pac.34.1466443282092;
        Mon, 20 Jun 2016 10:21:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:dd7a:ae19:9fa3:441d])
        by smtp.gmail.com with ESMTPSA id zo15sm69283334pab.15.2016.06.20.10.21.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Jun 2016 10:21:21 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com, peff@peff.net
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] t5614: don't use subshells
Date:	Mon, 20 Jun 2016 10:21:18 -0700
Message-Id: <1466443278-21591-1-git-send-email-sbeller@google.com>
X-Mailer: git-send-email 2.7.0.rc0.40.g5328432.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Using a subshell for just one git command is both a waste in compute
overhead (create a new process) as well as in line count.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Junio,

 This goes on top of the patch that I just sent
 "[PATCH] shallow clone to not imply shallow submodules" (which is to
 be squashed into "clone: do not let --depth imply --shallow-submodules".
 
 Unlike the prior patch we would not want this patch to fall through
 to origin/maint fast, but allow cooking?
 
 Thanks,
 Stefan

 t/t5614-clone-submodules.sh | 70 +++++++++++++--------------------------------
 1 file changed, 20 insertions(+), 50 deletions(-)

diff --git a/t/t5614-clone-submodules.sh b/t/t5614-clone-submodules.sh
index a9aaa01..da2a67f 100755
--- a/t/t5614-clone-submodules.sh
+++ b/t/t5614-clone-submodules.sh
@@ -25,76 +25,46 @@ test_expect_success 'setup' '
 test_expect_success 'nonshallow clone implies nonshallow submodule' '
 	test_when_finished "rm -rf super_clone" &&
 	git clone --recurse-submodules "file://$pwd/." super_clone &&
-	(
-		cd super_clone &&
-		git log --oneline >lines &&
-		test_line_count = 3 lines
-	) &&
-	(
-		cd super_clone/sub &&
-		git log --oneline >lines &&
-		test_line_count = 3 lines
-	)
+	git -C super_clone log --oneline >lines &&
+	test_line_count = 3 lines &&
+	git -C super_clone/sub log --oneline >lines &&
+	test_line_count = 3 lines
 '
 
 test_expect_success 'shallow clone with shallow submodule' '
 	test_when_finished "rm -rf super_clone" &&
 	git clone --recurse-submodules --depth 2 --shallow-submodules "file://$pwd/." super_clone &&
-	(
-		cd super_clone &&
-		git log --oneline >lines &&
-		test_line_count = 2 lines
-	) &&
-	(
-		cd super_clone/sub &&
-		git log --oneline >lines &&
-		test_line_count = 1 lines
-	)
+	git -C super_clone log --oneline >lines &&
+	test_line_count = 2 lines &&
+	git -C super_clone/sub log --oneline >lines &&
+	test_line_count = 1 lines
 '
 
 test_expect_success 'shallow clone does not imply shallow submodule' '
 	test_when_finished "rm -rf super_clone" &&
 	git clone --recurse-submodules --depth 2 "file://$pwd/." super_clone &&
-	(
-		cd super_clone &&
-		git log --oneline >lines &&
-		test_line_count = 2 lines
-	) &&
-	(
-		cd super_clone/sub &&
-		git log --oneline >lines &&
-		test_line_count = 3 lines
-	)
+	git -C super_clone log --oneline >lines &&
+	test_line_count = 2 lines &&
+	git -C super_clone/sub log --oneline >lines &&
+	test_line_count = 3 lines
 '
 
 test_expect_success 'shallow clone with non shallow submodule' '
 	test_when_finished "rm -rf super_clone" &&
 	git clone --recurse-submodules --depth 2 --no-shallow-submodules "file://$pwd/." super_clone &&
-	(
-		cd super_clone &&
-		git log --oneline >lines &&
-		test_line_count = 2 lines
-	) &&
-	(
-		cd super_clone/sub &&
-		git log --oneline >lines &&
-		test_line_count = 3 lines
-	)
+	git -C super_clone log --oneline >lines &&
+	test_line_count = 2 lines &&
+	git -C super_clone/sub log --oneline >lines &&
+	test_line_count = 3 lines
 '
 
 test_expect_success 'non shallow clone with shallow submodule' '
 	test_when_finished "rm -rf super_clone" &&
 	git clone --recurse-submodules --no-local --shallow-submodules "file://$pwd/." super_clone &&
-	(
-		cd super_clone &&
-		git log --oneline >lines &&
-		test_line_count = 3 lines
-	) &&
-	(
-		cd super_clone/sub &&
-		git log --oneline >lines &&
-		test_line_count = 1 lines
-	)
+	git -C super_clone log --oneline >lines &&
+	test_line_count = 3 lines &&
+	git -C super_clone/sub log --oneline >lines &&
+	test_line_count = 1 lines
 '
 
 test_done
-- 
2.7.0.rc0.40.g5328432.dirty

