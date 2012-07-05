From: marcnarc@xiplink.com
Subject: [PATCH 6/6] Teach get_default_remote to respect remote.default.
Date: Thu,  5 Jul 2012 18:11:17 -0400
Message-ID: <1341526277-17055-7-git-send-email-marcnarc@xiplink.com>
References: <1341526277-17055-1-git-send-email-marcnarc@xiplink.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com, Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 00:11:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmuGq-00069c-Uw
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 00:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756773Ab2GEWLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 18:11:20 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:26071 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755576Ab2GEWLT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jul 2012 18:11:19 -0400
Received: from xiplink.com (rincewind.xiplink.com [192.168.1.166])
	by farnsworth.xiplink.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id q65MBE0F004223;
	Thu, 5 Jul 2012 18:11:16 -0400
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1341526277-17055-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201064>

From: Marc Branchaud <marcnarc@xiplink.com>

Use "git remote default" instead of replicating its logic.

The unit test checks a relative-path submodule because the submodule code
is (almost) the only thing that uses get_default_remote.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 git-parse-remote.sh        |  5 +----
 t/t7400-submodule-basic.sh | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 484b2e6..49257f0 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -5,10 +5,7 @@
 GIT_DIR=$(git rev-parse -q --git-dir) || :;
 
 get_default_remote () {
-	curr_branch=$(git symbolic-ref -q HEAD)
-	curr_branch="${curr_branch#refs/heads/}"
-	origin=$(git config --get "branch.$curr_branch.remote")
-	echo ${origin:-origin}
+	echo $(git remote default)
 }
 
 get_remote_merge_branch () {
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 81827e6..2ac2ffc 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -507,6 +507,27 @@ test_expect_success 'relative path works with user@host:path' '
 	)
 '
 
+test_expect_success 'realtive path works when superproject on detached HEAD' '
+	(
+		test_create_repo detach &&
+		cd detach &&
+		test_create_repo sub &&
+		(
+			cd sub &&
+			test_commit foo
+		) &&
+		git add sub &&
+		git commit -m "added sub" &&
+		rm -rf sub &&
+		git checkout HEAD@{0} &&
+		git config -f .gitmodules submodule.sub.path sub &&
+		git config -f .gitmodules submodule.sub.url ../subrepo &&
+		git remote add awkward /path/to/awkward
+		git submodule init sub &&
+		test "$(git config submodule.sub.url)" = /path/to/subrepo
+	)
+'
+
 test_expect_success 'moving the superproject does not break submodules' '
 	(
 		cd addtest &&
-- 
1.7.11.1
