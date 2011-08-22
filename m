From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v3 3/5] git-p4: Add test case for rename detection
Date: Mon, 22 Aug 2011 09:33:07 +0100
Message-ID: <1314001989-29017-4-git-send-email-vitor.hda@gmail.com>
References: <1314001989-29017-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 22 10:34:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvPxo-0001Q3-Tt
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 10:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850Ab1HVIeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 04:34:24 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58449 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643Ab1HVIeT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 04:34:19 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so4968962wwf.1
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 01:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=64/MxQukhKTi4O6UkLADmGt/rvzqcE0D3n5boCVKn0o=;
        b=gxV+lwLkgz/C4EKsa7zeXlkK63nK0ZtzDoAwy5YsTnKZpNWL4V+GXHNi8aoHwxGSq3
         cV/6czKs4UsPrz10zq0uKOaw5aMIVH0rtIkZQ4cBaDM+DyLawZ3ZBf1s008dqVaeNqvG
         PKRzDQLks8kwT9Dp3wnNW0UPK2rDM/7jErqac=
Received: by 10.216.70.194 with SMTP id p44mr1800156wed.52.1314002058991;
        Mon, 22 Aug 2011 01:34:18 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id e44sm3284981wed.41.2011.08.22.01.34.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Aug 2011 01:34:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1314001989-29017-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179847>

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4.sh |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index 97ec975..5a5fd0f 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -269,6 +269,59 @@ test_expect_success 'initial import time from top change time' '
 	test $p4time = $gittime
 '
 
+# Rename a file and confirm that rename is not detected in P4.
+# Rename the new file again with detectRenames option enabled and confirm that
+# this is detected in P4.
+# Rename the new file again adding an extra line, configure a big threshold in
+# detectRenames and confirm that rename is not detected in P4.
+# Repeat, this time with a smaller threshold and confirm that the rename is
+# detected in P4.
+test_expect_success 'detect renames' '
+	"$GITP4" clone --dest="$git" //depot@all &&
+	test_when_finished cleanup_git &&
+	cd "$git" &&
+	git config git-p4.skipSubmitEditCheck true &&
+
+	git mv file1 file4 &&
+	git commit -a -m "Rename file1 to file4" &&
+	git diff-tree -r -M HEAD &&
+	"$GITP4" submit &&
+	p4 filelog //depot/file4 &&
+	! p4 filelog //depot/file4 | grep -q "branch from" &&
+
+	git mv file4 file5 &&
+	git commit -a -m "Rename file4 to file5" &&
+	git diff-tree -r -M HEAD &&
+	git config git-p4.detectRenames true &&
+	"$GITP4" submit &&
+	p4 filelog //depot/file5 &&
+	p4 filelog //depot/file5 | grep -q "branch from //depot/file4" &&
+
+	git mv file5 file6 &&
+	echo update >>file6 &&
+	git add file6 &&
+	git commit -a -m "Rename file5 to file6 with changes" &&
+	git diff-tree -r -M HEAD &&
+	level=$(git diff-tree -r -M HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/R0*//") &&
+	test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
+	git config git-p4.detectRenames $((level + 2)) &&
+	"$GITP4" submit &&
+	p4 filelog //depot/file6 &&
+	! p4 filelog //depot/file6 | grep -q "branch from" &&
+
+	git mv file6 file7 &&
+	echo update >>file7 &&
+	git add file7 &&
+	git commit -a -m "Rename file6 to file7 with changes" &&
+	git diff-tree -r -M HEAD &&
+	level=$(git diff-tree -r -M HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/R0*//") &&
+	test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
+	git config git-p4.detectRenames $((level - 2)) &&
+	"$GITP4" submit &&
+	p4 filelog //depot/file7 &&
+	p4 filelog //depot/file7 | grep -q "branch from //depot/file6"
+'
+
 test_expect_success 'shutdown' '
 	pid=`pgrep -f p4d` &&
 	test -n "$pid" &&
-- 
1.7.5.4
