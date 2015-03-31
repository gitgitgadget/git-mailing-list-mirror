From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH V2] t9814: Guarantee only one source exists in git-p4 copy tests
Date: Wed,  1 Apr 2015 00:29:42 +0100
Message-ID: <1427844582-29749-1-git-send-email-vitor.hda@gmail.com>
References: <xmqqk2xzxk3y.fsf@gitster.dls.corp.google.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 01 01:30:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd5c6-0001Hw-9t
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 01:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbbCaXaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 19:30:21 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36526 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbbCaXaT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 19:30:19 -0400
Received: by wixo5 with SMTP id o5so30831646wix.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2015 16:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9Zqtba1zf+qnu3CdEISsMB7p4SI2nlgalIWge8A9Dp8=;
        b=xPkwdpuvqSHvo9Q8hRcZ4VnGZEFOEWbZQswArZBqOb7RURmXMw9WDHpZbdvkjn4sBG
         2a5iRdrmOlMAWe6OMpolCfbkpkHMrffd1+huwUWWaa26AVOIyLY4s6lypN0Q/FZ/eYtK
         kKP5+shLPtnZEQPoN/+wEYR7pB3VfSmPe1Yl80T4/sbD58PMPOCO6Gdb+jQIuNEoPE9g
         l6/dui9hgxQVyqnpal6GsWqdU88IsNQ+5AQWkiiTKoJ4UF31aax8iWIMnSSRt/6n0r7x
         mgWiIS/PKi96oPA8XN6sQ9BGXmR5XYpNDMfZ4xTyUPwnjJxs43jnQxAx/rjpnV1hIrsM
         bAmg==
X-Received: by 10.180.83.68 with SMTP id o4mr9839291wiy.55.1427844618100;
        Tue, 31 Mar 2015 16:30:18 -0700 (PDT)
Received: from localhost.localdomain (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id bd1sm22906246wib.13.2015.03.31.16.30.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2015 16:30:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <xmqqk2xzxk3y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266583>

* Modify source file (file2) before copying the file.
* Check that only file2 is the source in the output of "p4 filelog".
* Remove all "case" statements and replace them with simple tests to check
  that source is "file2".

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
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
