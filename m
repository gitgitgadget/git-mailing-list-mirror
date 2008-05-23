From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 7/8] builtin-cat-file.c: use parse_options()
Date: Fri, 23 May 2008 16:19:42 +0200
Message-ID: <1211552384-29636-8-git-send-email-barra_cuda@katamail.com>
References: <1211552384-29636-1-git-send-email-barra_cuda@katamail.com>
Cc: git@vger.kernel.org
To: aroben@apple.com
X-From: git-owner@vger.kernel.org Fri May 23 16:17:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzY58-00066y-P0
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 16:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623AbYEWOQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 10:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753894AbYEWOQ1
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 10:16:27 -0400
Received: from smtp.katamail.com ([62.149.157.154]:51831 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751281AbYEWOQS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 10:16:18 -0400
Received: (qmail 581 invoked by uid 89); 23 May 2008 14:14:59 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.207)
  by smtp1-pc with SMTP; 23 May 2008 14:14:57 -0000
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211552384-29636-1-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82706>

This simplifies the option parsing.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 builtin-cat-file.c |  119 ++++++++++++++++++++--------------------------------
 1 files changed, 46 insertions(+), 73 deletions(-)

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index b4d0c25..5ef15a4 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -8,6 +8,10 @@
 #include "tag.h"
 #include "tree.h"
 #include "builtin.h"
+#include "parse-options.h"
+
+#define BATCH 1
+#define BATCH_CHECK 2
 
 static void pprint_tag(const unsigned char *sha1, const char *buf, unsigned long size)
 {
@@ -158,7 +162,7 @@ static int batch_one_object(const char *obj_name, int print_contents)
 		return 0;
 	}
 
-	if (print_contents)
+	if (print_contents == BATCH)
 		contents = read_sha1_file(sha1, &type, &size);
 	else
 		type = sha1_object_info(sha1, &size);
@@ -169,7 +173,7 @@ static int batch_one_object(const char *obj_name, int print_contents)
 	printf("%s %s %lu\n", sha1_to_hex(sha1), typename(type), size);
 	fflush(stdout);
 
-	if (print_contents) {
+	if (print_contents == BATCH) {
 		write_or_die(1, contents, size);
 		printf("\n");
 		fflush(stdout);
@@ -192,89 +196,58 @@ static int batch_objects(int print_contents)
 	return 0;
 }
 
-static const char cat_file_usage[] = "git-cat-file [ [-t|-s|-e|-p|<type>] <sha1> | [--batch|--batch-check] < <list_of_sha1s> ]";
+static const char * const cat_file_usage[] = {
+	"git-cat-file [-t|-s|-e|-p|<type>] <sha1>",
+	"git-cat-file [--batch|--batch-check] < <list_of_sha1s>",
+	NULL
+};
 
 int cmd_cat_file(int argc, const char **argv, const char *prefix)
 {
-	int i, opt = 0, batch = 0, batch_check = 0;
+	int opt = 0, batch = 0;
 	const char *exp_type = NULL, *obj_name = NULL;
 
-	git_config(git_default_config);
-
-	for (i = 1; i < argc; ++i) {
-		const char *arg = argv[i];
-		int is_batch = 0, is_batch_check = 0;
-
-		is_batch = !strcmp(arg, "--batch");
-		if (!is_batch)
-			is_batch_check = !strcmp(arg, "--batch-check");
-
-		if (is_batch || is_batch_check) {
-			if (opt) {
-				error("git-cat-file: Can't use %s with -%c", arg, opt);
-				usage(cat_file_usage);
-			} else if (exp_type) {
-				error("git-cat-file: Can't use %s when a type (\"%s\") is specified", arg, exp_type);
-				usage(cat_file_usage);
-			} else if (obj_name) {
-				error("git-cat-file: Can't use %s when an object (\"%s\") is specified", arg, obj_name);
-				usage(cat_file_usage);
-			}
-
-			if ((is_batch && batch_check) || (is_batch_check && batch)) {
-				error("git-cat-file: Can't use %s with %s", arg, is_batch ? "--batch-check" : "--batch");
-				usage(cat_file_usage);
-			}
-
-			if (is_batch)
-				batch = 1;
-			else
-				batch_check = 1;
+	const struct option options[] = {
+		OPT_GROUP("<type> can be one of: blob, tree, commit, tag"),
+		OPT_SET_INT('t', NULL, &opt, "show object type", 't'),
+		OPT_SET_INT('s', NULL, &opt, "show object size", 's'),
+		OPT_SET_INT('e', NULL, &opt,
+			    "exit with zero when there's no error", 'e'),
+		OPT_SET_INT('p', NULL, &opt, "pretty-print object's content", 'p'),
+		OPT_SET_INT(0, "batch", &batch,
+			    "show info and content of objects feeded on stdin", BATCH),
+		OPT_SET_INT(0, "batch-check", &batch,
+			    "show info about objects feeded on stdin",
+			    BATCH_CHECK),
+		OPT_END()
+	};
 
-			continue;
-		}
-
-		if (!strcmp(arg, "-t") || !strcmp(arg, "-s") || !strcmp(arg, "-e") || !strcmp(arg, "-p")) {
-			if (batch || batch_check) {
-				error("git-cat-file: Can't use %s with %s", arg, batch ? "--batch" : "--batch-check");
-				usage(cat_file_usage);
-			}
-
-			exp_type = arg;
-			opt = exp_type[1];
-			continue;
-		}
-
-		if (arg[0] == '-')
-			usage(cat_file_usage);
-
-		if (!exp_type) {
-			if (batch || batch_check) {
-				error("git-cat-file: Can't specify a type (\"%s\") with %s", arg, batch ? "--batch" : "--batch-check");
-				usage(cat_file_usage);
-			}
-
-			exp_type = arg;
-			continue;
-		}
+	git_config(git_default_config);
 
-		if (obj_name)
-			usage(cat_file_usage);
+	if (argc != 3 && argc != 2)
+		usage_with_options(cat_file_usage, options);
 
-		// We should have hit one of the earlier if (batch || batch_check) cases before
-		// getting here.
-		assert(!batch);
-		assert(!batch_check);
+	argc = parse_options(argc, argv, options, cat_file_usage, 0);
 
-		obj_name = arg;
-		break;
+	if (opt) {
+		if (argc == 1)
+			obj_name = argv[0];
+		else
+			usage_with_options(cat_file_usage, options);
+	}
+	if (!opt && !batch) {
+		if (argc == 2) {
+			exp_type = argv[0];
+			obj_name = argv[1];
+		} else
+			usage_with_options(cat_file_usage, options);
+	}
+	if (batch && (opt || argc)) {
+		usage_with_options(cat_file_usage, options);
 	}
 
-	if (batch || batch_check)
+	if (batch)
 		return batch_objects(batch);
 
-	if (!exp_type || !obj_name)
-		usage(cat_file_usage);
-
 	return cat_one_file(opt, exp_type, obj_name);
 }
-- 
1.5.5.1
