From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [BUG/TEST] git-svn: fetch fails with deleted tag
Date: Fri,  6 Aug 2010 22:36:55 -0700
Message-ID: <1281159415-60900-1-git-send-email-ddkilzer@kilzer.net>
Cc: Eric Wong <normalperson@yhbt.net>,
	"David D. Kilzer" <ddkilzer@kilzer.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 07 07:37:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ohc5j-0002rc-OR
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 07:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab0HGFhC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Aug 2010 01:37:02 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:56375 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab0HGFhA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 01:37:00 -0400
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out3.apple.com (Postfix) with ESMTP id E47F4A1F9341;
	Fri,  6 Aug 2010 22:36:59 -0700 (PDT)
X-AuditID: 1180711d-b7c37ae0000027a8-9b-4c5cf0fbb1af
Received: from pwmerge.apple.com (pwmerge.apple.com [17.202.36.35])
	by relay13.apple.com (Apple SCV relay) with SMTP id 20.6A.10152.BF0FC5C4; Fri,  6 Aug 2010 22:36:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.49.g98551
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152844>

The attached test fails when fetching the svn repo:

    Checksum mismatch: ChangeLog 065854....
    expected: ce771b....
         got: 9563fd....

The issue seems to be that the tag was created, deleted and then
recreated from the same source revision but at different paths.

Any suggestions for how to work around or fix this would be
greatly appreciated.

Ironically, I made the original commits in the svn repo that I'm
trying to fetch.  And yes, the extra "trunk" directory on the
branch was intended--it's the style that was agreed upon at the
time.

Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>
---
 t/t9199-git-svn-deleted-tag.sh |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)
 create mode 100755 t/t9199-git-svn-deleted-tag.sh

diff --git a/t/t9199-git-svn-deleted-tag.sh b/t/t9199-git-svn-deleted-tag.sh
new file mode 100755
index 0000000..059cccd
--- /dev/null
+++ b/t/t9199-git-svn-deleted-tag.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description='git svn fetch with deleted tag'
+
+. ./lib-git-svn.sh
+
+test_expect_success 'setup svn repo' '
+	mkdir -p import/trunk/SubDir &&
+	mkdir -p import/branches &&
+	mkdir -p import/tags &&
+	echo "base" > import/trunk/SubDir/ChangeLog &&
+	svn_cmd import -m "import for git svn" import "$svnrepo" &&
+	rm -rf import &&
+
+	svn_cmd mkdir --parents -m "create MyBranch directory" "$svnrepo/branches/MyBranch" &&
+	svn_cmd cp -m "create branch MyBranch" "$svnrepo/trunk" "$svnrepo/branches/MyBranch/trunk" &&
+
+	svn_cmd co "$svnrepo/trunk" svn_project &&
+	cd svn_project &&
+
+	echo "trunk change" >> SubDir/ChangeLog &&
+	svn_cmd ci -m "trunk change" SubDir/ChangeLog &&
+
+	svn_cmd switch "$svnrepo/branches/MyBranch/trunk" &&
+	echo "branch change" >> SubDir/ChangeLog &&
+	svn_cmd ci -m "branch change" SubDir/ChangeLog &&
+
+	cd .. &&
+	svn_cmd cp -m "create MyTag attempt 1" -r5 "$svnrepo/trunk/SubDir" "$svnrepo/tags/MyTag" &&
+	svn_cmd rm -m "delete MyTag attempt 1" "$svnrepo/tags/MyTag" &&
+	svn_cmd cp -m "create MyTag attempt 2" -r5 "$svnrepo/branches/MyBranch/trunk/SubDir" "$svnrepo/tags/MyTag"
+'
+
+test_expect_success 'fetch with deleted tag' '
+	git svn init --stdlayout "$svnrepo" git_project &&
+	cd git_project &&
+	git svn fetch
+'
+
+test_done
-- 
1.7.2.1.49.g98551
