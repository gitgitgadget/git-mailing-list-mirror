From: Adam Roben <aroben@apple.com>
Subject: [PATCH 05/11] git-cat-file: Add --batch option
Date: Wed, 23 Apr 2008 15:17:47 -0400
Message-ID: <1208978273-98146-6-git-send-email-aroben@apple.com>
References: <1208978273-98146-1-git-send-email-aroben@apple.com>
 <1208978273-98146-2-git-send-email-aroben@apple.com>
 <1208978273-98146-3-git-send-email-aroben@apple.com>
 <1208978273-98146-4-git-send-email-aroben@apple.com>
 <1208978273-98146-5-git-send-email-aroben@apple.com>
Cc: Adam Roben <aroben@apple.com>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 21:20:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JokV1-00058u-PM
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 21:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757305AbYDWTSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 15:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757488AbYDWTSe
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 15:18:34 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:49416 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617AbYDWTSB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 15:18:01 -0400
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out3.apple.com (Postfix) with ESMTP id 61185293B009;
	Wed, 23 Apr 2008 12:18:01 -0700 (PDT)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id 4DB8528087;
	Wed, 23 Apr 2008 12:18:01 -0700 (PDT)
X-AuditID: 1180711d-acb99bb000000ed7-32-480f8b6837d0
Received: from localhost.localdomain (unknown [17.151.126.45])
	by relay13.apple.com (Apple SCV relay) with ESMTP id 534202807F;
	Wed, 23 Apr 2008 12:18:00 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.152.g9aeb7
In-Reply-To: <1208978273-98146-5-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80248>

--batch is similar to --batch-check, except that the contents of each object is
also printed. The output's form is:

<sha1> SP <type> SP <size> LF
<contents> LF

Signed-off-by: Adam Roben <aroben@apple.com>
---
 Documentation/git-cat-file.txt |   18 +++++++++--
 builtin-cat-file.c             |   63 ++++++++++++++++++++++++++++-----------
 t/t1006-cat-file.sh            |   62 ++++++++++++++++++++++++++++-----------
 3 files changed, 105 insertions(+), 38 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index d5821af..f6c394c 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -9,7 +9,7 @@ git-cat-file - Provide content or type/size information for repository objects
 SYNOPSIS
 --------
 'git-cat-file' [-t | -s | -e | -p | <type>] <object>
-'git-cat-file' --batch-check < <list-of-objects>
+'git-cat-file' [--batch | --batch-check] < <list-of-objects>
 
 DESCRIPTION
 -----------
@@ -50,6 +50,10 @@ OPTIONS
 	or to ask for a "blob" with <object> being a tag object that
 	points at it.
 
+--batch::
+	Print the SHA1, type, size, and contents of each object provided on
+	stdin. May not be combined with any other options or arguments.
+
 --batch-check::
 	Print the SHA1, type, and size of each object provided on stdin. May not be
 	combined with any other options or arguments.
@@ -67,6 +71,14 @@ If '-p' is specified, the contents of <object> are pretty-printed.
 If <type> is specified, the raw (though uncompressed) contents of the <object>
 will be returned.
 
+If '--batch' is specified, output of the following form is printed for each
+object specified on stdin:
+
+------------
+<sha1> SP <type> SP <size> LF
+<contents> LF
+------------
+
 If '--batch-check' is specified, output of the following form is printed for
 each object specified fon stdin:
 
@@ -74,8 +86,8 @@ each object specified fon stdin:
 <sha1> SP <type> SP <size> LF
 ------------
 
-Additionally, output of the following form is printed for each object specified
-on stdin that does not exist in the repository:
+For both '--batch' and '--batch-check', output of the following form is printed
+for each object specified on stdin that does not exist in the repository:
 
 ------------
 <object> SP missing LF
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 832cfd1..827ffcc 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -143,11 +143,12 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 	return 0;
 }
 
-static int batch_one_object(const char *obj_name)
+static int batch_one_object(const char *obj_name, int print_contents)
 {
 	unsigned char sha1[20];
 	enum object_type type;
 	unsigned long size;
+	void *contents;
 
 	if (!obj_name)
 	   return 1;
@@ -157,22 +158,33 @@ static int batch_one_object(const char *obj_name)
 		return 0;
 	}
 
-	type = sha1_object_info(sha1, &size);
+	if (print_contents)
+		contents = read_sha1_file(sha1, &type, &size);
+	else
+		type = sha1_object_info(sha1, &size);
+
 	if (type <= 0)
 		return 1;
 
 	printf("%s %s %lu\n", sha1_to_hex(sha1), typename(type), size);
+	fflush(stdout);
+
+	if (print_contents) {
+		write_or_die(1, contents, size);
+		printf("\n");
+		fflush(stdout);
+	}
 
 	return 0;
 }
 
-static int batch_objects(void)
+static int batch_objects(int print_contents)
 {
 	struct strbuf buf;
 
 	strbuf_init(&buf, 0);
 	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
-		int error = batch_one_object(buf.buf);
+		int error = batch_one_object(buf.buf, print_contents);
 		if (error)
 			return error;
 	}
@@ -180,37 +192,51 @@ static int batch_objects(void)
 	return 0;
 }
 
-static const char cat_file_usage[] = "git-cat-file [ [-t|-s|-e|-p|<type>] <sha1> | --batch-check < <list_of_sha1s> ]";
+static const char cat_file_usage[] = "git-cat-file [ [-t|-s|-e|-p|<type>] <sha1> | [--batch|--batch-check] < <list_of_sha1s> ]";
 
 int cmd_cat_file(int argc, const char **argv, const char *prefix)
 {
-	int i, opt = 0, batch_check = 0;
+	int i, opt = 0, batch = 0, batch_check = 0;
 	const char *exp_type = NULL, *obj_name = NULL;
 
 	git_config(git_default_config);
 
 	for (i = 1; i < argc; ++i) {
 		const char *arg = argv[i];
+		int is_batch = 0, is_batch_check = 0;
+
+		is_batch = !strcmp(arg, "--batch");
+		if (!is_batch)
+			is_batch_check = !strcmp(arg, "--batch-check");
 
-		if (!strcmp(arg, "--batch-check")) {
+		if (is_batch || is_batch_check) {
 			if (opt) {
-				error("git-cat-file: Can't use --batch-check with -%c", opt);
+				error("git-cat-file: Can't use %s with -%c", arg, opt);
 				usage(cat_file_usage);
 			} else if (exp_type) {
-				error("git-cat-file: Can't use --batch-check when a type (\"%s\") is specified", exp_type);
+				error("git-cat-file: Can't use %s when a type (\"%s\") is specified", arg, exp_type);
 				usage(cat_file_usage);
 			} else if (obj_name) {
-				error("git-cat-file: Can't use --batch-check when an object (\"%s\") is specified", obj_name);
+				error("git-cat-file: Can't use %s when an object (\"%s\") is specified", arg, obj_name);
 				usage(cat_file_usage);
 			}
 
-			batch_check = 1;
+			if (is_batch && batch_check || is_batch_check && batch) {
+				error("git-cat-file: Can't use %s with %s", arg, is_batch ? "--batch-check" : "--batch");
+				usage(cat_file_usage);
+			}
+
+			if (is_batch)
+				batch = 1;
+			else
+				batch_check = 1;
+
 			continue;
 		}
 
 		if (!strcmp(arg, "-t") || !strcmp(arg, "-s") || !strcmp(arg, "-e") || !strcmp(arg, "-p")) {
-			if (batch_check) {
-				error("git-cat-file: Can't use %s with --batch-check", arg);
+			if (batch || batch_check) {
+				error("git-cat-file: Can't use %s with %s", arg, batch ? "--batch" : "--batch-check");
 				usage(cat_file_usage);
 			}
 
@@ -223,8 +249,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 			usage(cat_file_usage);
 
 		if (!exp_type) {
-			if (batch_check) {
-				error("git-cat-file: Can't specify a type (\"%s\") with --batch-check", arg);
+			if (batch || batch_check) {
+				error("git-cat-file: Can't specify a type (\"%s\") with %s", arg, batch ? "--batch" : "--batch-check");
 				usage(cat_file_usage);
 			}
 
@@ -235,16 +261,17 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		if (obj_name)
 			usage(cat_file_usage);
 
-		// We should have hit one of the earlier if (batch_check) cases before
+		// We should have hit one of the earlier if (batch || batch_check) cases before
 		// getting here.
+		assert(!batch);
 		assert(!batch_check);
 
 		obj_name = arg;
 		break;
 	}
 
-	if (batch_check)
-		return batch_objects();
+	if (batch || batch_check)
+		return batch_objects(batch);
 
 	if (!exp_type || !obj_name)
 		usage(cat_file_usage);
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 46b0f54..acce8c8 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -32,6 +32,9 @@ function run_tests()
     pretty_content=$5
     no_timestamp=$6
 
+    batch_output="$sha1 $type $size
+$content"
+
     test_expect_success \
         "$type exists" \
         "git cat-file -e $sha1"
@@ -47,6 +50,9 @@ function run_tests()
     test_expect_success \
         "Pretty content of $type is correct" \
         "test \"\$(maybe_remove_timestamp '$pretty_content' $no_timestamp)\" = \"\$(maybe_remove_timestamp \"\$(git cat-file -p $sha1)\" $no_timestamp)\""
+    test -z "$content" || test_expect_success \
+        "--batch output of $type is correct" \
+        "test \"\$(maybe_remove_timestamp '$batch_output' $no_timestamp)\" = \"\$(maybe_remove_timestamp \"\$(echo $sha1 | git cat-file --batch)\" $no_timestamp)\""
     test_expect_success \
         "--batch-check output of $type is correct" \
         "test \"$sha1 $type $size\" = \"\$(echo_without_newline $sha1 | git cat-file --batch-check)\""
@@ -101,27 +107,29 @@ test_expect_success \
     "Reach a blob from a tag pointing to it" \
     "test '$hello_content' = \"\$(git cat-file blob $tag_sha1)\""
 
-for opt in t s e p; do
-    test_expect_success \
-        "Passing -$opt with --batch-check fails" \
-        "test_must_fail git cat-file --batch-check -$opt $hello_sha1"
+for batch in batch batch-check; do
+    for opt in t s e p; do
+        test_expect_success \
+            "Passing -$opt with --$batch fails" \
+            "test_must_fail git cat-file --$batch -$opt $hello_sha1"
 
-    test_expect_success \
-        "Passing --batch-check with -$opt fails" \
-        "test_must_fail git cat-file -$opt --batch-check $hello_sha1"
-done
+        test_expect_success \
+            "Passing --$batch with -$opt fails" \
+            "test_must_fail git cat-file -$opt --$batch $hello_sha1"
+    done
 
-test_expect_success \
-    "Passing <type> with --batch-check fails" \
-    "test_must_fail git cat-file --batch-check blob $hello_sha1"
+    test_expect_success \
+        "Passing <type> with --$batch fails" \
+        "test_must_fail git cat-file --$batch blob $hello_sha1"
 
-test_expect_success \
-    "Passing --batch-check with <type> fails" \
-    "test_must_fail git cat-file blob --batch-check $hello_sha1"
+    test_expect_success \
+        "Passing --$batch with <type> fails" \
+        "test_must_fail git cat-file blob --$batch $hello_sha1"
 
-test_expect_success \
-    "Passing sha1 with --batch-check fails" \
-    "test_must_fail git cat-file --batch-check $hello_sha1"
+    test_expect_success \
+        "Passing sha1 with --$batch fails" \
+        "test_must_fail git cat-file --$batch $hello_sha1"
+done
 
 test_expect_success \
     "--batch-check for a non-existent object" \
@@ -131,6 +139,26 @@ test_expect_success \
     "--batch-check for an emtpy line" \
     "test \" missing\" = \"\$(printf \"\\\\n\" | git cat-file --batch-check)\""
 
+batch_input="$hello_sha1
+$commit_sha1
+$tag_sha1
+deadbeef
+
+"
+
+batch_output="$hello_sha1 blob $hello_size
+$hello_content
+$commit_sha1 commit $commit_size
+$commit_content
+$tag_sha1 tag $tag_size
+$tag_content
+deadbeef missing
+ missing"
+
+test_expect_success \
+    "--batch with multiple sha1s gives correct format" \
+    "test \"\$(maybe_remove_timestamp \"$batch_output\" 1)\" = \"\$(maybe_remove_timestamp \"\$(echo_without_newline \"$batch_input\" | git cat-file --batch)\" 1)\""
+
 batch_check_input="$hello_sha1
 $tree_sha1
 $commit_sha1
-- 
1.5.5.1.152.g9aeb7
