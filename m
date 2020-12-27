Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C2DC433E6
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 21:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC9F2255F
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 21:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgL0U70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 15:59:26 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:46476 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgL0U7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 15:59:25 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktd7k-004xb5-DC
        for git@vger.kernel.org; Sun, 27 Dec 2020 13:58:44 -0700
Received: from mta5.zcs.xmission.com ([166.70.13.69])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktd7j-00FgVW-Dv
        for git@vger.kernel.org; Sun, 27 Dec 2020 13:58:43 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta5.zcs.xmission.com (Postfix) with ESMTP id 475F112806B1;
        Sun, 27 Dec 2020 13:58:43 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta5.zcs.xmission.com
Received: from mta5.zcs.xmission.com ([127.0.0.1])
        by localhost (mta5.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xIqAkVjApdIa; Sun, 27 Dec 2020 13:58:43 -0700 (MST)
Received: from localhost.localdomain (unknown [139.60.10.209])
        by mta5.zcs.xmission.com (Postfix) with ESMTPSA id EC35212807DC;
        Sun, 27 Dec 2020 13:58:42 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>
Date:   Sun, 27 Dec 2020 13:58:35 -0700
Message-Id: <20201227205835.502556-3-seth@eseth.com>
X-Mailer: git-send-email 2.30.0.rc0.dirty
In-Reply-To: <20201227205835.502556-1-seth@eseth.com>
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
 <20201227205835.502556-1-seth@eseth.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1ktd7j-00FgVW-Dv;;;mid=<20201227205835.502556-3-seth@eseth.com>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.69;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.69
X-SA-Exim-Mail-From: seth@eseth.com
Subject: [PATCH v6 2/2] mergetool: Add per-tool support for the autoMerge flag
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep the global mergetool flag and add a per-tool override flag so that
users may enable the flag for one tool and disable it for another.

Signed-off-by: Seth House <seth@eseth.com>
---
 Documentation/config/mergetool.txt | 3 +++
 git-mergetool.sh                   | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 43af7a96f9..7f32281a61 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -21,6 +21,9 @@ mergetool.<tool>.trustExitCode::
 	if the file has been updated, otherwise the user is prompted to
 	indicate the success of the merge.
 
+mergetool.<tool>.autoMerge::
+	Automatically resolve conflicts that don't require user intervention.
+
 mergetool.meld.hasOutput::
 	Older versions of `meld` do not support the `--output` option.
 	Git will attempt to detect whether `meld` supports `--output`
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 6e86d3b492..81df301734 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -323,7 +323,10 @@ merge_file () {
 	checkout_staged_file 2 "$MERGED" "$LOCAL"
 	checkout_staged_file 3 "$MERGED" "$REMOTE"
 
-	if test "$(git config --bool mergetool.autoMerge)" = "true"
+	if test "$(
+		git config --get --bool "mergetool.$merge_tool.automerge" ||
+		git config --get --bool "mergetool.automerge" ||
+		echo true)" = true
 	then
 		git merge-file --diff3 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
 		sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======\r\?$/,/^>>>>>>> /d' "$DIFF3" >"$BASE"
-- 
2.29.2


