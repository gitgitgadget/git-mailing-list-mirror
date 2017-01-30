Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E4D120D11
	for <e@80x24.org>; Mon, 30 Jan 2017 20:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932409AbdA3UpU (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 15:45:20 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:9295 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932280AbdA3UpS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 15:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1485809111;
        l=1754; s=domk; d=benjaminfuchs.de;
        h=References:In-Reply-To:Date:Subject:Cc:To:From;
        bh=xDO7FbR4qpCwH5WOzEF8t1yAVsI0SoMMFH0/b/ykptg=;
        b=tVUzRwiSwIM8cJHpPPw0wy1WsTDPY2fcqiXClV4RoBvmvyj5H9moVBSZG07XNJ0k78
        3EtR1NGBR9ETUdNuMrOyacPdOHeRYCA9UYFisxl/kRDknGU7p30SS3/Zl3fM3BRqAxn0
        OjcR5UcqaLYokDOlGJcMa36sicPF5SC2AL5qU=
X-RZG-AUTH: :KWEFfEyIefqISxrQo86CUgBQlWGSsNRH+R9D//SwlcQsxFnnwAcCdlhhPcjKRjsJ00UGWq4=
X-RZG-CLASS-ID: mo00
Received: from fuchs-ThinkPad-T431s.poststrasse57.local (p5499AE19.dip0.t-ipconnect.de [84.153.174.25])
        by smtp.strato.de (RZmta 39.11 DYNA|AUTH)
        with ESMTPSA id x0accft0UKiZLRV
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 30 Jan 2017 21:44:35 +0100 (CET)
From:   Benjamin Fuchs <email@benjaminfuchs.de>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, sbeller@google.com,
        sandals@crustytoothpaste.net, ville.skytta@iki.fi,
        Benjamin Fuchs <email@benjaminfuchs.de>
Subject: [PATCH 4/4] git-prompt.sh: add tests for submodule indicator
Date:   Mon, 30 Jan 2017 21:44:25 +0100
Message-Id: <1485809065-11978-5-git-send-email-email@benjaminfuchs.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1485809065-11978-1-git-send-email-email@benjaminfuchs.de>
References: <1485809065-11978-1-git-send-email-email@benjaminfuchs.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Benjamin Fuchs <email@benjaminfuchs.de>
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

