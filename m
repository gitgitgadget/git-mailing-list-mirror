From: Adam Roben <aroben@apple.com>
Subject: [PATCH 4/9] git-cat-file: Add --stdin option
Date: Thu, 25 Oct 2007 03:25:22 -0700
Message-ID: <1193307927-3592-5-git-send-email-aroben@apple.com>
References: <1193307927-3592-1-git-send-email-aroben@apple.com>
 <1193307927-3592-2-git-send-email-aroben@apple.com>
 <1193307927-3592-3-git-send-email-aroben@apple.com>
 <1193307927-3592-4-git-send-email-aroben@apple.com>
Cc: Junio Hamano <gitster@pobox.com>, Adam Roben <aroben@apple.com>,
	Brian Downing <bdowning@lavos.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 12:27:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikzvi-0007WS-Aa
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 12:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756048AbXJYK0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 06:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756372AbXJYK0Q
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 06:26:16 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:63565 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756048AbXJYK0G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 06:26:06 -0400
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out3.apple.com (Postfix) with ESMTP id 928331639CF2;
	Thu, 25 Oct 2007 03:26:05 -0700 (PDT)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id 7D8E7280A8;
	Thu, 25 Oct 2007 03:26:05 -0700 (PDT)
X-AuditID: 11807134-a765dbb000000c52-44-47206f3d05f9
Received: from localhost.localdomain (aroben3.apple.com [17.203.12.72])
	by relay14.apple.com (Apple SCV relay) with ESMTP id 570B72808E;
	Thu, 25 Oct 2007 03:26:05 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.1342.g32de
In-Reply-To: <1193307927-3592-4-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62300>

This lets you specify object names on stdin instead of on the command line.
When printing object contents or pretty-printing, objects will be printed
preceded by their size:

<size>LF
<content>LF

Signed-off-by: Adam Roben <aroben@apple.com>
---
Brian Downing wrote:
> I think a far more reasonable output format for multiple objects would
> be something like:
> 
> <count> LF
> <raw data> LF
> 
> Where <count> is the number of bytes in the <raw data> as an ASCII
> decimal integer.

Agreed.

 Documentation/git-cat-file.txt |    6 ++++-
 builtin-cat-file.c             |   43 ++++++++++++++++++++++++++++++++++-----
 t/t1005-cat-file.sh            |   35 ++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index afa095c..588d71a 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -8,7 +8,7 @@ git-cat-file - Provide content or type/size information for repository objects
 
 SYNOPSIS
 --------
-'git-cat-file' [-t | -s | -e | -p | <type>] <object>
+'git-cat-file' [-t | -s | -e | -p | <type>] [--stdin | <object>]
 
 DESCRIPTION
 -----------
@@ -23,6 +23,10 @@ OPTIONS
 	For a more complete list of ways to spell object names, see
 	"SPECIFYING REVISIONS" section in gitlink:git-rev-parse[1].
 
+--stdin::
+	Read object names from stdin instead of specifying one on the
+	command line.
+
 -t::
 	Instead of the content, show the object type identified by
 	<object>.
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 3a0be4a..ee46ba4 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -76,7 +76,7 @@ static void pprint_tag(const unsigned char *sha1, const char *buf, unsigned long
 		write_or_die(1, cp, endp - cp);
 }
 
-static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
+static int cat_one_file(int opt, const char *exp_type, const char *obj_name, int print_size)
 {
 	unsigned char sha1[20];
 	enum object_type type;
@@ -139,16 +139,26 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 	if (!buf)
 		die("git-cat-file %s: bad file", obj_name);
 
+	if (print_size) {
+		printf("%lu\n", size);
+		fflush(stdout);
+	}
 	write_or_die(1, buf, size);
+	if (print_size) {
+		printf("\n");
+		fflush(stdout);
+	}
 	return 0;
 }
 
-static const char cat_file_usage[] = "git-cat-file [-t|-s|-e|-p|<type>] <sha1>";
+static const char cat_file_usage[] = "git-cat-file [-t|-s|-e|-p|<type>] [--stdin | <sha1>]";
 
 int cmd_cat_file(int argc, const char **argv, const char *prefix)
 {
-	int i, opt = 0;
+	int i, opt = 0, print_size = 0;
+	int read_stdin = 0;
 	const char *exp_type = 0, *obj_name = 0;
+	struct strbuf buf;
 
 	git_config(git_default_config);
 
@@ -161,6 +171,11 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
+		if (!strcmp(arg, "--stdin")) {
+		    read_stdin = 1;
+		    continue;
+		}
+
 		if (arg[0] == '-')
 			usage(cat_file_usage);
 
@@ -169,15 +184,31 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (obj_name)
+		if (obj_name || read_stdin)
 			usage(cat_file_usage);
 
 		obj_name = arg;
 		break;
 	}
 
-	if (!exp_type || !obj_name)
+	if (!exp_type)
 		usage(cat_file_usage);
 
-	return cat_one_file(opt, exp_type, obj_name);
+	if (!read_stdin) {
+		if (!obj_name)
+			usage(cat_file_usage);
+		return cat_one_file(opt, exp_type, obj_name, 0);
+	}
+
+	print_size = !opt || opt == 'p';
+
+	strbuf_init(&buf, 0);
+	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+		int error = cat_one_file(opt, exp_type, buf.buf, print_size);
+		if (error)
+			return error;
+	}
+	strbuf_release(&buf);
+
+	return 0;
 }
diff --git a/t/t1005-cat-file.sh b/t/t1005-cat-file.sh
index 697354d..2b2d386 100755
--- a/t/t1005-cat-file.sh
+++ b/t/t1005-cat-file.sh
@@ -88,4 +88,39 @@ test_expect_success \
     "Reach a blob from a tag pointing to it" \
     "test '$hello_content' = \"\$(git cat-file blob $tag_sha1)\""
 
+sha1s="$hello_sha1
+$tree_sha1
+$commit_sha1
+$tag_sha1"
+
+sizes="$hello_size
+$tree_size
+$commit_size
+$tag_size"
+
+test_expect_success \
+    "Pass object hashes on stdin to retrieve sizes" \
+    "test '$sizes' = \"\$(echo '$sha1s' | git cat-file -s --stdin)\""
+
+example_content="Silly example"
+example_size=$(echo "$example_content" | wc -c)
+example_sha1=f24c74a2e500f5ee1332c86b94199f52b1d1d962
+
+echo "$example_content" > example
+
+git update-index --add example
+
+sha1s="$hello_sha1
+$example_sha1"
+
+contents="$hello_size
+$hello_content
+
+$example_size
+$example_content"
+
+test_expect_success \
+    "Pass object hashes on stdin to retrieve contents" \
+    "test '$contents' = \"\$(echo '$sha1s' | git cat-file blob --stdin)\""
+
 test_done
-- 
1.5.3.4.1337.g8e67d-dirty
