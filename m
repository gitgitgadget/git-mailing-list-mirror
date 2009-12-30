From: Jeff King <peff@peff.net>
Subject: [PATCH] reset: unbreak hard resets with GIT_WORK_TREE
Date: Wed, 30 Dec 2009 03:47:03 -0500
Message-ID: <20091230084702.GA19649@coredump.intra.peff.net>
References: <1a04eebf0912282247p6975a96el8076cb39378bd104@mail.gmail.com>
 <fcaeb9bf0912290038u77a5e83cqe2f3cbfab05af263@mail.gmail.com>
 <20091229200426.6117@nanako3.lavabit.com>
 <fcaeb9bf0912290336m69303c3es8138c4e6497b801a@mail.gmail.com>
 <1a04eebf0912291309u7a222d9ch7e0926d30a5899b7@mail.gmail.com>
 <20091229215015.GA1529@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Fyn Fynn <fynfynn@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 09:48:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPuEN-0003g6-6z
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 09:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbZL3IrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 03:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbZL3IrI
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 03:47:08 -0500
Received: from peff.net ([208.65.91.99]:42350 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751847AbZL3IrH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 03:47:07 -0500
Received: (qmail 4440 invoked by uid 107); 30 Dec 2009 08:51:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 30 Dec 2009 03:51:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Dec 2009 03:47:03 -0500
Content-Disposition: inline
In-Reply-To: <20091229215015.GA1529@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135873>

Commit 952dfc6 tried to tighten the safety valves for doing
a "reset --hard" in a bare repository or outside the work
tree, but accidentally broke the case for GIT_WORK_TREE.
This patch unbreaks it.

Most git commands which need a work tree simply use
NEED_WORK_TREE in git.c to die before they get to their
cmd_* function. Reset, however, only needs a work tree in
some cases, and so must handle the work tree itself. The
error that 952dfc6 made was to simply forbid certain
operations if the work tree was not set up; instead, we need
to do the same thing that NEED_WORK_TREE does, which is to
call setup_work_tree(). We no longer have to worry about dying
in the non-worktree case, as setup_work_tree handles that
for us.

Signed-off-by: Jeff King <peff@peff.net>
---
Junio, this should probably go onto maint. I based it directly on
952dfc6, which is in v1.6.6 and v1.6.5.5.

 builtin-reset.c       |    6 ++----
 t/t7103-reset-bare.sh |    6 ++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index 11d1c6e..e4418bc 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -286,10 +286,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (reset_type == NONE)
 		reset_type = MIXED; /* by default */
 
-	if ((reset_type == HARD || reset_type == MERGE)
-	    && !is_inside_work_tree())
-		die("%s reset requires a work tree",
-		    reset_type_names[reset_type]);
+	if (reset_type == HARD || reset_type == MERGE)
+		setup_work_tree();
 
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
diff --git a/t/t7103-reset-bare.sh b/t/t7103-reset-bare.sh
index 68041df..afb55b3 100755
--- a/t/t7103-reset-bare.sh
+++ b/t/t7103-reset-bare.sh
@@ -29,6 +29,12 @@ test_expect_success 'soft reset is ok' '
 	(cd .git && git reset --soft)
 '
 
+test_expect_success 'hard reset works with GIT_WORK_TREE' '
+	mkdir worktree &&
+	GIT_WORK_TREE=$PWD/worktree GIT_DIR=$PWD/.git git reset --hard &&
+	test_cmp file worktree/file
+'
+
 test_expect_success 'setup bare' '
 	git clone --bare . bare.git &&
 	cd bare.git
-- 
1.6.6.320.g7c9b3
