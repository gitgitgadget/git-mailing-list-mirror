From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/6] t3040 (subprojects-basic): fix '&&' chaining, modernize style
Date: Fri,  9 Dec 2011 16:59:13 +0530
Message-ID: <1323430158-14885-2-git-send-email-artagnon@gmail.com>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323430158-14885-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@mgmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 12:30:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYyew-0000FT-91
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 12:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218Ab1LILaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 06:30:24 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42923 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119Ab1LILaW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 06:30:22 -0500
Received: by ggnr5 with SMTP id r5so3168867ggn.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 03:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=sC1/lMjoD1Kdwn1MoQrXfkQgWZM338KVW9GAik9GwWg=;
        b=JJtLk9SpX383UOE1yMUJeL0J8Yc/XCg1WPAOYBHgDrVmcLr9mFDu9Jv7MlUGMOhQyD
         1kBA8lwnUBDfuvgAg9gLceADDtqz3iErLmkSeNzfvssuIMuu91BcsQFQZXmpoVW06P8m
         clGxMfXKRyhC3BWxrEzDQYLYVsVSs9pcxK78M=
Received: by 10.50.89.200 with SMTP id bq8mr3007363igb.91.1323430222183;
        Fri, 09 Dec 2011 03:30:22 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id d19sm9096588ibh.8.2011.12.09.03.30.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 03:30:21 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323430158-14885-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186626>

Breaks in a test assertion's && chain can potentially hide failures
from earlier commands in the chain.  Fix instances of this.  While at
it, clean up the style to fit the prevailing style.  This means:

- Put the opening quote starting each test on the same line as the
  test_expect_* invocation.

- Indent the file with tabs, not spaces.

- Use test_expect_code() in preference to checking the exit status of
  various statements by hand.

- Guard commands that prepare test input for individual tests in the
  same test_expect_success, so that their scope is clearer and errors
  at that stage can be caught.

- Use <<-\EOF in preference to <<EOF to save readers the trouble of
  looking for variable interpolations.

- Include "setup" in the titles of test assertions that prepare for
  later ones to make it more obvious which tests can be skipped.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3040-subprojects-basic.sh |  144 +++++++++++++++++++++---------------------
 1 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/t/t3040-subprojects-basic.sh b/t/t3040-subprojects-basic.sh
index f6973e9..0a4ff6d 100755
--- a/t/t3040-subprojects-basic.sh
+++ b/t/t3040-subprojects-basic.sh
@@ -3,81 +3,81 @@
 test_description='Basic subproject functionality'
 . ./test-lib.sh
 
-test_expect_success 'Super project creation' \
-    ': >Makefile &&
-    git add Makefile &&
-    git commit -m "Superproject created"'
-
-
-cat >expected <<EOF
-:000000 160000 00000... A	sub1
-:000000 160000 00000... A	sub2
-EOF
-test_expect_success 'create subprojects' \
-    'mkdir sub1 &&
-    ( cd sub1 && git init && : >Makefile && git add * &&
-    git commit -q -m "subproject 1" ) &&
-    mkdir sub2 &&
-    ( cd sub2 && git init && : >Makefile && git add * &&
-    git commit -q -m "subproject 2" ) &&
-    git update-index --add sub1 &&
-    git add sub2 &&
-    git commit -q -m "subprojects added" &&
-    git diff-tree --abbrev=5 HEAD^ HEAD |cut -d" " -f-3,5- >current &&
-    test_cmp expected current'
-
-git branch save HEAD
-
-test_expect_success 'check if fsck ignores the subprojects' \
-    'git fsck --full'
-
-test_expect_success 'check if commit in a subproject detected' \
-    '( cd sub1 &&
-    echo "all:" >>Makefile &&
-    echo "	true" >>Makefile &&
-    git commit -q -a -m "make all" ) && {
-        git diff-files --exit-code
-	test $? = 1
-    }'
-
-test_expect_success 'check if a changed subproject HEAD can be committed' \
-    'git commit -q -a -m "sub1 changed" && {
-	git diff-tree --exit-code HEAD^ HEAD
-	test $? = 1
-    }'
-
-test_expect_success 'check if diff-index works for subproject elements' \
-    'git diff-index --exit-code --cached save -- sub1
-    test $? = 1'
-
-test_expect_success 'check if diff-tree works for subproject elements' \
-    'git diff-tree --exit-code HEAD^ HEAD -- sub1
-    test $? = 1'
-
-test_expect_success 'check if git diff works for subproject elements' \
-    'git diff --exit-code HEAD^ HEAD
-    test $? = 1'
-
-test_expect_success 'check if clone works' \
-    'git ls-files -s >expected &&
-    git clone -l -s . cloned &&
-    ( cd cloned && git ls-files -s ) >current &&
-    test_cmp expected current'
-
-test_expect_success 'removing and adding subproject' \
-    'git update-index --force-remove -- sub2 &&
-    mv sub2 sub3 &&
-    git add sub3 &&
-    git commit -q -m "renaming a subproject" && {
-	git diff -M --name-status --exit-code HEAD^ HEAD
-	test $? = 1
-    }'
+test_expect_success 'setup: create superproject' '
+	: >Makefile &&
+	git add Makefile &&
+	git commit -m "Superproject created"
+'
+
+test_expect_success 'setup: create subprojects' '
+	mkdir sub1 &&
+	( cd sub1 && git init && : >Makefile && git add * &&
+	git commit -q -m "subproject 1" ) &&
+	mkdir sub2 &&
+	( cd sub2 && git init && : >Makefile && git add * &&
+	git commit -q -m "subproject 2" ) &&
+	git update-index --add sub1 &&
+	git add sub2 &&
+	git commit -q -m "subprojects added" &&
+	git diff-tree --abbrev=5 HEAD^ HEAD |cut -d" " -f-3,5- >current &&
+	git branch save HEAD &&
+	cat >expected <<-\EOF &&
+	:000000 160000 00000... A	sub1
+	:000000 160000 00000... A	sub2
+	EOF
+	test_cmp expected current
+'
+
+test_expect_success 'check if fsck ignores the subprojects' '
+	git fsck --full
+'
+
+test_expect_success 'check if commit in a subproject detected' '
+	( cd sub1 &&
+	echo "all:" >>Makefile &&
+	echo "	true" >>Makefile &&
+	git commit -q -a -m "make all" ) &&
+	test_expect_code 1 git diff-files --exit-code
+'
+
+test_expect_success 'check if a changed subproject HEAD can be committed' '
+	git commit -q -a -m "sub1 changed" &&
+	test_expect_code 1 git diff-tree --exit-code HEAD^ HEAD
+'
+
+test_expect_success 'check if diff-index works for subproject elements' '
+	test_expect_code 1 git diff-index --exit-code --cached save -- sub1
+'
+
+test_expect_success 'check if diff-tree works for subproject elements' '
+	test_expect_code 1 git diff-tree --exit-code HEAD^ HEAD -- sub1
+'
+
+test_expect_success 'check if git diff works for subproject elements' '
+	test_expect_code 1 git diff --exit-code HEAD^ HEAD
+'
+
+test_expect_success 'check if clone works' '
+	git ls-files -s >expected &&
+	git clone -l -s . cloned &&
+	( cd cloned && git ls-files -s ) >current &&
+	test_cmp expected current
+'
+
+test_expect_success 'removing and adding subproject' '
+	git update-index --force-remove -- sub2 &&
+	mv sub2 sub3 &&
+	git add sub3 &&
+	git commit -q -m "renaming a subproject" &&
+	test_expect_code 1 git diff -M --name-status --exit-code HEAD^ HEAD
+'
 
 # the index must contain the object name the HEAD of the
 # subproject sub1 was at the point "save"
-test_expect_success 'checkout in superproject' \
-    'git checkout save &&
-    git diff-index --exit-code --raw --cached save -- sub1'
+test_expect_success 'checkout in superproject' '
+	git checkout save &&
+	git diff-index --exit-code --raw --cached save -- sub1
+'
 
 # just interesting what happened...
 # git diff --name-status -M save master
-- 
1.7.7.3
