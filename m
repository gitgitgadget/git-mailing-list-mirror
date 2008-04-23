From: Adam Roben <aroben@apple.com>
Subject: [PATCH 04/11] git-cat-file: Add --batch-check option
Date: Wed, 23 Apr 2008 15:17:46 -0400
Message-ID: <1208978273-98146-5-git-send-email-aroben@apple.com>
References: <1208978273-98146-1-git-send-email-aroben@apple.com>
 <1208978273-98146-2-git-send-email-aroben@apple.com>
 <1208978273-98146-3-git-send-email-aroben@apple.com>
 <1208978273-98146-4-git-send-email-aroben@apple.com>
Cc: Adam Roben <aroben@apple.com>, Junio C Hamano <gitster@pobox.com>,
	Brian Downing <bdowning@lavos.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 21:20:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JokV2-00058u-Lr
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 21:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766AbYDWTSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 15:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753617AbYDWTSh
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 15:18:37 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:49410 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967AbYDWTSA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 15:18:00 -0400
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out3.apple.com (Postfix) with ESMTP id 5E72E293B005;
	Wed, 23 Apr 2008 12:18:00 -0700 (PDT)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id 4558928042;
	Wed, 23 Apr 2008 12:18:00 -0700 (PDT)
X-AuditID: 1180711d-ac398bb000000ed7-2e-480f8b6744cd
Received: from localhost.localdomain (unknown [17.151.126.45])
	by relay13.apple.com (Apple SCV relay) with ESMTP id 4181628085;
	Wed, 23 Apr 2008 12:17:59 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.152.g9aeb7
In-Reply-To: <1208978273-98146-4-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80243>

This new option allows multiple objects to be specified on stdin. For each
object specified, a line of the following form is printed:

<sha1> SP <type> SP <size> LF

If the object does not exist in the repository, a line of the following form is
printed:

<object> SP missing LF

Signed-off-by: Adam Roben <aroben@apple.com>
---
Junio C Hamano <gitster@pobox.com> wrote:
> Here is an alternative suggestion.
> 
>    Two new options, --batch and --batch-check, are introduced.
>    These options are incompatible with -[tsep] or an object type
>    given as the first parameter to git-cat-file.
> 
>    * git-cat-file --batch-check <list-of-sha1
> 
>      outputs a record of this form
> 
>           <sha1> SP <type> SP <size> LF
> 
>      for each of the input lines.
> 
>    * git-cat-file --batch <list-of-sha1
> 
>      outputs a record of this form
> 
>           <sha1> SP <type> SP <size> LF <contents> LF
> 
>      for each of the input lines.
> 
>   For a missing object, either option gives a record of form:
> 
>           <sha1> SP missing LF

This patch introduces --batch-check as described above. The next patch introduces --batch.

 Documentation/git-cat-file.txt |   31 ++++++++++++++---
 builtin-cat-file.c             |   74 ++++++++++++++++++++++++++++++++++++++-
 t/t1006-cat-file.sh            |   52 ++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index df42cb1..d5821af 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -9,12 +9,16 @@ git-cat-file - Provide content or type/size information for repository objects
 SYNOPSIS
 --------
 'git-cat-file' [-t | -s | -e | -p | <type>] <object>
+'git-cat-file' --batch-check < <list-of-objects>
 
 DESCRIPTION
 -----------
-Provides content or type of objects in the repository. The type
-is required unless '-t' or '-p' is used to find the object type,
-or '-s' is used to find the object size.
+In the first form, provides content or type of objects in the repository. The
+type is required unless '-t' or '-p' is used to find the object type, or '-s'
+is used to find the object size.
+
+In the second form, a list of object (separated by LFs) is provided on stdin,
+and the SHA1, type, and size of each object is printed on stdout.
 
 OPTIONS
 -------
@@ -46,6 +50,10 @@ OPTIONS
 	or to ask for a "blob" with <object> being a tag object that
 	points at it.
 
+--batch-check::
+	Print the SHA1, type, and size of each object provided on stdin. May not be
+	combined with any other options or arguments.
+
 OUTPUT
 ------
 If '-t' is specified, one of the <type>.
@@ -56,9 +64,22 @@ If '-e' is specified, no output.
 
 If '-p' is specified, the contents of <object> are pretty-printed.
 
-Otherwise the raw (though uncompressed) contents of the <object> will
-be returned.
+If <type> is specified, the raw (though uncompressed) contents of the <object>
+will be returned.
+
+If '--batch-check' is specified, output of the following form is printed for
+each object specified fon stdin:
+
+------------
+<sha1> SP <type> SP <size> LF
+------------
+
+Additionally, output of the following form is printed for each object specified
+on stdin that does not exist in the repository:
 
+------------
+<object> SP missing LF
+------------
 
 Author
 ------
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index a76bb16..832cfd1 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -143,11 +143,48 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 	return 0;
 }
 
-static const char cat_file_usage[] = "git-cat-file [-t|-s|-e|-p|<type>] <sha1>";
+static int batch_one_object(const char *obj_name)
+{
+	unsigned char sha1[20];
+	enum object_type type;
+	unsigned long size;
+
+	if (!obj_name)
+	   return 1;
+
+	if (get_sha1(obj_name, sha1)) {
+		printf("%s missing\n", obj_name);
+		return 0;
+	}
+
+	type = sha1_object_info(sha1, &size);
+	if (type <= 0)
+		return 1;
+
+	printf("%s %s %lu\n", sha1_to_hex(sha1), typename(type), size);
+
+	return 0;
+}
+
+static int batch_objects(void)
+{
+	struct strbuf buf;
+
+	strbuf_init(&buf, 0);
+	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+		int error = batch_one_object(buf.buf);
+		if (error)
+			return error;
+	}
+
+	return 0;
+}
+
+static const char cat_file_usage[] = "git-cat-file [ [-t|-s|-e|-p|<type>] <sha1> | --batch-check < <list_of_sha1s> ]";
 
 int cmd_cat_file(int argc, const char **argv, const char *prefix)
 {
-	int i, opt = 0;
+	int i, opt = 0, batch_check = 0;
 	const char *exp_type = NULL, *obj_name = NULL;
 
 	git_config(git_default_config);
@@ -155,7 +192,28 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; ++i) {
 		const char *arg = argv[i];
 
+		if (!strcmp(arg, "--batch-check")) {
+			if (opt) {
+				error("git-cat-file: Can't use --batch-check with -%c", opt);
+				usage(cat_file_usage);
+			} else if (exp_type) {
+				error("git-cat-file: Can't use --batch-check when a type (\"%s\") is specified", exp_type);
+				usage(cat_file_usage);
+			} else if (obj_name) {
+				error("git-cat-file: Can't use --batch-check when an object (\"%s\") is specified", obj_name);
+				usage(cat_file_usage);
+			}
+
+			batch_check = 1;
+			continue;
+		}
+
 		if (!strcmp(arg, "-t") || !strcmp(arg, "-s") || !strcmp(arg, "-e") || !strcmp(arg, "-p")) {
+			if (batch_check) {
+				error("git-cat-file: Can't use %s with --batch-check", arg);
+				usage(cat_file_usage);
+			}
+
 			exp_type = arg;
 			opt = exp_type[1];
 			continue;
@@ -165,6 +223,11 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 			usage(cat_file_usage);
 
 		if (!exp_type) {
+			if (batch_check) {
+				error("git-cat-file: Can't specify a type (\"%s\") with --batch-check", arg);
+				usage(cat_file_usage);
+			}
+
 			exp_type = arg;
 			continue;
 		}
@@ -172,10 +235,17 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		if (obj_name)
 			usage(cat_file_usage);
 
+		// We should have hit one of the earlier if (batch_check) cases before
+		// getting here.
+		assert(!batch_check);
+
 		obj_name = arg;
 		break;
 	}
 
+	if (batch_check)
+		return batch_objects();
+
 	if (!exp_type || !obj_name)
 		usage(cat_file_usage);
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 15741d9..46b0f54 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -47,6 +47,9 @@ function run_tests()
     test_expect_success \
         "Pretty content of $type is correct" \
         "test \"\$(maybe_remove_timestamp '$pretty_content' $no_timestamp)\" = \"\$(maybe_remove_timestamp \"\$(git cat-file -p $sha1)\" $no_timestamp)\""
+    test_expect_success \
+        "--batch-check output of $type is correct" \
+        "test \"$sha1 $type $size\" = \"\$(echo_without_newline $sha1 | git cat-file --batch-check)\""
 }
 
 hello_content="Hello World"
@@ -98,4 +101,53 @@ test_expect_success \
     "Reach a blob from a tag pointing to it" \
     "test '$hello_content' = \"\$(git cat-file blob $tag_sha1)\""
 
+for opt in t s e p; do
+    test_expect_success \
+        "Passing -$opt with --batch-check fails" \
+        "test_must_fail git cat-file --batch-check -$opt $hello_sha1"
+
+    test_expect_success \
+        "Passing --batch-check with -$opt fails" \
+        "test_must_fail git cat-file -$opt --batch-check $hello_sha1"
+done
+
+test_expect_success \
+    "Passing <type> with --batch-check fails" \
+    "test_must_fail git cat-file --batch-check blob $hello_sha1"
+
+test_expect_success \
+    "Passing --batch-check with <type> fails" \
+    "test_must_fail git cat-file blob --batch-check $hello_sha1"
+
+test_expect_success \
+    "Passing sha1 with --batch-check fails" \
+    "test_must_fail git cat-file --batch-check $hello_sha1"
+
+test_expect_success \
+    "--batch-check for a non-existent object" \
+    "test \"deadbeef missing\" = \"\$(echo_without_newline deadbeef | git cat-file --batch-check)\""
+
+test_expect_success \
+    "--batch-check for an emtpy line" \
+    "test \" missing\" = \"\$(printf \"\\\\n\" | git cat-file --batch-check)\""
+
+batch_check_input="$hello_sha1
+$tree_sha1
+$commit_sha1
+$tag_sha1
+deadbeef
+
+"
+
+batch_check_output="$hello_sha1 blob $hello_size
+$tree_sha1 tree $tree_size
+$commit_sha1 commit $commit_size
+$tag_sha1 tag $tag_size
+deadbeef missing
+ missing"
+
+test_expect_success \
+    "--batch-check with multiple sha1s gives correct format" \
+    "test \"$batch_check_output\" = \"\$(echo_without_newline \"$batch_check_input\" | git cat-file --batch-check)\""
+
 test_done
-- 
1.5.5.1.152.g9aeb7
