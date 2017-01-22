Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 131CD20ABE
	for <e@80x24.org>; Sun, 22 Jan 2017 09:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751245AbdAVJHm (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 04:07:42 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:31391 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbdAVJHk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 04:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1485076058;
        l=3163; s=domk; d=benjaminfuchs.de;
        h=Date:Subject:Cc:To:From;
        bh=ve3I7ErAz5DGQi+G7btzM0lOMTVylU7FPg2d7G5T/Sw=;
        b=adktB8MnNks20HLgzWI8AvjNkE9v7SQuDRUgbKYJ+5U9H5HoX5vXR4ZycnLV1uxJob
        7hphFp+r4p3yCgyVcAMT03Ri7QASF1AeYvzl+alm2//5aNRU3ZSkc2WPT6A6SkVJTTh6
        h2MlS7PXBpQNWgBLyg6kaAtowqKlVqMCLKVfY=
X-RZG-AUTH: :KWEFfEyIefqISxrQo86CUgBQlWGSsNRH+R9D//SwlcQsxFnnwAcCdlRhOsvXXDgQ3mdiTQ==
X-RZG-CLASS-ID: mo00
Received: from fuchs-ThinkPad-T431s.local (dslb-088-066-042-195.088.066.pools.vodafone-ip.de [88.66.42.195])
        by smtp.strato.de (RZmta 39.11 DYNA|AUTH)
        with ESMTPSA id U06b4ft0M97aX4T
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 22 Jan 2017 10:07:36 +0100 (CET)
From:   Benjamin Fuchs <email@benjaminfuchs.de>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, sbeller@google.com, email@benjaminfuchs.de
Subject: [PATCH 2/2] git-prompt.sh: rework of submodule indicator
Date:   Sun, 22 Jan 2017 10:07:17 +0100
Message-Id: <1485076037-14660-1-git-send-email-email@benjaminfuchs.de>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rework of the first patch. The prompt now will look like this:
(+name:master). I tried to considere all suggestions.
Tests still missing.
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

