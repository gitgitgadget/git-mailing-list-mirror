From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 2/8] Add more tests for git hash-object
Date: Fri, 23 May 2008 16:19:37 +0200
Message-ID: <1211552384-29636-3-git-send-email-barra_cuda@katamail.com>
References: <1211552384-29636-1-git-send-email-barra_cuda@katamail.com>
Cc: git@vger.kernel.org
To: aroben@apple.com
X-From: git-owner@vger.kernel.org Fri May 23 16:17:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzY51-00066y-E8
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 16:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbYEWOQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 10:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752263AbYEWOQN
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 10:16:13 -0400
Received: from smtp.katamail.com ([62.149.157.154]:51162 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751746AbYEWOQL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 10:16:11 -0400
Received: (qmail 31695 invoked by uid 89); 23 May 2008 14:14:50 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.207)
  by smtp1-pc with SMTP; 23 May 2008 14:14:49 -0000
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211552384-29636-1-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82707>

From: Adam Roben <aroben@apple.com>

Signed-off-by: Adam Roben <aroben@apple.com>
---
 t/t1007-hash-object.sh |  120 +++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 93 insertions(+), 27 deletions(-)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 543c078..2019ea7 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -4,32 +4,98 @@ test_description=git-hash-object
 
 . ./test-lib.sh
 
-test_expect_success \
-    'git hash-object -w --stdin saves the object' \
-    'obname=$(echo foo | git hash-object -w --stdin) &&
-    obpath=$(echo $obname | sed -e "s/\(..\)/\1\//") &&
-    test -r .git/objects/"$obpath" &&
-    rm -f .git/objects/"$obpath"'
-    
-test_expect_success \
-    'git hash-object --stdin -w saves the object' \
-    'obname=$(echo foo | git hash-object --stdin -w) &&
-    obpath=$(echo $obname | sed -e "s/\(..\)/\1\//") &&
-    test -r .git/objects/"$obpath" &&
-    rm -f .git/objects/"$obpath"'    
-
-test_expect_success \
-    'git hash-object --stdin file1 <file0 first operates on file0, then file1' \
-    'echo foo > file1 &&
-    obname0=$(echo bar | git hash-object --stdin) &&
-    obname1=$(git hash-object file1) &&
-    obname0new=$(echo bar | git hash-object --stdin file1 | sed -n -e 1p) &&
-    obname1new=$(echo bar | git hash-object --stdin file1 | sed -n -e 2p) &&
-    test "$obname0" = "$obname0new" &&
-    test "$obname1" = "$obname1new"'
-
-test_expect_success \
-    'git hash-object refuses multiple --stdin arguments' \
-    '! git hash-object --stdin --stdin < file1'
+echo_without_newline() {
+	printf '%s' "$*"
+}
+
+test_blob_does_not_exist() {
+	test_expect_success 'blob does not exist in database' "
+		test_must_fail git cat-file blob $1
+	"
+}
+
+test_blob_exists() {
+	test_expect_success 'blob exists in database' "
+		git cat-file blob $1
+	"
+}
+
+hello_content="Hello World"
+hello_sha1=5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689
+
+example_content="This is an example"
+example_sha1=ddd3f836d3e3fbb7ae289aa9ae83536f76956399
+
+setup_repo() {
+	echo_without_newline "$hello_content" > hello
+	echo_without_newline "$example_content" > example
+}
+
+test_repo=test
+push_repo() {
+	test_create_repo $test_repo
+	cd $test_repo
+
+	setup_repo
+}
+
+pop_repo() {
+	cd ..
+	rm -rf $test_repo
+}
+
+setup_repo
+
+# Argument checking
+
+test_expect_success "multiple '--stdin's are rejected" '
+	test_must_fail git hash-object --stdin --stdin < example
+'
+
+# Behavior
+
+push_repo
+
+test_expect_success 'hash a file' '
+	test $hello_sha1 = $(git hash-object hello)
+'
+
+test_blob_does_not_exist $hello_sha1
+
+test_expect_success 'hash from stdin' '
+	test $example_sha1 = $(git hash-object --stdin < example)
+'
+
+test_blob_does_not_exist $example_sha1
+
+test_expect_success 'hash a file and write to database' '
+	test $hello_sha1 = $(git hash-object -w hello)
+'
+
+test_blob_exists $hello_sha1
+
+test_expect_success 'git hash-object --stdin file1 <file0 first operates on file0, then file1' '
+	echo foo > file1 &&
+	obname0=$(echo bar | git hash-object --stdin) &&
+	obname1=$(git hash-object file1) &&
+	obname0new=$(echo bar | git hash-object --stdin file1 | sed -n -e 1p) &&
+	obname1new=$(echo bar | git hash-object --stdin file1 | sed -n -e 2p) &&
+	test "$obname0" = "$obname0new" &&
+	test "$obname1" = "$obname1new"
+'
+
+pop_repo
+
+for args in "-w --stdin" "--stdin -w"; do
+	push_repo
+
+	test_expect_success "hash from stdin and write to database ($args)" '
+		test $example_sha1 = $(git hash-object $args < example)
+	'
+
+	test_blob_exists $example_sha1
+
+	pop_repo
+done
 
 test_done
-- 
1.5.5.1
