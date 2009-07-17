From: Greg Price <price@ksplice.com>
Subject: Re: [PATCH] Fix rebase -p --onto
Date: Fri, 17 Jul 2009 12:33:50 -0400
Message-ID: <20090717163350.GK7878@vinegar-pot.mit.edu>
References: <20090716230031.GM7503@vinegar-pot.mit.edu> <4A601C59.8040108@viscovery.net> <7vk52767el.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Stephen Haberman <stephen@exigencecorp.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 18:34:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRqNo-0002hu-38
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 18:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbZGQQd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 12:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbZGQQd4
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 12:33:56 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:52016 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964909AbZGQQd4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jul 2009 12:33:56 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n6HGXpSG010506;
	Fri, 17 Jul 2009 12:33:51 -0400 (EDT)
Received: from localhost (VINEGAR-POT.MIT.EDU [18.181.0.51])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n6HGXoTi006288;
	Fri, 17 Jul 2009 12:33:50 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vk52767el.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123474>

On Fri, Jul 17, 2009 at 01:27:46AM -0700, Junio C Hamano wrote:
> Hmm, if the original history were
> 
>  .---X---o---o---o---M
>   \                 /
>    x---x---x---x---x
> 
>      Y
> 
> and the rebase is about moving history leading to M since X on top of Y,
> I would actually have agreed that this
> 
>  .---X---o---o---o---M
>   \                 /
>    x---x---x---x---x
>                     \
>      Y---o'--o'--o'--M'
> 
> would be the right thing to do (IOW, I would agree with you).

Yes, I agree.


> Can the current code distinguish the two cases?

Yes.  Stephen's commit acc8559 already limits $TODO to the descendants
of the merge-bases of HEAD and UPSTREAM, which captures the
distinction here.  When we rebase from X, the merge-base is X, so only
that branch moves.  When we rebase from the base of both branches,
both branches should move.

I've added a test demonstrating this case to a revised version of the
patch, below.

Greg



>From dcab1103e14394364c15136823269416f8c56e97 Mon Sep 17 00:00:00 2001
From: Greg Price <price@ksplice.com>
Date: Thu, 16 Jul 2009 12:48:40 -0400
Subject: [PATCH] Fix rebase -p --onto

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
