From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 1/2] cat-file: teach cat-file a '--literally' option
Date: Tue, 17 Mar 2015 10:46:40 +0530
Message-ID: <1426569400-8204-1-git-send-email-karthik.188@gmail.com>
References: <5507B7EE.1070403@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 06:17:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXjsA-0008BW-9Z
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 06:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbbCQFQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 01:16:54 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36487 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbbCQFQx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 01:16:53 -0400
Received: by pdbcz9 with SMTP id cz9so79283167pdb.3
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 22:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dl67C2fGZo7gNBa5om2F0j8PJw+yA1IeD5hwxQ3Xxok=;
        b=Hv1N8tTVnZXq+fk+zvceg4CyqmXyjdRzkXvDoXgZQTXFY2TVSv6kOVpgMli/jcrCL3
         d0QNNLfRzkiqfwplQ33N2pUhr02D5GwJLgDXD4Y7zOBcKI7I6oBYfll+StZZMqHro47z
         TSasADxr8z2j9mzofD/aEn/HZ5B+eAK8kqQTlaMwGjSw5zpq52Cwq2Sz+rv/XoshO2RS
         zeY6Lyjw1VIBj9Cxx6u78dq/3yMqGhbFIznfMbJAm1PC+wKDXtcpY3SBlUmLB0C2lGVE
         uCp5oS7dsq36OmfA6OTBsQWXVLcznsj5ISjsuR+bgTSgS4Gj31u13eFI2IXR1st9CjV6
         IH4Q==
X-Received: by 10.70.65.105 with SMTP id w9mr87105407pds.129.1426569412634;
        Mon, 16 Mar 2015 22:16:52 -0700 (PDT)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id n10sm20034349pdp.18.2015.03.16.22.16.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2015 22:16:51 -0700 (PDT)
X-Mailer: git-send-email 2.3.1.307.gf3db8a5
In-Reply-To: <5507B7EE.1070403@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265605>

Currently 'git cat-file' throws an error while trying to
print the type or size of a broken/corrupt object which is
created using 'git hash-object --literally'. This is
because these objects are usually of unknown types.

Teach git cat-file a '--literally' option where it prints
the type or size of a broken/corrupt object without throwing
an error.

Modify '-t' and '-s' options to call sha1_object_info_extended()
directly to support the '--literally' option.

Add a 'LOOKUP_LITERALLY' flag to notify sha1_object_info_extended()
whenever the '--literally' is being used.

Add object_info::typename to support 'cat-file --literally' and
store the typename of objects.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/cat-file.c | 43 +++++++++++++++++++++++++++++++++----------
 cache.h            |  2 ++
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index df99df4..1625246 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -9,13 +9,20 @@
 #include "userdiff.h"
 #include "streaming.h"
 
-static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
+static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
+			int literally)
 {
 	unsigned char sha1[20];
 	enum object_type type;
 	char *buf;
 	unsigned long size;
 	struct object_context obj_context;
+	struct object_info oi = {NULL};
+	struct strbuf sb = STRBUF_INIT;
+	unsigned flags = LOOKUP_REPLACE_OBJECT;
+
+	if (literally)
+		flags |= LOOKUP_LITERALLY;
 
 	if (get_sha1_with_context(obj_name, 0, sha1, &obj_context))
 		die("Not a valid object name %s", obj_name);
@@ -23,16 +30,24 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 	buf = NULL;
 	switch (opt) {
 	case 't':
-		type = sha1_object_info(sha1, NULL);
-		if (type > 0) {
-			printf("%s\n", typename(type));
+		oi.typep = &type;
+		oi.typename = &sb;
+		if (sha1_object_info_extended(sha1, &oi, flags) < 0)
+			die("git cat-file: could not get object info");
+		if (sb.len) {
+			printf("%s\n", sb.buf);
+			strbuf_release(&sb);
 			return 0;
 		}
 		break;
 
 	case 's':
-		type = sha1_object_info(sha1, &size);
-		if (type > 0) {
+		oi.typep = &type;
+		oi.typename = &sb;
+		oi.sizep = &size;
+		if (sha1_object_info_extended(sha1, &oi, flags) < 0)
+			die("git cat-file: could not get object info");
+		if (sb.len) {
 			printf("%lu\n", size);
 			return 0;
 		}
@@ -323,8 +338,8 @@ static int batch_objects(struct batch_options *opt)
 }
 
 static const char * const cat_file_usage[] = {
-	N_("git cat-file (-t | -s | -e | -p | <type> | --textconv) <object>"),
-	N_("git cat-file (--batch | --batch-check) < <list-of-objects>"),
+	N_("git cat-file (-t [--literally]|-s [--literally]|-e|-p|<type>|--textconv) <object>"),
+	N_("git cat-file (--batch | --batch-check) <list-of-objects>"),
 	NULL
 };
 
@@ -359,6 +374,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	int opt = 0;
 	const char *exp_type = NULL, *obj_name = NULL;
 	struct batch_options batch = {0};
+	int literally = 0;
 
 	const struct option options[] = {
 		OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
@@ -369,6 +385,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
 		OPT_SET_INT(0, "textconv", &opt,
 			    N_("for blob objects, run textconv on object's content"), 'c'),
+		OPT_BOOL( 0, "literally", &literally,
+			  N_("get information about corrupt objects for debugging Git")),
 		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
 			N_("show info and content of objects fed from the standard input"),
 			PARSE_OPT_OPTARG, batch_option_callback },
@@ -380,7 +398,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 
 	git_config(git_cat_file_config, NULL);
 
-	if (argc != 3 && argc != 2)
+	if (argc < 2 || argc > 4)
 		usage_with_options(cat_file_usage, options);
 
 	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
@@ -405,5 +423,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	if (batch.enabled)
 		return batch_objects(&batch);
 
-	return cat_one_file(opt, exp_type, obj_name);
+	if (literally && (opt == 't' || opt == 's'))
+		return cat_one_file(opt, exp_type, obj_name, literally);
+	else if (literally)
+		die("git cat-file --literally: use with -s or -t");
+
+	return cat_one_file(opt, exp_type, obj_name, literally);
 }
diff --git a/cache.h b/cache.h
index 761c570..7c151ee 100644
--- a/cache.h
+++ b/cache.h
@@ -830,6 +830,7 @@ extern int is_ntfs_dotgit(const char *name);
 
 /* object replacement */
 #define LOOKUP_REPLACE_OBJECT 1
+#define LOOKUP_LITERALLY 2
 extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
 static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
 {
@@ -1296,6 +1297,7 @@ struct object_info {
 	unsigned long *sizep;
 	unsigned long *disk_sizep;
 	unsigned char *delta_base_sha1;
+	struct strbuf *typename;
 
 	/* Response */
 	enum {
-- 
2.3.1.307.gf3db8a5
