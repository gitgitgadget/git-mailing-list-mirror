From: Jeff King <peff@peff.net>
Subject: [PATCH 05/10] cat-file: refactor --batch option parsing
Date: Wed, 10 Jul 2013 07:38:58 -0400
Message-ID: <20130710113858.GE21963@sigill.intra.peff.net>
References: <20130710113447.GA20113@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 10 13:39:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwsjl-00048W-A8
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 13:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451Ab3GJLjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 07:39:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:47777 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754320Ab3GJLjE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 07:39:04 -0400
Received: (qmail 25145 invoked by uid 102); 10 Jul 2013 11:40:19 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Jul 2013 06:40:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jul 2013 07:38:58 -0400
Content-Disposition: inline
In-Reply-To: <20130710113447.GA20113@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230046>

We currently use an int to tell us whether --batch parsing
is on, and if so, whether we should print the full object
contents. Let's instead factor this into a struct, filled in
by callback, which will make further batch-related options
easy to add.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 56 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 70dd8c8..5254fe8 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -13,9 +13,6 @@
 #include "userdiff.h"
 #include "streaming.h"
 
-#define BATCH 1
-#define BATCH_CHECK 2
-
 static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 {
 	unsigned char sha1[20];
@@ -142,7 +139,12 @@ static void print_object_or_die(int fd, const unsigned char *sha1,
 	}
 }
 
-static int batch_one_object(const char *obj_name, int print_contents)
+struct batch_options {
+	int enabled;
+	int print_contents;
+};
+
+static int batch_one_object(const char *obj_name, struct batch_options *opt)
 {
 	unsigned char sha1[20];
 	enum object_type type = 0;
@@ -167,19 +169,19 @@ static int batch_objects(int print_contents)
 	printf("%s %s %lu\n", sha1_to_hex(sha1), typename(type), size);
 	fflush(stdout);
 
-	if (print_contents == BATCH) {
+	if (opt->print_contents) {
 		print_object_or_die(1, sha1, type, size);
 		write_or_die(1, "\n", 1);
 	}
 	return 0;
 }
 
-static int batch_objects(int print_contents)
+static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf buf = STRBUF_INIT;
 
 	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
-		int error = batch_one_object(buf.buf, print_contents);
+		int error = batch_one_object(buf.buf, opt);
 		if (error)
 			return error;
 	}
@@ -201,10 +203,28 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	return git_default_config(var, value, cb);
 }
 
+static int batch_option_callback(const struct option *opt,
+				 const char *arg,
+				 int unset)
+{
+	struct batch_options *bo = opt->value;
+
+	if (unset) {
+		memset(bo, 0, sizeof(*bo));
+		return 0;
+	}
+
+	bo->enabled = 1;
+	bo->print_contents = !strcmp(opt->long_name, "batch");
+
+	return 0;
+}
+
 int cmd_cat_file(int argc, const char **argv, const char *prefix)
 {
-	int opt = 0, batch = 0;
+	int opt = 0;
 	const char *exp_type = NULL, *obj_name = NULL;
+	struct batch_options batch = {0};
 
 	const struct option options[] = {
 		OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
@@ -215,12 +235,12 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
 		OPT_SET_INT(0, "textconv", &opt,
 			    N_("for blob objects, run textconv on object's content"), 'c'),
-		OPT_SET_INT(0, "batch", &batch,
-			    N_("show info and content of objects fed from the standard input"),
-			    BATCH),
-		OPT_SET_INT(0, "batch-check", &batch,
-			    N_("show info about objects fed from the standard input"),
-			    BATCH_CHECK),
+		{ OPTION_CALLBACK, 0, "batch", &batch, NULL,
+			N_("show info and content of objects fed from the standard input"),
+			PARSE_OPT_NOARG, batch_option_callback },
+		{ OPTION_CALLBACK, 0, "batch-check", &batch, NULL,
+			N_("show info about objects fed from the standard input"),
+			PARSE_OPT_NOARG, batch_option_callback },
 		OPT_END()
 	};
 
@@ -237,19 +257,19 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		else
 			usage_with_options(cat_file_usage, options);
 	}
-	if (!opt && !batch) {
+	if (!opt && !batch.enabled) {
 		if (argc == 2) {
 			exp_type = argv[0];
 			obj_name = argv[1];
 		} else
 			usage_with_options(cat_file_usage, options);
 	}
-	if (batch && (opt || argc)) {
+	if (batch.enabled && (opt || argc)) {
 		usage_with_options(cat_file_usage, options);
 	}
 
-	if (batch)
-		return batch_objects(batch);
+	if (batch.enabled)
+		return batch_objects(&batch);
 
 	return cat_one_file(opt, exp_type, obj_name);
 }
-- 
1.8.3.rc3.24.gec82cb9
