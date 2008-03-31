From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] Add corner case tests for diff-index and diff-files
Date: Sun, 30 Mar 2008 17:28:05 -0700
Message-ID: <7vzlsfu48a.fsf@gitster.siamese.dyndns.org>
References: <200803290813.08419.chriscool@tuxfamily.org>
 <7v4panyduy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 31 02:29:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg7ti-0006W2-9d
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 02:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbYCaA2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 20:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbYCaA2X
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 20:28:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42511 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbYCaA2W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 20:28:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D83D42034;
	Sun, 30 Mar 2008 20:28:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 620B52030; Sun, 30 Mar 2008 20:28:14 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78537>

diff-index and diff-files can get confused in corner cases when an indexed
blob turns into something else in the work tree.  This patch adds tests to
expose such breakages.

The test is classified under t2XXX series instead of t4XXX series, because
the ultimate objective is to fix "add -u" (and "commit -a" that shares the
same issue).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t2201-add-update-typechange.sh |  140 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 140 insertions(+), 0 deletions(-)
 create mode 100755 t/t2201-add-update-typechange.sh

diff --git a/t/t2201-add-update-typechange.sh b/t/t2201-add-update-typechange.sh
new file mode 100755
index 0000000..75c440c
--- /dev/null
+++ b/t/t2201-add-update-typechange.sh
@@ -0,0 +1,140 @@
+#!/bin/sh
+
+test_description='more git add -u'
+
+. ./test-lib.sh
+
+_z40=0000000000000000000000000000000000000000
+
+test_expect_success setup '
+	>xyzzy &&
+	_empty=$(git hash-object --stdin <xyzzy) &&
+	>yomin &&
+	>caskly &&
+	ln -s frotz nitfol &&
+	mkdir rezrov &&
+	>rezrov/bozbar &&
+	git add caskly xyzzy yomin nitfol rezrov/bozbar &&
+
+	test_tick &&
+	git commit -m initial
+
+'
+
+test_expect_success modify '
+	rm -f xyzzy yomin nitfol caskly &&
+	# caskly disappears (not a submodule)
+	mkdir caskly &&
+	# nitfol changes from symlink to regular
+	>nitfol &&
+	# rezrov/bozbar disappears
+	rm -fr rezrov &&
+	ln -s xyzzy rezrov &&
+	# xyzzy disappears (not a submodule)
+	mkdir xyzzy &&
+	echo gnusto >xyzzy/bozbar &&
+	# yomin gets replaced with a submodule
+	mkdir yomin &&
+	>yomin/yomin &&
+	(
+		cd yomin &&
+		git init &&
+		git add yomin &&
+		git commit -m "sub initial"
+	) &&
+	yomin=$(GIT_DIR=yomin/.git git rev-parse HEAD) &&
+	# yonk is added and then turned into a submodule
+	# this should appear as T in diff-files and as A in diff-index
+	>yonk &&
+	git add yonk &&
+	rm -f yonk &&
+	mkdir yonk &&
+	>yonk/yonk &&
+	(
+		cd yonk &&
+		git init &&
+		git add yonk &&
+		git commit -m "sub initial"
+	) &&
+	yonk=$(GIT_DIR=yonk/.git git rev-parse HEAD) &&
+	# zifmia is added and then removed
+	# this should appear in diff-files but not in diff-index.
+	>zifmia &&
+	git add zifmia &&
+	rm -f zifmia &&
+	mkdir zifmia &&
+	{
+		git ls-tree -r HEAD |
+		sed -e "s/^/:/" -e "
+			/	caskly/{
+				s/	caskly/ $_z40 D&/
+				s/blob/000000/
+			}
+			/	nitfol/{
+				s/	nitfol/ $_z40 T&/
+				s/blob/100644/
+			}
+			/	rezrov.bozbar/{
+				s/	rezrov.bozbar/ $_z40 D&/
+				s/blob/000000/
+			}
+			/	xyzzy/{
+				s/	xyzzy/ $_z40 D&/
+				s/blob/000000/
+			}
+			/	yomin/{
+			    s/	yomin/ $_z40 T&/
+				s/blob/160000/
+			}
+		"
+	} >expect &&
+	{
+		cat expect
+		echo ":100644 160000 $_empty $_z40 T	yonk"
+		echo ":100644 000000 $_empty $_z40 D	zifmia"
+	} >expect-files &&
+	{
+		cat expect
+		echo ":000000 160000 $_z40 $_z40 A	yonk"
+	} >expect-index &&
+	{
+		echo "100644 $_empty 0	nitfol"
+		echo "160000 $yomin 0	yomin"
+		echo "160000 $yonk 0	yonk"
+	} >expect-final
+'
+
+test_expect_failure diff-files '
+	git diff-files --raw >actual &&
+	diff -u expect-files actual
+'
+
+test_expect_failure diff-index '
+	git diff-index --raw HEAD -- >actual &&
+	diff -u expect-index actual
+'
+
+test_expect_failure 'add -u' '
+	rm -f ".git/saved-index" &&
+	cp -p ".git/index" ".git/saved-index" &&
+	git add -u &&
+	git ls-files -s >actual &&
+	diff -u expect-final actual
+'
+
+test_expect_failure 'commit -a' '
+	if test -f ".git/saved-index"
+	then
+		rm -f ".git/index" &&
+		mv ".git/saved-index" ".git/index"
+	fi &&
+	git commit -m "second" -a &&
+	git ls-files -s >actual &&
+	diff -u expect-final actual &&
+	rm -f .git/index &&
+	git read-tree HEAD &&
+	git ls-files -s >actual &&
+	diff -u expect-final actual
+'
+
+test_done
-- 
1.5.5.rc2.131.g3d2f0
