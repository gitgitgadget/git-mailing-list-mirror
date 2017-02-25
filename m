Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BD1D2022D
	for <e@80x24.org>; Sat, 25 Feb 2017 10:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbdBYKN3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 05:13:29 -0500
Received: from userp1040.oracle.com ([156.151.31.81]:33312 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbdBYKN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 05:13:29 -0500
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v1PADOVO016591
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 25 Feb 2017 10:13:24 GMT
Received: from t460.home (dhcp-ukc1-twvpn-2-vpnpool-10-175-206-239.vpn.oracle.com [10.175.206.239])
        by aserv0021.oracle.com (8.13.8/8.14.4) with ESMTP id v1PADC6E005857;
        Sat, 25 Feb 2017 10:13:22 GMT
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Michal Zalewski <lcamtuf@google.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH 2/2] apply: handle assertion failure gracefully
Date:   Sat, 25 Feb 2017 11:13:07 +0100
Message-Id: <20170225101307.24067-2-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.12.0.rc0
In-Reply-To: <20170225101307.24067-1-vegard.nossum@oracle.com>
References: <20170225101307.24067-1-vegard.nossum@oracle.com>
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the patches in the added testcases, we were crashing with:

    git-apply: apply.c:3665: check_preimage: Assertion `patch->is_new <= 0' failed.

As it turns out, check_preimage() is prepared to handle these conditions,
so we can remove the assertion.

Found using AFL.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>

---

(I'm fully aware of how it looks to just delete an assertion to "fix" a
bug without any other changes to accomodate the condition that was
being tested for. I am definitely not an expert on this code, but as far
as I can tell -- both by reviewing and testing the code -- the function
really is prepared to handle the case where patch->is_new == 1, as it
will always hit another error condition if that is true. I've tried to
add more test cases to show what errors you can expect to see instead of
the assertion failure when trying to apply these nonsensical patches. If
you don't want to remove the assertion for whatever reason, please feel
free to take the testcases and add "# TODO: known breakage" or whatever.)
---
 apply.c                     |  1 -
 t/t4154-apply-git-header.sh | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index cbf7cc7f2..9219d2737 100644
--- a/apply.c
+++ b/apply.c
@@ -3652,7 +3652,6 @@ static int check_preimage(struct apply_state *state,
 	if (!old_name)
 		return 0;
 
-	assert(patch->is_new <= 0);
 	previous = previous_patch(state, patch, &status);
 
 	if (status)
diff --git a/t/t4154-apply-git-header.sh b/t/t4154-apply-git-header.sh
index d651af4a2..c440c48ad 100755
--- a/t/t4154-apply-git-header.sh
+++ b/t/t4154-apply-git-header.sh
@@ -12,4 +12,40 @@ rename new 0
 EOF
 '
 
+test_expect_success 'apply deleted file mode / new file mode / wrong mode' '
+	test_must_fail git apply << EOF
+diff --git a/. b/.
+deleted file mode 
+new file mode 
+EOF
+'
+
+test_expect_success 'apply deleted file mode / new file mode / wrong type' '
+	mkdir x &&
+	chmod 755 x &&
+	test_must_fail git apply << EOF
+diff --git a/x b/x
+deleted file mode 160755
+new file mode 
+EOF
+'
+
+test_expect_success 'apply deleted file mode / new file mode / already exists' '
+	touch 1 &&
+	chmod 644 1 &&
+	test_must_fail git apply << EOF
+diff --git a/1 b/1
+deleted file mode 100644
+new file mode 
+EOF
+'
+
+test_expect_success 'apply new file mode / copy from / nonexistant file' '
+	test_must_fail git apply << EOF
+diff --git a/. b/.
+new file mode 
+copy from  
+EOF
+'
+
 test_done
-- 
2.12.0.rc0

