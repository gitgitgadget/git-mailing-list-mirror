Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AEAC433E2
	for <git@archiver.kernel.org>; Wed, 27 May 2020 11:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB12207D3
	for <git@archiver.kernel.org>; Wed, 27 May 2020 11:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgE0Liw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 07:38:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:3342 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730076AbgE0Lif (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 07:38:35 -0400
IronPort-SDR: Zji22/gi/XeoYTyONXQyLG8+ZmJBvEyuqRgf6iDL+O82IksuJavTdNNOckwF321H8BO0fdFbiw
 dHEYu/VHbQCw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 04:38:34 -0700
IronPort-SDR: JMWBlBMNE/tiHTdWo4OkHmBv3cqj6LTqQWgLbWFi6sTvAHvGLJlzFwD0NhbonX8T2zMVO8lnuV
 TD/IubWYjtEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="scan'208";a="302431801"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga008.jf.intel.com with ESMTP; 27 May 2020 04:38:34 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 7/9] completion: improve handling of --track in switch/checkout
Date:   Wed, 27 May 2020 04:38:29 -0700
Message-Id: <20200527113831.3294409-8-jacob.e.keller@intel.com>
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

Current completion for the --track option of git switch and git checkout
is sub par. In addition to the DWIM logic of a bare branch name, --track
has DWIM logic to convert specified remote/branch names into a local
branch tracking that remote. For example

  $git switch --track origin/master

This will create a local branch name master, that tracks the master
branch of the origin remote.

In fact, git switch --track on its own will not accept other forms of
references. These must instead be specified manually via the -c/-C/-b/-B
options.

Introduce __git_remote_heads() and the "remote-heads" mode for
__git_complete_refs. Use this when the --track option is provided while
completing in _git_switch and _git_checkout. Just as in the --detach
case, we never enable DWIM mode for --track, because it doesn't make
sense.

It should be noted that completion support is still a bit sub par when
it comes to handling -c/-C and --orphan. This will be resolved in
a future change.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 contrib/completion/git-completion.bash | 24 +++++++++++++++++--
 t/t9902-completion.sh                  | 32 ++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 38b5a5a0d874..4cdf09987725 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -624,6 +624,19 @@ __git_heads ()
 			"refs/heads/$cur_*" "refs/heads/$cur_*/**"
 }
 
+# Lists branches from remote repositories.
+# 1: A prefix to be added to each listed branch (optional).
+# 2: List only branches matching this word (optional; list all branches if
+#    unset or empty).
+# 3: A suffix to be appended to each listed branch (optional).
+__git_remote_heads ()
+{
+	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
+
+	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
+			"refs/remotes/$cur_*" "refs/remotes/$cur_*/**"
+}
+
 # Lists tags from the local repository.
 # Accepts the same positional parameters as __git_heads() above.
 __git_tags ()
@@ -783,8 +796,9 @@ __git_refs ()
 # --sfx=<suffix>: A suffix to be appended to each ref instead of the default
 #                 space.
 # --mode=<mode>: What set of refs to complete, one of 'refs' (the default) to
-#                complete all refs, 'heads' to complete only branches. Note
-#                that --remote is only compatible with --mode=refs.
+#                complete all refs, 'heads' to complete only branches, or
+#                'remote-heads' to complete only remote branches. Note that
+#                --remote is only compatible with --mode=refs.
 __git_complete_refs ()
 {
 	local remote dwim pfx cur_="$cur" sfx=" " mode="refs"
@@ -810,6 +824,8 @@ __git_complete_refs ()
 			__gitcomp_direct "$(__git_refs "$remote" "" "$pfx" "$cur_" "$sfx")" ;;
 		heads)
 			__gitcomp_direct "$(__git_heads "$pfx" "$cur_" "$sfx")" ;;
+		remote-heads)
+			__gitcomp_direct "$(__git_remote_heads "$pfx" "$cur_" "$sfx")" ;;
 		*)
 			return 1 ;;
 	esac
@@ -1492,6 +1508,8 @@ _git_checkout ()
 
 		if [ -n "$(__git_find_on_cmdline "-d --detach")" ]; then
 			__git_complete_refs --mode="refs"
+		elif [ -n "$(__git_find_on_cmdline "--track")" ]; then
+			__git_complete_refs --mode="remote-heads"
 		else
 			__git_complete_refs $dwim_opt --mode="refs"
 		fi
@@ -2347,6 +2365,8 @@ _git_switch ()
 
 		if [ -n "$(__git_find_on_cmdline "-d --detach")" ]; then
 			__git_complete_refs --mode="refs"
+		elif [ -n "$(__git_find_on_cmdline "--track")" ]; then
+			__git_complete_refs --mode="remote-heads"
 		else
 			__git_complete_refs $dwim_opt --mode="heads"
 		fi
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 5b1868e43632..b09eb498d175 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1404,6 +1404,38 @@ test_expect_success 'git checkout - with -d, complete only references' '
 	EOF
 '
 
+test_expect_success 'git switch - with --track, complete only remote branches' '
+	test_completion "git switch --track " <<-\EOF
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - with --track, complete only remote branches' '
+	test_completion "git checkout --track " <<-\EOF
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git switch - with --no-track, complete only local branch names' '
+	test_completion "git switch --no-track " <<-\EOF
+	master Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git checkout - with --no-track, complete only local references' '
+	test_completion "git checkout --no-track " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
 test_expect_success 'teardown after ref completion' '
 	git branch -d matching-branch &&
 	git tag -d matching-tag &&
-- 
2.25.2

