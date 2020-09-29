Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EEDC47420
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 16:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FE83207F7
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 16:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=adoakley.name header.i=@adoakley.name header.b="ou/QbEKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbgI2QN2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 12:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbgI2QN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 12:13:27 -0400
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BA4C0613D0
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 09:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X+FfSuBPTIJeP7y4U5e2L0Js8nPM1MMtWf+qIGo/kEU=; b=ou/QbEKpqX6192Z7lEaHIkaXhE
        P4RR7gXRfciozb6coWxtwiDiw4G4aKVMomszYIAeAlUeDOlt1p+B1EdnvoR0gRJs198qURnS9ipxk
        F7pwuH8TtFD0XH2roCASFW8bKulPudgbHGhQStqK1Jq9MWMVEHE2qQulgk243j8PtugE=;
Received: from [2001:8b0:14bb:e93b::df1] (helo=ado-tr.ado-tr.lan)
        by adoakley.name with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.2)
        (envelope-from <andrew@adoakley.name>)
        id 1kNHx8-0004AY-3E; Tue, 29 Sep 2020 15:54:06 +0000
From:   Andrew Oakley <andrew@adoakley.name>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     Andrew Oakley <andrew@adoakley.name>
Subject: [PATCH 3/7] Add failing test for partial clones with submodules
Date:   Tue, 29 Sep 2020 16:53:46 +0100
Message-Id: <20200929155350.49066-4-andrew@adoakley.name>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929155350.49066-1-andrew@adoakley.name>
References: <20200929155350.49066-1-andrew@adoakley.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Diamand <luke@diamand.org>

When using a partial clone with submodules, the initial clone works
fine, but subsequent updates fail with:

    fatal: git upload-pack: not our ref 5d54256650497d43cbeedc86648d6f16eaf556d2
    fatal: remote error: upload-pack: not our ref 5d54256650497d43cbeedc86648d6f16eaf556d2

Signed-off-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Andrew Oakley <andrew@adoakley.name>
---
 t/t0411-partial-clone-submodules.sh | 44 +++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100755 t/t0411-partial-clone-submodules.sh

diff --git a/t/t0411-partial-clone-submodules.sh b/t/t0411-partial-clone-submodules.sh
new file mode 100755
index 0000000000..e8fdcc4670
--- /dev/null
+++ b/t/t0411-partial-clone-submodules.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+
+test_description='partial clone with submodules'
+
+. ./test-lib.sh
+
+test_expect_success 'partial clone setup' '
+	test_create_repo super &&
+    test_create_repo submod &&
+
+	git -C super config uploadpack.allowfilter true &&
+	git -C super config uploadpack.allowanysha1inwant true &&
+
+    generate_zero_bytes 1024 >submod/bigfile &&
+    generate_zero_bytes 1 >submod/smallfile &&
+    git -C submod add bigfile smallfile &&
+    git -C submod commit -m "Adding files" &&
+    git -C super submodule add ../submod ./submod &&
+    git -C super commit -m "Adding submodule" &&
+    generate_zero_bytes 1025 >submod/bigfile &&
+    git -C submod commit -m "Extend bigfile" bigfile &&
+    git -C super submodule update --rebase --remote &&
+    git -C super add submod &&
+    git -C super commit -m "Extend bigfile"
+'
+
+test_expect_success 'partial clone of super' '
+    git clone --recursive --filter=blob:limit=512 "file://$(pwd)/super" cloned-super &&
+    test_path_exists cloned-super/submod/bigfile
+'
+
+test_expect_success 'update submodule' '
+    generate_zero_bytes 1026 >submod/bigfile &&
+    git -C submod commit -m "Further extend bigfile" bigfile &&
+    git -C super submodule update --rebase --remote &&
+    git -C super add submod &&
+    git -C super commit -m "Further extend bigfile"
+'
+
+test_expect_success 'update partial clone' '
+    git -C cloned-super pull --recurse-submodules --rebase
+'
+
+test_done
-- 
2.26.2

