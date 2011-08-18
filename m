From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 3/4] git-p4: Add test case for rename detection.
Date: Thu, 18 Aug 2011 02:04:18 +0100
Message-ID: <1313629459-22937-4-git-send-email-vitor.hda@gmail.com>
References: <1313629459-22937-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 03:04:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtr2T-00039P-O2
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 03:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734Ab1HRBEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 21:04:50 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34987 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab1HRBEt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 21:04:49 -0400
Received: by wyg24 with SMTP id 24so1057585wyg.19
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 18:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EyTXlGqaz5hyuLbaRDfxWzQ217ZlrkQdPQlkKnH/jj4=;
        b=bMC10JnEajEbbcYVa2kFcjGnsAsoZ2nIrVfdkKu8dHlZvW8xXg2O2VLHQBEwPbgqNX
         gwaOygDA5ahtjpC7KKIbj/SMMsMgBILZa7vbdFhgo/AoaHwLXDVxvkq1kzxeFQsEbAcY
         WY+6vjzYJ42rlb0NckNKQjXM8A9qRfg+loGC0=
Received: by 10.216.177.212 with SMTP id d62mr4785689wem.51.1313629488436;
        Wed, 17 Aug 2011 18:04:48 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id fm9sm1343282wbb.27.2011.08.17.18.04.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Aug 2011 18:04:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1313629459-22937-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179548>

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 t/t9800-git-p4.sh |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index 97ec975..d01a1cb 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -269,6 +269,56 @@ test_expect_success 'initial import time from top change time' '
 	test $p4time = $gittime
 '
 
+# Rename a file and confirm that rename is not detected in P4.
+# Rename the new file again with detectRenames option enabled and confirm that
+# this is detected in P4.
+# Rename the new file again adding an extra blank line, configure a big
+# threshold in detectRenames and confirm that rename is not detected in P4.
+# Rename the new file again adding another extra blank line, configure a small
+# threshold in detectRenames and confirm that rename is not detected in P4.
+test_expect_success 'detect renames' '
+	git init "$git" &&
+	cd "$git" &&
+	cd "$TRASH_DIRECTORY" &&
+	"$GITP4" clone --dest="$git" //depot@all &&
+	p4 files //depot/* &&
+	cd "$git" &&
+	git mv file1 file4 &&
+	git commit -a -m "Rename file1 to file4" &&
+	git diff-tree -r -M HEAD &&
+	git config git-p4.skipSubmitEditCheck true &&
+	"$GITP4" submit &&
+	p4 filelog //depot/file4 &&
+	! p4 filelog //depot/file4 | grep -q "branch from //depot/file1" &&
+	git mv file4 file5 &&
+	git commit -a -m "Rename file4 to file5" &&
+	git diff-tree -r -M HEAD &&
+	git config git-p4.detectRenames true &&
+	"$GITP4" submit &&
+	p4 filelog //depot/file5 &&
+	p4 filelog //depot/file5 | grep -q "branch from //depot/file4" &&
+	git mv file5 file6 &&
+	echo update >> file6 &&
+	git add file6 &&
+	git commit -a -m "Rename file5 to file6 with changes" &&
+	git diff-tree -r -M HEAD &&
+	git config git-p4.detectRenames 95 &&
+	"$GITP4" submit &&
+	p4 filelog //depot/file6 &&
+	! p4 filelog //depot/file6 | grep -q "branch from //depot/file5" &&
+	git mv file6 file7 &&
+	echo update >> file7 &&
+	git add file7 &&
+	git commit -a -m "Rename file6 to file7 with changes" &&
+	git diff-tree -r -M HEAD &&
+	git config git-p4.detectRenames 80 &&
+	"$GITP4" submit &&
+	p4 filelog //depot/file7 &&
+	p4 filelog //depot/file7 | grep -q "branch from //depot/file6" &&
+	cd "$TRASH_DIRECTORY" &&
+	rm -rf "$git" && mkdir "$git"
+'
+
 test_expect_success 'shutdown' '
 	pid=`pgrep -f p4d` &&
 	test -n "$pid" &&
-- 
1.7.5.4
