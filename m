From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 1/2] stash bug: stash can lose data in a file removed from the index
Date: Sat, 10 Apr 2010 19:14:00 +0100
Message-ID: <1270923241-14383-1-git-send-email-charles@hashpling.org>
References: <v2w918f64e01004101104xd4f1b4eciec01d2e87691ee72@mail.gmail.com>
Cc: Charles Bailey <charles@hashpling.org>
To: git@vger.kernel.org, khellls@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 10 20:34:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0fVv-0002Gq-SX
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 20:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122Ab0DJSee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 14:34:34 -0400
Received: from relay.pcl-ipout01.plus.net ([212.159.7.99]:31753 "EHLO
	relay.pcl-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752043Ab0DJSed (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 14:34:33 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAAJdwEvUnw4U/2dsb2JhbACbRnG5ZYUMBA
Received: from pih-relay08.plus.net ([212.159.14.20])
  by relay.pcl-ipout01.plus.net with ESMTP; 10 Apr 2010 19:14:27 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay08.plus.net with esmtp (Exim) id 1O0fCN-0007he-BP; Sat, 10 Apr 2010 19:14:27 +0100
Received: from charles by hashpling.plus.com with local (Exim 4.69)
	(envelope-from <charles@hashpling.org>)
	id 1O0fCM-0003mJ-Fl; Sat, 10 Apr 2010 19:14:26 +0100
X-Mailer: git-send-email 1.7.1.rc0.266.gf3d756
In-Reply-To: <v2w918f64e01004101104xd4f1b4eciec01d2e87691ee72@mail.gmail.com>
X-Plusnet-Relay: 0f5948e9a47a1976fe606a54c4884f03
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144573>

If a file is removed from the index and then modified in the working
tree then stash will discard the working tree file with no way to
recover the changes.

This can might be done in one of a number of ways.

git rm file
vi file              # edit a new version
git stash

or with git mv

git mv file newfile
vi file              # make a new file with the old name
git stash

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 t/t3903-stash.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 476e5ec..c85bf44 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -228,4 +228,13 @@ test_expect_success 'stash --invalid-option' '
 	test bar,bar2 = $(cat file),$(cat file2)
 '
 
+test_expect_failure 'stash git rm' '
+    git reset --hard &&
+	git rm file &&
+	echo bar7 > file &&
+	git stash &&
+	git stash apply &&
+	test bar7 = $(cat file)
+'
+
 test_done
-- 
1.7.1.rc0.266.gf3d756
