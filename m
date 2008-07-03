From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH] git-apply tests need to be portable
Date: Thu,  3 Jul 2008 12:00:20 -0400
Message-ID: <1215100820-23140-1-git-send-email-dzickus@redhat.com>
Cc: Don Zickus <dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 18:01:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KERFU-0007fo-Mb
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 18:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbYGCQA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 12:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752253AbYGCQA3
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 12:00:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52162 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751802AbYGCQA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 12:00:28 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m63G0Li1015975
	for <git@vger.kernel.org>; Thu, 3 Jul 2008 12:00:27 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m63G0K3o027645;
	Thu, 3 Jul 2008 12:00:20 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m63G0Kot029817;
	Thu, 3 Jul 2008 12:00:20 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m63G0KKq023167;
	Thu, 3 Jul 2008 12:00:20 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m63G0KC9023166;
	Thu, 3 Jul 2008 12:00:20 -0400
X-Mailer: git-send-email 1.5.6.rc2.48.g13da
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87294>

When I created the tests for my git-apply patch, I accidently used the '-i'
flag for sed.  Not all versions of sed handle this flag, so I converted
those instances to output to a temp file and move that temp file back to the
original file.

Thanks to Jim Meyering for noticing this!

---

Junio, I am not sure if you want me to resend the whole patch again or is a
small update like this preferred.  I am indifferent either way.

Cheers,
Don
---
 t/t4127-apply-same-fn.sh |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/t/t4127-apply-same-fn.sh b/t/t4127-apply-same-fn.sh
index 2a6ed77..2726a29 100755
--- a/t/t4127-apply-same-fn.sh
+++ b/t/t4127-apply-same-fn.sh
@@ -14,10 +14,12 @@ test_expect_success setup '
 	git commit -m initial
 '
 test_expect_success 'apply same filename with independent changes' '
-	sed -i -e "s/^d/z/" same_fn &&
+	sed -e "s/^d/z/" same_fn > f &&
+	mv f same_fn &&
 	git diff > patch0 &&
 	git add same_fn &&
-	sed -i -e "s/^i/y/" same_fn &&
+	sed -e "s/^i/y/" same_fn > f &&
+	mv f same_fn &&
 	git diff >> patch0 &&
 	cp same_fn same_fn2 &&
 	git reset --hard &&
@@ -27,10 +29,12 @@ test_expect_success 'apply same filename with independent changes' '
 
 test_expect_success 'apply same filename with overlapping changes' '
 	git reset --hard
-	sed -i -e "s/^d/z/" same_fn &&
+	sed -e "s/^d/z/" same_fn > f &&
+	mv f same_fn &&
 	git diff > patch0 &&
 	git add same_fn &&
-	sed -i -e "s/^e/y/" same_fn &&
+	sed -e "s/^e/y/" same_fn > f &&
+	mv f same_fn &&
 	git diff >> patch0 &&
 	cp same_fn same_fn2 &&
 	git reset --hard &&
@@ -41,10 +45,12 @@ test_expect_success 'apply same filename with overlapping changes' '
 test_expect_success 'apply same new filename after rename' '
 	git reset --hard
 	git mv same_fn new_fn
-	sed -i -e "s/^d/z/" new_fn &&
+	sed -e "s/^d/z/" new_fn > f &&
+	mv f new_fn &&
 	git add new_fn &&
 	git diff -M --cached > patch1 &&
-	sed -i -e "s/^e/y/" new_fn &&
+	sed -e "s/^e/y/" new_fn > f &&
+	mv f new_fn &&
 	git diff >> patch1 &&
 	cp new_fn new_fn2 &&
 	git reset --hard &&
@@ -55,11 +61,13 @@ test_expect_success 'apply same new filename after rename' '
 test_expect_success 'apply same old filename after rename -- should fail.' '
 	git reset --hard
 	git mv same_fn new_fn
-	sed -i -e "s/^d/z/" new_fn &&
+	sed -e "s/^d/z/" new_fn > f &&
+	mv f new_fn &&
 	git add new_fn &&
 	git diff -M --cached > patch1 &&
 	git mv new_fn same_fn
-	sed -i -e "s/^e/y/" same_fn &&
+	sed -e "s/^e/y/" same_fn > f &&
+	mv f same_fn &&
 	git diff >> patch1 &&
 	git reset --hard &&
 	test_must_fail git apply patch1
@@ -68,15 +76,18 @@ test_expect_success 'apply same old filename after rename -- should fail.' '
 test_expect_success 'apply A->B (rename), C->A (rename), A->A -- should pass.' '
 	git reset --hard
 	git mv same_fn new_fn
-	sed -i -e "s/^d/z/" new_fn &&
+	sed -e "s/^d/z/" new_fn > f &&
+	mv f new_fn &&
 	git add new_fn &&
 	git diff -M --cached > patch1 &&
 	git commit -m "a rename" &&
 	git mv other_fn same_fn
-	sed -i -e "s/^e/y/" same_fn &&
+	sed -e "s/^e/y/" same_fn > f &&
+	mv f same_fn &&
 	git add same_fn &&
 	git diff -M --cached >> patch1 &&
-	sed -i -e "s/^g/x/" same_fn &&
+	sed -e "s/^g/x/" same_fn > f &&
+	mv f same_fn &&
 	git diff >> patch1 &&
 	git reset --hard HEAD^ &&
 	git apply patch1
-- 
1.5.6.rc2.48.g13da
