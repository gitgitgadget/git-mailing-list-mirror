From: Jeff King <peff@peff.net>
Subject: [PATCH] git-push: documentation and tests for pushing only branches
Date: Tue, 18 Sep 2007 04:15:34 -0400
Message-ID: <20070918081534.GA9824@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 10:15:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXYFO-0006N6-55
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 10:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbXIRIPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 04:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbXIRIPl
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 04:15:41 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1188 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913AbXIRIPk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 04:15:40 -0400
Received: (qmail 25788 invoked by uid 111); 18 Sep 2007 08:15:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 18 Sep 2007 04:15:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Sep 2007 04:15:34 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58542>

Commit 098e711e caused git-push to match only branches when
considering which refs to push. This patch updates the
documentation accordingly and adds a test for this behavior.

Signed-off-by: Jeff King <peff@peff.net>
---

We had discussed this behavior in April, and I worked up an
implementation and test then. We ended up not using it, but your later
commit introduced the same behavior. So here are the supplementary
changes from my original, which still apply (I have verified that the
test goes from failure to success with 098e711e).

 Documentation/git-push.txt      |    4 ++--
 Documentation/git-send-pack.txt |    4 ++--
 t/t5400-send-pack.sh            |   10 ++++++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 7b8e075..6bc559d 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -48,7 +48,7 @@ even if it does not result in a fast forward update.
 Note: If no explicit refspec is found, (that is neither
 on the command line nor in any Push line of the
 corresponding remotes file---see below), then all the
-refs that exist both on the local side and on the remote
+heads that exist both on the local side and on the remote
 side are updated.
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
@@ -61,7 +61,7 @@ the remote repository.
 
 \--all::
 	Instead of naming each ref to push, specifies that all
-	refs be pushed.
+	refs under `$GIT_DIR/refs/heads/` be pushed.
 
 \--tags::
 	All refs under `$GIT_DIR/refs/tags` are pushed, in
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 205bfd2..3271e88 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -32,7 +32,7 @@ OPTIONS
 
 \--all::
 	Instead of explicitly specifying which refs to update,
-	update all refs that locally exist.
+	update all heads that locally exist.
 
 \--force::
 	Usually, the command refuses to update a remote ref that
@@ -70,7 +70,7 @@ With '--all' flag, all refs that exist locally are transferred to
 the remote side.  You cannot specify any '<ref>' if you use
 this flag.
 
-Without '--all' and without any '<ref>', the refs that exist
+Without '--all' and without any '<ref>', the heads that exist
 both on the local side and on the remote side are updated.
 
 When one or more '<ref>' are specified explicitly, it can be either a
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 6c8767e..57c6397 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -113,4 +113,14 @@ test_expect_success \
 	! git diff .git/refs/heads/master victim/.git/refs/heads/master
 '
 
+test_expect_success \
+	'pushing does not include non-head refs' '
+	mkdir parent && cd parent &&
+	git-init && touch file && git-add file && git-commit -m add &&
+	cd .. &&
+	git-clone parent child && cd child && git-push --all &&
+	cd ../parent &&
+	git-branch -a >branches && ! grep -q origin/master branches
+'
+
 test_done
-- 
1.5.3.1.986.g4c9eb
