From: marcnarc@xiplink.com
Subject: [PATCH 4/6] Teach clone to set remote.default.
Date: Wed, 11 Jul 2012 11:33:59 -0400
Message-ID: <1342020841-24368-5-git-send-email-marcnarc@xiplink.com>
References: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com, Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 17:34:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Soyvt-0005vj-TN
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 17:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758144Ab2GKPeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 11:34:19 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:62532 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758139Ab2GKPeQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jul 2012 11:34:16 -0400
Received: from xiplink.com (rincewind.xiplink.com [192.168.1.166])
	by farnsworth.xiplink.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id q6BFY4Ud029776;
	Wed, 11 Jul 2012 11:34:06 -0400
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201307>

From: Marc Branchaud <marcnarc@xiplink.com>

This makes git-clone consistent with the remote.default support implemented in
git-remote.  Specifically, since "git remote add" sets remote.default if
it's adding the first remote to the repository, when clone itself adds the
first remote it should do the same.

This also makes "git clone -o" work without a special case in the code (so
"git clone /some/repo" and "git clone -o origin /some/repo" produce the same
result).

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 builtin/clone.c          |  2 ++
 t/t5601-clone.sh         | 10 ++++++++++
 t/t5702-clone-options.sh |  7 +++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a4d8d25..b198456 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -770,6 +770,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
 
+	git_config_set("remote.default", option_origin);
+
 	if (option_reference.nr)
 		setup_reference();
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 67869b4..046610d 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -57,6 +57,16 @@ test_expect_success 'clone checks out files' '
 
 '
 
+test_expect_success 'clone sets remote.default' '
+
+	rm -fr dst &&
+	git clone src dst &&
+	(
+		cd dst &&
+		test "$(git config --get remote.default)" = origin
+	)
+'
+
 test_expect_success 'clone respects GIT_WORK_TREE' '
 
 	GIT_WORK_TREE=worktree git clone src bare &&
diff --git a/t/t5702-clone-options.sh b/t/t5702-clone-options.sh
index 02cb024..9e573dd 100755
--- a/t/t5702-clone-options.sh
+++ b/t/t5702-clone-options.sh
@@ -15,8 +15,11 @@ test_expect_success 'setup' '
 test_expect_success 'clone -o' '
 
 	git clone -o foo parent clone-o &&
-	(cd clone-o && git rev-parse --verify refs/remotes/foo/master)
-
+	(
+		cd clone-o &&
+		git rev-parse --verify refs/remotes/foo/master &&
+		test "$(git config --get remote.default)" = foo
+	)
 '
 
 test_expect_success 'redirected clone' '
-- 
1.7.11.1
