From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v3 4/4] git-p4: Add simple test case for branch import
Date: Fri, 19 Aug 2011 00:44:06 +0100
Message-ID: <1313711046-23489-5-git-send-email-vitor.hda@gmail.com>
References: <1313711046-23489-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 01:45:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuCGl-0006mR-Gs
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 01:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972Ab1HRXo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 19:44:59 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33240 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906Ab1HRXo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 19:44:57 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so2583952wwf.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 16:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=82gPlv2sGAcz4sK7xyhIjD3oU1aZGS8Wx66v1mF6IJc=;
        b=SNFbAaaLIbVlO9ZSw5DZPygdpPqInao2Y5LX7FzDamNXkzBSjGgkTxl4nhF0fQ77V+
         iI39qFkLKmO06NqKe9+mgx6pnwsTbfVgQLbqpAUs3c5g/BBuyzqmLsVOvcQHDJtzKPnD
         4sEKrX1AQygioQfeBSIHGeckjFbrlDXdP+SPs=
Received: by 10.216.69.77 with SMTP id m55mr1110369wed.11.1313711096902;
        Thu, 18 Aug 2011 16:44:56 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id u22sm1816046weq.15.2011.08.18.16.44.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 16:44:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1313711046-23489-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179660>

Create a basic branch structure in P4 and clone it with git-p4.
Also, make an update on P4 side and check if git-p4 imports it correctly.
The branch structure is created in such a way that git-p4 will fail to import
updates if patch "git-p4: Correct branch base depot path detection" is not
applied.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 t/t9800-git-p4.sh |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index a4f3d66..777ead8 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -390,6 +390,70 @@ test_expect_success 'detect copies' '
 	rm -rf "$git" && mkdir "$git"
 '
 
+# Create a simple branch structure in P4 depot to check if it is correctly
+# cloned.
+test_expect_success 'add simple p4 branches' '
+	cd "$cli" &&
+	mkdir branch1 &&
+	cd branch1 &&
+	echo file1 >file1 &&
+	echo file2 >file2 &&
+	p4 add file* &&
+	p4 submit -d "branch1" &&
+	p4 integrate //depot/branch1/... //depot/branch2/... &&
+	p4 submit -d "branch2" &&
+	echo file3 >file3 &&
+	p4 add file3 &&
+	p4 submit -d "add file3 in branch1" &&
+	p4 open file2 &&
+	echo update >>file2 &&
+	p4 submit -d "update file2 in branch1" &&
+	p4 integrate //depot/branch1/... //depot/branch3/... &&
+	p4 submit -d "branch3" &&
+	cd "$TRASH_DIRECTORY"
+'
+
+# Configure branches through git-config and clone them.
+# All files are tested to make sure branches were cloned correctly.
+# Finally, make an update to branch1 on P4 side to check if it is imported
+# correctly by git-p4.
+test_expect_success 'git-p4 clone simple branches' '
+	git init "$git" &&
+	cd "$git" &&
+	git config git-p4.branchList branch1:branch2 &&
+	git config --add git-p4.branchList branch1:branch3 &&
+	cd "$TRASH_DIRECTORY" &&
+	"$GITP4" clone --dest="$git" --detect-branches //depot@all &&
+	cd "$git" &&
+	git log --all --graph --decorate --stat &&
+	git reset --hard p4/depot/branch1 &&
+	test -f file1 &&
+	test -f file2 &&
+	test -f file3 &&
+	grep -q update file2 &&
+	git reset --hard p4/depot/branch2 &&
+	test -f file1 &&
+	test -f file2 &&
+	test \! -z file3 &&
+	! grep -q update file2 &&
+	git reset --hard p4/depot/branch3 &&
+	test -f file1 &&
+	test -f file2 &&
+	test -f file3 &&
+	grep -q update file2 &&
+	cd "$cli" &&
+	cd branch1 &&
+	p4 edit file2 &&
+	echo file2_ >> file2 &&
+	p4 submit -d "update file2 in branch3" &&
+	cd "$git" &&
+	git reset --hard p4/depot/branch1 &&
+	"$GITP4" rebase &&
+	grep -q file2_ file2 &&
+	cd "$TRASH_DIRECTORY" &&
+	rm -rf "$git" && mkdir "$git"
+'
+
 test_expect_success 'shutdown' '
 	pid=`pgrep -f p4d` &&
 	test -n "$pid" &&
-- 
1.7.5.4
