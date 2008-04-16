From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 0/7] submodule: fallback to .gitmodules and multiple level module definition
Date: Wed, 16 Apr 2008 22:19:30 +0800
Message-ID: <1208355577-8734-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 16:30:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm8VL-00050Q-Nv
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 16:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966AbYDPOUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 10:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754858AbYDPOTp
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 10:19:45 -0400
Received: from mail.qikoo.org ([60.28.205.235]:52417 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752101AbYDPOTm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 10:19:42 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id A9FB6470AE; Wed, 16 Apr 2008 22:19:37 +0800 (CST)
X-Mailer: git-send-email 1.5.5.70.gd68a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79702>

This is a resend of the RFC patches some days ago, with only minor
code modification and log refinement. Also swap the order of the last
two patches.

Since there is less feedback these days, i don't know much what you
guys think of this patch series. However, i have use this series for a
long time and think personally it is useful when having many submodules. 

So i resend it, and look forward to its acceptance.

This patch series has following functional improvements for submodule

 - Fall back on .gitmodules if info not found in $GIT_DIR/config
 - multi-level module definition
 - Don't die when subcommand fails for one module

 Actually, they seems three independent improvements. But the first two
 improvements are both dependent on the first two refactoring patches
 and the 3rd improvement is dependent on the implementation of the
 first two improvements. So i have to send them in batch.

Patches 1,2,4 is mainly code refactor but the second one also
has some semantic change.

The other patches do the real functional changes.

Ping Yin (7):
      git-submodule: Extract functions module_info and module_url
      git-submodule: Extract absolute_url & move absolute url logic to module_clone
      git-submodule: Fall back on .gitmodules if info not found in $GIT_DIR/config
      git-submodule: Extract module_add from cmd_add
      git-submodule: multi-level module definition
      git-submodule: "update --force" to enforce cloning non-submodule
      git-submodule: Don't die when command fails for one submodule

 git-submodule.sh           |  325 ++++++++++++++++++++++++++++++++------------
 t/t7400-submodule-basic.sh |   31 ++++-
 2 files changed, 266 insertions(+), 90 deletions(-)


Following is the diff with former RFC patch series

diff --git a/git-submodule.sh b/git-submodule.sh
index 8bea97a..0ecc4ff 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -354,7 +354,7 @@ cmd_init()
 		exit_status=1 &&
 		continue
 		# Skip already registered paths
-		git config submodule.$name.url && continue
+		test -z "$(git config submodule.$name.url)" || continue
 
 		url=$(absolute_url "$url")
 		git config submodule."$name".url "$url" ||
@@ -442,7 +442,6 @@ cmd_update()
 			}
 		fi
 
-
 		if test "$subsha1" != "$sha1"
 		then
 			(unset GIT_DIR; cd "$path" && git-fetch &&
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index d9b48f7..8b35ff8 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -187,7 +187,7 @@ test_expect_success 'status should be "modified" after submodule reset --hard HE
 	git-submodule status | grep "^+$rev2"
 '
 
-test_expect_success 'update should checkout rev1 when fall back' '
+test_expect_success 'update should checkout rev1 with falling back' '
 	git-config --unset submodule.example.url &&
 	GIT_CONFIG=.gitmodules git config submodule.example.url .subrepo &&
 	git-submodule update init &&
