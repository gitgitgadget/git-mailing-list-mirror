Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEB7C433E9
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 20:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8564F64E6C
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 20:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhBIUwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 15:52:12 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:59130 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbhBIUj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 15:39:27 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l9ZID-00CSnn-Rk
        for git@vger.kernel.org; Tue, 09 Feb 2021 13:07:26 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l9ZIC-001CnH-VH
        for git@vger.kernel.org; Tue, 09 Feb 2021 13:07:25 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id B22A8500269;
        Tue,  9 Feb 2021 13:07:24 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uZqMfzbALy7Q; Tue,  9 Feb 2021 13:07:24 -0700 (MST)
Received: from ellen.lan (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id 622085016A9;
        Tue,  9 Feb 2021 13:07:24 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>
Date:   Tue,  9 Feb 2021 13:07:11 -0700
Message-Id: <20210209200712.156540-3-seth@eseth.com>
X-Mailer: git-send-email 2.30.0.84.g93c9af8b0b
In-Reply-To: <20210209200712.156540-1-seth@eseth.com>
References: <20210130054655.48237-1-seth@eseth.com>
 <20210209200712.156540-1-seth@eseth.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1l9ZIC-001CnH-VH;;;mid=<20210209200712.156540-3-seth@eseth.com>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: [PATCH v11 2/3] mergetool: break setup_tool out into separate initialization function
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is preparation for the following commit where we need to source the
mergetool shell script to look for overrides before `run_merge_tool` is
called. Previously `run_merge_tool` both sourced that script and invoked
the mergetool.

In the case of the following commit, we need the result of the
`hide_resolved` override, if present, before we actually run
`run_merge_tool`.

The new `initialize_merge_tool` wrapper is exposed and documented as
a public interface for consistency with the existing `run_merge_tool`
which is also public. Although `setup_tool` could instead be exposed
directly, the related `setup_user_tool` would probably also want to be
elevated to match and this felt the cleanest to me.

Signed-off-by: Seth House <seth@eseth.com>
---
 Documentation/git-mergetool--lib.txt | 4 ++++
 git-difftool--helper.sh              | 6 ++++++
 git-mergetool--lib.sh                | 7 ++++---
 git-mergetool.sh                     | 2 ++
 4 files changed, 16 insertions(+), 3 deletions(-)

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
index 46af3e60b7..992124cc67 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -61,6 +61,9 @@ launch_merge_tool () {
 		export BASE
 		eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
 	else
+		initialize_merge_tool "$merge_tool"
+		# ignore the error from the above --- run_merge_tool
+		# will diagnose unusable tool by itself
 		run_merge_tool "$merge_tool"
 	fi
 }
@@ -79,6 +82,9 @@ if test -n "$GIT_DIFFTOOL_DIRDIFF"
 then
 	LOCAL="$1"
 	REMOTE="$2"
+	initialize_merge_tool "$merge_tool"
+	# ignore the error from the above --- run_merge_tool
+	# will diagnose unusable tool by itself
 	run_merge_tool "$merge_tool" false
 else
 	# Launch the merge tool on each path provided by 'git diff'
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 78f3647ed9..4a8e36c792 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -250,6 +250,10 @@ trust_exit_code () {
 	fi
 }
 
+initialize_merge_tool () {
+	# Bring tool-specific functions into scope
+	setup_tool "$1" || return 1
+}
 
 # Entry point for running tools
 run_merge_tool () {
@@ -261,9 +265,6 @@ run_merge_tool () {
 	merge_tool_path=$(get_merge_tool_path "$1") || exit
 	base_present="$2"
 
-	# Bring tool-specific functions into scope
-	setup_tool "$1" || return 1
-
 	if merge_mode
 	then
 		run_merge_cmd "$1"
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 40a103443d..e5eac935f3 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -272,6 +272,8 @@ merge_file () {
 		ext=
 	esac
 
+	initialize_merge_tool "$merge_tool" || return
+
 	mergetool_tmpdir_init
 
 	if test "$MERGETOOL_TMPDIR" != "."
-- 
2.29.2


