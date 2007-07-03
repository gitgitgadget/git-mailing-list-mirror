From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] filter-branch: add a test for the commit removal example
Date: Tue, 3 Jul 2007 17:50:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707031749480.4071@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 03 18:51:32 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5lb8-0000BS-2F
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 18:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759351AbXGCQu2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 12:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758978AbXGCQu0
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 12:50:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:56000 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758339AbXGCQuY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 12:50:24 -0400
Received: (qmail invoked by alias); 03 Jul 2007 16:50:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 03 Jul 2007 18:50:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EjOo4unlEaO841cuSMmabGmfpb6XNurUv04PUtb
	YJDsnTamaSQLsK
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51517>


In the man page, there is an example which describes how to remove
single commits (although it keeps the changes which were not reverted
in the next non-removed commit). Better make sure that it works as
expected.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7003-filter-branch.sh |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 21f9bc5..451ac86 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -107,4 +107,39 @@ test_expect_success 'use index-filter to move into a subdirectory' '
 		  mv \$GIT_INDEX_FILE.new \$GIT_INDEX_FILE" directorymoved &&
 	test -z "$(git diff HEAD directorymoved:newsubdir)"'
 
+test_expect_success 'author information is preserved' '
+	: > i &&
+	git add i &&
+	test_tick &&
+	GIT_AUTHOR_NAME="B V Uips" git commit -m bvuips &&
+	git-filter-branch --msg-filter "cat; \
+			test \$GIT_COMMIT = $(git rev-parse master) && \
+			echo Hallo" \
+		preserved-author &&
+	test 1 = $(git rev-list --author="B V Uips" preserved-author | wc -l)
+'
+
+test_expect_success "remove a certain author's commits" '
+	echo i > i &&
+	test_tick &&
+	git commit -m i i &&
+	git-filter-branch --commit-filter "\
+		if [ \"\$GIT_AUTHOR_NAME\" = \"B V Uips\" ];\
+		then\
+			shift;\
+			while [ -n \"\$1\" ];\
+			do\
+				shift;\
+				echo \"\$1\";\
+				shift;\
+			done;\
+		else\
+			git commit-tree \"\$@\";\
+		fi" removed-author &&
+	cnt1=$(git rev-list master | wc -l) &&
+	cnt2=$(git rev-list removed-author | wc -l) &&
+	test $cnt1 -eq $(($cnt2 + 1)) &&
+	test 0 = $(git rev-list --author="B V Uips" removed-author | wc -l)
+'
+
 test_done
-- 
1.5.3.rc0.2637.g1dd84-dirty
