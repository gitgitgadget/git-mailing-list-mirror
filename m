From: Greg Price <price@ksplice.com>
Subject: [PATCH] Fix rebase -p --onto
Date: Thu, 16 Jul 2009 19:00:32 -0400
Message-ID: <20090716230031.GM7503@vinegar-pot.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio Hamano <gitster@pobox.com>,
	Stephen Haberman <stephen@exigencecorp.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 01:00:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRZwS-0007ZH-Iu
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 01:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933532AbZGPXAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 19:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933525AbZGPXAh
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 19:00:37 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:54381 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933524AbZGPXAg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jul 2009 19:00:36 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n6GN0Wqu028704;
	Thu, 16 Jul 2009 19:00:33 -0400 (EDT)
Received: from localhost (VINEGAR-POT.MIT.EDU [18.181.0.51])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n6GN0WQE000505;
	Thu, 16 Jul 2009 19:00:32 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123434>

In a rebase with --onto, the correct test for whether we can skip
rewriting a commit is if it is already on top of $ONTO, not $UPSTREAM.
Without --onto, this distinction does not exist and the behavior does
not change.


In the situation

 X---o---o---o---M
  \             /
   x---x---x---x

 Y

if we try to move the branches merged at M from their base on X to be
based on Y, so as to get

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
Cc: Stephen Haberman <stephen@exigencecorp.com>
---

 git-rebase--interactive.sh      |    2 +-
 t/t3414-rebase-preserve-onto.sh |   48 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletions(-)
 create mode 100644 t/t3414-rebase-preserve-onto.sh

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
new file mode 100644
index 0000000..ee29517
--- /dev/null
+++ b/t/t3414-rebase-preserve-onto.sh
@@ -0,0 +1,48 @@
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
+# A1---B1---D1---E1
+#  \    \        /
+#   \    \--C1--/
+#    F1
+
+test_expect_success 'setup' '
+	test_commit A1 &&
+	test_commit B1 &&
+	test_commit C1 &&
+	git reset --hard B1 &&
+	test_commit D1 &&
+	test_merge E1 C1 &&
+	git reset --hard A1 &&
+	test_commit F1
+'
+
+# Now rebase E1 from B1 onto F1, expect to get this:
+# A1---B1---D1---E1
+#  \    \        /
+#   \    \--C1--/
+#    \
+#     F1---D2---E2
+#      \        /
+#       \--C2--/
+
+test_expect_success 'rebase from B1 onto F1' '
+	git checkout E1 &&
+	git rebase -p --onto F1 B1 &&
+	test "$(git rev-parse HEAD^1^1)" = "$(git rev-parse F1)" &&
+	test "$(git rev-parse HEAD^2^1)" = "$(git rev-parse F1)"
+'
+
+test_done
-- 
1.6.4.rc0.19.gbedf
