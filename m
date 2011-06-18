From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/3] git-svn: Demonstrate a bug with root commits in mergeinfo ranges
Date: Sat, 18 Jun 2011 08:47:58 +0200
Message-ID: <1308379680-17188-2-git-send-email-mhagger@alum.mit.edu>
References: <1308379680-17188-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, bert.wesarg@googlemail.com,
	normalperson@yhbt.net, git@drmicha.warpmail.net,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 18 08:49:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXpLC-0001ll-Gy
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 08:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856Ab1FRGtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 02:49:05 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:37962 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab1FRGtC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 02:49:02 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BE9EF0.dip.t-dialin.net [84.190.158.240])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p5I6mO8h000405;
	Sat, 18 Jun 2011 08:48:54 +0200
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1308379680-17188-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175965>

If a svn:mergeinfo range starts at a commit that was converted as a
git root commit (e.g., r1 or a branch that was created out of thin
air), then there is an error when git-svn tries to run

    git rev-list "$bottom_commit^..$top_commit"

because $bottom_commit (the git commit corresponding to r1) has no
parent.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t9159-git-svn-no-parent-mergeinfo.sh |   33 ++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)
 create mode 100755 t/t9159-git-svn-no-parent-mergeinfo.sh

diff --git a/t/t9159-git-svn-no-parent-mergeinfo.sh b/t/t9159-git-svn-no-parent-mergeinfo.sh
new file mode 100755
index 0000000..9472de3
--- /dev/null
+++ b/t/t9159-git-svn-no-parent-mergeinfo.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+test_description='git svn handling of root commits in merge ranges'
+. ./lib-git-svn.sh
+
+test_expect_failure 'test handling of root commits in merge ranges' '
+	mkdir -p init/trunk init/branches init/tags &&
+	echo "r1" > init/trunk/file.txt &&
+	svn_cmd import -m "initial import" init "$svnrepo" &&
+	svn_cmd co "$svnrepo" tmp &&
+	(
+		cd tmp &&
+		echo "r2" > trunk/file.txt &&
+		svn_cmd commit -m "Modify file.txt on trunk" &&
+		svn_cmd cp trunk@1 branches/a &&
+		svn_cmd commit -m "Create branch a from trunk r1" &&
+		svn_cmd propset svn:mergeinfo /trunk:1-2 branches/a &&
+		svn_cmd commit -m "Fake merge of trunk r2 into branch a" &&
+		mkdir branches/b &&
+		echo "r5" > branches/b/file2.txt &&
+		svn_cmd add branches/b &&
+		svn_cmd commit -m "Create branch b from thin air" &&
+		echo "r6" > branches/b/file2.txt &&
+		svn_cmd commit -m "Modify file2.txt on branch b" &&
+		svn_cmd cp branches/b@5 branches/c &&
+		svn_cmd commit -m "Create branch c from branch b r5" &&
+		svn_cmd propset svn:mergeinfo /branches/b:5-6 branches/c &&
+		svn_cmd commit -m "Fake merge of branch b r6 into branch c"
+	) &&
+	git svn init -s "$svnrepo" &&
+	git svn fetch
+	'
+
+test_done
-- 
1.7.5.4
