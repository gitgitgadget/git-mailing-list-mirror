Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017CEC433DB
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 04:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA70A22AB0
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 04:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgL1Ezq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 23:55:46 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:56000 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgL1Ezq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 23:55:46 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktkYi-008i59-SI
        for git@vger.kernel.org; Sun, 27 Dec 2020 21:55:04 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktkYi-00GtzU-2T
        for git@vger.kernel.org; Sun, 27 Dec 2020 21:55:04 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id 9814C500550;
        Sun, 27 Dec 2020 21:55:03 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pQh3STKm-mec; Sun, 27 Dec 2020 21:55:03 -0700 (MST)
Received: from localhost.localdomain (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id 711C25004F7;
        Sun, 27 Dec 2020 21:55:02 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>
Date:   Sun, 27 Dec 2020 21:54:26 -0700
Message-Id: <20201228045427.1166911-4-seth@eseth.com>
X-Mailer: git-send-email 2.30.0.rc2.4.g8f3eabcc0e
In-Reply-To: <20201228045427.1166911-1-seth@eseth.com>
References: <20201228004152.522421-1-seth@eseth.com>
 <20201228045427.1166911-1-seth@eseth.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1ktkYi-00GtzU-2T;;;mid=<20201228045427.1166911-4-seth@eseth.com>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: [PATCH v8 3/4] mergetool: Break setup_tool out into separate initialization function
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tool-specific functions are sometimes needed in scope earlier than
when run_merge_tool is called.

Signed-off-by: Seth House <seth@eseth.com>
---
 Documentation/git-mergetool--lib.txt | 4 ++++
 git-difftool--helper.sh              | 2 ++
 git-mergetool--lib.sh                | 7 ++++---
 git-mergetool.sh                     | 2 ++
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
index 4da9d24096..3e8f59ac0e 100644
--- a/Documentation/git-mergetool--lib.txt
+++ b/Documentation/git-mergetool--lib.txt
@@ -38,6 +38,10 @@ get_merge_tool_cmd::
 get_merge_tool_path::
 	returns the custom path for a merge tool.
 
+initialize_merge_tool::
+	bring merge tool specific functions into scope so they can be used or
+	overridden.
+
 run_merge_tool::
 	launches a merge tool given the tool name and a true/false
 	flag to indicate whether a merge base is present.
diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 46af3e60b7..c47a6d4253 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -61,6 +61,7 @@ launch_merge_tool () {
 		export BASE
 		eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
 	else
+		initialize_merge_tool "$merge_tool"
 		run_merge_tool "$merge_tool"
 	fi
 }
@@ -79,6 +80,7 @@ if test -n "$GIT_DIFFTOOL_DIRDIFF"
 then
 	LOCAL="$1"
 	REMOTE="$2"
+	initialize_merge_tool "$merge_tool"
 	run_merge_tool "$merge_tool" false
 else
 	# Launch the merge tool on each path provided by 'git diff'
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 7225abd811..e059b3559e 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -248,6 +248,10 @@ trust_exit_code () {
 	fi
 }
 
+initialize_merge_tool () {
+	# Bring tool-specific functions into scope
+	setup_tool "$1" || return 1
+}
 
 # Entry point for running tools
 run_merge_tool () {
@@ -259,9 +263,6 @@ run_merge_tool () {
 	merge_tool_path=$(get_merge_tool_path "$1") || exit
 	base_present="$2"
 
-	# Bring tool-specific functions into scope
-	setup_tool "$1" || return 1
-
 	if merge_mode
 	then
 		run_merge_cmd "$1"
diff --git a/git-mergetool.sh b/git-mergetool.sh
index e3c7d78d1d..929192d0f8 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -334,6 +334,8 @@ merge_file () {
 	checkout_staged_file 2 "$MERGED" "$LOCAL"
 	checkout_staged_file 3 "$MERGED" "$REMOTE"
 
+	initialize_merge_tool "$merge_tool"
+
 	if test "$(
 		git config --get --bool "mergetool.$merge_tool.automerge" ||
 		git config --get --bool "mergetool.automerge" ||
-- 
2.29.2


