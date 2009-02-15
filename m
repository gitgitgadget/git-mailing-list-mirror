From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 4/8] Test log --graph
Date: Sun, 15 Feb 2009 23:25:41 +0100
Message-ID: <708e8ea6f799b25674cd1b1c6f9f3084b3156dd0.1234736374.git.trast@student.ethz.ch>
References: <cover.1234736374.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 23:28:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYpSv-0004VH-2j
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 23:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566AbZBOW0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 17:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753519AbZBOW0I
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 17:26:08 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:11608 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752703AbZBOW0F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 17:26:05 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 23:25:55 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 23:25:54 +0100
X-Mailer: git-send-email 1.6.2.rc0.335.g1a2b
In-Reply-To: <cover.1234736374.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 15 Feb 2009 22:25:54.0506 (UTC) FILETIME=[5DADBAA0:01C98FBC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110074>

So far there were no tests checking that log --graph actually works.

Note that the tests strip trailing whitespace, as the current --graph
emits trailing whitespace on lines that do not contain anything but
graph lines.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t4202-log.sh |  148 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 148 insertions(+), 0 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 7b976ee..93966f7 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -134,5 +134,153 @@ test_expect_success 'log --grep -i' '
 	test_cmp expect actual
 '
 
+cat > expect <<EOF
+* Second
+* sixth
+* fifth
+* fourth
+* third
+* second
+* initial
+EOF
+
+test_expect_success 'simple log --graph' '
+	git log --graph --pretty=tformat:%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'set up merge history' '
+	git checkout -b side HEAD~4 &&
+	test_commit side-1 1 1 &&
+	test_commit side-2 2 2 &&
+	git checkout master &&
+	git merge side
+'
+
+cat > expect <<\EOF
+*   Merge branch 'side'
+|\
+| * side-2
+| * side-1
+* | Second
+* | sixth
+* | fifth
+* | fourth
+|/
+* third
+* second
+* initial
+EOF
+
+test_expect_success 'log --graph with merge' '
+	git log --graph --date-order --pretty=tformat:%s |
+		sed "s/ *$//" >actual &&
+	test_cmp expect actual
+'
+
+cat > expect <<\EOF
+*   commit master
+|\  Merge: A B
+| | Author: A U Thor <author@example.com>
+| |
+| |     Merge branch 'side'
+| |
+| * commit side
+| | Author: A U Thor <author@example.com>
+| |
+| |     side-2
+| |
+| * commit tags/side-1
+| | Author: A U Thor <author@example.com>
+| |
+| |     side-1
+| |
+* | commit master~1
+| | Author: A U Thor <author@example.com>
+| |
+| |     Second
+| |
+* | commit master~2
+| | Author: A U Thor <author@example.com>
+| |
+| |     sixth
+| |
+* | commit master~3
+| | Author: A U Thor <author@example.com>
+| |
+| |     fifth
+| |
+* | commit master~4
+|/  Author: A U Thor <author@example.com>
+|
+|       fourth
+|
+* commit tags/side-1~1
+| Author: A U Thor <author@example.com>
+|
+|     third
+|
+* commit tags/side-1~2
+| Author: A U Thor <author@example.com>
+|
+|     second
+|
+* commit tags/side-1~3
+  Author: A U Thor <author@example.com>
+
+      initial
+EOF
+
+test_expect_success 'log --graph with full output' '
+	git log --graph --date-order --pretty=short |
+		git name-rev --name-only --stdin |
+		sed "s/Merge:.*/Merge: A B/;s/ *$//" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'set up more tangled history' '
+	git checkout -b tangle HEAD~6 &&
+	test_commit tangle-a tangle-a a &&
+	git merge master~3 &&
+	git merge side~1 &&
+	git checkout master &&
+	git merge tangle
+'
+
+cat > expect <<\EOF
+*   Merge branch 'tangle'
+|\
+| *   Merge branch 'side' (early part) into tangle
+| |\
+| * \   Merge branch 'master' (early part) into tangle
+| |\ \
+| * | | tangle-a
+* | | |   Merge branch 'side'
+|\ \ \ \
+| * | | | side-2
+| | | |/
+| | |/|
+| |/| |
+| * | | side-1
+* | | | Second
+* | | | sixth
+| | |/
+| |/|
+|/| |
+* | | fifth
+* | | fourth
+|/ /
+* | third
+|/
+* second
+* initial
+EOF
+
+test_expect_success 'log --graph with merge' '
+	git log --graph --date-order --pretty=tformat:%s |
+		sed "s/ *$//" >actual &&
+	test_cmp expect actual
+'
+
 test_done
 
-- 
1.6.2.rc0.335.g1a2b
