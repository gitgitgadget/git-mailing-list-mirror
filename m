From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 1/7] reset: do not accept a mixed reset in a .git dir
Date: Sat, 12 Dec 2009 05:32:52 +0100
Message-ID: <20091212043259.3930.98779.chriscool@tuxfamily.org>
References: <20091212042042.3930.54783.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 05:31:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJJdS-0000Cf-4P
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 05:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756101AbZLLEbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 23:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760801AbZLLEa6
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 23:30:58 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:36811 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756004AbZLLEau (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 23:30:50 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4CE9D81806B;
	Sat, 12 Dec 2009 05:30:46 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 04B7F81804B;
	Sat, 12 Dec 2009 05:30:43 +0100 (CET)
X-git-sha1: a1547debd3a8d7bdf21ff55736a65e66f98bbcdd 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20091212042042.3930.54783.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135115>

It is strange and fragile that a mixed reset is disallowed in a bare
repo but is allowed in a .git dir. So this patch simplifies things
by only allowing soft resets when not in a working tree.

This patch is also needed to speed up "git reset" by using
unpack_tree() directly (instead of execing "git read-tree"). A
following patch will do just that.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-reset.c       |    3 +--
 t/t7103-reset-bare.sh |    4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index 11d1c6e..14bdb03 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -286,8 +286,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (reset_type == NONE)
 		reset_type = MIXED; /* by default */
 
-	if ((reset_type == HARD || reset_type == MERGE)
-	    && !is_inside_work_tree())
+	if (reset_type != SOFT && !is_inside_work_tree())
 		die("%s reset requires a work tree",
 		    reset_type_names[reset_type]);
 
diff --git a/t/t7103-reset-bare.sh b/t/t7103-reset-bare.sh
index 68041df..13344b2 100755
--- a/t/t7103-reset-bare.sh
+++ b/t/t7103-reset-bare.sh
@@ -21,8 +21,8 @@ test_expect_success 'merge reset requires a worktree' '
 	 test_must_fail git reset --merge)
 '
 
-test_expect_success 'mixed reset is ok' '
-	(cd .git && git reset)
+test_expect_success 'mixed reset requires a worktree' '
+	(cd .git && test_must_fail git reset)
 '
 
 test_expect_success 'soft reset is ok' '
-- 
1.6.6.rc1.8.gd33ec
