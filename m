From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [PATCH 0/8] Speed up git-svn
Date: Fri, 23 May 2008 16:19:44 +0200
Message-ID: <1211552384-29636-10-git-send-email-barra_cuda@katamail.com>
References: <1211552384-29636-1-git-send-email-barra_cuda@katamail.com>
Cc: git@vger.kernel.org
To: aroben@apple.com
X-From: git-owner@vger.kernel.org Fri May 23 16:17:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzY5A-00066y-L3
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 16:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbYEWOQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 10:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753894AbYEWOQa
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 10:16:30 -0400
Received: from smtp.katamail.com ([62.149.157.154]:52111 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751829AbYEWOQU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 10:16:20 -0400
Received: (qmail 1094 invoked by uid 89); 23 May 2008 14:15:02 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.207)
  by smtp1-pc with SMTP; 23 May 2008 14:15:01 -0000
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211552384-29636-1-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82710>

Output of "git diff -w" against the old version by Adam Roben of
patches 2 and 3:

diff --git a/hash-object.c b/hash-object.c
index 1b39162..0a7ac2f 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -6,6 +6,7 @@
  */
 #include "cache.h"
 #include "blob.h"
+#include "quote.h"
 
 static void hash_object(const char *path, enum object_type type, int write_object)
 {
@@ -31,7 +32,7 @@ static void hash_stdin(const char *type, int write_object)
 	printf("%s\n", sha1_to_hex(sha1));
 }
 
-static int hash_stdin_paths(const char *type, int write_objects)
+static void hash_stdin_paths(const char *type, int write_objects)
 {
 	struct strbuf buf, nbuf;
 
@@ -127,7 +128,7 @@ int main(int argc, char **argv)
 	}
 
 	if (stdin_paths)
-		return hash_stdin_paths(type, write_object);
+		hash_stdin_paths(type, write_object);
 
 	if (hashstdin)
 		hash_stdin(type, write_object);
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index dbb4129..0526295 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -4,23 +4,20 @@ test_description=git-hash-object
 
 . ./test-lib.sh
 
-function echo_without_newline()
-{
-    echo "$@\c"
+echo_without_newline() {
+	printf '%s' "$*"
 }
 
-function test_blob_does_not_exist()
-{
-    test_expect_success \
-        "blob does not exist in database" \
-        "test_must_fail git cat-file blob $1"
+test_blob_does_not_exist() {
+	test_expect_success 'blob does not exist in database' "
+		test_must_fail git cat-file blob $1
+	"
 }
 
-function test_blob_exists()
-{
-    test_expect_success \
-        "blob exists in database" \
-        "git cat-file blob $1"
+test_blob_exists() {
+	test_expect_success 'blob exists in database' "
+		git cat-file blob $1
+	"
 }
 
 hello_content="Hello World"
@@ -29,23 +26,20 @@ hello_sha1=5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689
 example_content="This is an example"
 example_sha1=ddd3f836d3e3fbb7ae289aa9ae83536f76956399
 
-function setup_repo()
-{
+setup_repo() {
     echo_without_newline "$hello_content" > hello
     echo_without_newline "$example_content" > example
 }
 
 test_repo=test
-function push_repo()
-{
+push_repo() {
     test_create_repo $test_repo
     cd $test_repo
 
     setup_repo
 }
 
-function pop_repo()
-{
+pop_repo() {
     cd ..
     rm -rf $test_repo
 }
@@ -54,59 +48,59 @@ setup_repo
 
 # Argument checking
 
-test_expect_success \
-    "multiple '--stdin's are rejected" \
-    "test_must_fail git hash-object --stdin --stdin < example"
+test_expect_success "multiple '--stdin's are rejected" '
+	test_must_fail git hash-object --stdin --stdin < example
+'
 
-test_expect_success \
-    "Can't use --stdin and --stdin-paths together" \
-    "test_must_fail git hash-object --stdin --stdin-paths &&
-     test_must_fail git hash-object --stdin-paths --stdin"
+test_expect_success "Can't use --stdin and --stdin-paths together" '
+	test_must_fail git hash-object --stdin --stdin-paths &&
+	test_must_fail git hash-object --stdin-paths --stdin
+'
 
-test_expect_success \
-    "Can't pass filenames as arguments with --stdin-paths" \
-    "test_must_fail git hash-object --stdin-paths hello < example"
+test_expect_success "Can't pass filenames as arguments with --stdin-paths" '
+	test_must_fail git hash-object --stdin-paths hello < example
+'
 
 # Behavior
 
 push_repo
 
-    test_expect_success \
-        "hash a file" \
-        "test $hello_sha1 = \$(git hash-object hello)"
+test_expect_success 'hash a file' '
+	test $hello_sha1 = $(git hash-object hello)
+'
 
     test_blob_does_not_exist $hello_sha1
 
-    test_expect_success \
-        "hash from stdin" \
-        "test $example_sha1 = \$(git hash-object --stdin < example)"
+test_expect_success 'hash from stdin' '
+	test $example_sha1 = $(git hash-object --stdin < example)
+'
 
     test_blob_does_not_exist $example_sha1
 
-    test_expect_success \
-        "hash a file and write to database" \
-        "test $hello_sha1 = \$(git hash-object -w hello)"
+test_expect_success 'hash a file and write to database' '
+	test $hello_sha1 = $(git hash-object -w hello)
+'
 
     test_blob_exists $hello_sha1
 
-    test_expect_success \
-        'git hash-object --stdin file1 <file0 first operates on file0, then file1' \
-        'echo foo > file1 &&
+test_expect_success 'git hash-object --stdin file1 <file0 first operates on file0, then file1' '
+	echo foo > file1 &&
         obname0=$(echo bar | git hash-object --stdin) &&
         obname1=$(git hash-object file1) &&
         obname0new=$(echo bar | git hash-object --stdin file1 | sed -n -e 1p) &&
         obname1new=$(echo bar | git hash-object --stdin file1 | sed -n -e 2p) &&
         test "$obname0" = "$obname0new" &&
-        test "$obname1" = "$obname1new"'
+	test "$obname1" = "$obname1new"
+'
 
 pop_repo
 
 for args in "-w --stdin" "--stdin -w"; do
     push_repo
 
-        test_expect_success \
-            "hash from stdin and write to database ($args)" \
-            "test $example_sha1 = \$(git hash-object $args < example)"
+	test_expect_success "hash from stdin and write to database ($args)" '
+		test $example_sha1 = $(git hash-object $args < example)
+	'
 
         test_blob_exists $example_sha1
 
@@ -119,16 +113,16 @@ example"
 sha1s="$hello_sha1
 $example_sha1"
 
-test_expect_success \
-    "hash two files with names on stdin" \
-    "test \"$sha1s\" = \"\$(echo_without_newline \"$filenames\" | git hash-object --stdin-paths)\""
+test_expect_success "hash two files with names on stdin" '
+	test "$sha1s" = "$(echo_without_newline "$filenames" | git hash-object --stdin-paths)"
+'
 
 for args in "-w --stdin-paths" "--stdin-paths -w"; do
     push_repo
 
-        test_expect_success \
-            "hash two files with names on stdin and write to database ($args)" \
-            "test \"$sha1s\" = \"\$(echo_without_newline \"$filenames\" | git hash-object $args)\""
+	test_expect_success "hash two files with names on stdin and write to database ($args)" '
+		test "$sha1s" = "$(echo_without_newline "$filenames" | git hash-object $args)"
+	'
 
         test_blob_exists $hello_sha1
         test_blob_exists $example_sha1
