From: Adam Roben <aroben@apple.com>
Subject: [PATCH 7/9] git-hash-object: Add --stdin-paths option
Date: Mon, 22 Oct 2007 22:46:35 -0700
Message-ID: <1193118397-4696-8-git-send-email-aroben@apple.com>
References: <1193118397-4696-1-git-send-email-aroben@apple.com>
 <1193118397-4696-2-git-send-email-aroben@apple.com>
 <1193118397-4696-3-git-send-email-aroben@apple.com>
 <1193118397-4696-4-git-send-email-aroben@apple.com>
 <1193118397-4696-5-git-send-email-aroben@apple.com>
 <1193118397-4696-6-git-send-email-aroben@apple.com>
 <1193118397-4696-7-git-send-email-aroben@apple.com>
Cc: Junio C Hamano <gitster@pobox.com>, Adam Roben <aroben@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 07:48:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkCcj-0007YT-GU
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 07:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbXJWFr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 01:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbXJWFrZ
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 01:47:25 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:61934 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbXJWFrM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 01:47:12 -0400
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out3.apple.com (Postfix) with ESMTP id ACFE215F2466;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id 92CD7280A1;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
X-AuditID: 11807134-a665bbb000000c52-62-471d8adf236d
Received: from localhost.localdomain (aroben3.apple.com [17.203.12.72])
	by relay14.apple.com (Apple SCV relay) with ESMTP id 6ADAE28095;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.1333.ga2f32
In-Reply-To: <1193118397-4696-7-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62103>

This allows multiple paths to be specified on stdin.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 Documentation/git-hash-object.txt |    5 ++++-
 hash-object.c                     |   29 ++++++++++++++++++++++++++++-
 t/t1006-hash-object.sh            |   22 ++++++++++++++++++++++
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 616f196..50fc401 100644
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
index 18f5017..fd96d50 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -20,6 +20,7 @@ static void hash_object(const char *path, enum object_type type, int write_objec
 		    ? "Unable to add %s to database"
 		    : "Unable to hash %s", path);
 	printf("%s\n", sha1_to_hex(sha1));
+	maybe_flush_or_die(stdout, "hash to stdout");
 }
 
 static void hash_stdin(const char *type, int write_object)
@@ -31,7 +32,7 @@ static void hash_stdin(const char *type, int write_object)
 }
 
 static const char hash_object_usage[] =
-"git-hash-object [-t <type>] [-w] [--stdin] <file>...";
+"git-hash-object [-t <type>] [-w] [--stdin | --stdin-paths] <file>...";
 
 int main(int argc, char **argv)
 {
@@ -41,6 +42,7 @@ int main(int argc, char **argv)
 	const char *prefix = NULL;
 	int prefix_length = -1;
 	int no_more_flags = 0;
+	int found_stdin_flag = 0;
 
 	for (i = 1 ; i < argc; i++) {
 		if (!no_more_flags && argv[i][0] == '-') {
@@ -62,7 +64,32 @@ int main(int argc, char **argv)
 			}
 			else if (!strcmp(argv[i], "--help"))
 				usage(hash_object_usage);
+			else if (!strcmp(argv[i], "--stdin-paths")) {
+				struct strbuf buf, nbuf;
+
+				if (found_stdin_flag)
+					die("Can't use both --stdin and --stdin-paths");
+				found_stdin_flag = 1;
+
+				strbuf_init(&buf, 0);
+				strbuf_init(&nbuf, 0);
+				while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+					if (buf.buf[0] == '"') {
+						strbuf_reset(&nbuf);
+						if (unquote_c_style(&nbuf, buf.buf, NULL))
+							die("line is badly quoted");
+						strbuf_swap(&buf, &nbuf);
+					}
+					hash_object(buf.buf, type_from_string(type), write_object);
+				}
+				strbuf_release(&buf);
+				strbuf_release(&nbuf);
+			}
 			else if (!strcmp(argv[i], "--stdin")) {
+				if (found_stdin_flag)
+					die("Can't use both --stdin and --stdin-paths");
+				found_stdin_flag = 1;
+
 				hash_stdin(type, write_object);
 			}
 			else
diff --git a/t/t1006-hash-object.sh b/t/t1006-hash-object.sh
index 77b8eca..e6da1c1 100755
--- a/t/t1006-hash-object.sh
+++ b/t/t1006-hash-object.sh
@@ -24,4 +24,26 @@ test_expect_success \
     'hash from stdin and write to database' \
     "test $hello_sha1 = $(echo "$hello_content" | git hash-object -w --stdin)"
 
+example_content="Silly example"
+example_sha1=f24c74a2e500f5ee1332c86b94199f52b1d1d962
+echo "$example_content" > example
+
+filenames="hello
+example"
+
+sha1s="$hello_sha1
+$example_sha1"
+
+test_expect_success \
+    'hash two files with names on stdin' \
+    "test \"$sha1s\" = \"$(echo "$filenames" | git hash-object --stdin-paths)\""
+
+test_expect_success \
+    'hash two files with names on stdin and write to database' \
+    "test \"$sha1s\" = \"$(echo "$filenames" | git hash-object --stdin-paths)\""
+
+test_expect_failure \
+    "Can't use --stdin and --stdin-paths together" \
+    "echo \"$filenames\" | git hash-object --stdin --stdin-paths"
+
 test_done
-- 
1.5.3.4.1333.ga2f32
