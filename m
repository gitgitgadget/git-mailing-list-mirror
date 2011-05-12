From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1] git-p4: test harness directory handling tidyup
Date: Thu, 12 May 2011 06:14:59 +0100
Message-ID: <1305177299-27130-2-git-send-email-luke@diamand.org>
References: <1305177299-27130-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 07:15:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKOF3-0001sp-2s
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 07:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211Ab1ELFPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 01:15:09 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42651 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198Ab1ELFPI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 01:15:08 -0400
Received: by wya21 with SMTP id 21so881050wya.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 22:15:07 -0700 (PDT)
Received: by 10.227.206.133 with SMTP id fu5mr10457040wbb.31.1305177307203;
        Wed, 11 May 2011 22:15:07 -0700 (PDT)
Received: from localhost.localdomain (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id bd8sm505740wbb.14.2011.05.11.22.15.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 May 2011 22:15:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1305177299-27130-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173441>

The git-p4 test harness relied a lot on cd'ing to the target directory
and then cd'ing back explicitly. That caused problems if the test failed
partway through. i.e.
  cd $git && stuff && cd "$TRASH_DIRECTORY"

Instead, use:
  (cd $git && stuff)

Signed-off-by: Luke Diamand <luke@diamand.org>
Suggested-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9800-git-p4.sh |   37 ++++++++++++++++++++++---------------
 1 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index 888ad54..122e91d 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -28,6 +28,8 @@ test_expect_success setup '
 '
 
 test_expect_success 'add p4 files' '
+	export P4CLIENT=client &&
+	(
 	cd "$cli" &&
 	p4 client -i <<-EOF &&
 	Client: client
@@ -35,14 +37,13 @@ test_expect_success 'add p4 files' '
 	Root: $cli
 	View: //depot/... //client/...
 	EOF
-	export P4CLIENT=client &&
 	echo file1 >file1 &&
 	p4 add file1 &&
 	p4 submit -d "file1" &&
 	echo file2 >file2 &&
 	p4 add file2 &&
-	p4 submit -d "file2" &&
-	cd "$TRASH_DIRECTORY"
+	p4 submit -d "file2"
+	)
 '
 
 test_expect_success 'basic git-p4 clone' '
@@ -100,34 +101,37 @@ test_expect_success 'exit when p4 fails to produce marshaled output' '
 '
 
 test_expect_success 'add p4 files with wildcards in the names' '
+	(
 	cd "$cli" &&
 	echo file-wild-hash >file-wild#hash &&
 	echo file-wild-star >file-wild\*star &&
 	echo file-wild-at >file-wild@at &&
 	echo file-wild-percent >file-wild%percent &&
 	p4 add -f file-wild* &&
-	p4 submit -d "file wildcards" &&
-	cd "$TRASH_DIRECTORY"
+	p4 submit -d "file wildcards"
+	)
 '
 
 test_expect_success 'wildcard files git-p4 clone' '
 	"$GITP4" clone --dest="$git" //depot &&
+	(
 	cd "$git" &&
 	test -f file-wild#hash &&
 	test -f file-wild\*star &&
 	test -f file-wild@at &&
-	test -f file-wild%percent &&
-	cd "$TRASH_DIRECTORY" &&
+	test -f file-wild%percent
+	)
 	rm -rf "$git" && mkdir "$git"
 '
 
 test_expect_success 'clone bare' '
 	"$GITP4" clone --dest="$git" --bare //depot &&
+	(
 	cd "$git" &&
 	test ! -d .git &&
 	bare=`git config --get core.bare` &&
-	test "$bare" = true &&
-	cd "$TRASH_DIRECTORY" &&
+	test "$bare" = true
+	)
 	rm -rf "$git" && mkdir "$git"
 '
 
@@ -175,6 +179,7 @@ test_expect_success 'preserve users' '
 	p4_add_user bob Bob &&
 	p4_grant_admin alice &&
 	"$GITP4" clone --dest="$git" //depot &&
+	(
 	cd "$git" &&
 	echo "username: a change by alice" >> file1 &&
 	echo "username: a change by bob" >> file2 &&
@@ -183,8 +188,8 @@ test_expect_success 'preserve users' '
 	git config git-p4.skipSubmitEditCheck true &&
 	P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit --preserve-user &&
 	p4_check_commit_author file1 alice &&
-	p4_check_commit_author file2 bob &&
-	cd "$TRASH_DIRECTORY" &&
+	p4_check_commit_author file2 bob
+	)
 	rm -rf "$git" && mkdir "$git"
 '
 
@@ -192,18 +197,20 @@ test_expect_success 'preserve users' '
 # not submit change to p4 (git diff should show deltas).
 test_expect_success 'refuse to preserve users without perms' '
 	"$GITP4" clone --dest="$git" //depot &&
+	(
 	cd "$git" &&
 	echo "username-noperms: a change by alice" >> file1 &&
 	git commit --author "Alice <alice@localhost>" -m "perms: a change by alice" file1 &&
 	! P4EDITOR=touch P4USER=bob P4PASSWD=secret "$GITP4" commit --preserve-user &&
-	! git diff --exit-code HEAD..p4/master > /dev/null &&
-	cd "$TRASH_DIRECTORY" &&
+	! git diff --exit-code HEAD..p4/master > /dev/null
+	)
 	rm -rf "$git" && mkdir "$git"
 '
 
 # What happens with unknown author? Without allowMissingP4Users it should fail.
 test_expect_success 'preserve user where author is unknown to p4' '
 	"$GITP4" clone --dest="$git" //depot &&
+	(
 	cd "$git" &&
 	git config git-p4.skipSubmitEditCheck true
 	echo "username-bob: a change by bob" >> file1 &&
@@ -217,8 +224,8 @@ test_expect_success 'preserve user where author is unknown to p4' '
 	git config git-p4.preserveUser true &&
 	P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit &&
 	git diff --exit-code HEAD..p4/master > /dev/null &&
-	p4_check_commit_author file1 alice &&
-	cd "$TRASH_DIRECTORY" &&
+	p4_check_commit_author file1 alice
+	)
 	rm -rf "$git" && mkdir "$git"
 '
 
-- 
1.7.1
