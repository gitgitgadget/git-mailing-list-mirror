Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D6B120D11
	for <e@80x24.org>; Mon, 30 Jan 2017 20:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932417AbdA3Up1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 15:45:27 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:23944 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932383AbdA3UpT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 15:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1485809111;
        l=2590; s=domk; d=benjaminfuchs.de;
        h=References:In-Reply-To:Date:Subject:Cc:To:From;
        bh=cWfpv4Z96dAUbmgdA5KEcGTHxBEMWO48SB+ax0NW2ag=;
        b=aEiBkmAtYVc0H02yYeWn0hHVmvRh5O3YBn/ZS/9WEVmImz8OqAZo87BFx+FtFG/hgH
        s/ytLpSM/tFUyXhkXdLDD1C7ApaU0qIORCLf6mAAvHQlPax4nZaNvX4GUtMPJlXih7DM
        PWmroiIDZId69mcBi/zm7pmOfaNzLxmPNcRbQ=
X-RZG-AUTH: :KWEFfEyIefqISxrQo86CUgBQlWGSsNRH+R9D//SwlcQsxFnnwAcCdlhhPcjKRjsJ00UGWq4=
X-RZG-CLASS-ID: mo00
Received: from fuchs-ThinkPad-T431s.poststrasse57.local (p5499AE19.dip0.t-ipconnect.de [84.153.174.25])
        by smtp.strato.de (RZmta 39.11 DYNA|AUTH)
        with ESMTPSA id x0accft0UKiZLRS
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 30 Jan 2017 21:44:35 +0100 (CET)
From:   Benjamin Fuchs <email@benjaminfuchs.de>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, sbeller@google.com,
        sandals@crustytoothpaste.net, ville.skytta@iki.fi,
        Benjamin Fuchs <email@benjaminfuchs.de>
Subject: [PATCH 1/4] git-prompt.sh: add submodule indicator
Date:   Mon, 30 Jan 2017 21:44:22 +0100
Message-Id: <1485809065-11978-2-git-send-email-email@benjaminfuchs.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1485809065-11978-1-git-send-email-email@benjaminfuchs.de>
References: <1485809065-11978-1-git-send-email-email@benjaminfuchs.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I expirienced that working with submodules can be confusing. This indicator
will make you notice very easy when you switch into a submodule.
The new prompt will look like this: (sub:master)
Adding a new optional env variable for the new feature.

Signed-off-by: Benjamin Fuchs <email@benjaminfuchs.de>
---
 contrib/completion/git-prompt.sh | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 97eacd7..4c82e7f 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -93,6 +93,10 @@
 # directory is set up to be ignored by git, then set
 # GIT_PS1_HIDE_IF_PWD_IGNORED to a nonempty value. Override this on the
 # repository level by setting bash.hideIfPwdIgnored to "false".
+#
+# If you would like __git_ps1 to indicate that you are in a submodule,
+# set GIT_PS1_SHOWSUBMODULE. In this case a "sub:" will be added before
+# the branch name.
 
 # check whether printf supports -v
 __git_printf_supports_v=
@@ -284,6 +288,32 @@ __git_eread ()
 	test -r "$f" && read "$@" <"$f"
 }
 
+# __git_is_submodule
+# Based on:
+# http://stackoverflow.com/questions/7359204/git-command-line-know-if-in-submodule
+__git_is_submodule ()
+{
+	local git_dir parent_git module_name path
+	# Find the root of this git repo, then check if its parent dir is also a repo
+	git_dir="$(git rev-parse --show-toplevel)"
+	module_name="$(basename "$git_dir")"
+	parent_git="$(cd "$git_dir/.." && git rev-parse --show-toplevel 2> /dev/null)"
+	if [[ -n $parent_git ]]; then
+		# List all the submodule paths for the parent repo
+		while read path
+		do
+			if [[ "$path" != "$module_name" ]]; then continue; fi
+			if [[ -d "$git_dir/../$path" ]];    then return 0; fi
+		done < <(cd $parent_git && git submodule --quiet foreach 'echo $path' 2> /dev/null)
+    fi
+    return 1
+}
+
+__git_ps1_submodule ()
+{
+	__git_is_submodule && printf "sub:"
+}
+
 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
 # when called from PS1 using command substitution
 # in this mode it prints text to add to bash PS1 prompt (includes branch name)
@@ -513,8 +543,13 @@ __git_ps1 ()
 		b="\${__git_ps1_branch_name}"
 	fi
 
+	local sub=""
+	if [ -n "${GIT_PS1_SHOWSUBMODULE}" ]; then
+		sub="$(__git_ps1_submodule)"
+	fi
+
 	local f="$w$i$s$u"
-	local gitstring="$c$b${f:+$z$f}$r$p"
+	local gitstring="$c$sub$b${f:+$z$f}$r$p"
 
 	if [ $pcmode = yes ]; then
 		if [ "${__git_printf_supports_v-}" != yes ]; then
-- 
2.7.4

