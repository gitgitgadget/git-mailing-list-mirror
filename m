From: Adam Roben <aroben@apple.com>
Subject: [PATCH 5/9] git-cat-file: Add --separator option
Date: Mon, 22 Oct 2007 22:46:33 -0700
Message-ID: <1193118397-4696-6-git-send-email-aroben@apple.com>
References: <1193118397-4696-1-git-send-email-aroben@apple.com>
 <1193118397-4696-2-git-send-email-aroben@apple.com>
 <1193118397-4696-3-git-send-email-aroben@apple.com>
 <1193118397-4696-4-git-send-email-aroben@apple.com>
 <1193118397-4696-5-git-send-email-aroben@apple.com>
Cc: Junio C Hamano <gitster@pobox.com>, Adam Roben <aroben@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 07:48:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkCci-0007YT-5l
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 07:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbXJWFrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 01:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbXJWFrW
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 01:47:22 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:61932 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbXJWFrM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 01:47:12 -0400
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out3.apple.com (Postfix) with ESMTP id 90FC215F2465;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id 68CFB28092;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
X-AuditID: 11807134-a8e60bb000000c52-60-471d8adfdfd8
Received: from localhost.localdomain (aroben3.apple.com [17.203.12.72])
	by relay14.apple.com (Apple SCV relay) with ESMTP id 47A2028085;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.1333.ga2f32
In-Reply-To: <1193118397-4696-5-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62101>

This lets the user specify a string to be printed in between the output from
each object passed on stdin.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 Documentation/git-cat-file.txt |    7 ++++++-
 builtin-cat-file.c             |   28 +++++++++++++++++++++++++---
 t/t1005-cat-file.sh            |   36 +++++++++++++++++++++++++++++++++++-
 3 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 588d71a..7a59a5e 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -8,7 +8,7 @@ git-cat-file - Provide content or type/size information for repository objects
 
 SYNOPSIS
 --------
-'git-cat-file' [-t | -s | -e | -p | <type>] [--stdin | <object>]
+'git-cat-file' [-t | -s | -e | -p | <type>] [--stdin [--separator <string>] | <object>]
 
 DESCRIPTION
 -----------
@@ -27,6 +27,11 @@ OPTIONS
 	Read object names from stdin instead of specifying one on the
 	command line.
 
+--separator::
+	A string to print in between the output for each object passed on
+	stdin. A newline will be appended to the separator each time it is
+	printed.
+
 -t::
 	Instead of the content, show the object type identified by
 	<object>.
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 0f1ffe5..9ae3184 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -92,6 +92,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 		type = sha1_object_info(sha1, NULL);
 		if (type > 0) {
 			printf("%s\n", typename(type));
+			fflush(stdout);
 			return 0;
 		}
 		break;
@@ -100,6 +101,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 		type = sha1_object_info(sha1, &size);
 		if (type > 0) {
 			printf("%lu\n", size);
+			fflush(stdout);
 			return 0;
 		}
 		break;
@@ -143,14 +145,16 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 	return 0;
 }
 
-static const char cat_file_usage[] = "git-cat-file [-t|-s|-e|-p|<type>] [--stdin | <sha1>]";
+static const char cat_file_usage[] = "git-cat-file [-t|-s|-e|-p|<type>] [--stdin [--separator <string>] | <sha1>]";
+
+static const char *separator;
 
 int cmd_cat_file(int argc, const char **argv, const char *prefix)
 {
 	int i, opt = 0;
 	int read_stdin = 0;
 	const char *exp_type = 0, *obj_name = 0;
-	struct strbuf buf;
+	struct strbuf buf, sbuf;
 
 	git_config(git_default_config);
 
@@ -168,6 +172,13 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		    continue;
 		}
 
+		if (!strcmp(arg, "--separator")) {
+			if (++i == argc)
+				usage(cat_file_usage);
+			separator = argv[i];
+			continue;
+		}
+
 		if (arg[0] == '-')
 			usage(cat_file_usage);
 
@@ -184,18 +195,29 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!read_stdin) {
-	    if (!exp_type || !obj_name)
+	    if (!exp_type || !obj_name || separator)
 		usage(cat_file_usage);
 	    return cat_one_file(opt, exp_type, obj_name);
 	}
 
+	if (separator) {
+		strbuf_init(&sbuf, 0);
+		strbuf_addstr(&sbuf, separator);
+		strbuf_addch(&sbuf, '\n');
+	}
+
 	strbuf_init(&buf, 0);
 	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
 		int error = cat_one_file(opt, exp_type, buf.buf);
 		if (error)
 			return error;
+		if (separator)
+			write_or_die(1, sbuf.buf, sbuf.len);
 	}
 	strbuf_release(&buf);
 
+	if (separator)
+		strbuf_release(&sbuf);
+
 	return 0;
 }
diff --git a/t/t1005-cat-file.sh b/t/t1005-cat-file.sh
index 49eb89d..52a3efd 100755
--- a/t/t1005-cat-file.sh
+++ b/t/t1005-cat-file.sh
@@ -99,7 +99,41 @@ $commit_size
 $tag_size"
 
 test_expect_success \
-    "Pass object hashes on stdin" \
+    "Print sizes for object hashes on stdin" \
     "test \"$sizes\" = \"$(echo "$sha1s" | git cat-file -s --stdin)\""
 
+separator="TESTSEPARATOR"
+
+separated_sizes="$hello_size
+$separator
+$tree_size
+$separator
+$commit_size
+$separator
+$tag_size
+$separator"
+
+test_expect_success \
+    "Print sizes for object hashes on stdin with --separator" \
+    "test \"$separated_sizes\" = \"$(echo "$sha1s" | git cat-file -s --stdin --separator $separator)\""
+
+sha1s="$hello_sha1
+$hello_sha1"
+
+contents="$hello_content
+$hello_content"
+
+separated_contents="$hello_content
+$separator
+$hello_content
+$separator"
+
+test_expect_success \
+    "Print objects for object hashes on stdin" \
+    "test \"$contents\" = \"$(echo "$sha1s" | git cat-file blob --stdin)\""
+
+test_expect_success \
+    "Print objects for object hashes on stdin with --separator" \
+    "test \"$separated_contents\" = \"$(echo "$sha1s" | git cat-file blob --stdin --separator $separator)\""
+
 test_done
-- 
1.5.3.4.1333.ga2f32
