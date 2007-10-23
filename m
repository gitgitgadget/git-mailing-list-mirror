From: Adam Roben <aroben@apple.com>
Subject: [PATCH 4/9] git-cat-file: Add --stdin option
Date: Mon, 22 Oct 2007 22:46:32 -0700
Message-ID: <1193118397-4696-5-git-send-email-aroben@apple.com>
References: <1193118397-4696-1-git-send-email-aroben@apple.com>
 <1193118397-4696-2-git-send-email-aroben@apple.com>
 <1193118397-4696-3-git-send-email-aroben@apple.com>
 <1193118397-4696-4-git-send-email-aroben@apple.com>
Cc: Junio C Hamano <gitster@pobox.com>, Adam Roben <aroben@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 07:48:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkCch-0007YT-HG
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 07:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbXJWFrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 01:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbXJWFrT
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 01:47:19 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:57266 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbXJWFrM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 01:47:12 -0400
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out4.apple.com (Postfix) with ESMTP id 88BB316874AD;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id 5D10028055;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
X-AuditID: 11807134-a765dbb000000c52-5f-471d8adf1f21
Received: from localhost.localdomain (aroben3.apple.com [17.203.12.72])
	by relay14.apple.com (Apple SCV relay) with ESMTP id 343322804C;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.1333.ga2f32
In-Reply-To: <1193118397-4696-4-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62100>

This lets you specify object names on stdin instead of on the command line.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 Documentation/git-cat-file.txt |    6 +++++-
 builtin-cat-file.c             |   26 ++++++++++++++++++++++----
 t/t1005-cat-file.sh            |   14 ++++++++++++++
 3 files changed, 41 insertions(+), 5 deletions(-)

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
index 3a0be4a..0f1ffe5 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -143,12 +143,14 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 	return 0;
 }
 
-static const char cat_file_usage[] = "git-cat-file [-t|-s|-e|-p|<type>] <sha1>";
+static const char cat_file_usage[] = "git-cat-file [-t|-s|-e|-p|<type>] [--stdin | <sha1>]";
 
 int cmd_cat_file(int argc, const char **argv, const char *prefix)
 {
 	int i, opt = 0;
+	int read_stdin = 0;
 	const char *exp_type = 0, *obj_name = 0;
+	struct strbuf buf;
 
 	git_config(git_default_config);
 
@@ -161,6 +163,11 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
+		if (!strcmp(arg, "--stdin")) {
+		    read_stdin = 1;
+		    continue;
+		}
+
 		if (arg[0] == '-')
 			usage(cat_file_usage);
 
@@ -169,15 +176,26 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (obj_name)
+		if (obj_name || read_stdin)
 			usage(cat_file_usage);
 
 		obj_name = arg;
 		break;
 	}
 
-	if (!exp_type || !obj_name)
+	if (!read_stdin) {
+	    if (!exp_type || !obj_name)
 		usage(cat_file_usage);
+	    return cat_one_file(opt, exp_type, obj_name);
+	}
 
-	return cat_one_file(opt, exp_type, obj_name);
+	strbuf_init(&buf, 0);
+	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+		int error = cat_one_file(opt, exp_type, buf.buf);
+		if (error)
+			return error;
+	}
+	strbuf_release(&buf);
+
+	return 0;
 }
diff --git a/t/t1005-cat-file.sh b/t/t1005-cat-file.sh
index 2fdc446..49eb89d 100755
--- a/t/t1005-cat-file.sh
+++ b/t/t1005-cat-file.sh
@@ -88,4 +88,18 @@ test_expect_success \
     "Reach a blob from a tag pointing to it" \
     "test \"$hello_content\" = \"$(git cat-file blob $tag_sha1)\""
 
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
+    "Pass object hashes on stdin" \
+    "test \"$sizes\" = \"$(echo "$sha1s" | git cat-file -s --stdin)\""
+
 test_done
-- 
1.5.3.4.1333.ga2f32
