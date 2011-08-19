From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH/RFC 2/2] git-p4: Add complex test case for branch import
Date: Fri, 19 Aug 2011 01:09:50 +0100
Message-ID: <1313712590-26876-3-git-send-email-vitor.hda@gmail.com>
References: <1313712590-26876-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 02:11:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuCgP-0007Dk-Bm
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 02:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716Ab1HSALO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 20:11:14 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59052 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193Ab1HSALK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 20:11:10 -0400
Received: by mail-wy0-f174.google.com with SMTP id 24so1766479wyg.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 17:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=F1/LqoVP7jpp+qSb9OnuiQHGsy0LtBBr5xUVZlg7XPM=;
        b=lbiUvbBzWSY0YQME1/fFnF7Cvk09FFp91K22bGDR/l3Q3N5zXEUhC7TKPL9YxHnxud
         X2ZwZrWtloV74VXFEGW+1LInxCz1AmnV7IrVyq7DvILT00NNMP0G7KuqK+eNvTkTjMNK
         sVIorqEwVi6dDrKmsD/uZZgoIOYP1Zs+xfKG0=
Received: by 10.227.157.81 with SMTP id a17mr1143653wbx.75.1313712669711;
        Thu, 18 Aug 2011 17:11:09 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id fy12sm2152633wbb.49.2011.08.18.17.11.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 17:11:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1313712590-26876-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179664>

Check if branches created from old changelists are correctly imported.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 t/t9800-git-p4.sh |   77 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index 15704d2..9f757d7 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -454,6 +454,83 @@ test_expect_success 'git-p4 clone simple branches' '
 	rm -rf "$git" && mkdir "$git"
 '
 
+# Create a complex branch structure in P4 depot to check if they are correctly
+# cloned. The branches are created from older changelists to check if git-p4 is
+# able to correctly detect them.
+# The final expected structure is:
+# `branch1
+# | `- file1
+# | `- file2 (updated)
+# | `- file3
+# `branch2
+# | `- file1
+# | `- file2
+# `branch3
+# | `- file1
+# | `- file2 (updated)
+# | `- file3
+# `branch4
+# | `- file1
+# | `- file2
+# `branch5
+#   `- file1
+#   `- file2
+#   `- file3
+test_expect_success 'add p4 complex branches' '
+	cd "$cli" &&
+	changelist=$(p4 changes -m1 //depot/... | cut -d \  -f 2) &&
+	changelist=$(($changelist - 5)) &&
+	p4 integrate //depot/branch1/...@$changelist //depot/branch4/... &&
+	p4 submit -d "branch4" &&
+	changelist=$(($changelist + 2)) &&
+	p4 integrate //depot/branch1/...@$changelist //depot/branch5/... &&
+	p4 submit -d "branch5" &&
+	cd "$TRASH_DIRECTORY"
+'
+
+# Configure branches through git-config and clone them. git-p4 will only be able
+# to clone the original structure if it is able to detect the origin changelist
+# of each branch.
+test_expect_success 'git-p4 clone complex branches' '
+	git init "$git" &&
+	cd "$git" &&
+	git config git-p4.branchList branch1:branch2 &&
+	git config --add git-p4.branchList branch1:branch3 &&
+	git config --add git-p4.branchList branch1:branch4 &&
+	git config --add git-p4.branchList branch1:branch5 &&
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
+	test \! -f file3 &&
+	! grep -q update file2 &&
+	git reset --hard p4/depot/branch3 &&
+	test -f file1 &&
+	test -f file2 &&
+	test -f file3 &&
+	grep -q update file2 &&
+	git reset --hard p4/depot/branch4 &&
+	test -f file1 &&
+	test -f file2 &&
+	test \! -f file3 &&
+	! grep -q update file2 &&
+	git reset --hard p4/depot/branch5 &&
+	test -f file1 &&
+	test -f file2 &&
+	test -f file3 &&
+	! grep -q update file2 &&
+	cd "$TRASH_DIRECTORY" &&
+	rm -rf "$git" && mkdir "$git"
+'
+
 test_expect_success 'shutdown' '
 	pid=`pgrep -f p4d` &&
 	test -n "$pid" &&
-- 
1.7.5.4
