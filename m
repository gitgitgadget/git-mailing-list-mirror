From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v3 4/4] git-p4: Add simple test case for branch import
Date: Sat, 20 Aug 2011 15:11:33 -0400
Message-ID: <20110820191133.GB7135@arf.padd.com>
References: <1313711046-23489-1-git-send-email-vitor.hda@gmail.com>
 <1313711046-23489-5-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 21:11:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuqxJ-0001ne-Ss
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 21:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800Ab1HTTLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 15:11:37 -0400
Received: from honk.padd.com ([74.3.171.149]:54478 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754532Ab1HTTLh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 15:11:37 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id D666A2C27;
	Sat, 20 Aug 2011 12:11:36 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id EA51C31447; Sat, 20 Aug 2011 15:11:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1313711046-23489-5-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179777>

vitor.hda@gmail.com wrote on Fri, 19 Aug 2011 00:44 +0100:
> Create a basic branch structure in P4 and clone it with git-p4.
> Also, make an update on P4 side and check if git-p4 imports it correctly.
> The branch structure is created in such a way that git-p4 will fail to import
> updates if patch "git-p4: Correct branch base depot path detection" is not
> applied.

Here are some minor style edits to this test.

		-- Pete

-----------------8<-----------------------

>From 958effaad24d129ad472b48f3a691c7e7de2e918 Mon Sep 17 00:00:00 2001
From: Pete Wyckoff <pw@padd.com>
Date: Sat, 20 Aug 2011 14:24:31 -0400
Subject: [PATCH 2/4] git-p4: simple branch tests edits

More review comments.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4.sh |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index bbf1485..5bcb8b4 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -412,7 +412,7 @@ test_expect_success 'add simple p4 branches' '
 	cd branch1 &&
 	echo file1 >file1 &&
 	echo file2 >file2 &&
-	p4 add file* &&
+	p4 add file1 file2 &&
 	p4 submit -d "branch1" &&
 	p4 integrate //depot/branch1/... //depot/branch2/... &&
 	p4 submit -d "branch2" &&
@@ -432,13 +432,12 @@ test_expect_success 'add simple p4 branches' '
 # Finally, make an update to branch1 on P4 side to check if it is imported
 # correctly by git-p4.
 test_expect_success 'git-p4 clone simple branches' '
-	git init "$git" &&
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
 	cd "$git" &&
 	git config git-p4.branchList branch1:branch2 &&
 	git config --add git-p4.branchList branch1:branch3 &&
-	cd "$TRASH_DIRECTORY" &&
-	"$GITP4" clone --dest="$git" --detect-branches //depot@all &&
-	cd "$git" &&
+	"$GITP4" clone --dest=. --detect-branches //depot@all &&
 	git log --all --graph --decorate --stat &&
 	git reset --hard p4/depot/branch1 &&
 	test -f file1 &&
@@ -448,7 +447,7 @@ test_expect_success 'git-p4 clone simple branches' '
 	git reset --hard p4/depot/branch2 &&
 	test -f file1 &&
 	test -f file2 &&
-	test \! -z file3 &&
+	test ! -f file3 &&
 	! grep -q update file2 &&
 	git reset --hard p4/depot/branch3 &&
 	test -f file1 &&
@@ -458,14 +457,12 @@ test_expect_success 'git-p4 clone simple branches' '
 	cd "$cli" &&
 	cd branch1 &&
 	p4 edit file2 &&
-	echo file2_ >> file2 &&
+	echo file2_ >>file2 &&
 	p4 submit -d "update file2 in branch3" &&
 	cd "$git" &&
 	git reset --hard p4/depot/branch1 &&
 	"$GITP4" rebase &&
-	grep -q file2_ file2 &&
-	cd "$TRASH_DIRECTORY" &&
-	rm -rf "$git" && mkdir "$git"
+	grep -q file2_ file2
 '
 
 # Create a complex branch structure in P4 depot to check if they are correctly
-- 
1.7.5.4
