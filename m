Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DC2F20D11
	for <e@80x24.org>; Mon, 30 Jan 2017 20:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932389AbdA3UpT (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 15:45:19 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:16717 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932374AbdA3UpS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 15:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1485809111;
        l=3221; s=domk; d=benjaminfuchs.de;
        h=References:In-Reply-To:Date:Subject:Cc:To:From;
        bh=VkfwHhlXMC+RQ+lcqkB3/TGviFMSBVmfcp9d228vxLc=;
        b=LuovLcuowBVLo9z4hHiQKTPX/dG2fpGH6hXubDfKrsxg141jJAN0XleX5ZB15AcKgQ
        Weu5UGLPg0tHzLN6nZZP6PaTJNWXY0HEL0B4+0k76eb8288cb8ppXfzCjUgaVyNwatHa
        GTRkvXlIO6iRxiSe849iKHUiuYqDTeuYFtSPo=
X-RZG-AUTH: :KWEFfEyIefqISxrQo86CUgBQlWGSsNRH+R9D//SwlcQsxFnnwAcCdlhhPcjKRjsJ00UGWq4=
X-RZG-CLASS-ID: mo00
Received: from fuchs-ThinkPad-T431s.poststrasse57.local (p5499AE19.dip0.t-ipconnect.de [84.153.174.25])
        by smtp.strato.de (RZmta 39.11 DYNA|AUTH)
        with ESMTPSA id x0accft0UKiZLRT
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 30 Jan 2017 21:44:35 +0100 (CET)
From:   Benjamin Fuchs <email@benjaminfuchs.de>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, sbeller@google.com,
        sandals@crustytoothpaste.net, ville.skytta@iki.fi,
        Benjamin Fuchs <email@benjaminfuchs.de>
Subject: [PATCH 2/4] git-prompt.sh: rework of submodule indicator
Date:   Mon, 30 Jan 2017 21:44:23 +0100
Message-Id: <1485809065-11978-3-git-send-email-email@benjaminfuchs.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1485809065-11978-1-git-send-email-email@benjaminfuchs.de>
References: <1485809065-11978-1-git-send-email-email@benjaminfuchs.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rework of the first patch. The prompt now will look like this:
(+name:master). I tried to considere all suggestions.
Tests still missing.

Signed-off-by: Benjamin Fuchs <email@benjaminfuchs.de>
---
 contrib/completion/git-prompt.sh | 49 ++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 4c82e7f..c44b9a2 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -95,8 +95,10 @@
 # repository level by setting bash.hideIfPwdIgnored to "false".
 #
 # If you would like __git_ps1 to indicate that you are in a submodule,
-# set GIT_PS1_SHOWSUBMODULE. In this case a "sub:" will be added before
-# the branch name.
+# set GIT_PS1_SHOWSUBMODULE to a nonempty value. In this case the name
+# of the submodule will be prepended to the branch name (e.g. module:master).
+# The name will be prepended by "+" if the currently checked out submodule
+# commit does not match the SHA-1 found in the index of the containing repository.
 
 # check whether printf supports -v
 __git_printf_supports_v=
@@ -288,30 +290,27 @@ __git_eread ()
 	test -r "$f" && read "$@" <"$f"
 }
 
-# __git_is_submodule
-# Based on:
-# http://stackoverflow.com/questions/7359204/git-command-line-know-if-in-submodule
-__git_is_submodule ()
-{
-	local git_dir parent_git module_name path
-	# Find the root of this git repo, then check if its parent dir is also a repo
-	git_dir="$(git rev-parse --show-toplevel)"
-	module_name="$(basename "$git_dir")"
-	parent_git="$(cd "$git_dir/.." && git rev-parse --show-toplevel 2> /dev/null)"
-	if [[ -n $parent_git ]]; then
-		# List all the submodule paths for the parent repo
-		while read path
-		do
-			if [[ "$path" != "$module_name" ]]; then continue; fi
-			if [[ -d "$git_dir/../$path" ]];    then return 0; fi
-		done < <(cd $parent_git && git submodule --quiet foreach 'echo $path' 2> /dev/null)
-    fi
-    return 1
-}
-
+# __git_ps1_submodule
+#
+# $1 - git_dir path
+#
+# Returns the name of the submodule if we are currently inside one. The name
+# will be prepended by "+" if the currently checked out submodule commit does
+# not match the SHA-1 found in the index of the containing repository.
+# NOTE: git_dir looks like in a ...
+# - submodule: "GIT_PARENT/.git/modules/PATH_TO_SUBMODULE"
+# - parent: "GIT_PARENT/.git" (exception "." in .git)
 __git_ps1_submodule ()
 {
-	__git_is_submodule && printf "sub:"
+	local git_dir="$1"
+	local submodule_name="$(basename "$git_dir")"
+	if [ "$submodule_name" != ".git" ] && [ "$submodule_name" != "." ]; then
+		local parent_top="${git_dir%.git*}"
+		local submodule_top="${git_dir#*modules}"
+		local status=""
+		git diff -C "$parent_top" --no-ext-diff --ignore-submodules=dirty --quiet -- "$submodule_top" 2>/dev/null || status="+"
+		printf "$status$submodule_name:"
+	fi
 }
 
 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
@@ -545,7 +544,7 @@ __git_ps1 ()
 
 	local sub=""
 	if [ -n "${GIT_PS1_SHOWSUBMODULE}" ]; then
-		sub="$(__git_ps1_submodule)"
+		sub="$(__git_ps1_submodule $g)"
 	fi
 
 	local f="$w$i$s$u"
-- 
2.7.4

