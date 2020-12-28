Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E6BC4332B
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 04:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8D921D94
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 04:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgL1Ezr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 23:55:47 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:38278 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbgL1Ezr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 23:55:47 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktkYj-005P42-HB
        for git@vger.kernel.org; Sun, 27 Dec 2020 21:55:05 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktkYi-00Gtzl-R3
        for git@vger.kernel.org; Sun, 27 Dec 2020 21:55:05 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id B895650057A;
        Sun, 27 Dec 2020 21:55:04 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JNymxk6dHDoG; Sun, 27 Dec 2020 21:55:04 -0700 (MST)
Received: from localhost.localdomain (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id D8AD95004F7;
        Sun, 27 Dec 2020 21:55:03 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>
Date:   Sun, 27 Dec 2020 21:54:27 -0700
Message-Id: <20201228045427.1166911-5-seth@eseth.com>
X-Mailer: git-send-email 2.30.0.rc2.4.g8f3eabcc0e
In-Reply-To: <20201228045427.1166911-1-seth@eseth.com>
References: <20201228004152.522421-1-seth@eseth.com>
 <20201228045427.1166911-1-seth@eseth.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1ktkYi-00Gtzl-R3;;;mid=<20201228045427.1166911-5-seth@eseth.com>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: [PATCH v8 4/4] mergetool: Add automerge_enabled tool-specific override function
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hat-tip to Junio C Hamano for the implementation.

Signed-off-by: Seth House <seth@eseth.com>
---
 git-mergetool--lib.sh | 4 ++++
 git-mergetool.sh      | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index e059b3559e..5084ceffeb 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -164,6 +164,10 @@ setup_tool () {
 		return 1
 	}
 
+	automerge_enabled () {
+		true
+	}
+
 	translate_merge_tool_path () {
 		echo "$1"
 	}
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 929192d0f8..a44afd3822 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -336,7 +336,7 @@ merge_file () {
 
 	initialize_merge_tool "$merge_tool"
 
-	if test "$(
+	if automerge_enabled && test "$(
 		git config --get --bool "mergetool.$merge_tool.automerge" ||
 		git config --get --bool "mergetool.automerge" ||
 		echo true)" = true
-- 
2.29.2


