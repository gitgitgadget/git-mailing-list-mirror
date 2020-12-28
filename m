Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1567C433DB
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 00:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA93D229F0
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 00:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgL1Amy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 19:42:54 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:42880 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgL1Amx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 19:42:53 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktgc0-008QgC-Hq
        for git@vger.kernel.org; Sun, 27 Dec 2020 17:42:12 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktgbx-00GE0a-T2
        for git@vger.kernel.org; Sun, 27 Dec 2020 17:42:11 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id 90005500840;
        Sun, 27 Dec 2020 17:42:09 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2VgaZOwjHmZm; Sun, 27 Dec 2020 17:42:09 -0700 (MST)
Received: from localhost.localdomain (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id 3B243500613;
        Sun, 27 Dec 2020 17:42:09 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>
Date:   Sun, 27 Dec 2020 17:41:52 -0700
Message-Id: <20201228004152.522421-3-seth@eseth.com>
X-Mailer: git-send-email 2.30.0.rc0.dirty
In-Reply-To: <20201228004152.522421-1-seth@eseth.com>
References: <20201227205835.502556-1-seth@eseth.com>
 <20201228004152.522421-1-seth@eseth.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1ktgbx-00GE0a-T2;;;mid=<20201228004152.522421-3-seth@eseth.com>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: [PATCH v7 2/2] mergetool: Add per-tool support for the autoMerge flag
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
index 7ce6d0d3ac..ef147fc118 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -21,6 +21,9 @@ mergetool.<tool>.trustExitCode::
 	if the file has been updated, otherwise the user is prompted to
 	indicate the success of the merge.
 
+mergetool.<tool>.autoMerge::
+	Remove lines without conflicts from all the files. Defaults to `true`.
+
 mergetool.meld.hasOutput::
 	Older versions of `meld` do not support the `--output` option.
 	Git will attempt to detect whether `meld` supports `--output`
diff --git a/git-mergetool.sh b/git-mergetool.sh
index f4db0cac8d..e3c7d78d1d 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -334,7 +334,10 @@ merge_file () {
 	checkout_staged_file 2 "$MERGED" "$LOCAL"
 	checkout_staged_file 3 "$MERGED" "$REMOTE"
 
-	if test "$(git config --bool mergetool.autoMerge)" != "false"
+	if test "$(
+		git config --get --bool "mergetool.$merge_tool.automerge" ||
+		git config --get --bool "mergetool.automerge" ||
+		echo true)" = true
 	then
 		auto_merge
 	fi
-- 
2.29.2


