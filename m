Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D77C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 21:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F99364EE1
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 21:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhBIVnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 16:43:15 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:35420 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbhBIU7b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 15:59:31 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l9ZIF-00CSnu-3v; Tue, 09 Feb 2021 13:07:27 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l9ZID-001CnS-Er; Tue, 09 Feb 2021 13:07:26 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id 5395D501668;
        Tue,  9 Feb 2021 13:07:25 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aDzTjOK_nn_d; Tue,  9 Feb 2021 13:07:25 -0700 (MST)
Received: from ellen.lan (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id C1C05501666;
        Tue,  9 Feb 2021 13:07:24 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Date:   Tue,  9 Feb 2021 13:07:12 -0700
Message-Id: <20210209200712.156540-4-seth@eseth.com>
X-Mailer: git-send-email 2.30.0.84.g93c9af8b0b
In-Reply-To: <20210209200712.156540-1-seth@eseth.com>
References: <20210130054655.48237-1-seth@eseth.com>
 <20210209200712.156540-1-seth@eseth.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1l9ZID-001CnS-Er;;;mid=<20210209200712.156540-4-seth@eseth.com>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: [PATCH v11 3/3] mergetool: add per-tool support and overrides for the hideResolved flag
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a per-tool override flag so that users may enable the flag for one
tool and disable it for another by setting
`mergetool.<tool>.hideResolved` to `false`.

In addition, the author or maintainer of a mergetool may optionally
override the default `hideResolved` value for that mergetool. If the
`mergetools/<tool>` shell script contains a `hide_resolved_enabled`
function it will be called when the mergetool is invoked and the return
value will be used as the default for the `hideResolved` flag.

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
 Documentation/config/mergetool.txt |  5 +++++
 git-mergetool--lib.sh              |  4 ++++
 git-mergetool.sh                   | 36 +++++++++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index b858191970..90f76f5b9b 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -13,6 +13,11 @@ mergetool.<tool>.cmd::
 	merged; 'MERGED' contains the name of the file to which the merge
 	tool should write the results of a successful merge.
 
+mergetool.<tool>.hideResolved::
+	Allows the user to override the global `mergetool.hideResolved` value
+	for a specific tool. See `mergetool.hideResolved` for the full
+	description.
+
 mergetool.<tool>.trustExitCode::
 	For a custom merge command, specify whether the exit code of
 	the merge command can be used to determine whether the merge was
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 4a8e36c792..542a6a75eb 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -166,6 +166,10 @@ setup_tool () {
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
index e5eac935f3..911470a5b2 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -333,7 +333,41 @@ merge_file () {
 	checkout_staged_file 2 "$MERGED" "$LOCAL"
 	checkout_staged_file 3 "$MERGED" "$REMOTE"
 
-	if test "$(git config --type=bool mergetool.hideResolved)" != "false"
+	# hideResolved preferences hierarchy.
+	global_config="mergetool.hideResolved"
+	tool_config="mergetool.${merge_tool}.hideResolved"
+
+	if enabled=$(git config --type=bool "$tool_config")
+	then
+		# The user has a specific preference for a specific tool and no
+		# other preferences should override that.
+		: ;
+	elif enabled=$(git config --type=bool "$global_config")
+	then
+		# The user has a general preference for all tools.
+		#
+		# 'true' means the user likes the feature so we should use it
+		# where possible but tool authors can still override.
+		#
+		# 'false' means the user doesn't like the feature so we should
+		# not use it anywhere.
+		if test "$enabled" = true && hide_resolved_enabled
+		then
+		    enabled=true
+		else
+		    enabled=false
+		fi
+	else
+		# The user does not have a preference. Ask the tool.
+		if hide_resolved_enabled
+		then
+		    enabled=true
+		else
+		    enabled=false
+		fi
+	fi
+
+	if test "$enabled" = true
 	then
 		hide_resolved
 	fi
-- 
2.29.2


