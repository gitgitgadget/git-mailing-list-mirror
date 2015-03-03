From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 3/3] cat-file: add "--literally" option
Date: Tue,  3 Mar 2015 15:43:02 +0530
Message-ID: <1425377582-25388-1-git-send-email-karthik.188@gmail.com>
References: <54F5888B.7040400@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 11:13:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSjpP-0005KM-AD
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 11:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159AbbCCKNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 05:13:22 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33998 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755752AbbCCKNT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 05:13:19 -0500
Received: by pdjg10 with SMTP id g10so47386282pdj.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 02:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DWJUw0f02jK1c4ve3M7KdMwrmJ1EMOlCGMgIPG4i6As=;
        b=XFA2nmGIhsmeI0usXHMYexf1VLZu4u7gVKnhkOvs18FO+ejzNEExaN1Fu9jNjhNIZL
         Fc8y6GWrZO7ehGVy4fjfag+Cwy9E/I1Ss/7qfXQ1HF/H/M73XnnlL9ELweMQnO3ZsnN3
         XCLZMTTPXueCLRpXad9anT+3SamKFVV4HFxkvq+oD9DlOEBWB+HqNPf52HnbNAd08RQl
         Tm7zYvPEQXOQSuCtBmQvFAHbZTsbPh4ZT45t7WoSkJ/jugcSYIesNvO8PzSASdRrtr4X
         MxQGrAm5TyXbJabBrTR/jT/y7lGBcWrdoB6DmbDP01arvbVVsy/RNzJLvU/Y7ykKxAkz
         oo9w==
X-Received: by 10.68.252.198 with SMTP id zu6mr53870808pbc.102.1425377598533;
        Tue, 03 Mar 2015 02:13:18 -0800 (PST)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id lf13sm559159pab.2.2015.03.03.02.13.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Mar 2015 02:13:17 -0800 (PST)
X-Mailer: git-send-email 2.3.1.169.ga243085.dirty
In-Reply-To: <54F5888B.7040400@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264645>

made changes to "cat-file" to include a "--literally"
option which prints the type of the object without any
complaints.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/cat-file.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index df99df4..2af9f40 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -9,7 +9,8 @@
 #include "userdiff.h"
 #include "streaming.h"
 
-static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
+static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
+			int literally)
 {
 	unsigned char sha1[20];
 	enum object_type type;
@@ -23,6 +24,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 	buf = NULL;
 	switch (opt) {
 	case 't':
+		if (literally)
+			return sha1_object_info_literally(sha1);
 		type = sha1_object_info(sha1, NULL);
 		if (type > 0) {
 			printf("%s\n", typename(type));
@@ -323,7 +326,7 @@ static int batch_objects(struct batch_options *opt)
 }
 
 static const char * const cat_file_usage[] = {
-	N_("git cat-file (-t | -s | -e | -p | <type> | --textconv) <object>"),
+	N_("git cat-file (-t|-s|-e|-p|<type>|--textconv|-t --literally) <object>"),
 	N_("git cat-file (--batch | --batch-check) < <list-of-objects>"),
 	NULL
 };
@@ -359,6 +362,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	int opt = 0;
 	const char *exp_type = NULL, *obj_name = NULL;
 	struct batch_options batch = {0};
+	int literally = 0;
 
 	const struct option options[] = {
 		OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
@@ -369,6 +373,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
 		OPT_SET_INT(0, "textconv", &opt,
 			    N_("for blob objects, run textconv on object's content"), 'c'),
+		OPT_BOOL( 0, "literally", &literally,
+			  N_("show the type of the given loose object, use for debugging")),
 		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
 			N_("show info and content of objects fed from the standard input"),
 			PARSE_OPT_OPTARG, batch_option_callback },
@@ -380,7 +386,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 
 	git_config(git_cat_file_config, NULL);
 
-	if (argc != 3 && argc != 2)
+	if (argc != 3 && argc != 2 && argc != 4)
 		usage_with_options(cat_file_usage, options);
 
 	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
@@ -405,5 +411,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	if (batch.enabled)
 		return batch_objects(&batch);
 
-	return cat_one_file(opt, exp_type, obj_name);
+	if (literally && opt == 't')
+		return cat_one_file(opt, exp_type, obj_name, literally);
+	else if (literally)
+		usage_with_options(cat_file_usage, options);
+
+	return cat_one_file(opt, exp_type, obj_name, literally);
 }
-- 
2.3.1.169.ga243085.dirty
