From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 3/5] cat-file: teach cat-file a '--allow-unknown-type' option
Date: Wed, 29 Apr 2015 18:23:26 +0530
Message-ID: <1430312006-23323-1-git-send-email-karthik.188@gmail.com>
References: <5540D397.8020104@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 14:53:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnRUm-0004jI-Mg
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 14:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422979AbbD2Mxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 08:53:40 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35205 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422900AbbD2Mxk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 08:53:40 -0400
Received: by pdbqd1 with SMTP id qd1so27543428pdb.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 05:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U1QqS1bUDeEeLCbpeIoTV0QpoBhlMS3BFKsVH7g39D8=;
        b=vxLFVUOHXCBBMmRDk05auaytTGu3+7i6wN1pEJP8BLiFr0nxWSm81P0MEpvosWJ8Sl
         m2TE/lNyGa+07G60E075Tzfk86QOkRSu/kapTgnon/R2fnEtFH+T9lTCjKgcO6GBmVHT
         y5vm8qIjGtZVp7aWz9+otPwODwJVQDtvgB4m2HA2k6CtnGV4hF7WkKOhnv9qCH74QjIR
         qBAVLYGRU1TOONBnsDB0ihylwA2myxq2MQpnK/RJsqdAbyO1HivrE8XOztD83N4J5P4B
         DJJh1yj7ePHQAyT45WIzCc1dZjt3SQnQUuHYvTCpobnECAzaztJzzFW4BoBEbGGzF6QK
         ET/w==
X-Received: by 10.70.50.199 with SMTP id e7mr42040748pdo.124.1430312019543;
        Wed, 29 Apr 2015 05:53:39 -0700 (PDT)
Received: from ashley.localdomain ([182.48.234.2])
        by mx.google.com with ESMTPSA id lm2sm25333295pbc.84.2015.04.29.05.53.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Apr 2015 05:53:38 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc1.250.g565e85b
In-Reply-To: <5540D397.8020104@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267963>

Currently 'git cat-file' throws an error while trying to
print the type or size of a broken/corrupt object. This is
because these objects are usually of unknown types.

Teach git cat-file a '--allow-unkown-type' option where it prints
the type or size of a broken/corrupt object without throwing
an error.

Modify '-t' and '-s' options to call sha1_object_info_extended()
directly to support the '--allow-unkown-type' option.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/cat-file.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 53b5376..299e2e5 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -9,13 +9,20 @@
 #include "userdiff.h"
 #include "streaming.h"
 
-static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
+static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
+			int unkown_type)
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
+	if (unkown_type)
+		flags |= LOOKUP_UNKNOWN_OBJECT;
 
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
+		if (sha1_object_info_extended(sha1, &oi, flags) < 0)
+			die("git cat-file: could not get object info");
+		printf("%lu\n", size);
+		return 0;
 
 	case 'e':
 		return !has_sha1_file(sha1);
@@ -323,7 +332,7 @@ static int batch_objects(struct batch_options *opt)
 }
 
 static const char * const cat_file_usage[] = {
-	N_("git cat-file (-t | -s | -e | -p | <type> | --textconv) <object>"),
+	N_("git cat-file (-t [--allow-unkown-type]|-s [--allow-unkown-type]|-e|-p|<type>|--textconv) <object>"),
 	N_("git cat-file (--batch | --batch-check) < <list-of-objects>"),
 	NULL
 };
@@ -359,6 +368,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	int opt = 0;
 	const char *exp_type = NULL, *obj_name = NULL;
 	struct batch_options batch = {0};
+	int unkown_type = 0;
 
 	const struct option options[] = {
 		OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
@@ -369,6 +379,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
 		OPT_CMDMODE(0, "textconv", &opt,
 			    N_("for blob objects, run textconv on object's content"), 'c'),
+		OPT_BOOL( 0, "allow-unkown-type", &unkown_type,
+			  N_("allow -s and -t to work with broken/corrupt objects")),
 		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
 			N_("show info and content of objects fed from the standard input"),
 			PARSE_OPT_OPTARG, batch_option_callback },
@@ -402,5 +414,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	if (batch.enabled)
 		return batch_objects(&batch);
 
-	return cat_one_file(opt, exp_type, obj_name);
+	if (unkown_type && opt != 't' && opt != 's')
+		die("git cat-file --allow-unkown-type: use with -s or -t");
+	return cat_one_file(opt, exp_type, obj_name, unkown_type);
 }
-- 
2.4.0.rc1.250.g565e85b
