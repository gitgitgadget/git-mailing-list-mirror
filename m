Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0035EC433DB
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 05:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9ED364E0C
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 05:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhA3Ftj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 00:49:39 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:53820 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbhA3Fso (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 00:48:44 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l5j6k-00D8hf-Cl; Fri, 29 Jan 2021 22:47:42 -0700
Received: from mta5.zcs.xmission.com ([166.70.13.69])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l5j6i-003C4G-6x; Fri, 29 Jan 2021 22:47:41 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta5.zcs.xmission.com (Postfix) with ESMTP id 1293D1280DB7;
        Fri, 29 Jan 2021 22:47:40 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta5.zcs.xmission.com
Received: from mta5.zcs.xmission.com ([127.0.0.1])
        by localhost (mta5.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zIH4E0KUSeTh; Fri, 29 Jan 2021 22:47:40 -0700 (MST)
Received: from localhost.localdomain (unknown [139.60.10.209])
        by mta5.zcs.xmission.com (Postfix) with ESMTPSA id 02E8F1280E00;
        Fri, 29 Jan 2021 22:47:36 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Date:   Fri, 29 Jan 2021 22:46:55 -0700
Message-Id: <20210130054655.48237-4-seth@eseth.com>
X-Mailer: git-send-email 2.30.0.84.g93c9af8b0b
In-Reply-To: <20210130054655.48237-1-seth@eseth.com>
References: <20201228192919.1195211-1-seth@eseth.com>
 <20210130054655.48237-1-seth@eseth.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1l5j6i-003C4G-6x;;;mid=<20210130054655.48237-4-seth@eseth.com>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.69;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.69
X-SA-Exim-Mail-From: seth@eseth.com
Subject: [PATCH v10 3/3] mergetool: add per-tool support and overrides for the hideResolved flag
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep the global mergetool flag and add a per-tool override flag so that
users may enable the flag for one tool and disable it for another. In
addition, the author or maintainer of a mergetool may optionally elect
to set the default `hideResolved` value for that mergetool.

To disable the feature for a specific tool, edit the `mergetools/<tool>`
shell script for that tool and add a `hide_resolved_enabled` function:

    hide_resolved_enabled () {
        return 1
    }

Disabling may be desirable if the mergetool wants or needs access to the
original, unmodified 'LOCAL' and 'REMOTE' versions of the conflicted
file. For example:

- A tool may use a custom conflict resolution algorithm and prefer to
  ignore the results of Git's conflict resolution.
- A tool may want to visually compare/constrast the version of the file
  from before the merge (saved to 'LOCAL', 'REMOTE', and 'BASE') with
  Git's conflict resolution results (saved to 'MERGED').

Helped-by: Johannes Sixt <j6t@kdbg.org>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Seth House <seth@eseth.com>
---
 Documentation/config/mergetool.txt |  6 ++++++
 git-mergetool--lib.sh              |  4 ++++
 git-mergetool.sh                   | 14 ++++++++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 3171bacf91..046816fb07 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -13,6 +13,12 @@ mergetool.<tool>.cmd::
 	merged; 'MERGED' contains the name of the file to which the merge
 	tool should write the results of a successful merge.
 
+mergetool.<tool>.hideResolved::
+	A mergetool-specific override for the global `mergetool.hideResolved`
+	configuration flag. This allows individual mergetools to enable or
+	disable the flag regardless of the global setting. See
+	`mergetool.hideResolved` for the full description.
+
 mergetool.<tool>.trustExitCode::
 	For a custom merge command, specify whether the exit code of
 	the merge command can be used to determine whether the merge was
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index e059b3559e..11f00dde41 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -164,6 +164,10 @@ setup_tool () {
 		return 1
 	}
 
+	hide_resolved_enabled () {
+		return 0
+	}
+
 	translate_merge_tool_path () {
 		echo "$1"
 	}
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 865f12551a..6cf3884277 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -333,9 +333,19 @@ merge_file () {
 	checkout_staged_file 2 "$MERGED" "$LOCAL"
 	checkout_staged_file 3 "$MERGED" "$REMOTE"
 
-	if test "$(git config --get mergetool.hideResolved)" != "false"
+	# hideResolved preferences hierarchy:
+	# First respect user's tool-specific configuration if exists.
+	if test "$(git config --get "mergetool.$merge_tool.hideResolved")" != "false"
 	then
-		hide_resolved
+		# Next respect tool-specified configuration.
+		if hide_resolved_enabled
+		then
+			# Finally respect if user has a global disable.
+			if test "$(git config --get "mergetool.hideResolved")" != "false"
+			then
+				hide_resolved
+			fi
+		fi
 	fi
 
 	if test -z "$local_mode" || test -z "$remote_mode"
-- 
2.29.2


