From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 1/3] hash-object: add -v/--verbose option
Date: Mon,  2 Mar 2015 19:55:00 +0600
Message-ID: <1425304500-14117-1-git-send-email-kuleshovmail@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 14:55:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSQoY-0005Uk-TI
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 14:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbbCBNzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 08:55:14 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:41404 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbbCBNzN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 08:55:13 -0500
Received: by lbvp9 with SMTP id p9so7177968lbv.8
        for <git@vger.kernel.org>; Mon, 02 Mar 2015 05:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=U415gPzf7BG3YSe8z6jg2bdR03zHpJe0AEDVGi61X/0=;
        b=w5WCAdHU1VS8Vg7IpN4+OER97TphAQzDlhedRrYX32JIFRnYqXvSSVl7FFnorECxyA
         PRGcjsnnZpydnQ+2n6fDm7rEkM3nJS4sHm1lHfgbV8D29vb4i0WX9Qc0LgdLbsL9HMp2
         pH1YNziXb+gy1psy3pOv+QyzzPZaoiBZnq2mpq++xShJ/yLvSYvR0RUAOZyX5/T9p3oo
         6zvDMLySiEWGw4pRDko6GytUf62cQqX9Iim6u1bc5H43raeHp1QVHMATMcGdNimZw1W2
         Gz8KPReb/4VzcFxjgC5vGW6bBnSXLzjoU9VyFUvvZaT4NLSUbpP4ZjyD+PEjNAQcR3vO
         Dimg==
X-Received: by 10.112.181.41 with SMTP id dt9mr24901533lbc.56.1425304511761;
        Mon, 02 Mar 2015 05:55:11 -0800 (PST)
Received: from localhost.localdomain ([147.30.48.224])
        by mx.google.com with ESMTPSA id qw1sm2211875lbb.21.2015.03.02.05.55.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Mar 2015 05:55:10 -0800 (PST)
X-Mailer: git-send-email 2.3.1.167.g7f4ba4b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264595>

This patch provides ability to pass -v/--verbose option to the
git hash-object command. hash-object will print not only hash,
but also file path of a file from what hash was calculated.

It can be useful in scripting, especially with --stdin-paths
option.

For example:

$ git hash-object -v test
e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	test

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/hash-object.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 207b90c..97961ee 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -10,6 +10,8 @@
 #include "parse-options.h"
 #include "exec_cmd.h"
 
+static int verbose;
+
 /*
  * This is to create corrupt objects for debugging and as such it
  * needs to bypass the data conversion performed by, and the type
@@ -43,7 +45,10 @@ static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
 		die((flags & HASH_WRITE_OBJECT)
 		    ? "Unable to add %s to database"
 		    : "Unable to hash %s", path);
-	printf("%s\n", sha1_to_hex(sha1));
+	if (verbose)
+		printf("%s\t%s\n", sha1_to_hex(sha1), path);
+	else
+		printf("%s\n", sha1_to_hex(sha1));
 	maybe_flush_or_die(stdout, "hash to stdout");
 }
 
@@ -79,7 +84,7 @@ static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
 int cmd_hash_object(int argc, const char **argv, const char *prefix)
 {
 	static const char * const hash_object_usage[] = {
-		N_("git hash-object [-t <type>] [-w] [--path=<file> | --no-filters] [--stdin] [--] <file>..."),
+		N_("git hash-object [-t <type>] [-w] [-v] [--path=<file> | --no-filters] [--stdin] [--] <file>..."),
 		N_("git hash-object  --stdin-paths < <list-of-paths>"),
 		NULL
 	};
@@ -99,6 +104,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 		OPT_BOOL( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
 		OPT_BOOL( 0, "literally", &literally, N_("just hash any random garbage to create corrupt objects for debugging Git")),
 		OPT_STRING( 0 , "path", &vpath, N_("file"), N_("process file as it were from this path")),
+		OPT__VERBOSE(&verbose, N_("show hash and file path")),
 		OPT_END()
 	};
 	int i;
@@ -108,6 +114,11 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, NULL, hash_object_options,
 			     hash_object_usage, 0);
 
+	if (verbose & literally)
+		errstr = "Can't use --verbose with --literally";
+	else if (verbose & hashstdin)
+		errstr = "Can't use --verbose with --stdin";
+
 	if (flags & HASH_WRITE_OBJECT) {
 		prefix = setup_git_directory();
 		prefix_length = prefix ? strlen(prefix) : 0;
-- 
2.3.1.167.g7f4ba4b.dirty
