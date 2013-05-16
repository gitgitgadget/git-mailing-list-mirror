From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v4 03/15] t6111: new TREESAME test set
Date: Thu, 16 May 2013 18:32:29 +0300
Message-ID: <1368718361-27859-4-git-send-email-kevin@bracey.fi>
References: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 17:39:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud0HU-0000lm-LA
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 17:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036Ab3EPPjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 11:39:40 -0400
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:36498 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751552Ab3EPPji (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 11:39:38 -0400
Received: from mail92.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 26A6E10540C8
	for <git@vger.kernel.org>; Thu, 16 May 2013 17:33:06 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 16 May 2013 17:33:05 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 16 May 2013 17:33:01 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g4b02ef5
In-Reply-To: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 18171180072997589217
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -58
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -58
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224580>

Some side branching and odd merging to illustrate various flaws in
revision list scans, particularly when limiting the list.

Many expected failures, which will be gone by the end of the "history
traversal refinements" series.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 t/t6111-rev-list-treesame.sh | 184 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 184 insertions(+)
 create mode 100755 t/t6111-rev-list-treesame.sh

diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
new file mode 100755
index 0000000..b2bca77
--- /dev/null
+++ b/t/t6111-rev-list-treesame.sh
@@ -0,0 +1,184 @@
+#!/bin/sh
+#
+#        ,---E--.   *H----------.             * marks !TREESAME parent paths
+#       /        \ /             \*
+# *A--*B---D--*F-*G---------K-*L-*M
+#   \     /*       \       /
+#    `-C-'          `-*I-*J
+#
+# A creates "file", B and F change it.
+# Odd merge G takes the old version from B.
+# I changes it, but J reverts it, so K is TREESAME to both parents.
+# H and L both change "file", and M merges those changes.
+
+test_description='TREESAME and limiting'
+
+. ./test-lib.sh
+
+note () {
+	git tag "$1"
+}
+
+unnote () {
+	git name-rev --tags --stdin | sed -e "s|$_x40 (tags/\([^)]*\)) |\1 |g"
+}
+
+test_expect_success setup '
+	test_commit "Initial file" file "Hi there" A &&
+	git branch other-branch &&
+
+	test_commit "file=Hello" file "Hello" B &&
+	git branch third-branch &&
+
+	git checkout other-branch &&
+	test_commit "Added other" other "Hello" C &&
+
+	git checkout master &&
+	test_merge D other-branch &&
+
+	git checkout third-branch &&
+	test_commit "Third file" third "Nothing" E &&
+
+	git checkout master &&
+	test_commit "file=Blah" file "Blah" F &&
+
+	test_tick && git merge --no-commit third-branch &&
+	git checkout third-branch file &&
+	git commit &&
+	note G &&
+	git branch fiddler-branch &&
+
+	git checkout -b part2-branch &&
+	test_commit "file=Part 2" file "Part 2" H &&
+
+	git checkout fiddler-branch &&
+	test_commit "Bad commit" file "Silly" I &&
+
+	test_tick && git revert I && note J &&
+
+	git checkout master &&
+	test_tick && git merge --no-ff fiddler-branch &&
+	note K
+
+	test_commit "file=Part 1" file "Part 1" L &&
+
+	test_tick && test_must_fail git merge part2-branch &&
+	test_commit M file "Parts 1+2"
+'
+
+FMT='tformat:%P 	%H | %s'
+
+# could we soup this up to optionally check parents? So "(BA)C" would check
+# that C is shown and has parents B A.
+check_outcome () {
+	outcome=$1
+	shift
+	for c in $1
+	do
+		echo "$c"
+	done >expect &&
+	shift &&
+	param="$*" &&
+	test_expect_$outcome "log $param" '
+		git log --format="$FMT" $param |
+		unnote >actual &&
+		sed -e "s/^.*	\([^ ]*\) .*/\1/" >check <actual &&
+		test_cmp expect check || {
+			cat actual
+			false
+		}
+	'
+}
+
+check_result () {
+	check_outcome success "$@"
+}
+
+# Odd merge G drops a change in F. Important that G is listed in all
+# except the most basic list. Achieving this means normal merge D will also be
+# shown in normal full-history, as we can't distinguish unless we do a
+# simplification pass. After simplification, D is dropped but G remains.
+check_result 'M L K J I H G F E D C B A'
+check_result 'M H L K J I G E F D C B A' --topo-order
+check_result 'M L H B A' -- file
+check_result 'M L H B A' --parents -- file
+check_outcome failure 'M L J I H G F D B A' --full-history -- file # drops G
+check_result 'M L K J I H G F D B A' --full-history --parents -- file
+check_outcome failure 'M H L J I G F B A' --simplify-merges -- file # drops G
+check_result 'M L K G F D B A' --first-parent
+check_result 'M L G F B A' --first-parent -- file
+
+# Check that odd merge G remains shown when F is the bottom.
+check_result 'M L K J I H G E' F..M
+check_result 'M H L K J I G E' F..M --topo-order
+check_result 'M L H' F..M -- file
+check_result 'M L H' F..M --parents -- file # L+H's parents rewritten to B, so more useful than it may seem
+check_outcome failure 'M L J I H G' F..M --full-history -- file # drops G
+check_result 'M L K J I H G' F..M --full-history --parents -- file
+check_outcome failure 'M H L J I G' F..M --simplify-merges -- file # drops G
+check_result 'M L K J I H G' F..M --ancestry-path
+check_outcome failure 'M L J I H G' F..M --ancestry-path -- file # drops G
+check_result 'M L K J I H G' F..M --ancestry-path --parents -- file
+check_result 'M H L J I G' F..M --ancestry-path --simplify-merges -- file
+check_result 'M L K G' F..M --first-parent
+check_result 'M L G' F..M --first-parent -- file
+
+# Note that G is pruned when E is the bottom, even if it's the same commit list
+# If we want history since E, then we're quite happy to ignore G that took E.
+check_result 'M L K J I H G' E..M --ancestry-path
+check_result 'M L J I H' E..M --ancestry-path -- file
+check_outcome failure 'M L K J I H' E..M --ancestry-path --parents -- file # includes G
+check_outcome failure 'M H L J I' E..M --ancestry-path --simplify-merges -- file # includes G
+
+# Should still be able to ignore I-J branch in simple log, despite limiting
+# to G.
+check_result 'M L K J I H' G..M
+check_result 'M H L K J I' G..M --topo-order
+check_outcome failure 'M L H' G..M -- file # includes J I
+check_outcome failure 'M L H' G..M --parents -- file # includes J I
+check_result 'M L J I H' G..M --full-history -- file
+check_result 'M L K J I H' G..M --full-history --parents -- file
+check_result 'M H L J I' G..M --simplify-merges -- file
+check_result 'M L K J I H' G..M --ancestry-path
+check_result 'M L J I H' G..M --ancestry-path -- file
+check_result 'M L K J I H' G..M --ancestry-path --parents -- file
+check_result 'M H L J I' G..M --ancestry-path --simplify-merges -- file
+
+# B..F should be able to simplify the merge D from irrelevant side branch C.
+# Default log should also be free to follow B-D, and ignore C.
+# But --full-history shouldn't drop D on its own - without simplification,
+# we can't decide if the merge from INTERESTING commit C was sensible.
+check_result 'F D C' B..F
+check_result 'F' B..F -- file
+check_outcome failure 'F' B..F --parents -- file # includes D
+check_outcome failure 'F D' B..F --full-history -- file # drops D prematurely
+check_result 'F D' B..F --full-history --parents -- file
+check_result 'F' B..F --simplify-merges -- file
+check_result 'F D' B..F --ancestry-path
+check_result 'F' B..F --ancestry-path -- file
+check_outcome failure 'F' B..F --ancestry-path --parents -- file # includes D
+check_outcome failure 'F' B..F --ancestry-path --simplify-merges -- file # includes D
+check_result 'F D' B..F --first-parent
+check_result 'F' B..F --first-parent -- file
+
+# E...F should be equivalent to E F ^B, and be able to drop D as above.
+check_result 'F' E F ^B -- file
+check_result 'F' E...F -- file
+
+# Any sort of full history of C..F should show D, as it's the connection to C,
+# and it differs from it.
+check_result 'F D B' C..F
+check_result 'F B' C..F -- file
+check_result 'F B' C..F --parents -- file
+check_outcome failure 'F D B' C..F --full-history -- file # drops D
+check_result 'F D B' C..F --full-history --parents -- file
+check_result 'F D B' C..F --simplify-merges -- file
+check_result 'F D' C..F --ancestry-path
+check_outcome failure 'F D' C..F --ancestry-path -- file # drops D
+check_result 'F D' C..F --ancestry-path --parents -- file
+check_result 'F D' C..F --ancestry-path --simplify-merges -- file
+check_result 'F D B' C..F --first-parent
+check_result 'F B' C..F --first-parent -- file
+
+
+test_done
-- 
1.8.3.rc0.28.g4b02ef5
