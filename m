From: Greg Price <price@ksplice.com>
Subject: Re: [PATCH] Fix rebase -p --onto
Date: Fri, 17 Jul 2009 12:48:46 -0400
Message-ID: <20090717164845.GL7878@vinegar-pot.mit.edu>
References: <20090716230031.GM7503@vinegar-pot.mit.edu> <4A601C59.8040108@viscovery.net> <7vk52767el.fsf@alter.siamese.dyndns.org> <4A6038E8.1090402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephen Haberman <stephen@exigencecorp.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 17 18:49:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRqcF-0000Fd-CK
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 18:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbZGQQsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 12:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbZGQQsu
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 12:48:50 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:55773 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964950AbZGQQsu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jul 2009 12:48:50 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n6HGmls1019017;
	Fri, 17 Jul 2009 12:48:47 -0400 (EDT)
Received: from localhost (VINEGAR-POT.MIT.EDU [18.181.0.51])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n6HGmk65013063;
	Fri, 17 Jul 2009 12:48:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4A6038E8.1090402@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123476>

On Fri, Jul 17, 2009 at 10:40:08AM +0200, Johannes Sixt wrote:
> I have used rebase -i -p in the past to rewrite history that involves
> merges of topic branches like this:
> 
>   ---------Y--M--M--F     <-- master
>              /  /
>   ----a--a--a  /
>               /
>   --b--b--b--b
> 
> where F is a fixup that I want to insert between Y and M, and I thought
> rebase -i -p was intended for this use-case.

I don't believe rebase -i -p has ever worked with reordering commits.
It certainly doesn't now, as the tests below demonstrate both for your
case and for the most trivial possible situation without even any merges.

This is not a mere coding error, as in the general case with a hairy
set of merges it's not clear what an arbitrary reordering of the
commits would even mean.  To really fix it will require a richer TODO
file format, as in the sequencer or the discussion Johannes Schindelin
started in January about a rebase -i -p rework.


In any case, this has nothing to do with my patch to fix -p --onto,
which is a no-op when --onto is not used.  You want `git rebase -i -p Y`,
and the generation of the TODO file correctly gives you M, M, F.
It's the execution of the TODO file you give back, with F, M, M,
that does not do what you want.

Cheers,
Greg



>From 185fa9da4caee5a0a96105e60269d02ec832e876 Mon Sep 17 00:00:00 2001
From: Greg Price <price@ksplice.com>
Date: Fri, 17 Jul 2009 11:55:11 -0400
Subject: [PATCH] Add failing test for commit reordering in rebase -i -p

Signed-off-by: Greg Price <price@ksplice.com>
---
 t/t3411-rebase-preserve-around-merges.sh |   59 ++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/t/t3411-rebase-preserve-around-merges.sh b/t/t3411-rebase-preserve-around-merges.sh
index 6533505..1759a98 100755
--- a/t/t3411-rebase-preserve-around-merges.sh
+++ b/t/t3411-rebase-preserve-around-merges.sh
@@ -71,4 +71,63 @@ test_expect_success 'rebase two levels of merge' '
 	test "$(git rev-parse HEAD^2^1^1)" = "$(git rev-parse HEAD^2^2^1)"
 '
 
+# Reorder commits while using -p.  Basic prerequisite for the next test
+# to have a hope of working.
+#
+# a---b---c
+#
+# want
+#
+# a---c---b
+
+test_expect_failure 'reorder with -p' '
+	test_commit a &&
+	test_commit b &&
+	test_commit c &&
+	FAKE_LINES="2 1" git rebase -i -p HEAD~2 &&
+	test "$(git rev-parse HEAD~2)" = "$(git rev-parse a)" &&
+	git log -n1 --pretty=format:%s HEAD | grep b &&
+	git log -n1 --pretty=format:%s HEAD^ | grep c
+'
+
+
+# Reorder a commit to before a merge.  From
+#
+# R---x---Ma--Mb--F
+#  \     /   /
+#   a1--a2  /
+#    \     /
+#     b1--b2
+#
+# we get
+#
+# R---x---F*--Ma*--Mb*
+#  \         /    /
+#   a1--a2--/    /
+#    \          /
+#     b1--b2---/
+
+test_expect_failure 'rewrite to before merge' '
+	test_commit R &&
+	test_commit a1 &&
+	test_commit b1 &&
+	test_commit b2 &&
+	git reset --hard a1 &&
+	test_commit a2 &&
+	git reset --hard R &&
+	test_commit x &&
+	test_merge Ma a2 &&
+	test_merge Mb b2 &&
+	test_commit F &&
+
+	FAKE_LINES="3 1 2" git rebase -i -p x &&
+	git log --pretty=oneline HEAD && echo &&
+	git log --pretty=oneline HEAD^2 && echo &&
+	git log --pretty=oneline HEAD^^2 && echo &&
+	git log --pretty=oneline HEAD^^ && echo &&
+	test "$(git rev-parse HEAD^2)" = "$(git rev-parse b2)" &&
+	test "$(git rev-parse HEAD^1^2)" = "$(git rev-parse a2)" &&
+	test "$(git rev-parse HEAD~3)" = "$(git rev-parse x)"
+'
+
 test_done
-- 
1.6.3.1.499.ge7b8da
