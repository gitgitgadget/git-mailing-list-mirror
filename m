From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v2 3/4] git-p4: Add test case for rename detection.
Date: Thu, 18 Aug 2011 23:20:53 +0100
Message-ID: <1313706054-11740-4-git-send-email-vitor.hda@gmail.com>
References: <1313706054-11740-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 00:21:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuAy9-0002QM-8v
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913Ab1HRWVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 18:21:41 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:64443 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754894Ab1HRWVk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:21:40 -0400
Received: by wwe5 with SMTP id 5so4514481wwe.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 15:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EyTXlGqaz5hyuLbaRDfxWzQ217ZlrkQdPQlkKnH/jj4=;
        b=fLqWjBgLJY8EWBqXl+ZiJEd+x6Qo99bVG3ELdEft3bdPlSduOpV7P1Zfc4hKDjq0/v
         c0S3+tKvxcqCyK8gEE5fB6QgrPewJ6krhPqPpOR/ViiMMfk3ewUEVNsiEkzXI2tkYeLE
         nz9DT9Kej8Lcen4+ry3kJGM12WF5oDdpU3RFQ=
Received: by 10.227.121.130 with SMTP id h2mr2354215wbr.97.1313706098849;
        Thu, 18 Aug 2011 15:21:38 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id fy12sm2103590wbb.32.2011.08.18.15.21.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 15:21:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1313706054-11740-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179639>

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
