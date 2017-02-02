Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE0241F9AF
	for <e@80x24.org>; Thu,  2 Feb 2017 22:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbdBBWv4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 17:51:56 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:19888 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751726AbdBBWvy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 17:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1486075911;
        l=5428; s=domk; d=benjaminfuchs.de;
        h=References:In-Reply-To:Date:Subject:Cc:To:From;
        bh=YLwkDIYBMMalsK0LQ288VmY1uRM7vIT5c6Y/qk+rxEA=;
        b=S2ZY+wAKWL5YZlatESt6OXwfLd2nEaotV7mH/HrNZ09NMaT/09Obs/SemFXh3l4Yz9
        FwBN/bJoWn9ppW5tmKDSd6gQT8P4LK/H3S6NcZxBhM/iszvlyyW+swIlEkNdfHTk0kTj
        dvhLXCt07+wGxjxq9ZuJAyXvKh3PrU7wqRTD8=
X-RZG-AUTH: :KWEFfEyIefqISxrQo86CUgBQlWGSsNRH+R9D//SwlcQsxFnnwAcCdlhhPcjKRjsJ10UFW8MI
X-RZG-CLASS-ID: mo00
Received: from fuchs-ThinkPad-T431s.poststrasse57.local (p5499AA8C.dip0.t-ipconnect.de [84.153.170.140])
        by smtp.strato.de (RZmta 39.12 DYNA|AUTH)
        with ESMTPSA id e066aft12Mplau8
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 2 Feb 2017 23:51:47 +0100 (CET)
From:   Benjamin Fuchs <email@benjaminfuchs.de>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, sbeller@google.com, gitster@pobox.com,
        Benjamin Fuchs <email@benjaminfuchs.de>
Subject: [PATCH v2] git-prompt.sh: add submodule indicator
Date:   Thu,  2 Feb 2017 23:51:32 +0100
Message-Id: <1486075892-20676-2-git-send-email-email@benjaminfuchs.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1486075892-20676-1-git-send-email-email@benjaminfuchs.de>
References: <1486075892-20676-1-git-send-email-email@benjaminfuchs.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I expirienced that working with submodules can be confusing. A submodule can be
anywhere in your parent git repository. While walking through the parent
repository it would be good to have a reminder to know when you entered a
submodule.

This new indicator will show if you are in a submodule. The new prompt will look
like this: (sub:master). If the currently checked out submodule commit does not
match the SHA-1 found in the index of the containing repository a "+" will be
prepended (+sub:master). Adding a new optional env variable for the new feature.

Signed-off-by: Benjamin Fuchs <email@benjaminfuchs.de>
---
 contrib/completion/git-prompt.sh | 40 ++++++++++++++++++++++++++-
 t/t9903-bash-prompt.sh           | 59 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 97eacd7..9a0c4af 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -93,6 +93,13 @@
 # directory is set up to be ignored by git, then set
 # GIT_PS1_HIDE_IF_PWD_IGNORED to a nonempty value. Override this on the
 # repository level by setting bash.hideIfPwdIgnored to "false".
+#
+# If you would like __git_ps1 to indicate that you are in a submodule,
+# set GIT_PS1_SHOWSUBMODULE to a nonempty value. In this case the name
+# of the submodule will be prepended to the branch name (e.g. module:master).
+# If you set GIT_PS1_SHOWDIRTYSTATE to a nonempty value, the name will be
+# prepended by "+" if the currently checked out submodule commit does not
+# match the SHA-1 found in the index of the containing repository.
 
 # check whether printf supports -v
 __git_printf_supports_v=
@@ -284,6 +291,32 @@ __git_eread ()
 	test -r "$f" && read "$@" <"$f"
 }
 
+# __git_ps1_submodule
+# Requires the git dir set in $g by the caller.
+# Returns the name of the submodule in $sub if we are currently inside one.
+# The name will be prepended by "+" if the currently checked out submodule commit
+# does not match the SHA-1 found in the index of the containing repository.
+# NOTE: git_dir looks like in a ...
+# - submodule:	"GIT_PARENT/.git/modules/PATH_TO_SUBMODULE"
+# - parent:	"GIT_PARENT/.git" (exception "." in .git)
+__git_ps1_submodule ()
+{
+	local git_dir="$g"
+	local submodule_name="$(basename "$git_dir")"
+	if [ "$submodule_name" != ".git" ] && [ "$submodule_name" != "." ]; then
+		local status=""
+		if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] &&
+		   [ "$(git config --bool bash.showDirtyState)" != "false" ]
+		then
+			local parent_top="${git_dir%.git*}"
+			local submodule_top="${git_dir#*modules/}"
+			git -C "$parent_top" diff --no-ext-diff --ignore-submodules=dirty --quiet -- "$submodule_top" 2>/dev/null || status="+"
+		fi
+
+		sub="$status$submodule_name:"
+	fi
+}
+
 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
 # when called from PS1 using command substitution
 # in this mode it prints text to add to bash PS1 prompt (includes branch name)
@@ -513,8 +546,13 @@ __git_ps1 ()
 		b="\${__git_ps1_branch_name}"
 	fi
 
+	local sub=""
+	if [ -n "${GIT_PS1_SHOWSUBMODULE-}" ]; then
+		__git_ps1_submodule
+	fi
+
 	local f="$w$i$s$u"
-	local gitstring="$c$b${f:+$z$f}$r$p"
+	local gitstring="$c$sub$b${f:+$z$f}$r$p"
 
 	if [ $pcmode = yes ]; then
 		if [ "${__git_printf_supports_v-}" != yes ]; then
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 97c9b32..ac82c99 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -16,9 +16,22 @@ c_lblue='\\[\\e[1;34m\\]'
 c_clear='\\[\\e[0m\\]'
 
 test_expect_success 'setup for prompt tests' '
+	mkdir .subrepo &&
+	(cd .subrepo &&
+		git init &&
+		echo 1 >file &&
+		git add file &&
+		git commit -m initial &&
+		git checkout -b dirty &&
+		echo 2 >file &&
+		git commit -m "dirty branch" file
+	) &&
 	git init otherrepo &&
 	echo 1 >file &&
 	git add file &&
+	git submodule add ./.subrepo sub &&
+	git -C sub checkout master &&
+	git add sub &&
 	test_tick &&
 	git commit -m initial &&
 	git tag -a -m msg1 t1 &&
@@ -755,4 +768,50 @@ test_expect_success 'prompt - hide if pwd ignored - inside gitdir (stderr)' '
 	test_cmp expected "$actual"
 '
 
+test_expect_success 'prompt - submodule indicator' '
+	printf " (sub:master)" >expected &&
+	(
+		cd sub &&
+		GIT_PS1_SHOWSUBMODULE=y &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - submodule indicator - disabled' '
+	printf " (master)" >expected &&
+	(
+		cd sub &&
+		GIT_PS1_SHOWSUBMODULE= &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - submodule indicator - dirty status indicator' '
+	printf " (+sub:dirty)" >expected &&
+	git -C sub checkout dirty &&
+	test_when_finished "git -C sub checkout master" &&
+	(
+		cd sub &&
+		GIT_PS1_SHOWSUBMODULE=y &&
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - submodule indicator - dirty status indicator disabled' '
+	printf " (sub:dirty)" >expected &&
+	git -C sub checkout dirty &&
+	test_when_finished "git -C sub checkout master" &&
+	(
+		cd sub &&
+		GIT_PS1_SHOWSUBMODULE=y &&
+		GIT_PS1_SHOWDIRTYSTATE= &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_done
-- 
2.7.4

