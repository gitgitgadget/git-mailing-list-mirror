From: Adam Roben <aroben@apple.com>
Subject: [PATCH 07/11] Add more tests for git hash-object
Date: Wed, 23 Apr 2008 15:17:49 -0400
Message-ID: <1208978273-98146-8-git-send-email-aroben@apple.com>
References: <1208978273-98146-1-git-send-email-aroben@apple.com>
 <1208978273-98146-2-git-send-email-aroben@apple.com>
 <1208978273-98146-3-git-send-email-aroben@apple.com>
 <1208978273-98146-4-git-send-email-aroben@apple.com>
 <1208978273-98146-5-git-send-email-aroben@apple.com>
 <1208978273-98146-6-git-send-email-aroben@apple.com>
 <1208978273-98146-7-git-send-email-aroben@apple.com>
Cc: Adam Roben <aroben@apple.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 21:20:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JokUx-00058u-Tm
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 21:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273AbYDWTSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 15:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755171AbYDWTSM
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 15:18:12 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:50304 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044AbYDWTSE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 15:18:04 -0400
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out4.apple.com (Postfix) with ESMTP id 3D92E2A6A25C;
	Wed, 23 Apr 2008 12:18:03 -0700 (PDT)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id 1FBE928042;
	Wed, 23 Apr 2008 12:18:03 -0700 (PDT)
X-AuditID: 1180711d-a8b91bb000000ed7-3a-480f8b6a6ea9
Received: from localhost.localdomain (unknown [17.151.126.45])
	by relay13.apple.com (Apple SCV relay) with ESMTP id 514522808B;
	Wed, 23 Apr 2008 12:18:02 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.152.g9aeb7
In-Reply-To: <1208978273-98146-7-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80239>


Signed-off-by: Adam Roben <aroben@apple.com>
---
Junio C Hamano <gitster@pobox.com> wrote:
> > +test_expect_success \
> > +    'hash a file' \
> > +    "test $hello_sha1 = \$(git hash-object hello)"
> > +
> > +test_expect_success \
> > +    'hash from stdin' \
> > +    "test $hello_sha1 = \$(echo '$hello_content' | git hash-object --stdin)"
> 
> Needs to make sure no object has been written to the object
> database at this point?
> 
> > +test_expect_success \
> > +    'hash a file and write to database' \
> > +    "test $hello_sha1 = \$(git hash-object -w hello)"
> 
> ... and make sure the objectis written here?
> 
> > +test_expect_success \
> > +    'hash from stdin and write to database' \
> > +    "test $hello_sha1 = \$(echo '$hello_content' | git hash-object -w --stdin)"
> > +
> > +test_done
> 
> ... and/or here?

Fixed.

 t/t1007-hash-object.sh |  120 ++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 96 insertions(+), 24 deletions(-)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 543c078..eb54f1f 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -4,32 +4,104 @@ test_description=git-hash-object
 
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
+function echo_without_newline()
+{
+    echo "$@\c"
+}
 
-test_expect_success \
-    'git hash-object --stdin file1 <file0 first operates on file0, then file1' \
-    'echo foo > file1 &&
-    obname0=$(echo bar | git hash-object --stdin) &&
-    obname1=$(git hash-object file1) &&
-    obname0new=$(echo bar | git hash-object --stdin file1 | sed -n -e 1p) &&
-    obname1new=$(echo bar | git hash-object --stdin file1 | sed -n -e 2p) &&
-    test "$obname0" = "$obname0new" &&
-    test "$obname1" = "$obname1new"'
+function test_blob_does_not_exist()
+{
+    test_expect_success \
+        "blob does not exist in database" \
+        "test_must_fail git cat-file blob $1"
+}
+
+function test_blob_exists()
+{
+    test_expect_success \
+        "blob exists in database" \
+        "git cat-file blob $1"
+}
+
+hello_content="Hello World"
+hello_sha1=5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689
+
+example_content="This is an example"
+example_sha1=ddd3f836d3e3fbb7ae289aa9ae83536f76956399
+
+function setup_repo()
+{
+    echo_without_newline "$hello_content" > hello
+    echo_without_newline "$example_content" > example
+}
+
+test_repo=test
+function push_repo()
+{
+    test_create_repo $test_repo
+    cd $test_repo
+
+    setup_repo
+}
+
+function pop_repo()
+{
+    cd ..
+    rm -rf $test_repo
+}
+
+setup_repo
+
+# Argument checking
 
 test_expect_success \
-    'git hash-object refuses multiple --stdin arguments' \
-    '! git hash-object --stdin --stdin < file1'
+    "multiple '--stdin's are rejected" \
+    "test_must_fail git hash-object --stdin --stdin < example"
+
+# Behavior
+
+push_repo
+
+    test_expect_success \
+        "hash a file" \
+        "test $hello_sha1 = \$(git hash-object hello)"
+
+    test_blob_does_not_exist $hello_sha1
+
+    test_expect_success \
+        "hash from stdin" \
+        "test $example_sha1 = \$(git hash-object --stdin < example)"
+
+    test_blob_does_not_exist $example_sha1
+
+    test_expect_success \
+        "hash a file and write to database" \
+        "test $hello_sha1 = \$(git hash-object -w hello)"
+
+    test_blob_exists $hello_sha1
+
+    test_expect_success \
+        'git hash-object --stdin file1 <file0 first operates on file0, then file1' \
+        'echo foo > file1 &&
+        obname0=$(echo bar | git hash-object --stdin) &&
+        obname1=$(git hash-object file1) &&
+        obname0new=$(echo bar | git hash-object --stdin file1 | sed -n -e 1p) &&
+        obname1new=$(echo bar | git hash-object --stdin file1 | sed -n -e 2p) &&
+        test "$obname0" = "$obname0new" &&
+        test "$obname1" = "$obname1new"'
+
+pop_repo
+
+for args in "-w --stdin" "--stdin -w"; do
+    push_repo
+
+        test_expect_success \
+            "hash from stdin and write to database ($args)" \
+            "test $example_sha1 = \$(git hash-object $args < example)"
+
+        test_blob_exists $example_sha1
+
+    pop_repo
+done
 
 test_done
-- 
1.5.5.1.152.g9aeb7
