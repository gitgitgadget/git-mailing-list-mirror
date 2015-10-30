From: Max Kirillov <max@max630.net>
Subject: [PATCH v5 1/3] blame: test to describe use of blame --reverse --first-parent
Date: Fri, 30 Oct 2015 07:01:51 +0200
Message-ID: <1446181313-15094-2-git-send-email-max@max630.net>
References: <1446181313-15094-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 06:02:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zs1pJ-0004Sv-RY
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 06:02:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbbJ3FCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 01:02:05 -0400
Received: from p3plsmtpa07-01.prod.phx3.secureserver.net ([173.201.192.230]:51741
	"EHLO p3plsmtpa07-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751485AbbJ3FCD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2015 01:02:03 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-01.prod.phx3.secureserver.net with 
	id bH1u1r0075B68XE01H21fa; Thu, 29 Oct 2015 22:02:03 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1446181313-15094-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280477>

Reverse blame can be used to locate removal of lines which does not
change adjacent lines. Such edits do not appear in non-reverse blame,
because the adjacent lines last changed commit is older history, before
the edit.

For a big and active project which uses topic branches, or analogous
feature, for example pull-requests, the history can contain many
concurrent branches, and even after an edit merged into the target
branch, there are still many (sometimes several tens or even hundreds)
topic branch which do not contain it:

 a0--a1-----*a2-*a3-a4...-*a100
 |\         /   /         /
 | b0-B1..bN   /         /
 |\           /         /
 | c0..   ..cN         /
 \                    /
  z0..            ..zN

Here, the '*'s mark the first parent in merge, and uppercase B1 - the
commit where the line being blamed for was removed. Since commits cN-zN
do not contain the B1, the still have the line removed in B1, and
reverce blame can report that the last commit for the line was zN
(meaning that it was removed in a100). In fact it really does return
some very late commit, and this makes it unusable for finding the B1
commit.

The search could be done by blame --reverse --first-parent. For range
a0..a100 it would return a1, and then only one additional blame along
the a0..bN will return the desired commit b0. But combining --reverse
and --first-parent was forbidden in 95a4fb0eac, because incorrectly
specified range could produce unexpected and meaningless result.

Add test which describes the expected behavior of
`blame --reverse --first-parent` in the case described above.

Signed-off-by: Max Kirillov <max@max630.net>
---
 t/t8009-blame-vs-topicbranches.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100755 t/t8009-blame-vs-topicbranches.sh

diff --git a/t/t8009-blame-vs-topicbranches.sh b/t/t8009-blame-vs-topicbranches.sh
new file mode 100755
index 0000000..175ad37
--- /dev/null
+++ b/t/t8009-blame-vs-topicbranches.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description='blaming trough history with topic branches'
+. ./test-lib.sh
+
+# Creates the history shown below. '*'s mark the first parent in the merges.
+# The only line of file.t is changed in commit B2
+#
+#        +---C1
+#       /      \
+# A0--A1--*A2--*A3
+#   \     /
+#    B1-B2
+#
+test_expect_success setup '
+	test_commit A0 file.t line0 &&
+	test_commit A1 &&
+	git reset --hard A0 &&
+	test_commit B1 &&
+	test_commit B2 file.t line0changed &&
+	git reset --hard A1 &&
+	test_merge A2 B2 &&
+	git reset --hard A1 &&
+	test_commit C1 &&
+	git reset --hard A2 &&
+	test_merge A3 C1
+	'
+
+test_expect_failure 'blame --reverse --first-parent finds A1' '
+	git blame --porcelain --reverse --first-parent A0..A3 -- file.t >actual_full &&
+	head -n 1 <actual_full | sed -e "s/ .*//" >actual &&
+	git rev-parse A1 >expect &&
+	test_cmp expect actual
+	'
+
+test_done
-- 
2.3.4.2801.g3d0809b
