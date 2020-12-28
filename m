Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47FBC4361B
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4495207A6
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgL1Wzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:35 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:48910 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbgL1Tai (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 14:30:38 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktyDN-002gQR-Fe; Mon, 28 Dec 2020 12:29:57 -0700
Received: from mta5.zcs.xmission.com ([166.70.13.69])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktyDM-001lpV-HA; Mon, 28 Dec 2020 12:29:57 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta5.zcs.xmission.com (Postfix) with ESMTP id 50B6912801DF;
        Mon, 28 Dec 2020 12:29:56 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta5.zcs.xmission.com
Received: from mta5.zcs.xmission.com ([127.0.0.1])
        by localhost (mta5.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qpc43HR5JKXu; Mon, 28 Dec 2020 12:29:56 -0700 (MST)
Received: from localhost.localdomain (unknown [139.60.10.209])
        by mta5.zcs.xmission.com (Postfix) with ESMTPSA id E86DB12805E8;
        Mon, 28 Dec 2020 12:29:55 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Date:   Mon, 28 Dec 2020 12:29:17 -0700
Message-Id: <20201228192919.1195211-4-seth@eseth.com>
X-Mailer: git-send-email 2.30.0.rc2.4.g8f3eabcc0e
In-Reply-To: <20201228192919.1195211-1-seth@eseth.com>
References: <20201228045427.1166911-1-seth@eseth.com>
 <20201228192919.1195211-1-seth@eseth.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1ktyDM-001lpV-HA;;;mid=<20201228192919.1195211-4-seth@eseth.com>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.69;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.69
X-SA-Exim-Mail-From: seth@eseth.com
Subject: [PATCH v9 3/5] mergetool: add per-tool support for the autoMerge flag
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep the global mergetool flag and add a per-tool override flag so that
users may enable the flag for one tool and disable it for another.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Seth House <seth@eseth.com>
---
 Documentation/config/mergetool.txt | 15 ++++++++++++++-
 git-mergetool.sh                   |  5 ++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 3291fa7102..bde472d49a 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -1,3 +1,9 @@
+mergetool.<tool>.autoMerge::
+	A mergetool-specific override for the global `mergetool.autoMerge`
+	configuration flag. This allows individual mergetools to enable or
+	disable the flag regardless of the global setting. See
+	`mergetool.autoMerge` for the full description.
+
 mergetool.<tool>.cmd::
 	Specify the command to invoke the specified merge tool.  The
 	specified command is evaluated in shell with the following
@@ -41,7 +47,14 @@ mergetool.meld.useAutoMerge::
 	default value.
 
 mergetool.autoMerge::
-	Remove lines without conflicts from all the files. Defaults to `true`.
+	During a merge Git will automatically resolve as many conflicts as
+	possible and then wrap conflict markers around any conflicts that it
+	cannot resolve. This flag consolidates the non-conflicting parts into
+	the corresponding 'LOCAL' and 'REMOTE' files so that only the
+	unresolved conflicts are presented to the merge tool. Can be overriden
+	per-tool via the `mergetool.<tool>.autoMerge` configuration variable.
+	Note: individual mergetool scripts can elect to ignore user preferences
+	entirely. Defaults to `true`.
 
 mergetool.keepBackup::
 	After performing a merge, the original file with conflict markers
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


