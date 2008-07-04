From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] t4127-apply-same-fn: Avoid sed -i
Date: Fri, 04 Jul 2008 08:43:19 +0200
Message-ID: <486DC687.4070307@viscovery.net>
References: <1215100820-23140-1-git-send-email-dzickus@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 08:44:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEf1s-000272-2c
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 08:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbYGDGn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 02:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbYGDGn0
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 02:43:26 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:39332 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbYGDGn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 02:43:26 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KEf0p-0002aE-GO; Fri, 04 Jul 2008 08:43:22 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 46D636D9; Fri,  4 Jul 2008 08:43:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1215100820-23140-1-git-send-email-dzickus@redhat.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87368>

From: Johannes Sixt <johannes.sixt@telecom.at>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
Don Zickus schrieb:
> When I created the tests for my git-apply patch, I accidently used the '-i'
> flag for sed.  Not all versions of sed handle this flag, so I converted
> those instances to output to a temp file and move that temp file back to the
> original file.

I had this alternate patch in my tree, but forgot to submit it.

-- Hannes

 t/t4127-apply-same-fn.sh |   27 ++++++++++++++++-----------
 1 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/t/t4127-apply-same-fn.sh b/t/t4127-apply-same-fn.sh
index 2a6ed77..1f859dd 100755
--- a/t/t4127-apply-same-fn.sh
+++ b/t/t4127-apply-same-fn.sh
@@ -4,6 +4,11 @@ test_description='apply same filename'

 . ./test-lib.sh

+modify () {
+	sed -e "$1" < "$2" > "$2".x &&
+	mv "$2".x "$2"
+}
+
 test_expect_success setup '
 	for i in a b c d e f g h i j k l m
 	do
@@ -14,10 +19,10 @@ test_expect_success setup '
 	git commit -m initial
 '
 test_expect_success 'apply same filename with independent changes' '
-	sed -i -e "s/^d/z/" same_fn &&
+	modify "s/^d/z/" same_fn &&
 	git diff > patch0 &&
 	git add same_fn &&
-	sed -i -e "s/^i/y/" same_fn &&
+	modify "s/^i/y/" same_fn &&
 	git diff >> patch0 &&
 	cp same_fn same_fn2 &&
 	git reset --hard &&
@@ -27,10 +32,10 @@ test_expect_success 'apply same filename with independent changes' '

 test_expect_success 'apply same filename with overlapping changes' '
 	git reset --hard
-	sed -i -e "s/^d/z/" same_fn &&
+	modify "s/^d/z/" same_fn &&
 	git diff > patch0 &&
 	git add same_fn &&
-	sed -i -e "s/^e/y/" same_fn &&
+	modify "s/^e/y/" same_fn &&
 	git diff >> patch0 &&
 	cp same_fn same_fn2 &&
 	git reset --hard &&
@@ -41,10 +46,10 @@ test_expect_success 'apply same filename with overlapping changes' '
 test_expect_success 'apply same new filename after rename' '
 	git reset --hard
 	git mv same_fn new_fn
-	sed -i -e "s/^d/z/" new_fn &&
+	modify "s/^d/z/" new_fn &&
 	git add new_fn &&
 	git diff -M --cached > patch1 &&
-	sed -i -e "s/^e/y/" new_fn &&
+	modify "s/^e/y/" new_fn &&
 	git diff >> patch1 &&
 	cp new_fn new_fn2 &&
 	git reset --hard &&
@@ -55,11 +60,11 @@ test_expect_success 'apply same new filename after rename' '
 test_expect_success 'apply same old filename after rename -- should fail.' '
 	git reset --hard
 	git mv same_fn new_fn
-	sed -i -e "s/^d/z/" new_fn &&
+	modify "s/^d/z/" new_fn &&
 	git add new_fn &&
 	git diff -M --cached > patch1 &&
 	git mv new_fn same_fn
-	sed -i -e "s/^e/y/" same_fn &&
+	modify "s/^e/y/" same_fn &&
 	git diff >> patch1 &&
 	git reset --hard &&
 	test_must_fail git apply patch1
@@ -68,15 +73,15 @@ test_expect_success 'apply same old filename after rename -- should fail.' '
 test_expect_success 'apply A->B (rename), C->A (rename), A->A -- should pass.' '
 	git reset --hard
 	git mv same_fn new_fn
-	sed -i -e "s/^d/z/" new_fn &&
+	modify "s/^d/z/" new_fn &&
 	git add new_fn &&
 	git diff -M --cached > patch1 &&
 	git commit -m "a rename" &&
 	git mv other_fn same_fn
-	sed -i -e "s/^e/y/" same_fn &&
+	modify "s/^e/y/" same_fn &&
 	git add same_fn &&
 	git diff -M --cached >> patch1 &&
-	sed -i -e "s/^g/x/" same_fn &&
+	modify "s/^g/x/" same_fn &&
 	git diff >> patch1 &&
 	git reset --hard HEAD^ &&
 	git apply patch1
-- 
1.5.6.1.1099.ge791.dirty
