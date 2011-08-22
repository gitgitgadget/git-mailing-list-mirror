From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v3 4/5] git-p4: Add test case for copy detection
Date: Mon, 22 Aug 2011 09:33:08 +0100
Message-ID: <1314001989-29017-5-git-send-email-vitor.hda@gmail.com>
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
	id 1QvPxp-0001Q3-Dq
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 10:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864Ab1HVIeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 04:34:25 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59148 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754189Ab1HVIeW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 04:34:22 -0400
Received: by wwf5 with SMTP id 5so4969059wwf.1
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 01:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FhqwlBV187qKZLPStj8ZUqZl7qo21N7zCb6Ltxr4N1g=;
        b=NbsRKWuKjBYTq7LsUJyL5fLQ1wyMHpJDWNNLNSDHllWGsLJLwVnPxldcT4OmXF4Flj
         Rq4ggyPeyWsxwGNT23rq5Oa4VvtkWNW/bUdN/L1tg03fVdHN/dNgnZenJv//GvFgMP+7
         M5IY+y8UsNLIG9zqjKy7OsZCKD+87/v3Vs9NU=
Received: by 10.216.69.77 with SMTP id m55mr1722639wed.11.1314002060700;
        Mon, 22 Aug 2011 01:34:20 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id e44sm3284981wed.41.2011.08.22.01.34.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Aug 2011 01:34:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1314001989-29017-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179848>

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4.sh |   83 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index 5a5fd0f..9d4d4bf 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -322,6 +322,89 @@ test_expect_success 'detect renames' '
 	p4 filelog //depot/file7 | grep -q "branch from //depot/file6"
 '
 
+# Copy a file and confirm that copy is not detected in P4.
+# Copy a file with detectCopies option enabled and confirm that copy is not
+# detected in P4.
+# Modify and copy a file with detectCopies option enabled and confirm that copy
+# is detected in P4.
+# Copy a file with detectCopies and detectCopiesHarder options enabled and
+# confirm that copy is detected in P4.
+# Modify and copy a file, configure a bigger threshold in detectCopies and
+# confirm that copy is not detected in P4.
+# Modify and copy a file, configure a smaller threshold in detectCopies and
+# confirm that copy is detected in P4.
+test_expect_success 'detect copies' '
+	"$GITP4" clone --dest="$git" //depot@all &&
+	test_when_finished cleanup_git &&
+	cd "$git" &&
+	git config git-p4.skipSubmitEditCheck true &&
+
+	cp file2 file8 &&
+	git add file8 &&
+	git commit -a -m "Copy file2 to file8" &&
+	git diff-tree -r -C HEAD &&
+	"$GITP4" submit &&
+	p4 filelog //depot/file8 &&
+	! p4 filelog //depot/file8 | grep -q "branch from" &&
+
+	cp file2 file9 &&
+	git add file9 &&
+	git commit -a -m "Copy file2 to file9" &&
+	git diff-tree -r -C HEAD &&
+	git config git-p4.detectCopies true &&
+	"$GITP4" submit &&
+	p4 filelog //depot/file9 &&
+	! p4 filelog //depot/file9 | grep -q "branch from" &&
+
+	echo "file2" >>file2 &&
+	cp file2 file10 &&
+	git add file2 file10 &&
+	git commit -a -m "Modify and copy file2 to file10" &&
+	git diff-tree -r -C HEAD &&
+	"$GITP4" submit &&
+	p4 filelog //depot/file10 &&
+	p4 filelog //depot/file10 | grep -q "branch from //depot/file" &&
+
+	cp file2 file11 &&
+	git add file11 &&
+	git commit -a -m "Copy file2 to file11" &&
+	git diff-tree -r -C --find-copies-harder HEAD &&
+	src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
+	test "$src" = file10 &&
+	git config git-p4.detectCopiesHarder true &&
+	"$GITP4" submit &&
+	p4 filelog //depot/file11 &&
+	p4 filelog //depot/file11 | grep -q "branch from //depot/file" &&
+
+	cp file2 file12 &&
+	echo "some text" >>file12 &&
+	git add file12 &&
+	git commit -a -m "Copy file2 to file12 with changes" &&
+	git diff-tree -r -C --find-copies-harder HEAD &&
+	level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
+	test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
+	src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
+	test "$src" = file10 &&
+	git config git-p4.detectCopies $((level + 2)) &&
+	"$GITP4" submit &&
+	p4 filelog //depot/file12 &&
+	! p4 filelog //depot/file12 | grep -q "branch from" &&
+
+	cp file2 file13 &&
+	echo "different text" >>file13 &&
+	git add file13 &&
+	git commit -a -m "Copy file2 to file13 with changes" &&
+	git diff-tree -r -C --find-copies-harder HEAD &&
+	level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
+	test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
+	src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
+	test "$src" = file10 &&
+	git config git-p4.detectCopies $((level - 2)) &&
+	"$GITP4" submit &&
+	p4 filelog //depot/file13 &&
+	p4 filelog //depot/file13 | grep -q "branch from //depot/file"
+'
+
 test_expect_success 'shutdown' '
 	pid=`pgrep -f p4d` &&
 	test -n "$pid" &&
-- 
1.7.5.4
