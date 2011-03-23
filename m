From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 4/5] rev-list --min-parents,--max-parents: doc, test and completion
Date: Wed, 23 Mar 2011 10:38:51 +0100
Message-ID: <df079eb89fa305bf8d33019ea7089df5950e4506.1300872923.git.git@drmicha.warpmail.net>
References: <20110321105628.GC16334@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 10:42:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Kae-0008Vn-8u
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 10:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620Ab1CWJmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 05:42:39 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:59668 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752373Ab1CWJmf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 05:42:35 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id F0C4F203C7;
	Wed, 23 Mar 2011 05:42:34 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 23 Mar 2011 05:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=kvSJx6j1kelxklqmWJFTU0u5W2c=; b=jm4lzTVIGS1C4Gg/Itz661xbPBWh4TLPF1bdG6uCz+WqZP4wsq0S18DQa+LKbx00TGX+TCHzeR12fiqSAgB6c36yuX/ttoHa5TbrQGq8/atHsSHhQcyvH2ZxRw0Jv1yxVb7Mx4iN0LDqASNBfjZ81zq+L0AU+lBAlP7B9HB5PXk=
X-Sasl-enc: vU5f6uUXlYJYOvXfugzbSS7IBud8GSq++bDKp8uFvQvb 1300873354
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 22D21448B2A;
	Wed, 23 Mar 2011 05:42:34 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.511.g72e46
In-Reply-To: <20110321105628.GC16334@sigill.intra.peff.net>
In-Reply-To: <cover.1300872923.git.git@drmicha.warpmail.net>
References: <cover.1300872923.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169810>

This also adds test for "--merges" and "--no-merges" which we did not
have so far.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-rev-list.txt         |    2 +
 Documentation/rev-list-options.txt     |   16 ++++-
 contrib/completion/git-completion.bash |    1 +
 t/t6009-rev-list-parent.sh             |  105 +++++++++++++++++++++++++++++++-
 4 files changed, 121 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index b08dfbc..c5ea96f 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -16,6 +16,8 @@ SYNOPSIS
 	     [ \--sparse ]
 	     [ \--merges ]
 	     [ \--no-merges ]
+	     [ \--min-parents=<number> ]
+	     [ \--max-parents=<number> ]
 	     [ \--first-parent ]
 	     [ \--remove-empty ]
 	     [ \--full-history ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5c6850f..0bbf7da 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -72,11 +72,23 @@ endif::git-rev-list[]
 
 --merges::
 
-	Print only merge commits.
+	Print only merge commits. This is exactly the same as `--min-parents=2`.
 
 --no-merges::
 
-	Do not print commits with more than one parent.
+	Do not print commits with more than one parent. This is
+	exactly the same as `--max-parents=1`.
+
+--min-parents=<number>::
+--max-parents=<number>::
+
+	Show only commits which have at least (or at most) that many
+	commits, where negative parameters for `--max-parents=` denote
+	infinity (i.e. no upper	limit).
++
+In particular, `--max-parents=1` is the same as `--no-merges`,
+`--min-parents=2` is the same as `--merges`.  `--max-parents=0`
+gives all root commits and `--min-parents=3` all octopus merges.
 
 --first-parent::
 	Follow only the first parent commit upon seeing a merge
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3b1cc83..4da087e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1577,6 +1577,7 @@ __git_log_common_options="
 	--max-count=
 	--max-age= --since= --after=
 	--min-age= --until= --before=
+	--min-parents= --max-parents=
 "
 # Options that go well for log and gitk (not shortlog)
 __git_log_gitk_options="
diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index 0f0e457..5309378 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -1,9 +1,17 @@
 #!/bin/sh
 
-test_description='properly cull all ancestors'
+test_description='ancestor culling and limiting by parent number'
 
 . ./test-lib.sh
 
+check_revlist () {
+	rev_list_args="$1" &&
+	shift &&
+	git rev-parse "$@" >expect &&
+	git rev-list $rev_list_args --all >actual &&
+	test_cmp expect actual
+}
+
 test_expect_success setup '
 
 	touch file &&
@@ -28,4 +36,99 @@ test_expect_success 'one is ancestor of others and should not be shown' '
 
 '
 
+test_expect_success 'setup roots, merges and octopuses' '
+
+	git checkout --orphan newroot &&
+	test_commit five &&
+	git checkout -b sidebranch two &&
+	test_commit six &&
+	git checkout -b anotherbranch three &&
+	test_commit seven &&
+	git checkout -b yetanotherbranch four &&
+	test_commit eight &&
+	git checkout master &&
+	test_merge normalmerge newroot &&
+	test_tick &&
+	git merge -m tripus sidebranch anotherbranch &&
+	git tag tripus &&
+	git checkout -b tetrabranch normalmerge &&
+	test_tick &&
+	git merge -m tetrapus sidebranch anotherbranch yetanotherbranch &&
+	git tag tetrapus &&
+	git checkout master
+'
+
+test_expect_success 'rev-list roots' '
+
+	check_revlist "--max-parents=0" one five
+'
+
+test_expect_success 'rev-list no merges' '
+
+	check_revlist "--max-parents=1" one eight seven six five four three two &&
+	check_revlist "--no-merges" one eight seven six five four three two
+'
+
+test_expect_success 'rev-list no octopuses' '
+
+	check_revlist "--max-parents=2" one normalmerge eight seven six five four three two
+'
+
+test_expect_success 'rev-list no roots' '
+
+	check_revlist "--min-parents=1" tetrapus tripus normalmerge eight seven six four three two
+'
+
+test_expect_success 'rev-list merges' '
+
+	check_revlist "--min-parents=2" tetrapus tripus normalmerge &&
+	check_revlist "--merges" tetrapus tripus normalmerge
+'
+
+test_expect_success 'rev-list octopus' '
+
+	check_revlist "--min-parents=3" tetrapus tripus
+'
+
+test_expect_success 'rev-list ordinary commits' '
+
+	check_revlist "--min-parents=1 --max-parents=1" eight seven six four three two
+'
+
+test_expect_success 'rev-list --merges --no-merges yields empty set' '
+
+	check_revlist "--min-parents=2 --no-merges" &&
+	check_revlist "--merges --no-merges" &&
+	check_revlist "--no-merges --merges"
+'
+
+test_expect_success 'rev-list override and infinities' '
+
+	check_revlist "--min-parents=2 --max-parents=1 --max-parents=3" tripus normalmerge &&
+	check_revlist "--min-parents=1 --min-parents=2 --max-parents=7" tetrapus tripus normalmerge &&
+	check_revlist "--min-parents=2 --max-parents=8" tetrapus tripus normalmerge &&
+	check_revlist "--min-parents=2 --max-parents=-1" tetrapus tripus normalmerge
+'
+
+test_expect_success 'set up dodecapus' '
+
+	for i in 1 2 3 4 5 6 7 8 9 10 11
+	do
+		git checkout -b root$i five || return
+		test_commit $i || return
+	done &&
+	git checkout master &&
+	test_tick &&
+	git merge -m dodecapus root{1,2,3,4,5,6,7,8,9,10,11} &&
+	git tag dodecapus
+'
+
+test_expect_success 'test with dodecapus' '
+
+	check_revlist "--min-parents=4" dodecapus tetrapus &&
+	check_revlist "--min-parents=8" dodecapus &&
+	check_revlist "--min-parents=12" dodecapus &&
+	check_revlist "--min-parents=13" &&
+	check_revlist "--min-parents=4 --max-parents=11" tetrapus
+'
 test_done
-- 
1.7.4.1.511.g72e46
