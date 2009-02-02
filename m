From: Keith Cascio <keith@cs.ucla.edu>
Subject: [PATCH v2 2/2] Test functionality of new config variable "diff.primer"
Date: Mon,  2 Feb 2009 10:20:55 -0800
Message-ID: <1233598855-1088-3-git-send-email-keith@cs.ucla.edu>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu>
 <1233598855-1088-2-git-send-email-keith@cs.ucla.edu>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 19:58:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU40F-0001vp-Hw
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 19:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855AbZBBS5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 13:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbZBBS5N
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 13:57:13 -0500
Received: from Sensitivity.CS.UCLA.EDU ([131.179.176.150]:41656 "EHLO
	sensitivity.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbZBBS5N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 13:57:13 -0500
Received: from sensitivity.cs.ucla.edu (localhost.localdomain [127.0.0.1])
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8) with ESMTP id n12It4XZ001226;
	Mon, 2 Feb 2009 10:55:04 -0800
Received: (from keith@localhost)
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8/Submit) id n12It4Cj001225;
	Mon, 2 Feb 2009 10:55:04 -0800
X-Mailer: git-send-email 1.6.1
In-Reply-To: <1233598855-1088-2-git-send-email-keith@cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108107>

Test functionality of new config variable "diff.primer"

Signed-off-by: Keith Cascio <keith@cs.ucla.edu>
---
 t/t4035-diff-primer.sh |  129 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 129 insertions(+), 0 deletions(-)
 create mode 100755 t/t4035-diff-primer.sh

diff --git a/t/t4035-diff-primer.sh b/t/t4035-diff-primer.sh
new file mode 100755
index 0000000..c33911c
--- /dev/null
+++ b/t/t4035-diff-primer.sh
@@ -0,0 +1,129 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Keith G. Cascio
+#
+# based on t4015-diff-whitespace.sh by Johannes E. Schindelin
+#
+
+test_description='Ensure diff engine honors config variable "diff.primer".
+
+'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
+
+tr 'Q' '\015' << EOF > x
+whitespace at beginning
+whitespace change
+whitespace in the middle
+whitespace at end
+unchanged line
+CR at endQ
+EOF
+
+git add x
+git commit -m '1.0' >/dev/null 2>&1
+
+tr '_' ' ' << EOF > x
+	whitespace at beginning
+whitespace 	 change
+white space in the middle
+whitespace at end__
+unchanged line
+CR at end
+EOF
+
+test_expect_success 'ensure diff.primer born empty' '
+[ -z $(git config --get diff.primer) ]
+'
+
+tr 'Q_' '\015 ' << EOF > expect_noprimer
+diff --git a/x b/x
+index d99af23..8b32fb5 100644
+--- a/x
++++ b/x
+@@ -1,6 +1,6 @@
+-whitespace at beginning
+-whitespace change
+-whitespace in the middle
+-whitespace at end
++	whitespace at beginning
++whitespace 	 change
++white space in the middle
++whitespace at end__
+ unchanged line
+-CR at endQ
++CR at end
+EOF
+git diff > out
+test_expect_success 'test git-diff with empty value of diff.primer' 'test_cmp expect_noprimer out'
+
+git config diff.primer '-w'
+
+test_expect_success 'ensure diff.primer value set' '
+[ $(git config --get diff.primer) = "-w" ]
+'
+
+git diff --no-primer > out
+test_expect_success 'test git-diff --no-primer' 'test_cmp expect_noprimer out'
+git diff-files -p > out
+test_expect_success 'ensure diff-files unaffected by diff.primer' 'test_cmp expect_noprimer out'
+git diff-index -p HEAD > out
+test_expect_success 'ensure diff-index unaffected by diff.primer' 'test_cmp expect_noprimer out'
+
+cat << EOF > expect_primer
+diff --git a/x b/x
+index d99af23..8b32fb5 100644
+EOF
+git diff > out
+test_expect_success 'test git-diff with diff.primer = -w' 'test_cmp expect_primer out'
+git diff-files -p --primer > out
+test_expect_success 'ensure diff-files honors --primer' 'test_cmp expect_primer out'
+git diff-index -p --primer HEAD > out
+test_expect_success 'ensure diff-index honors --primer' 'test_cmp expect_primer out'
+
+git add x
+git commit -m 'whitespace changes' >/dev/null 2>&1
+
+git config diff.primer '-w --color'
+
+tr 'Q_' '\015 ' << EOF > expect
+Subject: [PATCH] whitespace changes
+
+---
+ x |   10 +++++-----
+ 1 files changed, 5 insertions(+), 5 deletions(-)
+
+diff --git a/x b/x
+index d99af23..8b32fb5 100644
+--- a/x
++++ b/x
+@@ -1,6 +1,6 @@
+-whitespace at beginning
+-whitespace change
+-whitespace in the middle
+-whitespace at end
++	whitespace at beginning
++whitespace 	 change
++white space in the middle
++whitespace at end__
+ unchanged line
+-CR at endQ
++CR at end
+--_
+EOF
+
+git format-patch --stdout HEAD^..HEAD 2>&1 | sed -re '1,3d;$d' | sed -re '$d' > out
+test_expect_success 'ensure format-patch unaffected by diff.primer' 'test_cmp expect out'
+
+git add x
+git commit -m '2.0' >/dev/null 2>&1
+
+git config diff.primer '-w'
+
+git diff-tree -p -r          HEAD^ HEAD > out
+test_expect_success 'ensure diff-tree unaffected by diff.primer' 'test_cmp expect_noprimer out'
+git diff-tree -p -r --primer HEAD^ HEAD > out
+test_expect_success 'ensure diff-tree honors --primer' 'test_cmp expect_primer out'
+
+test_done
+
-- 
1.6.1
