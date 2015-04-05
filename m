From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH V3] t9814: Guarantee only one source exists in git-p4 copy tests
Date: Mon,  6 Apr 2015 00:08:35 +0100
Message-ID: <1428275315-15425-1-git-send-email-vitor.hda@gmail.com>
References: <xmqq384ffzqm.fsf@gitster.dls.corp.google.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 01:09:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yetfp-0006al-FU
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 01:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbbDEXJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 19:09:44 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36595 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbbDEXJo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 19:09:44 -0400
Received: by wizk4 with SMTP id k4so16780878wiz.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2015 16:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nmJbpNQub3LoQCIK/IrjiIO3Pa61JRYoScYg/DNiF64=;
        b=oxjhDG1ppv26IwdVuJFX7KwD8aUj4k75HJ4vNwDUMF60UkXADUWpoEKmOT+Zct2gdc
         9qlJHoQAasMj2m5QiyGREqZ/vcP4smvqWbW/jgM0ZxQI7Z3H61aVTIW7njFTyOYU80Y4
         b9NuQ82AoJ4LwA+UqLdTk2vscTB8JfvtnGPlDuBJH31yJWcOS7DD7tBc2MU9Crwwq/8H
         ExshcCvNL64RR+NjwRlfYu/NCZAqGuA8pLDH9YnRhgALhYw5EP6LD/A1PiTVQ+rsVyJm
         A7pqZJLJze5CQ/z8XVVVs3InGS4sAIDlmAYTKgReDf5D4LReO05iCxDqBZhG3GHWQCwU
         nU+A==
X-Received: by 10.194.94.164 with SMTP id dd4mr26227720wjb.56.1428275382493;
        Sun, 05 Apr 2015 16:09:42 -0700 (PDT)
Received: from localhost.localdomain (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id dq8sm4144083wib.9.2015.04.05.16.09.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Apr 2015 16:09:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <xmqq384ffzqm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266826>

By using a tree with multiple identical files and allowing copy detection to
choose any one of them, the check in the test is unnecessarily complex.  We can
simplify by:

* Modify source file (file2) before copying the file.
* Check that only file2 is the source in the output of "p4 filelog".
* Remove all "case" statements and replace them with simple tests to check
  that source is "file2".

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
Acked-by: Luke Diamand <luke@diamand.org>
---
 t/t9814-git-p4-rename.sh |   46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 8b9c295..99bb71b 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -132,6 +132,9 @@ test_expect_success 'detect copies' '
 		cd "$git" &&
 		git config git-p4.skipSubmitEdit true &&
 
+		echo "file8" >>file2 &&
+		git commit -a -m "Differentiate file2" &&
+		git p4 submit &&
 		cp file2 file8 &&
 		git add file8 &&
 		git commit -a -m "Copy file2 to file8" &&
@@ -140,6 +143,10 @@ test_expect_success 'detect copies' '
 		p4 filelog //depot/file8 &&
 		p4 filelog //depot/file8 | test_must_fail grep -q "branch from" &&
 
+		echo "file9" >>file2 &&
+		git commit -a -m "Differentiate file2" &&
+		git p4 submit &&
+
 		cp file2 file9 &&
 		git add file9 &&
 		git commit -a -m "Copy file2 to file9" &&
@@ -149,28 +156,39 @@ test_expect_success 'detect copies' '
 		p4 filelog //depot/file9 &&
 		p4 filelog //depot/file9 | test_must_fail grep -q "branch from" &&
 
+		echo "file10" >>file2 &&
+		git commit -a -m "Differentiate file2" &&
+		git p4 submit &&
+
 		echo "file2" >>file2 &&
 		cp file2 file10 &&
 		git add file2 file10 &&
 		git commit -a -m "Modify and copy file2 to file10" &&
 		git diff-tree -r -C HEAD &&
+		src=$(git diff-tree -r -C HEAD | sed 1d | sed 2d | cut -f2) &&
+		test "$src" = file2 &&
 		git p4 submit &&
 		p4 filelog //depot/file10 &&
-		p4 filelog //depot/file10 | grep -q "branch from //depot/file" &&
+		p4 filelog //depot/file10 | grep -q "branch from //depot/file2" &&
+
+		echo "file11" >>file2 &&
+		git commit -a -m "Differentiate file2" &&
+		git p4 submit &&
 
 		cp file2 file11 &&
 		git add file11 &&
 		git commit -a -m "Copy file2 to file11" &&
 		git diff-tree -r -C --find-copies-harder HEAD &&
 		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
-		case "$src" in
-		file2 | file10) : ;; # happy
-		*) false ;; # not
-		esac &&
+		test "$src" = file2 &&
 		git config git-p4.detectCopiesHarder true &&
 		git p4 submit &&
 		p4 filelog //depot/file11 &&
-		p4 filelog //depot/file11 | grep -q "branch from //depot/file" &&
+		p4 filelog //depot/file11 | grep -q "branch from //depot/file2" &&
+
+		echo "file12" >>file2 &&
+		git commit -a -m "Differentiate file2" &&
+		git p4 submit &&
 
 		cp file2 file12 &&
 		echo "some text" >>file12 &&
@@ -180,15 +198,16 @@ test_expect_success 'detect copies' '
 		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
 		test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
 		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
-		case "$src" in
-		file10 | file11) : ;; # happy
-		*) false ;; # not
-		esac &&
+		test "$src" = file2 &&
 		git config git-p4.detectCopies $(($level + 2)) &&
 		git p4 submit &&
 		p4 filelog //depot/file12 &&
 		p4 filelog //depot/file12 | test_must_fail grep -q "branch from" &&
 
+		echo "file13" >>file2 &&
+		git commit -a -m "Differentiate file2" &&
+		git p4 submit &&
+
 		cp file2 file13 &&
 		echo "different text" >>file13 &&
 		git add file13 &&
@@ -197,14 +216,11 @@ test_expect_success 'detect copies' '
 		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
 		test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
 		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
-		case "$src" in
-		file10 | file11 | file12) : ;; # happy
-		*) false ;; # not
-		esac &&
+		test "$src" = file2 &&
 		git config git-p4.detectCopies $(($level - 2)) &&
 		git p4 submit &&
 		p4 filelog //depot/file13 &&
-		p4 filelog //depot/file13 | grep -q "branch from //depot/file"
+		p4 filelog //depot/file13 | grep -q "branch from //depot/file2"
 	)
 '
 
-- 
1.7.10.4
