Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C121C43217
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E9322AEC
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbgL1Wzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:37 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:39074 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729270AbgL1Taj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 14:30:39 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktyDN-00A1eZ-VM; Mon, 28 Dec 2020 12:29:58 -0700
Received: from mta5.zcs.xmission.com ([166.70.13.69])
        by in01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <seth@eseth.com>)
        id 1ktyDN-0002H1-54; Mon, 28 Dec 2020 12:29:57 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta5.zcs.xmission.com (Postfix) with ESMTP id 100BD12802EC;
        Mon, 28 Dec 2020 12:29:57 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta5.zcs.xmission.com
Received: from mta5.zcs.xmission.com ([127.0.0.1])
        by localhost (mta5.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xGBiVSGvrdDC; Mon, 28 Dec 2020 12:29:57 -0700 (MST)
Received: from localhost.localdomain (unknown [139.60.10.209])
        by mta5.zcs.xmission.com (Postfix) with ESMTPSA id 9FB1712806A8;
        Mon, 28 Dec 2020 12:29:56 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>, Junio C Hamano <gitster@pobox.com>
Date:   Mon, 28 Dec 2020 12:29:19 -0700
Message-Id: <20201228192919.1195211-6-seth@eseth.com>
X-Mailer: git-send-email 2.30.0.rc2.4.g8f3eabcc0e
In-Reply-To: <20201228192919.1195211-1-seth@eseth.com>
References: <20201228045427.1166911-1-seth@eseth.com>
 <20201228192919.1195211-1-seth@eseth.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1ktyDN-0002H1-54;;;mid=<20201228192919.1195211-6-seth@eseth.com>;;;hst=in01.mta.xmission.com;;;ip=166.70.13.69;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.69
X-SA-Exim-Mail-From: seth@eseth.com
Subject: [PATCH v9 5/5] mergetool: add automerge_enabled tool-specific override function
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The author or maintainer of a mergetool may optionally elect disable (or
enable) the `autoMerge` feature for that mergetool even if the user has
chosen differently using the `mergetool.autoMerge` and
`mergetool.<tool>.autoMerge` options.

To add a tool-specific override, edit the `mergetools/<tool>` shell
script for that tool and add an `automerge_enabled` function:

    automerge_enabled () {
        return 1
    }

Disabling may be desirable if the mergetool wants or needs access to the
original, unmodified 'LOCAL', 'REMOTE', and 'BASE' versions of the
conflicted file. For example:

- A tool may use a custom conflict resolution algorithm and prefer to
  ignore the results of Git's conflict resolution.
- A tool may want to visually compare/constrast the version of the file
  from before the merge (saved to 'LOCAL', 'REMOTE', and 'BASE') with
  Git's conflict resolution results (saved to 'MERGED').
- A student or researcher working on a new algorithm may want to
  directly compare the result of that algorithm with the result of Git's
  algorithm.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Seth House <seth@eseth.com>
---
 git-mergetool--lib.sh | 4 ++++
 git-mergetool.sh      | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index e059b3559e..567991abbc 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -164,6 +164,10 @@ setup_tool () {
 		return 1
 	}
 
+	automerge_enabled () {
+		return 0
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


