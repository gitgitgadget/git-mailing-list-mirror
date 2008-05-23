From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 3/8] git-hash-object: Add --stdin-paths option
Date: Fri, 23 May 2008 16:19:38 +0200
Message-ID: <1211552384-29636-4-git-send-email-barra_cuda@katamail.com>
References: <1211552384-29636-1-git-send-email-barra_cuda@katamail.com>
Cc: git@vger.kernel.org
To: aroben@apple.com
X-From: git-owner@vger.kernel.org Fri May 23 16:17:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzY52-00066y-3i
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 16:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744AbYEWOQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 10:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753716AbYEWOQO
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 10:16:14 -0400
Received: from smtp.katamail.com ([62.149.157.154]:51292 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751586AbYEWOQM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 10:16:12 -0400
Received: (qmail 31974 invoked by uid 89); 23 May 2008 14:14:52 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.207)
  by smtp1-pc with SMTP; 23 May 2008 14:14:51 -0000
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211552384-29636-1-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82708>

From: Adam Roben <aroben@apple.com>

This allows multiple paths to be specified on stdin.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 Documentation/git-hash-object.txt |    5 +++-
 hash-object.c                     |   45 ++++++++++++++++++++++++++++++++++++-
 t/t1007-hash-object.sh            |   32 ++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 2 deletions(-)

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
index 61e7160..0a7ac2f 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -6,6 +6,7 @@
  */
 #include "cache.h"
 #include "blob.h"
+#include "quote.h"
 
 static void hash_object(const char *path, enum object_type type, int write_object)
 {
@@ -20,6 +21,7 @@ static void hash_object(const char *path, enum object_type type, int write_objec
 		    ? "Unable to add %s to database"
 		    : "Unable to hash %s", path);
 	printf("%s\n", sha1_to_hex(sha1));
+	maybe_flush_or_die(stdout, "hash to stdout");
 }
 
 static void hash_stdin(const char *type, int write_object)
@@ -30,8 +32,27 @@ static void hash_stdin(const char *type, int write_object)
 	printf("%s\n", sha1_to_hex(sha1));
 }
 
+static void hash_stdin_paths(const char *type, int write_objects)
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
@@ -42,6 +63,7 @@ int main(int argc, char **argv)
 	int prefix_length = -1;
 	int no_more_flags = 0;
 	int hashstdin = 0;
+	int stdin_paths = 0;
 
 	git_config(git_default_config);
 
@@ -65,7 +87,19 @@ int main(int argc, char **argv)
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
@@ -76,6 +110,11 @@ int main(int argc, char **argv)
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
@@ -87,6 +126,10 @@ int main(int argc, char **argv)
 			no_more_flags = 1;
 		}
 	}
+
+	if (stdin_paths)
+		hash_stdin_paths(type, write_object);
+
 	if (hashstdin)
 		hash_stdin(type, write_object);
 	return 0;
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 2019ea7..0526295 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -52,6 +52,15 @@ test_expect_success "multiple '--stdin's are rejected" '
 	test_must_fail git hash-object --stdin --stdin < example
 '
 
+test_expect_success "Can't use --stdin and --stdin-paths together" '
+	test_must_fail git hash-object --stdin --stdin-paths &&
+	test_must_fail git hash-object --stdin-paths --stdin
+'
+
+test_expect_success "Can't pass filenames as arguments with --stdin-paths" '
+	test_must_fail git hash-object --stdin-paths hello < example
+'
+
 # Behavior
 
 push_repo
@@ -98,4 +107,27 @@ for args in "-w --stdin" "--stdin -w"; do
 	pop_repo
 done
 
+filenames="hello
+example"
+
+sha1s="$hello_sha1
+$example_sha1"
+
+test_expect_success "hash two files with names on stdin" '
+	test "$sha1s" = "$(echo_without_newline "$filenames" | git hash-object --stdin-paths)"
+'
+
+for args in "-w --stdin-paths" "--stdin-paths -w"; do
+	push_repo
+
+	test_expect_success "hash two files with names on stdin and write to database ($args)" '
+		test "$sha1s" = "$(echo_without_newline "$filenames" | git hash-object $args)"
+	'
+
+	test_blob_exists $hello_sha1
+	test_blob_exists $example_sha1
+
+	pop_repo
+done
+
 test_done
-- 
1.5.5.1
