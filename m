From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 3/3] rev-list --min-parents,--max-parents: doc and test and completion
Date: Mon, 21 Mar 2011 11:14:07 +0100
Message-ID: <8bad49d4e4897be623b7af3096498a5803dbbd89.1300702130.git.git@drmicha.warpmail.net>
References: <4D870157.2070309@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 11:14:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1c86-0007KI-7x
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 11:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850Ab1CUKOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 06:14:19 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:41378 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752704Ab1CUKOQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 06:14:16 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 294D5209E1;
	Mon, 21 Mar 2011 06:14:16 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 21 Mar 2011 06:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=XI5Qit8VfSH7KJGZC8hMkJM54xs=; b=aIUosf/DRoAJq9SBAtBbUiPIbkt3Rd5FbyhU2g2r+rK/854ot690SIGFX3aBSIUHRsJpSUklw92si/avM8g6A3kjCWhckzAMo/c7xuVOCjDv/FeCsaORzh7gsJUiMiaJYuRbY8J0iOTNf4kZWzCx3XuwRvIrKd2c5piQViQWBdg=
X-Sasl-enc: Dh4OMiExWs5kJAE+drkjBE2JNlXemi7xHocowh8YL1x5 1300702455
Received: from localhost (p548593A3.dip0.t-ipconnect.de [84.133.147.163])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 25C4B441B38;
	Mon, 21 Mar 2011 06:14:14 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.511.g72e46
In-Reply-To: <4D870157.2070309@drmicha.warpmail.net>
In-Reply-To: <cover.1300702130.git.git@drmicha.warpmail.net>
References: <cover.1300702130.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169577>

This also adds test for "--merges" and "--no-merges" which we did not
have so far.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-rev-list.txt         |    2 +
 Documentation/rev-list-options.txt     |   17 ++++++-
 contrib/completion/git-completion.bash |    1 +
 t/t6009-rev-list-parent.sh             |   84 +++++++++++++++++++++++++++++++-
 4 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index b08dfbc..4d2b0c5 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -16,6 +16,8 @@ SYNOPSIS
 	     [ \--sparse ]
 	     [ \--merges ]
 	     [ \--no-merges ]
+	     [ \--min-parents ]
+	     [ \--max-parents ]
 	     [ \--first-parent ]
 	     [ \--remove-empty ]
 	     [ \--full-history ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5c6850f..18d5534 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -72,11 +72,24 @@ endif::git-rev-list[]
 
 --merges::
 
-	Print only merge commits.
+	Print only merge commits. This is equivalent to `--min-parents=2`.
 
 --no-merges::
 
-	Do not print commits with more than one parent.
+	Do not print commits with more than one parent. This is
+	equivalent to `--max-parents=1`.
+
+--min-parents::
+--max-parents::
+
+	Show only commits which have at least resp. at most that many
+	commits, where negative parameters for `--max-parents=` denote
+	infinity (i.e. no upper	limit).
++
+In particular, `--max-parents=1` is `--no-merges`, `--min-parents=2` is
+`--merges` (only), `--max-parents=0` gives all root commits and
+`--min-parents=3` all octopuses.
+
 
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
index 0f0e457..d460369 100755
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
@@ -28,4 +36,78 @@ test_expect_success 'one is ancestor of others and should not be shown' '
 
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
 test_done
-- 
1.7.4.1.511.g72e46
