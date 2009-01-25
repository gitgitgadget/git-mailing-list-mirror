From: Keith Cascio <keith@cs.ucla.edu>
Subject: [PATCH v1 2/3] Test functionality of new config variable "diff.primer"
Date: Sun, 25 Jan 2009 09:30:56 -0800
Message-ID: <1232904657-31831-3-git-send-email-keith@cs.ucla.edu>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu>
 <1232904657-31831-2-git-send-email-keith@cs.ucla.edu>
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 18:44:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR92I-0006Ap-3K
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 18:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbZAYRnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 12:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753061AbZAYRnP
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 12:43:15 -0500
Received: from Sensitivity.CS.UCLA.EDU ([131.179.176.150]:34037 "EHLO
	sensitivity.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbZAYRnN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 12:43:13 -0500
X-Greylist: delayed 718 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Jan 2009 12:43:13 EST
Received: from sensitivity.cs.ucla.edu (localhost.localdomain [127.0.0.1])
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8) with ESMTP id n0PHW2TR031878;
	Sun, 25 Jan 2009 09:32:02 -0800
Received: (from keith@localhost)
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8/Submit) id n0PHW2nl031877;
	Sun, 25 Jan 2009 09:32:02 -0800
X-Mailer: git-send-email 1.6.1
In-Reply-To: <1232904657-31831-2-git-send-email-keith@cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107070>

Test functionality of new config variable "diff.primer"

Signed-off-by: Keith Cascio <keith@cs.ucla.edu>
---
 t/t4033-diff-primer.sh |  111 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 111 insertions(+), 0 deletions(-)
 create mode 100755 t/t4033-diff-primer.sh

diff --git a/t/t4033-diff-primer.sh b/t/t4033-diff-primer.sh
new file mode 100755
index 0000000..116d6ad
--- /dev/null
+++ b/t/t4033-diff-primer.sh
@@ -0,0 +1,111 @@
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
+test_expect_success 'ensure diff.primer begins with empty value' '
+[ -z $(git config --get diff.primer) ]
+'
+
+tr 'Q_' '\015 ' << EOF > expect
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
+test_expect_success 'test diff with empty value of diff.primer' 'test_cmp expect out'
+
+git config diff.primer '-w'
+
+test_expect_success 'ensure diff.primer value set' '
+[ $(git config --get diff.primer) = "-w" ]
+'
+
+git diff --no-primer > out
+test_expect_success 'test git diff --no-primer' 'test_cmp expect out'
+
+cat << EOF > expect
+diff --git a/x b/x
+index d99af23..8b32fb5 100644
+EOF
+git diff > out
+test_expect_success 'test with diff.primer = -w' 'test_cmp expect out'
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
+test_expect_success 'ensure git format-patch not affected by diff.primer' 'test_cmp expect out'
+
+test_done
+
-- 
1.6.1
