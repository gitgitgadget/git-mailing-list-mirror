Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21C3C433E2
	for <git@archiver.kernel.org>; Wed, 27 May 2020 11:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B564520888
	for <git@archiver.kernel.org>; Wed, 27 May 2020 11:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgE0Lik (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 07:38:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:3343 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730090AbgE0Lii (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 07:38:38 -0400
IronPort-SDR: yIos0zB07lzMf0/gb4BFAfZgYWkYMK6khOtfH81wiAbyXk9rcOhEs4z3O2RHuh0qQ0tNCRUIpC
 NM1UwI+tWUeA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 04:38:34 -0700
IronPort-SDR: vV6MX35L64bu4BoJB6ExKphY148NFhMYgasD3yLvrvAnDPgwoNAej6+wQCWxcGAUuncIGabhGl
 QII/yMJ07mLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="scan'208";a="302431797"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga008.jf.intel.com with ESMTP; 27 May 2020 04:38:34 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/9] completion: extract function __git_dwim_remote_heads
Date:   Wed, 27 May 2020 04:38:25 -0700
Message-Id: <20200527113831.3294409-4-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200527113831.3294409-1-jacob.e.keller@intel.com>
References: <20200527113831.3294409-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

__git_refs() has the ability to report unique remote names for
supporting completion of remote branch names for the DWIMery of git
checkout and git switch.

For git checkout, this is fine, because it always supports completing
all local references.

However, git switch by default only supports either switching branches
or using this DWIMery to create a local branch tracking the remote
branch.

Future work to cleanup and improve completion support for git switch
will be aided if the remote branch names can be completed separately
from __git_refs.

Extract this logic to a function __git_dwim_remote_heads(), and use it
in __git_refs.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 28 +++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ed966f5e2991..8854812cb32e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -621,6 +621,26 @@ __git_tags ()
 			"refs/tags/$cur_*" "refs/tags/$cur_*/**"
 }
 
+# List unique branches from refs/remotes used for 'git checkout' and 'git
+# switch' tracking DWIMery.
+# 1: A prefix to be added to each listed branch (optional)
+# 2: List only branches matching this word (optional; list all branches if
+#    unset or empty).
+# 3: A suffix to be appended to each listed branch (optional).
+__git_dwim_remote_heads ()
+{
+	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
+	local fer_pfx="${pfx//\%/%%}" # "escape" for-each-ref format specifiers
+
+	# employ the heuristic used by git checkout and git switch
+	# Try to find a remote branch that cur_es the completion word
+	# but only output if the branch name is unique
+	__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
+		--sort="refname:strip=3" \
+		"refs/remotes/*/$cur_*" "refs/remotes/*/$cur_*/**" | \
+	uniq -u
+}
+
 # Lists refs from the local (by default) or from a remote repository.
 # It accepts 0, 1 or 2 arguments:
 # 1: The remote to list refs from (optional; ignored, if set but empty).
@@ -696,13 +716,7 @@ __git_refs ()
 		__git_dir="$dir" __git for-each-ref --format="$fer_pfx%($format)$sfx" \
 			"${refs[@]}"
 		if [ -n "$track" ]; then
-			# employ the heuristic used by git checkout
-			# Try to find a remote branch that matches the completion word
-			# but only output if the branch name is unique
-			__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
-				--sort="refname:strip=3" \
-				"refs/remotes/*/$match*" "refs/remotes/*/$match*/**" | \
-			uniq -u
+			__git_dwim_remote_heads "$pfx" "$match" "$sfx"
 		fi
 		return
 	fi
-- 
2.25.2

