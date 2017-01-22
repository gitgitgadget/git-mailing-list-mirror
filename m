Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F2D82092F
	for <e@80x24.org>; Sun, 22 Jan 2017 23:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750737AbdAVXLi (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 18:11:38 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:24787 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbdAVXLh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 18:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1485126695;
        l=1698; s=domk; d=benjaminfuchs.de;
        h=Date:Subject:Cc:To:From;
        bh=AQBSIQKznp0+OGqUYPfGnsxA4ylf9u8xdo6hElamA4M=;
        b=M59EGURUy3Ium6Z9CGFR2oVse0jZWRTdZJyg2UpyghFiz15R9maeNko1bIW/NnHrrJ
        KO/wT3joItyqgONvTpbtafcUY7BfoWiO9o6OnNFN6/RDngO3qIkoF1jA7NG1Y+S4ztSm
        ayYvR3wG56sDYjMRSB/30wJSRl5IxYvgjGnlk=
X-RZG-AUTH: :KWEFfEyIefqISxrQo86CUgBQlWGSsNRH+R9D//SwlcQsxFnnwAcCeXqAJxZfrWfVMhxHI84=
X-RZG-CLASS-ID: mo00
Received: from fuchs-ThinkPad-T431s.poststrasse57.local (p4FF7640E.dip0.t-ipconnect.de [79.247.100.14])
        by smtp.strato.de (RZmta 39.11 DYNA|AUTH)
        with ESMTPSA id 0069c1t0MNBVXum
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 23 Jan 2017 00:11:31 +0100 (CET)
From:   Benjamin Fuchs <email@benjaminfuchs.de>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, sbeller@google.com, email@benjaminfuchs.de
Subject: [PATCH 4/4] git-prompt.sh: add tests for submodule indicator
Date:   Mon, 23 Jan 2017 00:11:19 +0100
Message-Id: <1485126679-7629-1-git-send-email-email@benjaminfuchs.de>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 t/t9903-bash-prompt.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 97c9b32..4dce366 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -37,6 +37,11 @@ test_expect_success 'setup for prompt tests' '
 	git commit -m "yet another b2" file &&
 	mkdir ignored_dir &&
 	echo "ignored_dir/" >>.gitignore &&
+	git checkout -b submodule &&
+	git submodule add ./. sub &&
+	git -C sub checkout master &&
+	git add sub &&
+	git commit -m submodule &&
 	git checkout master
 '
 
@@ -755,4 +760,42 @@ test_expect_success 'prompt - hide if pwd ignored - inside gitdir (stderr)' '
 	test_cmp expected "$actual"
 '
 
+test_expect_success 'prompt - submodule indicator' '
+	printf " (sub:master)" >expected &&
+	git checkout submodule &&
+	test_when_finished "git checkout master" &&
+	(
+		cd sub &&
+		GIT_PS1_SHOWSUBMODULE=1 &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - submodule indicator - verify false' '
+	printf " (master)" >expected &&
+	git checkout submodule &&
+	test_when_finished "git checkout master" &&
+	(
+		cd sub &&
+		GIT_PS1_SHOWSUBMODULE= &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - submodule indicator - dirty status indicator' '
+	printf " (+sub:b1)" >expected &&
+	git checkout submodule &&
+	git -C sub checkout b1 &&
+	test_when_finished "git checkout master" &&
+	(
+		cd sub &&
+		GIT_PS1_SHOWSUBMODULE=1 &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+
 test_done
-- 
2.7.4

