From: Greg Price <price@ksplice.com>
Subject: [PATCH v2 1/1] Fix rebase -p --onto
Date: Wed, 22 Jul 2009 12:38:58 -0400
Message-ID: <20090722163858.GP7503@vinegar-pot.mit.edu>
References: <20090722163738.GO7503@vinegar-pot.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jul 22 18:39:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTeqz-0001W6-Ey
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 18:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbZGVQjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 12:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbZGVQjE
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 12:39:04 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:37612 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751842AbZGVQjD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 12:39:03 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n6MGcx9c026988;
	Wed, 22 Jul 2009 12:38:59 -0400 (EDT)
Received: from localhost (VINEGAR-POT.MIT.EDU [18.181.0.51])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n6MGcwwQ019066;
	Wed, 22 Jul 2009 12:38:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20090722163738.GO7503@vinegar-pot.mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123755>

In a rebase with --onto, the correct test for whether we can skip
rewriting a commit is if it is already on top of $ONTO, not $UPSTREAM.
Without --onto, this distinction does not exist and the behavior does
not change.

In a situation with two merged branches on a common base X:

 X---o---o---o---M
  \             /
   x---x---x---x

 Y

if we try to move the branches from their base on X to be based on Y,
so as to get

 X

 Y---o'--o'--o'--M'
  \             /
   x'--x'--x'--x'

then we fail.  The command `git rebase -p --onto Y X M` moves only the
first-parent chain, like so:

 X
  \
   x---x---x---x
                \
 Y---o'--o'--o'--M'

because it mistakenly drops the other branch(es) x---x---x---x from
the TODO file.  This tests and fixes this behavior.

Signed-off-by: Greg Price <price@ksplice.com>
---
 git-rebase--interactive.sh      |    2 +-
 t/t3414-rebase-preserve-onto.sh |   80 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 1 deletions(-)
 create mode 100755 t/t3414-rebase-preserve-onto.sh

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f96d887..23ded48 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -703,7 +703,7 @@ first and then run 'git rebase --continue' again."
 					preserve=t
 					for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
 					do
-						if test -f "$REWRITTEN"/$p -a \( $p != $UPSTREAM -o $sha1 = $first_after_upstream \)
+						if test -f "$REWRITTEN"/$p -a \( $p != $ONTO -o $sha1 = $first_after_upstream \)
 						then
 							preserve=f
 						fi
diff --git a/t/t3414-rebase-preserve-onto.sh b/t/t3414-rebase-preserve-onto.sh
new file mode 100755
index 0000000..80019ee
--- /dev/null
+++ b/t/t3414-rebase-preserve-onto.sh
@@ -0,0 +1,80 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Greg Price
+#
+
+test_description='git rebase -p should respect --onto
+
+In a rebase with --onto, we should rewrite all the commits that
+aren'"'"'t on top of $ONTO, even if they are on top of $UPSTREAM.
+'
+. ./test-lib.sh
+
+. ../lib-rebase.sh
+
+# Set up branches like this:
+# A1---B1---E1---F1---G1
+#  \    \             /
+#   \    \--C1---D1--/
+#    H1
+
+test_expect_success 'setup' '
+	test_commit A1 &&
+	test_commit B1 &&
+	test_commit C1 &&
+	test_commit D1 &&
+	git reset --hard B1 &&
+	test_commit E1 &&
+	test_commit F1 &&
+	test_merge G1 D1 &&
+	git reset --hard A1 &&
+	test_commit H1
+'
+
+# Now rebase merge G1 from both branches' base B1, both should move:
+# A1---B1---E1---F1---G1
+#  \    \             /
+#   \    \--C1---D1--/
+#    \
+#     H1---E2---F2---G2
+#      \             /
+#       \--C2---D2--/
+
+test_expect_success 'rebase from B1 onto H1' '
+	git checkout G1 &&
+	git rebase -p --onto H1 B1 &&
+	test "$(git rev-parse HEAD^1^1^1)" = "$(git rev-parse H1)" &&
+	test "$(git rev-parse HEAD^2^1^1)" = "$(git rev-parse H1)"
+'
+
+# On the other hand if rebase from E1 which is within one branch,
+# then the other branch stays:
+# A1---B1---E1---F1---G1
+#  \    \             /
+#   \    \--C1---D1--/
+#    \             \
+#     H1-----F3-----G3
+
+test_expect_success 'rebase from E1 onto H1' '
+	git checkout G1 &&
+	git rebase -p --onto H1 E1 &&
+	test "$(git rev-parse HEAD^1^1)" = "$(git rev-parse H1)" &&
+	test "$(git rev-parse HEAD^2)" = "$(git rev-parse D1)"
+'
+
+# And the same if we rebase from a commit in the second-parent branch.
+# A1---B1---E1---F1----G1
+#  \    \          \   /
+#   \    \--C1---D1-\-/
+#    \               \
+#     H1------D3------G4
+
+test_expect_success 'rebase from C1 onto H1' '
+	git checkout G1 &&
+	git rev-list --first-parent --pretty=oneline C1..G1 &&
+	git rebase -p --onto H1 C1 &&
+	test "$(git rev-parse HEAD^2^1)" = "$(git rev-parse H1)" &&
+	test "$(git rev-parse HEAD^1)" = "$(git rev-parse F1)"
+'
+
+test_done
-- 
1.6.3.1.499.ge7b8da
