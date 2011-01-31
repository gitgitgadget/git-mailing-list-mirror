From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t6004: add pathspec globbing test for log family
Date: Mon, 31 Jan 2011 12:09:53 -0800
Message-ID: <7vei7s6dim.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 31 21:10:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk05C-0000Jd-3o
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 21:10:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955Ab1AaUKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 15:10:19 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734Ab1AaUKD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 15:10:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 85CB43B72;
	Mon, 31 Jan 2011 15:10:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=MYu/
	0FGvzw0AlU4aVJwaDmJU7Dk=; b=qg9P+tbZ+3y5UvTHm26BrbG31t9MqnV+YIJ3
	QwQ0dft8L7XeiI+TNcOhRZTv9vrAvo2zxfyr7lZy0MmTHZGBR0p0xvH06UB0cXt5
	hleYgp5IOdz9DvUG0q+HvZjYa3VmhtQxLVUBf6D5oN5vNc2CUFcPDE+y9rd7J+uo
	dQGvSAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	pwT+Tkd+h9I+kJRDSSIbZ+uD2u2iiGT1M5IyPDUm0GMiOk6W/kfRxVm5ZQkD2BX3
	n0bEGL13uO03g8AryweQGL0Swt4ypR25tK7PRWIwkEgzby1HwcCsvWS7XiPalULZ
	m7z+3YzRndRNCnLvTmZf8GuUYybfOt01h9QBj/b6RPo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 646843B71;
	Mon, 31 Jan 2011 15:10:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1F9EC3B70; Mon, 31 Jan 2011
 15:10:47 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3373BEEC-2D76-11E0-85CD-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165744>

Earlier e10cb0f (tree_entry_interesting(): support wildcard matching,
2010-12-15) and b3d4b34 (tree_entry_interesting(): optimize wildcard
matching when base is matched, 2010-12-15) added tests for globbing
support for diff-tree plumbing.  This is a follow-up to update the test
for revision traversal and path pruning machinery for the same topic.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6004-rev-list-path-optim.sh |   69 +++++++++++++++++++++++++++++++++-------
 1 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/t/t6004-rev-list-path-optim.sh b/t/t6004-rev-list-path-optim.sh
index 5dabf1c..3e8c42e 100755
--- a/t/t6004-rev-list-path-optim.sh
+++ b/t/t6004-rev-list-path-optim.sh
@@ -1,51 +1,96 @@
 #!/bin/sh
 
-test_description='git rev-list trivial path optimization test'
+test_description='git rev-list trivial path optimization test
+
+   d/z1
+   b0                             b1
+   o------------------------*----o master
+  /                        /
+ o---------o----o----o----o side
+ a0        c0   c1   a1   c2
+ d/f0      d/f1
+ d/z0
+
+'
 
 . ./test-lib.sh
 
 test_expect_success setup '
-echo Hello > a &&
-git add a &&
-git commit -m "Initial commit" a &&
-initial=$(git rev-parse --verify HEAD)
+	echo Hello >a &&
+	mkdir d &&
+	echo World >d/f &&
+	echo World >d/z &&
+	git add a d &&
+	test_tick &&
+	git commit -m "Initial commit" &&
+	git rev-parse --verify HEAD &&
+	git tag initial
 '
 
 test_expect_success path-optimization '
-    commit=$(echo "Unchanged tree" | git commit-tree "HEAD^{tree}" -p HEAD) &&
-    test $(git rev-list $commit | wc -l) = 2 &&
-    test $(git rev-list $commit -- . | wc -l) = 1
+	test_tick &&
+	commit=$(echo "Unchanged tree" | git commit-tree "HEAD^{tree}" -p HEAD) &&
+	test $(git rev-list $commit | wc -l) = 2 &&
+	test $(git rev-list $commit -- . | wc -l) = 1
 '
 
 test_expect_success 'further setup' '
 	git checkout -b side &&
 	echo Irrelevant >c &&
-	git add c &&
+	echo Irrelevant >d/f &&
+	git add c d/f &&
+	test_tick &&
 	git commit -m "Side makes an irrelevant commit" &&
+	git tag side_c0 &&
 	echo "More Irrelevancy" >c &&
 	git add c &&
+	test_tick &&
 	git commit -m "Side makes another irrelevant commit" &&
 	echo Bye >a &&
 	git add a &&
+	test_tick &&
 	git commit -m "Side touches a" &&
-	side=$(git rev-parse --verify HEAD) &&
+	git tag side_a1 &&
 	echo "Yet more Irrelevancy" >c &&
 	git add c &&
+	test_tick &&
 	git commit -m "Side makes yet another irrelevant commit" &&
 	git checkout master &&
 	echo Another >b &&
-	git add b &&
+	echo Munged >d/z &&
+	git add b d/z &&
+	test_tick &&
 	git commit -m "Master touches b" &&
+	git tag master_b0 &&
 	git merge side &&
 	echo Touched >b &&
 	git add b &&
+	test_tick &&
 	git commit -m "Master touches b again"
 '
 
 test_expect_success 'path optimization 2' '
-	( echo "$side"; echo "$initial" ) >expected &&
+	git rev-parse side_a1 initial >expected &&
 	git rev-list HEAD -- a >actual &&
 	test_cmp expected actual
 '
 
+test_expect_success 'pathspec with leading path' '
+	git rev-parse master^ master_b0 side_c0 initial >expected &&
+	git rev-list HEAD -- d >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'pathspec with glob (1)' '
+	git rev-parse master^ master_b0 side_c0 initial >expected &&
+	git rev-list HEAD -- "d/*" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'pathspec with glob (2)' '
+	git rev-parse side_c0 initial >expected &&
+	git rev-list HEAD -- "d/[a-m]*" >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.7.4.261.g705f2
