From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH] 3way still has D/F conflict problems...
Date: Mon, 23 Jul 2007 00:22:51 -0700
Message-ID: <7vejizmvn8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 09:22:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICsFt-0003BF-BU
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 09:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbXGWHWx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 03:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbXGWHWx
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 03:22:53 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:32886 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbXGWHWw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 03:22:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070723072252.PEWX1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Jul 2007 03:22:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SvNr1X00A1kojtg0000000; Mon, 23 Jul 2007 03:22:51 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53402>

The four commit series starting at 4c4caaf fixed a few D/F
conflict case in merge recursive.

  4c4caaf... Treat D/F conflict entry more carefully in unpack-tree...
  ac7f0f4... merge-recursive: do not barf on "to be removed" entries.
  4d50895... merge-recursive: handle D/F conflict case more carefully.
  885b981... t3030: merge-recursive backend test.

However this ended up regressed the following case (don't bother
bisecting, it will point at 4c4caaf).

The test case starts with a tree with a directory at D/,
one branch (master) modifies files in it, while the other branch
(side) makes a bunch of rename and has a blob at D.A, D, and D0C

Yes, this does not trigger if you change D.A to DxA (anything
that does not sort before D/ in the index).

Anybody interested in figuring out how to fix unpack-trees.c
without breaking the problem the above series fixed?

---

 t/t3031-df-3way.sh |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100755 t/t3031-df-3way.sh

diff --git a/t/t3031-df-3way.sh b/t/t3031-df-3way.sh
new file mode 100755
index 0000000..42548d2
--- /dev/null
+++ b/t/t3031-df-3way.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+
+test_description='D/F conflicting threeway merge'
+
+. ./test-lib.sh
+
+fill () {
+	cnt="$1"
+	shift
+	while test "$cnt" -ge 0
+	do
+		cnt=$(( $cnt - 1 ))
+		for line
+		do
+			echo "$line"
+		done
+	done
+}
+
+T=D
+
+test_expect_success 'setup' '
+
+	mkdir D &&
+	fill 50 "Tis true without lying, certain & most true." >D/A &&
+	fill 50 "The Sun is its father, the moon its mother," >D/B &&
+	fill 50 "the wind hath carried it in its belly, the earth its nourse." >D/C &&
+	git add D/A D/B D/C &&
+	test_tick &&
+	git commit -m "Initial" &&
+
+	git tag initial &&
+	git branch side &&
+
+	echo "It has the Sun for father and the Moon for mother:" >>D/B &&
+	test_tick &&
+	git commit -a -m "master changes in-place" &&
+
+	git checkout side &&
+	echo "Truth! Certainty! That in which there is no doubt!" >D.A &&
+	cat D/A >>D.A &&
+	echo "Its father is the Sun and its mother the Moon." >B &&
+	cat D/B >>B &&
+	mv D/C D0C &&
+	rm -rf D &&
+	mv B $T &&
+	git add D.A $T D0C &&
+	test_tick &&
+	git commit -a -m "side moves and makes changes"
+'
+
+test_expect_success 'threeway' '
+
+	git read-tree -m initial side master
+
+'
+
+test_done
