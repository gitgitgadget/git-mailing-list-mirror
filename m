From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 4/4] git-p4: Add test case for copy detection.
Date: Thu, 18 Aug 2011 02:04:19 +0100
Message-ID: <1313629459-22937-5-git-send-email-vitor.hda@gmail.com>
References: <1313629459-22937-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 03:05:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtr2g-0003E9-6h
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 03:05:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740Ab1HRBEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 21:04:53 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38117 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab1HRBEv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 21:04:51 -0400
Received: by wyg24 with SMTP id 24so1057598wyg.19
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 18:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=MewksGdImzxhFkh0Q+Cv/hRZsNAC4C1wANSLU4dNjiU=;
        b=OPUSk3wJDo0nO6c3HZzIcSrkzHRG48bt7kFzmiHX/BvsNr3vinnzN8TbYtEmRjkFKi
         DppSO1s4KkMFSoaFI6Ts5rK64dcbbvgkw1vPh/ZroqxAszPeyqklLdtG0/QuFTu9SGz7
         ednBtql6yPBZyfW8s/zexEOHJJO22zUyX664Q=
Received: by 10.227.208.208 with SMTP id gd16mr1426153wbb.34.1313629490033;
        Wed, 17 Aug 2011 18:04:50 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id fm9sm1343282wbb.27.2011.08.17.18.04.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Aug 2011 18:04:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1313629459-22937-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179550>

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
