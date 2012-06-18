From: marcnarc@xiplink.com
Subject: [PATCH] Try harder to find a remote when on a detached HEAD or non-tracking branch.
Date: Mon, 18 Jun 2012 13:01:06 -0400
Message-ID: <1340038866-24552-1-git-send-email-marcnarc@xiplink.com>
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 18 19:07:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgfQC-00038m-Ac
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 19:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab2FRRHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 13:07:17 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:9797 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753456Ab2FRRHQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jun 2012 13:07:16 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Jun 2012 13:07:15 EDT
Received: from xiplink.com (rincewind.xiplink.com [192.168.1.166])
	by farnsworth.xiplink.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id q5IH16bp006951;
	Mon, 18 Jun 2012 13:01:06 -0400
X-Mailer: git-send-email 1.7.11.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200145>

From: Marc Branchaud <marcnarc@xiplink.com>

get_default_remote() tries to use the checked-out branch's 'remote' config
value to figure out the remote's name.  This fails if there is no currently
checked-out branch (i.e. HEAD is detached) or if the checked-out branch
doesn't track a remote.  In these cases and the function would just fall
back to "origin".

Instead, let's use the first remote listed in the configuration, and fall
back to "origin" only if we don't find any configured remotes.

Prior to this change, git would fail to initialize a relative-path
submodule if the super-repo was on a detached HEAD and it had no remote
named "origin".

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

Our build system likes to use detached HEADs, so we got tripped up when we
started using relative submodule URLs.

(I'm not sure about the portability of my change, or if I should wrap it
to 80 columns...)

 git-parse-remote.sh        |  1 +
 t/t7400-submodule-basic.sh | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 484b2e6..225ad94 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -8,6 +8,7 @@ get_default_remote () {
 	curr_branch=$(git symbolic-ref -q HEAD)
 	curr_branch="${curr_branch#refs/heads/}"
 	origin=$(git config --get "branch.$curr_branch.remote")
+	test -z "$origin" && origin=$(git config --list | grep '^remote\.' | head -1 | awk -F . '{print $2}')
 	echo ${origin:-origin}
 }
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 81827e6..8f1ff4f 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -507,6 +507,28 @@ test_expect_success 'relative path works with user@host:path' '
 	)
 '
 
+test_expect_success 'relative path works on detached HEAD and remote is not named "origin"' '
+	mkdir detachtest &&
+	(
+		cd detachtest &&
+		git init &&
+		mkdir sub &&
+		(
+			cd sub &&
+			git init &&
+			test_commit foo
+		) &&
+		git add sub &&
+		git commit -m "added sub" &&
+		git checkout HEAD@{0} &&
+		git config -f .gitmodules submodule.sub.path sub &&
+		git config -f .gitmodules submodule.sub.url ../subrepo &&
+		git remote add awkward ssh://awkward/repo &&
+		git submodule init sub &&
+		test "$(git config submodule.sub.url)" = ssh://awkward/subrepo
+	)
+'
+
 test_expect_success 'moving the superproject does not break submodules' '
 	(
 		cd addtest &&
-- 
1.7.11.dirty
