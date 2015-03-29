From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH] t9814: Guarantee only one source exists in git-p4 copy tests
Date: Mon, 30 Mar 2015 00:31:54 +0100
Message-ID: <1427671914-12131-1-git-send-email-vitor.hda@gmail.com>
References: <1427545730-3563-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 01:32:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcMgq-0005GS-Hm
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 01:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbbC2XcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2015 19:32:19 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35093 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbbC2XcT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2015 19:32:19 -0400
Received: by wgdm6 with SMTP id m6so152630518wgd.2
        for <git@vger.kernel.org>; Sun, 29 Mar 2015 16:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0xwB/u8PfKBxD+GrThIBZA8jHug8chW4X8iKZLNtbrc=;
        b=N0lWUs6yGti8c3V6mEHCeJhTaK3if5kL7NYVh4X5nDPLXcwkD/FgFB9uCFS3Vf2/cD
         nf3Kf3VM7OZDhidnwOkx06kZKKTvqGNWsKYHFqj/JNxv2CLi3LvKlViSxzsdIBLKipLF
         Su6eRUIrhOAoQK0cesrdBvi3AUDhzNKFsyphTsx+2VTE1QxIy6YBXDkKPNVYGrbW8eTs
         DJp2urHJ/ir2ODFGQMBe0alXz/N+79lu4eEgwtQ01biQh2TLHIFVsww7FJ46fJkfl4HU
         xPoeo4azRAaURJ8fc9DFIzotasnTNAyoLSiyZFBRbZH7kW6zmBwHXZA7ILVLhARiaHPF
         gYMQ==
X-Received: by 10.194.85.46 with SMTP id e14mr55710643wjz.110.1427671937917;
        Sun, 29 Mar 2015 16:32:17 -0700 (PDT)
Received: from localhost.localdomain (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id fo8sm13119318wib.14.2015.03.29.16.32.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2015 16:32:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1427545730-3563-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266446>

* Modify source file (file2) before copying the file.
* Check that only file2 is the source in the output of "p4 filelog".
* Remove all "case" statements and replace them simple tests to check that
  source is "file2".

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 t/t9814-git-p4-rename.sh |   46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 8b9c295..d8fb22d 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -132,6 +132,9 @@ test_expect_success 'detect copies' '
 		cd "$git" &&
 		git config git-p4.skipSubmitEdit true &&
 
+		echo "file8" >> file2 &&
+		git commit -a -m "Differentiate file2" &&
+		git p4 submit &&
 		cp file2 file8 &&
 		git add file8 &&
 		git commit -a -m "Copy file2 to file8" &&
@@ -140,6 +143,10 @@ test_expect_success 'detect copies' '
 		p4 filelog //depot/file8 &&
 		p4 filelog //depot/file8 | test_must_fail grep -q "branch from" &&
 
+		echo "file9" >> file2 &&
+		git commit -a -m "Differentiate file2" &&
+		git p4 submit &&
+
 		cp file2 file9 &&
 		git add file9 &&
 		git commit -a -m "Copy file2 to file9" &&
@@ -149,28 +156,39 @@ test_expect_success 'detect copies' '
 		p4 filelog //depot/file9 &&
 		p4 filelog //depot/file9 | test_must_fail grep -q "branch from" &&
 
+		echo "file10" >> file2 &&
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
+		echo "file11" >> file2 &&
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
+		echo "file12" >> file2 &&
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
 
+		echo "file13" >> file2 &&
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
