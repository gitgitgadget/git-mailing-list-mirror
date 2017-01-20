Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E53AA20A17
	for <e@80x24.org>; Fri, 20 Jan 2017 00:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753921AbdATAOf (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 19:14:35 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:25436 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753835AbdATAOS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 19:14:18 -0500
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Jan 2017 19:14:17 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1484871233;
        l=2590; s=domk; d=benjaminfuchs.de;
        h=Date:Subject:Cc:To:From;
        bh=cWfpv4Z96dAUbmgdA5KEcGTHxBEMWO48SB+ax0NW2ag=;
        b=i5lV+vfyVn0suadijuFdjPNvjV0QZzPEPw3UspskrWitJb8uQDYWovY7/WIq9V6toH
        Tj5im7cy9nkXPefN0wAww2vSm4S6pA6qA/Q9jTshcCWY+iTcDjlX1dReiOveb7SWJbra
        cBZK+1IkuGtrHrcfLXuZpjlTpaZo+2JgHXxU0=
X-RZG-AUTH: :KWEFfEyIefqISxrQo86CUgBQlWGSsNRH+R9D//SwlcQsxFnnwAcCdlhhPcjKRjsIV1Xpb0L2
X-RZG-CLASS-ID: mo00
Received: from fuchs-ThinkPad-T431s.poststrasse57.local (p5499A0B8.dip0.t-ipconnect.de [84.153.160.184])
        by smtp.strato.de (RZmta 39.11 DYNA|AUTH)
        with ESMTPSA id z09533t0K07lFuV
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 20 Jan 2017 01:07:47 +0100 (CET)
From:   Benjamin Fuchs <email@benjaminfuchs.de>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, felipe.contreras@gmail.com,
        ville.skytta@iki.fi, email@benjaminfuchs.de
Subject: [PATCH] git-prompt.sh: add submodule indicator
Date:   Fri, 20 Jan 2017 01:07:38 +0100
Message-Id: <1484870858-6336-1-git-send-email-email@benjaminfuchs.de>
X-Mailer: git-send-email 2.7.4
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

