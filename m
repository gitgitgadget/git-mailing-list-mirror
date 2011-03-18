From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/3] rev-list --min-parents,--max-parents: doc and test and completion
Date: Fri, 18 Mar 2011 15:50:25 +0100
Message-ID: <182c5ece22835559a9762e242adb701547cf6575.1300459017.git.git@drmicha.warpmail.net>
References: <20110318085616.GA16703@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 15:54:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0b4B-0000wi-7E
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 15:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825Ab1CROyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 10:54:04 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:46687 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756820Ab1CROyA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 10:54:00 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2B26620862;
	Fri, 18 Mar 2011 10:54:00 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 18 Mar 2011 10:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=1D2hCHLiyRZu5D6mThjBdXtXnfc=; b=MQF9gUkb/wbEBOf3nzdSEkMyCAlVveMERrl0iJ4TN8iLMTVAUDj77ivKHPPv4pV2i8encO98hKeLwsSIEY6LNaWYGst8KvEn3A4f8r/DGXqsWHjQcvBkxluJsOekFMtUXpBf0CirO6G9YtD6F2u7QHl8TxMeRjy49qmSQfSZE8g=
X-Sasl-enc: jriTP7su1Hq4QfRBznpiMtBHBSY80w8FWxP7tJ2lIgx6 1300460039
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 79505400B60;
	Fri, 18 Mar 2011 10:53:59 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.464.gf81ff
In-Reply-To: <20110318085616.GA16703@sigill.intra.peff.net>
In-Reply-To: <cover.1300459016.git.git@drmicha.warpmail.net>
References: <cover.1300459016.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169326>

This also adds test for "--merges" and "--no-merges" which we did not
have so far.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-rev-list.txt         |    2 +
 Documentation/rev-list-options.txt     |   13 ++++++
 contrib/completion/git-completion.bash |    1 +
 t/t6009-rev-list-parent.sh             |   70 +++++++++++++++++++++++++++++++-
 4 files changed, 85 insertions(+), 1 deletions(-)

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
index 5c6850f..104e644 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -78,6 +78,19 @@ endif::git-rev-list[]
 
 	Do not print commits with more than one parent.
 
+--min-parents::
+--max-parents::
+
+	Show only commits which have at least resp. at most that many
+	commits, where `--max-parents=8` denotes infinity (i.e. no upper
+	limit). In fact, 7 (or any negative number) does, but 8 is
+	infinity sideways 8-)
++
+In particular, `--max-parents=1` is `--no-merges`, `--min-parents=2` is
+`--merges` (only), `--max-parents=0` gives all root commits and
+`--min-parents=3` all octopusses.
+
+
 --first-parent::
 	Follow only the first parent commit upon seeing a merge
 	commit.  This option can give a better overview when
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
index 0f0e457..792bbe9 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='properly cull all ancestors'
+test_description='ancestor culling and limitting by parent number'
 
 . ./test-lib.sh
 
@@ -28,4 +28,72 @@ test_expect_success 'one is ancestor of others and should not be shown' '
 
 '
 
+test_expect_success 'setup roots, merges and octopusses' '
+
+	git checkout --orphan newroot &&
+	test_commit five &&
+	git checkout -b sidebranch two &&
+	test_commit six &&
+	git checkout -b anotherbranch three &&
+	test_commit seven &&
+	git checkout master &&
+	test_merge normalmerge newroot &&
+	test_tick &&
+	git merge -m octopus sidebranch anotherbranch &&
+	git tag octopus
+'
+
+check_revlist () {
+	> expect &&
+	for c in $2; do echo "$c" >> expect; done &&
+	git rev-list $1 master | git name-rev --name-only --tags --stdin >actual &&
+	test_cmp expect actual
+}
+ 
+test_expect_success 'rev-list roots' '
+
+	check_revlist "--max-parents=0" "five one"
+'
+
+test_expect_success 'rev-list no merges' '
+
+	check_revlist "--max-parents=1" "seven six five four three two one" &&
+	check_revlist "--no-merges" "seven six five four three two one"
+'
+
+test_expect_success 'rev-list no octopusses' '
+
+	check_revlist "--max-parents=2" "normalmerge seven six five four three two one"
+'
+
+test_expect_success 'rev-list no roots' '
+
+	check_revlist "--min-parents=1" "octopus normalmerge seven six four three two"
+'
+
+test_expect_success 'rev-list merges' '
+
+	check_revlist "--min-parents=2" "octopus normalmerge" &&
+	check_revlist "--merges" "octopus normalmerge"
+'
+
+test_expect_success 'rev-list octopus' '
+
+	check_revlist "--min-parents=3" "octopus"
+'
+
+test_expect_success 'rev-list ordinary commits' '
+
+	check_revlist "--min-parents=1 --max-parents=1" "seven six four three two"
+'
+
+test_expect_success 'rev-list override and infinities' '
+
+	check_revlist "--min-parents=2 --no-merges" "" &&
+	check_revlist "--min-parents=2 --no-merges --max-parents=3" "octopus normalmerge" &&
+	check_revlist "--min-parents=2 --no-merges --max-parents=7" "octopus normalmerge" &&
+	check_revlist "--min-parents=2 --no-merges --max-parents=8" "octopus normalmerge" &&
+	check_revlist "--min-parents=2 --no-merges --max-parents=-1" "octopus normalmerge"
+'
+
 test_done
-- 
1.7.4.1.464.gf81ff
