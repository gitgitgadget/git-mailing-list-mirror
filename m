From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/3] git-merge-base/git-show-branch --merge-base: Documentation and test
Date: Wed,  5 Aug 2009 09:59:20 +0200
Message-ID: <1249459160-3931-4-git-send-email-git@drmicha.warpmail.net>
References: <1249459160-3931-1-git-send-email-git@drmicha.warpmail.net>
 <1249459160-3931-2-git-send-email-git@drmicha.warpmail.net>
 <1249459160-3931-3-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 09:59:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYbPY-00031z-FP
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 09:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933742AbZHEH7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 03:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933741AbZHEH7n
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 03:59:43 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50952 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933737AbZHEH7m (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 03:59:42 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id A13533BCBA0;
	Wed,  5 Aug 2009 03:59:42 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 05 Aug 2009 03:59:42 -0400
X-Sasl-enc: 3fpZMoqm9W9bT1eKye7RZa6N4W/XpTua1ZyGDOUgXnRr 1249459181
Received: from localhost (vpn-136-027.rz.uni-augsburg.de [137.250.136.27])
	by mail.messagingengine.com (Postfix) with ESMTPSA id ADFE42DE0B;
	Wed,  5 Aug 2009 03:59:41 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.70.g9c084
In-Reply-To: <1249459160-3931-3-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124875>

Currently, the documentation suggests that 'git merge-base -a' and 'git
show-branch --merge-base' are equivalent (in fact it claims that the
former cannot handle more than two revs).

Alas, the handling of more than two revs is very different. Document
this by tests and correct the documentation to reflect this.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-merge-base.txt  |    4 ++++
 Documentation/git-show-branch.txt |    8 +++++---
 builtin-show-branch.c             |    2 +-
 t/t6010-merge-base.sh             |    6 ++++++
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 00e4003..ce5b369 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -27,6 +27,10 @@ commits on the command line.  As the most common special case, specifying only
 two commits on the command line means computing the merge base between
 the given two commits.
 
+As a consequence, the 'merge base' is not necessarily contained in each of the
+commit arguments if more than two commits are specified. This is different
+from linkgit:git-show-branch[1] when used with the `--merge-base` option.
+
 OPTIONS
 -------
 -a::
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 2c78c25..7343361 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -82,9 +82,11 @@ OPTIONS
 	Synonym to `--more=-1`
 
 --merge-base::
-	Instead of showing the commit list, just act like the
-	'git-merge-base -a' command, except that it can accept
-	more than two heads.
+	Instead of showing the commit list, determine possible
+	merge bases for the specified commits. All merge bases
+	will be contained in all specified commits. This is
+	different from how linkgit:git-merge-base[1] handles
+	the case of three or more commits.
 
 --independent::
 	Among the <reference>s given, display only the ones that
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 03bdea6..3510a86 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -665,7 +665,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		OPT_BOOLEAN(0, "sha1-name", &sha1_name,
 			    "name commits with their object names"),
 		OPT_BOOLEAN(0, "merge-base", &merge_base,
-			    "act like git merge-base -a"),
+			    "show possible merge bases"),
 		OPT_BOOLEAN(0, "independent", &independent,
 			    "show refs unreachable from any other ref"),
 		OPT_BOOLEAN(0, "topo-order", &lifo,
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 79124ec..0144d9e 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -149,6 +149,12 @@ test_expect_success 'merge-base A B C' '
 	test "$MM1" = "$MB"
 '
 
+test_expect_success 'merge-base A B C using show-branch' '
+	MB=$(git show-branch --merge-base MMA MMB MMC) &&
+	MMR=$(git rev-parse --verify MMR) &&
+	test "$MMR" = "$MB"
+'
+
 test_expect_success 'criss-cross merge-base for octopus-step (setup)' '
 	git reset --hard MMR &&
 	test_tick && git commit --allow-empty -m 1 && git tag CC1 &&
-- 
1.6.4.70.g9c084
