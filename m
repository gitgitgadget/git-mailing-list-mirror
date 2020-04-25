Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1411C55191
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 02:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A99D72084D
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 02:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgDYCU6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 22:20:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:47708 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgDYCU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 22:20:57 -0400
IronPort-SDR: NyWrx1L6PbcEguZ4OB2wrkVL42UrGoEEzSWquu6TbvohlGISgeYuvDH20LeFlvi3L128gfFwI0
 JXZtwlwo0NUg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 19:20:54 -0700
IronPort-SDR: Y73v/fy8orDHlGb8A0mgaSeAXG0Dknxv0o7uQefw38XEzJC5m9fnwCseAU80sZW2M/4sSY2+Df
 sIqkwIoNYOjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,314,1583222400"; 
   d="scan'208";a="281056796"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by fmsmga004.fm.intel.com with ESMTP; 24 Apr 2020 19:20:53 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 11/11] completion: complete remote branches for git switch --track
Date:   Fri, 24 Apr 2020 19:20:45 -0700
Message-Id: <20200425022045.1089291-13-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200425022045.1089291-1-jacob.e.keller@intel.com>
References: <20200425022045.1089291-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

git switch --track <remote>/<branch> will be interpreted as a DWIM to
create a local tracking branch named <branch> tracking the specified
remote.

Completion support for this case is buggy, because it will instead
report only local branches.

Fix this by extending __git_complete_refs with a new mode,
"remote-heads" which will list all reference under refs/remotes/*.

By doing this, "git switch --track <TAB>" changes from the rather
useless set of local branches to only listing remote branches.

Note that if the user has specified "-c" or "-C" already on the command
line, this will still enable completing all references, as the check to
use the mode "refs" occurs first in an if-elif chain.

This finally fixes the "git switch --track" test case, so it is updated
accordingly.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 contrib/completion/git-completion.bash | 25 +++++++++++++++++++++++--
 t/t9902-completion.sh                  |  5 +----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f9be0dabb03e..cdd141b2ba1d 100644
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
-#                complete all refs, or 'heads' to complete only branches. Note
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
@@ -2299,8 +2315,13 @@ _git_switch ()
 		# local branches, or DWIM with remote branch names. However,
 		# certain options for creating branches or detaching should
 		# complete all references.
+		#
+		# Additionally, if --track is provided on its own, we should
+		# complete only remote branch names.
 		if [ -n "$(__git_find_on_cmdline "-d --detach -c -C")" ]; then
 			mode="refs"
+		elif [ -n "$(__git_find_on_cmdline "--track")" ]; then
+			mode="remote-heads"
 		fi
 
 		__git_complete_refs $dwim_opt --mode=$mode
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 68296d79a3e9..7491d8c3b72d 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1267,10 +1267,7 @@ test_expect_success 'git switch - with --detach, complete all references' '
 	EOF
 '
 
-# TODO: Since --track on its own will perform a DWIM to extract the local
-# branch name, we should complete only the remote branches with their remote
-# name.
-test_expect_failure 'git switch - with --track, complete only remote branches' '
+test_expect_success 'git switch - with --track, complete only remote branches' '
 	test_completion "git switch --track " <<-\EOF
 	other/branch-in-other Z
 	other/master-in-other Z
-- 
2.25.2

