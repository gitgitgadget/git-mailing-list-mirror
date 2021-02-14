Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F12C433E0
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 02:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4386564E4C
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 02:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBNC3d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Feb 2021 21:29:33 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:59574 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhBNC3b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Feb 2021 21:29:31 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1lB79W-0030aW-Ci
        for git@vger.kernel.org; Sat, 13 Feb 2021 19:28:50 -0700
Received: from mta5.zcs.xmission.com ([166.70.13.69])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1lB79V-00CgBz-I7
        for git@vger.kernel.org; Sat, 13 Feb 2021 19:28:50 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta5.zcs.xmission.com (Postfix) with ESMTP id 6D31C1280AD3;
        Sat, 13 Feb 2021 19:28:49 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta5.zcs.xmission.com
Received: from mta5.zcs.xmission.com ([127.0.0.1])
        by localhost (mta5.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oUB1qaYEH4Ut; Sat, 13 Feb 2021 19:28:49 -0700 (MST)
Received: from ellen.lan (unknown [139.60.10.209])
        by mta5.zcs.xmission.com (Postfix) with ESMTPSA id 384901280B28;
        Sat, 13 Feb 2021 19:28:49 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>
Date:   Sat, 13 Feb 2021 19:28:40 -0700
Message-Id: <20210214022840.849312-2-seth@eseth.com>
X-Mailer: git-send-email 2.30.1.617.g3a1ad5624f
In-Reply-To: <20210214022840.849312-1-seth@eseth.com>
References: <20210214022840.849312-1-seth@eseth.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1lB79V-00CgBz-I7;;;mid=<20210214022840.849312-2-seth@eseth.com>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.69;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.69
X-SA-Exim-Mail-From: seth@eseth.com
Subject: [PATCH 1/1] mergetools/vimdiff: add vimdiff1 merge tool variant
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds yet another vimdiff/gvimdiff variant and presents conflicts as
a two-way diff between 'LOCAL' and 'REMOTE'. 'MERGED' is not opened
which deviates from the norm so usage text is echoed as a Vim message on
startup that instructs the user with how to proceed and how to abort.

Vimdiff is well-suited to two-way diffs so this is an option for a more
simple, more streamlined conflict resolution. For example: it is
difficult to communicate differences across more than two files using
only syntax highlighting; default vimdiff commands to get and put
changes between buffers do not need the user to manually specify
a source or destination buffer when only using two buffers.

Like other merge tools that directly compare 'LOCAL' with 'REMOTE', this
tool will benefit when paired with the new `mergetool.hideResolved`
setting.

Signed-off-by: Seth House <seth@eseth.com>
---
 mergetools/vimdiff | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index abc8ce4ec4..96f6209a04 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -15,6 +15,17 @@ merge_cmd () {
 				"$LOCAL" "$MERGED" "$REMOTE"
 		fi
 		;;
+	*vimdiff1)
+		"$merge_tool_path" -f -d \
+			-c 'echon "Resolve conflicts leftward then save. Use :cq to abort."' \
+			"$LOCAL" "$REMOTE"
+		ret="$?"
+		if test "$ret" -eq 0
+		then
+			cp -- "$LOCAL" "$MERGED"
+		fi
+		return "$ret"
+		;;
 	*vimdiff2)
 		"$merge_tool_path" -f -d -c 'wincmd l' \
 			"$LOCAL" "$MERGED" "$REMOTE"
@@ -52,7 +63,7 @@ exit_code_trustable () {
 
 list_tool_variants () {
 	for prefix in '' g n; do
-		for suffix in '' 2 3; do
+		for suffix in '' 1 2 3; do
 			echo "${prefix}vimdiff${suffix}"
 		done
 	done
-- 
2.29.2


