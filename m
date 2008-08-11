From: Abhijit Menon-Sen <ams@toroid.org>
Subject: [PATCH v2] Make cherry-pick use rerere for conflict resolution.
Date: Mon, 11 Aug 2008 08:00:53 +0530
Message-ID: <20080811023053.GA9144@toroid.org>
References: <1218368935-31124-1-git-send-email-ams@toroid.org> <alpine.DEB.1.00.0808110111430.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 11 04:32:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSNCb-0004Qu-Mv
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 04:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669AbYHKCbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 22:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753619AbYHKCbA
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 22:31:00 -0400
Received: from fugue.toroid.org ([85.10.196.113]:60086 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753514AbYHKCbA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 22:31:00 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id C0CE455848B;
	Mon, 11 Aug 2008 04:30:57 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 910BAADC36D; Mon, 11 Aug 2008 08:00:54 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808110111430.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91909>

It was a dark and stormy night. Sam struggled to keep his eyelids open
as he integrated yet another gigantic patch series. Ever the optimist,
he'd pulled in the changes, only to discover several merge conflicts.
But the night was young then, and he'd fixed them all by hand.

It was only later that he noticed many lousy, one-line commit messages.
Undaunted, he reset his branch and began to cherry-pick patches, giving
them a once-over, writing a comment here, squashing the odd grotesque
hack there, and writing sensible commit messages more often than not.

But even that was hours ago, and each new but oh-so-familiar conflict
ate into his determination like maggots through decaying meat; and Sam
was beginning to question the wisdom of staying in this fruit business.
His whiskey was running low, and time was running out.

"If only", thought Sam, "If only cherry-pick would..."

Signed-off-by: Abhijit Menon-Sen <ams@toroid.org>
---
 builtin-revert.c              |    2 +
 t/t3504-cherry-pick-rerere.sh |   45 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)
 create mode 100755 t/t3504-cherry-pick-rerere.sh

diff --git a/builtin-revert.c b/builtin-revert.c
index 27881e9..3667705 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -11,6 +11,7 @@
 #include "cache-tree.h"
 #include "diff.h"
 #include "revision.h"
+#include "rerere.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -395,6 +396,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			die ("Error wrapping up %s", defmsg);
 		fprintf(stderr, "Automatic %s failed.%s\n",
 			me, help_msg(commit->object.sha1));
+		rerere();
 		exit(1);
 	}
 	if (commit_lock_file(&msg_file) < 0)
diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
new file mode 100755
index 0000000..957b298
--- /dev/null
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description='cherry-pick should rerere for conflicts'
+
+. ./test-lib.sh
+
+echo foo > foo
+git add foo && git commit -q -m 1
+
+echo foo-master > foo
+git add foo && git commit -q -m 2
+
+git checkout -b dev HEAD^
+
+echo foo-dev > foo
+git add foo && git commit -q -m 3
+
+git config rerere.enabled true
+
+test_expect_success 'conflicting merge' '
+	test_must_fail git merge master
+'
+
+echo foo-dev > foo
+git add foo && git commit -q -m 4
+
+git reset --hard HEAD^
+
+echo foo-dev > expect
+
+test_expect_success 'cherry-pick conflict' '
+	test_must_fail git cherry-pick master &&
+	test_cmp expect foo
+'
+
+git config rerere.enabled false
+
+git reset --hard
+
+test_expect_success 'cherry-pick conflict without rerere' '
+	test_must_fail git cherry-pick master &&
+	test_must_fail test_cmp expect foo
+'
+
+test_done
-- 
1.6.0.rc2
