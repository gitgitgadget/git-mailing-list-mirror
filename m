From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v2 4/4] git-p4: Add test case for copy detection.
Date: Thu, 18 Aug 2011 23:20:54 +0100
Message-ID: <1313706054-11740-5-git-send-email-vitor.hda@gmail.com>
References: <1313706054-11740-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 00:22:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuAyO-0002XX-J5
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941Ab1HRWVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 18:21:44 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34913 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911Ab1HRWVl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:21:41 -0400
Received: by mail-wy0-f174.google.com with SMTP id 24so1729052wyg.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 15:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=MewksGdImzxhFkh0Q+Cv/hRZsNAC4C1wANSLU4dNjiU=;
        b=gaZrhZB/m+fUpMkbIp2NKt/vpi4h0dhV9zhqYmHU+PyLcfqseSSzVZZNuRlhVe7k43
         uQMGlMdTl++UNPaDp33XbvrjPHopEGmXXCsBxstcsbpAdnFFjurG3KQF6BILjvQkzie0
         wRFkFgjG5qN9P0abg3hQTv+Az0m33GaAwMewU=
Received: by 10.227.32.129 with SMTP id c1mr2381738wbd.32.1313706100461;
        Thu, 18 Aug 2011 15:21:40 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id fy12sm2103590wbb.32.2011.08.18.15.21.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 15:21:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1313706054-11740-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179640>

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 t/t9800-git-p4.sh |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index d01a1cb..a4f3d66 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -319,6 +319,77 @@ test_expect_success 'detect renames' '
 	rm -rf "$git" && mkdir "$git"
 '
 
+# Copy a file and confirm that copy is not detected in P4.
+# Copy a file with detectCopies option enabled and confirm that copy is not
+# detected in P4.
+# Modify and copy a file with detectCopies option enabled and confirm that copy
+# is detected in P4.
+# Copy a file with detectCopies and detectCopiesHarder options enabled and
+# confirm that copy is detected in P4.
+# Modify and copy a file, configure a big threshold in detectCopies and confirm
+# that copy is not detected in P4.
+# Modify and copy a file, configure a small threshold in detectCopies and
+# confirm that copy is detected in P4.
+test_expect_success 'detect copies' '
+	git init "$git" &&
+	cd "$git" &&
+	cd "$TRASH_DIRECTORY" &&
+	"$GITP4" clone --dest="$git" //depot@all &&
+	cd "$git" &&
+	cp file2 file8 &&
+	git add file8 &&
+	git commit -a -m "Copy file2 to file8" &&
+	git diff-tree -r -C HEAD
+	git config git-p4.skipSubmitEditCheck true &&
+	"$GITP4" submit &&
+	p4 filelog //depot/file8 &&
+	! p4 filelog //depot/file8 | grep -q "branch from //depot/file" &&
+	cp file2 file9 &&
+	git add file9 &&
+	git commit -a -m "Copy file2 to file9" &&
+	git diff-tree -r -C HEAD
+	git config git-p4.detectCopies true &&
+	"$GITP4" submit &&
+	p4 filelog //depot/file9 &&
+	! p4 filelog //depot/file9 | grep -q "branch from //depot/file" &&
+	echo file2 >> file2 &&
+	cp file2 file10 &&
+	git add file2 file10 &&
+	git commit -a -m "Modify and copy file2 to file10" &&
+	git diff-tree -r -C HEAD
+	"$GITP4" submit &&
+	p4 filelog //depot/file10 &&
+	p4 filelog //depot/file10 | grep -q "branch from //depot/file" &&
+	cp file2 file11 &&
+	git add file11 &&
+	git commit -a -m "Copy file2 to file11" &&
+	git diff-tree -r -C --find-copies-harder HEAD
+	git config git-p4.detectCopiesHarder true &&
+	"$GITP4" submit &&
+	p4 filelog //depot/file11 &&
+	p4 filelog //depot/file11 | grep -q "branch from //depot/file" &&
+	cp file2 file12 &&
+	echo >> file12 &&
+	git add file12 &&
+	git commit -a -m "Copy file2 to file12 with changes" &&
+	git diff-tree -r -C --find-copies-harder HEAD
+	git config git-p4.detectCopies 98 &&
+	"$GITP4" submit &&
+	p4 filelog //depot/file12 &&
+	! p4 filelog //depot/file12 | grep -q "branch from //depot/file" &&
+	cp file2 file13 &&
+	echo >> file13 &&
+	git add file13 &&
+	git commit -a -m "Copy file2 to file13 with changes" &&
+	git diff-tree -r -C --find-copies-harder HEAD
+	git config git-p4.detectCopies 80 &&
+	"$GITP4" submit &&
+	p4 filelog //depot/file13 &&
+	p4 filelog //depot/file13 | grep -q "branch from //depot/file" &&
+	cd "$TRASH_DIRECTORY" &&
+	rm -rf "$git" && mkdir "$git"
+'
+
 test_expect_success 'shutdown' '
 	pid=`pgrep -f p4d` &&
 	test -n "$pid" &&
-- 
1.7.5.4
