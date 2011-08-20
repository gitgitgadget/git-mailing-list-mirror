From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v2 0/4] Support threshold in copy/rename detection
Date: Sat, 20 Aug 2011 15:09:57 -0400
Message-ID: <20110820190957.GA7135@arf.padd.com>
References: <1313706054-11740-1-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 21:10:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Quqvu-0001K7-2v
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 21:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752Ab1HTTKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 15:10:06 -0400
Received: from honk.padd.com ([74.3.171.149]:54477 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754780Ab1HTTKE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 15:10:04 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 679E12C27;
	Sat, 20 Aug 2011 12:10:02 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id BF66731447; Sat, 20 Aug 2011 15:09:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1313706054-11740-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179776>

vitor.hda@gmail.com wrote on Thu, 18 Aug 2011 23:20 +0100:
> Second version that includes updates recommended by Pete Wyckoff.
> Now only "true" and "false" arguments are processed, any other argument
> that is no "" is passed directly.
> 
> Vitor Antunes (4):
>   git-p4: Allow setting rename/copy detection threshold.
>   git-p4: Add description of rename/copy detection options.
>   git-p4: Add test case for rename detection.
>   git-p4: Add test case for copy detection.

Here is a patch of review comments.  Some of these are style
and correctness fixes.  Others are my annotations to understand
what's going on in the test.  You might take the good ones and
send them to Junio.

		-- Pete

-----------------------8<--------------------

>From e8c627b08248bc17e8c4e6ca246099b0431a4bfb Mon Sep 17 00:00:00 2001
From: Pete Wyckoff <pw@padd.com>
Date: Sat, 20 Aug 2011 14:10:18 -0400
Subject: [PATCH 1/4] git-p4: copy/rename test case edits

Some review comments.  Take the ones in here you like.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4.sh |   88 ++++++++++++++++++++++++++++++----------------------
 1 files changed, 51 insertions(+), 37 deletions(-)

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index 2a872bc..bbf1485 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -272,24 +272,22 @@ test_expect_success 'initial import time from top change time' '
 # Rename a file and confirm that rename is not detected in P4.
 # Rename the new file again with detectRenames option enabled and confirm that
 # this is detected in P4.
-# Rename the new file again adding an extra blank line, configure a big
-# threshold in detectRenames and confirm that rename is not detected in P4.
-# Rename the new file again adding another extra blank line, configure a small
+# Rename the new file again adding an extra line, configure a big
 # threshold in detectRenames and confirm that rename is not detected in P4.
+# Repeat, this time with a smaller threshold.
 test_expect_success 'detect renames' '
-	git init "$git" &&
-	cd "$git" &&
-	cd "$TRASH_DIRECTORY" &&
 	"$GITP4" clone --dest="$git" //depot@all &&
-	p4 files //depot/* &&
+	test_when_finished cleanup_git &&
 	cd "$git" &&
+	git config git-p4.skipSubmitEditCheck true &&
+
 	git mv file1 file4 &&
 	git commit -a -m "Rename file1 to file4" &&
 	git diff-tree -r -M HEAD &&
-	git config git-p4.skipSubmitEditCheck true &&
 	"$GITP4" submit &&
 	p4 filelog //depot/file4 &&
 	! p4 filelog //depot/file4 | grep -q "branch from //depot/file1" &&
+
 	git mv file4 file5 &&
 	git commit -a -m "Rename file4 to file5" &&
 	git diff-tree -r -M HEAD &&
@@ -297,26 +295,30 @@ test_expect_success 'detect renames' '
 	"$GITP4" submit &&
 	p4 filelog //depot/file5 &&
 	p4 filelog //depot/file5 | grep -q "branch from //depot/file4" &&
+
 	git mv file5 file6 &&
-	echo update >> file6 &&
+	echo update >>file6 &&
 	git add file6 &&
 	git commit -a -m "Rename file5 to file6 with changes" &&
 	git diff-tree -r -M HEAD &&
-	git config git-p4.detectRenames 95 &&
+	level=$(git diff-tree -r -M HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/R0*//") &&
+	test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
+	git config git-p4.detectRenames $((level + 2)) &&
 	"$GITP4" submit &&
 	p4 filelog //depot/file6 &&
 	! p4 filelog //depot/file6 | grep -q "branch from //depot/file5" &&
+
 	git mv file6 file7 &&
-	echo update >> file7 &&
+	echo update >>file7 &&
 	git add file7 &&
 	git commit -a -m "Rename file6 to file7 with changes" &&
 	git diff-tree -r -M HEAD &&
-	git config git-p4.detectRenames 80 &&
+	level=$(git diff-tree -r -M HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/R0*//") &&
+	test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
+	git config git-p4.detectRenames $((level - 2)) &&
 	"$GITP4" submit &&
 	p4 filelog //depot/file7 &&
-	p4 filelog //depot/file7 | grep -q "branch from //depot/file6" &&
-	cd "$TRASH_DIRECTORY" &&
-	rm -rf "$git" && mkdir "$git"
+	p4 filelog //depot/file7 | grep -q "branch from //depot/file6"
 '
 
 # Copy a file and confirm that copy is not detected in P4.
@@ -326,68 +328,80 @@ test_expect_success 'detect renames' '
 # is detected in P4.
 # Copy a file with detectCopies and detectCopiesHarder options enabled and
 # confirm that copy is detected in P4.
-# Modify and copy a file, configure a big threshold in detectCopies and confirm
-# that copy is not detected in P4.
-# Modify and copy a file, configure a small threshold in detectCopies and
+# Modify and copy a file, configure a bigger threshold in detectCopies and
+# confirm that copy is not detected in P4.
+# Modify and copy a file, configure a smaller threshold in detectCopies and
 # confirm that copy is detected in P4.
 test_expect_success 'detect copies' '
-	git init "$git" &&
-	cd "$git" &&
-	cd "$TRASH_DIRECTORY" &&
 	"$GITP4" clone --dest="$git" //depot@all &&
+	test_when_finished cleanup_git &&
 	cd "$git" &&
+	git config git-p4.skipSubmitEditCheck true &&
+
 	cp file2 file8 &&
 	git add file8 &&
 	git commit -a -m "Copy file2 to file8" &&
-	git diff-tree -r -C HEAD
-	git config git-p4.skipSubmitEditCheck true &&
+	git diff-tree -r -C HEAD &&
 	"$GITP4" submit &&
 	p4 filelog //depot/file8 &&
-	! p4 filelog //depot/file8 | grep -q "branch from //depot/file" &&
+	! p4 filelog //depot/file8 | grep -q "branch from" &&
+
 	cp file2 file9 &&
 	git add file9 &&
 	git commit -a -m "Copy file2 to file9" &&
-	git diff-tree -r -C HEAD
+	git diff-tree -r -C HEAD &&
 	git config git-p4.detectCopies true &&
 	"$GITP4" submit &&
 	p4 filelog //depot/file9 &&
 	! p4 filelog //depot/file9 | grep -q "branch from //depot/file" &&
-	echo file2 >> file2 &&
+
+	echo "file2" >>file2 &&
 	cp file2 file10 &&
 	git add file2 file10 &&
 	git commit -a -m "Modify and copy file2 to file10" &&
-	git diff-tree -r -C HEAD
+	git diff-tree -r -C HEAD &&
 	"$GITP4" submit &&
 	p4 filelog //depot/file10 &&
 	p4 filelog //depot/file10 | grep -q "branch from //depot/file" &&
+
 	cp file2 file11 &&
 	git add file11 &&
 	git commit -a -m "Copy file2 to file11" &&
-	git diff-tree -r -C --find-copies-harder HEAD
+	git diff-tree -r -C --find-copies-harder HEAD &&
+	src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
+	test "$src" = file10 &&
 	git config git-p4.detectCopiesHarder true &&
 	"$GITP4" submit &&
 	p4 filelog //depot/file11 &&
 	p4 filelog //depot/file11 | grep -q "branch from //depot/file" &&
+
 	cp file2 file12 &&
-	echo >> file12 &&
+	echo "some text" >>file12 &&
 	git add file12 &&
 	git commit -a -m "Copy file2 to file12 with changes" &&
-	git diff-tree -r -C --find-copies-harder HEAD
-	git config git-p4.detectCopies 98 &&
+	git diff-tree -r -C --find-copies-harder HEAD &&
+	level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
+	test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
+	src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
+	test "$src" = file10 &&
+	git config git-p4.detectCopies $((level + 2)) &&
 	"$GITP4" submit &&
 	p4 filelog //depot/file12 &&
 	! p4 filelog //depot/file12 | grep -q "branch from //depot/file" &&
+
 	cp file2 file13 &&
-	echo >> file13 &&
+	echo "different text" >>file13 &&
 	git add file13 &&
 	git commit -a -m "Copy file2 to file13 with changes" &&
-	git diff-tree -r -C --find-copies-harder HEAD
-	git config git-p4.detectCopies 80 &&
+	git diff-tree -r -C --find-copies-harder HEAD &&
+	level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
+	test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
+	src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
+	test "$src" = file10 &&
+	git config git-p4.detectCopies $((level - 2)) &&
 	"$GITP4" submit &&
 	p4 filelog //depot/file13 &&
-	p4 filelog //depot/file13 | grep -q "branch from //depot/file" &&
-	cd "$TRASH_DIRECTORY" &&
-	rm -rf "$git" && mkdir "$git"
+	p4 filelog //depot/file13 | grep -q "branch from //depot/file"
 '
 
 # Create a simple branch structure in P4 depot to check if it is correctly
-- 
1.7.5.4
