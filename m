From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 4/8] Test log --graph
Date: Thu, 19 Feb 2009 12:13:38 +0100
Message-ID: <a6cc1b8844a60fc5284ac8e6b93658a041f6bfeb.1235041345.git.trast@student.ethz.ch>
References: <cover.1235041345.git.trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 12:16:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La6sw-0000Pm-Ow
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 12:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbZBSLOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 06:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753155AbZBSLOF
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 06:14:05 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:16533 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752906AbZBSLOC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 06:14:02 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 12:13:53 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 12:13:52 +0100
X-Mailer: git-send-email 1.6.2.rc1.266.gce6c4
In-Reply-To: <cover.1235041345.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 19 Feb 2009 11:13:52.0602 (UTC) FILETIME=[259A73A0:01C99283]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110676>

So far there were no tests checking that log --graph actually works.

Note that the tests strip trailing whitespace, as the current --graph
emits trailing whitespace on lines that do not contain anything but
graph lines.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Same as v1.

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
1.6.2.rc1.266.gce6c4
