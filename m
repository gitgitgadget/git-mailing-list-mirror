From: Adam Roben <aroben@apple.com>
Subject: [PATCH 08/11] git-hash-object: Add --stdin-paths option
Date: Wed, 23 Apr 2008 15:17:50 -0400
Message-ID: <1208978273-98146-9-git-send-email-aroben@apple.com>
References: <1208978273-98146-1-git-send-email-aroben@apple.com>
 <1208978273-98146-2-git-send-email-aroben@apple.com>
 <1208978273-98146-3-git-send-email-aroben@apple.com>
 <1208978273-98146-4-git-send-email-aroben@apple.com>
 <1208978273-98146-5-git-send-email-aroben@apple.com>
 <1208978273-98146-6-git-send-email-aroben@apple.com>
 <1208978273-98146-7-git-send-email-aroben@apple.com>
 <1208978273-98146-8-git-send-email-aroben@apple.com>
Cc: Adam Roben <aroben@apple.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 21:20:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JokUw-00058u-Ki
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 21:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127AbYDWTSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 15:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754861AbYDWTSJ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 15:18:09 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:49422 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbYDWTSE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 15:18:04 -0400
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out3.apple.com (Postfix) with ESMTP id 22A39293B00E;
	Wed, 23 Apr 2008 12:18:04 -0700 (PDT)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id 0A23228042;
	Wed, 23 Apr 2008 12:18:04 -0700 (PDT)
X-AuditID: 1180711d-ae39cbb000000ed7-3d-480f8b6be4ed
Received: from localhost.localdomain (unknown [17.151.126.45])
	by relay13.apple.com (Apple SCV relay) with ESMTP id 3319D28050;
	Wed, 23 Apr 2008 12:18:03 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.152.g9aeb7
In-Reply-To: <1208978273-98146-8-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80244>

This allows multiple paths to be specified on stdin.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 Documentation/git-hash-object.txt |    5 +++-
 hash-object.c                     |   44 ++++++++++++++++++++++++++++++++++++-
 t/t1007-hash-object.sh            |   32 ++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 33030c0..99a2143 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -8,7 +8,7 @@ git-hash-object - Compute object ID and optionally creates a blob from a file
 
 SYNOPSIS
 --------
-'git-hash-object' [-t <type>] [-w] [--stdin] [--] <file>...
+'git-hash-object' [-t <type>] [-w] [--stdin | --stdin-paths] [--] <file>...
 
 DESCRIPTION
 -----------
@@ -32,6 +32,9 @@ OPTIONS
 --stdin::
 	Read the object from standard input instead of from a file.
 
+--stdin-paths::
+	Read file names from stdin instead of from the command-line.
+
 Author
 ------
 Written by Junio C Hamano <junkio@cox.net>
diff --git a/hash-object.c b/hash-object.c
index 61e7160..1b39162 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -20,6 +20,7 @@ static void hash_object(const char *path, enum object_type type, int write_objec
 		    ? "Unable to add %s to database"
 		    : "Unable to hash %s", path);
 	printf("%s\n", sha1_to_hex(sha1));
+	maybe_flush_or_die(stdout, "hash to stdout");
 }
 
 static void hash_stdin(const char *type, int write_object)
@@ -30,8 +31,27 @@ static void hash_stdin(const char *type, int write_object)
 	printf("%s\n", sha1_to_hex(sha1));
 }
 
+static int hash_stdin_paths(const char *type, int write_objects)
+{
+	struct strbuf buf, nbuf;
+
+	strbuf_init(&buf, 0);
+	strbuf_init(&nbuf, 0);
+	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+		if (buf.buf[0] == '"') {
+			strbuf_reset(&nbuf);
+			if (unquote_c_style(&nbuf, buf.buf, NULL))
+				die("line is badly quoted");
+			strbuf_swap(&buf, &nbuf);
+		}
+		hash_object(buf.buf, type_from_string(type), write_objects);
+	}
+	strbuf_release(&buf);
+	strbuf_release(&nbuf);
+}
+
 static const char hash_object_usage[] =
-"git-hash-object [-t <type>] [-w] [--stdin] <file>...";
+"git-hash-object [ [-t <type>] [-w] [--stdin] <file>... | --stdin-paths < <list-of-paths> ]";
 
 int main(int argc, char **argv)
 {
@@ -42,6 +62,7 @@ int main(int argc, char **argv)
 	int prefix_length = -1;
 	int no_more_flags = 0;
 	int hashstdin = 0;
+	int stdin_paths = 0;
 
 	git_config(git_default_config);
 
@@ -65,7 +86,19 @@ int main(int argc, char **argv)
 			}
 			else if (!strcmp(argv[i], "--help"))
 				usage(hash_object_usage);
+			else if (!strcmp(argv[i], "--stdin-paths")) {
+				if (hashstdin) {
+					error("Can't use --stdin-paths with --stdin");
+					usage(hash_object_usage);
+				}
+				stdin_paths = 1;
+
+			}
 			else if (!strcmp(argv[i], "--stdin")) {
+				if (stdin_paths) {
+					error("Can't use %s with --stdin-paths", argv[i]);
+					usage(hash_object_usage);
+				}
 				if (hashstdin)
 					die("Multiple --stdin arguments are not supported");
 				hashstdin = 1;
@@ -76,6 +109,11 @@ int main(int argc, char **argv)
 		else {
 			const char *arg = argv[i];
 
+			if (stdin_paths) {
+				error("Can't specify files (such as \"%s\") with --stdin-paths", arg);
+				usage(hash_object_usage);
+			}
+
 			if (hashstdin) {
 				hash_stdin(type, write_object);
 				hashstdin = 0;
@@ -87,6 +125,10 @@ int main(int argc, char **argv)
 			no_more_flags = 1;
 		}
 	}
+
+	if (stdin_paths)
+		return hash_stdin_paths(type, write_object);
+
 	if (hashstdin)
 		hash_stdin(type, write_object);
 	return 0;
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index eb54f1f..dbb4129 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -58,6 +58,15 @@ test_expect_success \
     "multiple '--stdin's are rejected" \
     "test_must_fail git hash-object --stdin --stdin < example"
 
+test_expect_success \
+    "Can't use --stdin and --stdin-paths together" \
+    "test_must_fail git hash-object --stdin --stdin-paths &&
+     test_must_fail git hash-object --stdin-paths --stdin"
+
+test_expect_success \
+    "Can't pass filenames as arguments with --stdin-paths" \
+    "test_must_fail git hash-object --stdin-paths hello < example"
+
 # Behavior
 
 push_repo
@@ -104,4 +113,27 @@ for args in "-w --stdin" "--stdin -w"; do
     pop_repo
 done
 
+filenames="hello
+example"
+
+sha1s="$hello_sha1
+$example_sha1"
+
+test_expect_success \
+    "hash two files with names on stdin" \
+    "test \"$sha1s\" = \"\$(echo_without_newline \"$filenames\" | git hash-object --stdin-paths)\""
+
+for args in "-w --stdin-paths" "--stdin-paths -w"; do
+    push_repo
+
+        test_expect_success \
+            "hash two files with names on stdin and write to database ($args)" \
+            "test \"$sha1s\" = \"\$(echo_without_newline \"$filenames\" | git hash-object $args)\""
+
+        test_blob_exists $hello_sha1
+        test_blob_exists $example_sha1
+
+    pop_repo
+done
+
 test_done
-- 
1.5.5.1.152.g9aeb7
