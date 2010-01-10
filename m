From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/4] difftool--helper: Remove use of the GIT_MERGE_TOOL variable
Date: Sat,  9 Jan 2010 20:02:41 -0800
Message-ID: <1263096163-15743-2-git-send-email-davvid@gmail.com>
References: <1263096163-15743-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, markus.heidelberg@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 10 05:03:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTp19-000212-DT
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 05:03:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346Ab0AJEC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 23:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270Ab0AJEC6
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 23:02:58 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:38343 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab0AJEC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 23:02:57 -0500
Received: by gxk3 with SMTP id 3so9589151gxk.1
        for <git@vger.kernel.org>; Sat, 09 Jan 2010 20:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6nTGTcudHX4MzNcC83vLRG7E8hugoIA1A+iqbbeMJm0=;
        b=o7qMvB0Sv0PByfN6L/VMYQHAeD20MBeoNvyFbwfoJO57znS1tFAHE03ia47BeZK5ac
         xd5aZ6WVVvnOhokYFtvRSBiGun3yqpQjs3vcPR6rWU5Cp+ipdVMLiJnuD0x5868dZoY5
         b4r/Zx5NPoA6yxn6AKJnac7GqYuChrEpVZqD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=motfuAh6KtzkubCGsbvAJEJMC6rQo+3/elTJ00RqrPKPWREEdX4uQeb8+PmSWccneh
         3IdJ0GipJCHBA0DLbyix5vfg0Awe3mTHIpXuw00zeVtDnNhp5X7JFLYkEhf4IuaOrbDU
         IXEjvrS1MuJTQKbe8XVkGYMT4O1Eu22yL/59A=
Received: by 10.151.88.10 with SMTP id q10mr47134196ybl.191.1263096176895;
        Sat, 09 Jan 2010 20:02:56 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 36sm9921021yxh.13.2010.01.09.20.02.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Jan 2010 20:02:56 -0800 (PST)
X-Mailer: git-send-email 1.6.6.4.g20a38b.dirty
In-Reply-To: <1263096163-15743-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136552>

An undocumented mis-feature in git-difftool is that it allows you
to specify a default difftool by setting GIT_MERGE_TOOL.
This behavior was never documented and was included as an
oversight back when git-difftool was maintained outside of git.

git-mergetool never honored GIT_MERGE_TOOL so neither should
git-difftool.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool--helper.sh |    9 ++++-----
 t/t7800-difftool.sh     |    9 ---------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 1b13808..3621f28 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -40,11 +40,10 @@ launch_merge_tool () {
 	run_merge_tool "$merge_tool"
 }
 
-# Allow GIT_DIFF_TOOL and GIT_MERGE_TOOL to provide default values
-test -n "$GIT_MERGE_TOOL" && merge_tool="$GIT_MERGE_TOOL"
-test -n "$GIT_DIFF_TOOL" && merge_tool="$GIT_DIFF_TOOL"
-
-if test -z "$merge_tool"; then
+# GIT_DIFF_TOOL indicates that --tool=... was specified
+if test -n "$GIT_DIFF_TOOL"; then
+	merge_tool="$GIT_DIFF_TOOL"
+else
 	merge_tool="$(get_merge_tool)" || exit
 fi
 
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 9bf6c98..eca51a8 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -32,7 +32,6 @@ restore_test_defaults()
 	# Restores the test defaults used by several tests
 	remove_config_vars
 	unset GIT_DIFF_TOOL
-	unset GIT_MERGE_TOOL
 	unset GIT_DIFFTOOL_PROMPT
 	unset GIT_DIFFTOOL_NO_PROMPT
 	git config diff.tool test-tool &&
@@ -107,15 +106,7 @@ test_expect_success 'GIT_DIFF_TOOL overrides' '
 	git config diff.tool bogus-tool &&
 	git config merge.tool bogus-tool &&
 
-	GIT_MERGE_TOOL=test-tool &&
-	export GIT_MERGE_TOOL &&
-	diff=$(git difftool --no-prompt branch) &&
-	test "$diff" = "branch" &&
-	unset GIT_MERGE_TOOL &&
-
-	GIT_MERGE_TOOL=bogus-tool &&
 	GIT_DIFF_TOOL=test-tool &&
-	export GIT_MERGE_TOOL &&
 	export GIT_DIFF_TOOL &&
 
 	diff=$(git difftool --no-prompt branch) &&
-- 
1.6.6.4.g20a38b.dirty
