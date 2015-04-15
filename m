From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 2/4] cat-file: teach cat-file a '--literally' option
Date: Wed, 15 Apr 2015 22:29:34 +0530
Message-ID: <1429117174-4968-1-git-send-email-karthik.188@gmail.com>
References: <552E9816.6040502@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 19:00:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiQfa-0007TL-3Y
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 19:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407AbbDORAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 13:00:06 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36848 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbbDORAE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 13:00:04 -0400
Received: by pabsx10 with SMTP id sx10so57064637pab.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2015 10:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o9lKjxPGxH86xJIgQkJVkYRKzPgk/kSZ2axUULcpYbM=;
        b=HEz+dAYufI+d8spCmGPU2LoLxf04wlj2R+ZAtSR3X5EOO+47AkyzksdIuzopbtBFXP
         Ap6/ps+/inojMeK2EnsVLvGcBOqxC+TzKaIpY8aeeIeQffKwzYL3obXOsyOcPFugzhBN
         MjDA5Kw1UPNQFw/48hMhz6abl78uge70Y9PsSuu1W6nIlphj2YKTpXR6VAfvYr3czDUN
         +dLBo2UG/qoRbt/ufd4kLv5y51RXQ4OHIHnciux2jpgr7OxlQXJb2iDZxVaoHKOA9LTt
         ezcVxqGgd33C+VHacOW7VIZk77Or05U0oiKXWG3ryIAlX2nx1MXEkFKc1weD+YCBza2K
         zncA==
X-Received: by 10.70.108.231 with SMTP id hn7mr7528pdb.100.1429117203723;
        Wed, 15 Apr 2015 10:00:03 -0700 (PDT)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id i9sm4671812pdj.27.2015.04.15.10.00.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Apr 2015 10:00:03 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc1.249.g1310741
In-Reply-To: <552E9816.6040502@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267215>

Currently 'git cat-file' throws an error while trying to
print the type or size of a broken/corrupt object. This is
because these objects are usually of unknown types.

Teach git cat-file a '--literally' option where it prints
the type or size of a broken/corrupt object without throwing
an error.

Modify '-t' and '-s' options to call sha1_object_info_extended()
directly to support the '--literally' option.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/cat-file.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index df99df4..1ec7190 100644
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
@@ -23,20 +30,22 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 	buf = NULL;
 	switch (opt) {
 	case 't':
-		type = sha1_object_info(sha1, NULL);
-		if (type > 0) {
-			printf("%s\n", typename(type));
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
-			printf("%lu\n", size);
-			return 0;
-		}
-		break;
+		oi.sizep = &size;
+		if ((type = sha1_object_info_extended(sha1, &oi, flags)) < 0)
+			die("git cat-file: could not get object info");
+		printf("%lu\n", size);
+		return 0;
 
 	case 'e':
 		return !has_sha1_file(sha1);
@@ -323,7 +332,7 @@ static int batch_objects(struct batch_options *opt)
 }
 
 static const char * const cat_file_usage[] = {
-	N_("git cat-file (-t | -s | -e | -p | <type> | --textconv) <object>"),
+	N_("git cat-file (-t [--literally]|-s [--literally]|-e|-p|<type>|--textconv) <object>"),
 	N_("git cat-file (--batch | --batch-check) < <list-of-objects>"),
 	NULL
 };
@@ -359,6 +368,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	int opt = 0;
 	const char *exp_type = NULL, *obj_name = NULL;
 	struct batch_options batch = {0};
+	int literally = 0;
 
 	const struct option options[] = {
 		OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
@@ -369,6 +379,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
 		OPT_SET_INT(0, "textconv", &opt,
 			    N_("for blob objects, run textconv on object's content"), 'c'),
+		OPT_BOOL( 0, "literally", &literally,
+			  N_("allow -s and -t to work with broken/corrupt objects")),
 		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
 			N_("show info and content of objects fed from the standard input"),
 			PARSE_OPT_OPTARG, batch_option_callback },
@@ -380,7 +392,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 
 	git_config(git_cat_file_config, NULL);
 
-	if (argc != 3 && argc != 2)
+	if (argc < 2 || argc > 4)
 		usage_with_options(cat_file_usage, options);
 
 	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
@@ -405,5 +417,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	if (batch.enabled)
 		return batch_objects(&batch);
 
-	return cat_one_file(opt, exp_type, obj_name);
+	if (literally && opt != 't' && opt != 's')
+		die("git cat-file --literally: use with -s or -t");
+	return cat_one_file(opt, exp_type, obj_name, literally);
 }
-- 
2.4.0.rc1.249.gb598846
