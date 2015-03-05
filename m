From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 3/3] cat-file: add "--literally" option
Date: Thu,  5 Mar 2015 23:49:38 +0530
Message-ID: <1425579578-18955-1-git-send-email-karthik.188@gmail.com>
References: <54F89D90.6090505@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 19:19:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTaNH-0004ns-PL
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 19:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756375AbbCESTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 13:19:51 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:40486 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbbCESTu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 13:19:50 -0500
Received: by pdbfp1 with SMTP id fp1so31061783pdb.7
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 10:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PsDGx+zj0mjdGfqurtn68/qPK6+Yjf5KdlWmDkVX4Xc=;
        b=xk9Z/BASyazGOyF1W7FJvgELQ9+It/LGpvLokW7gdWV19zoxBetGYZC1p/X50bBXBM
         4XVgMzkIXc/sLIdBlLM6LkjHPWIUxMZPB9K5OvMEmDVLOiWVKLEJE0lNj5SmxHlVYyUZ
         8e5HbH8yQF1qA/jvf+8Ijsu3w8F6jTXcBQRRujS9fcpU99RZ3dF4l+ABioNW2vVLdhiJ
         wih7hwYkq/44+AitRAbYcZ86SUiB4XN2SwfViTJdMLhfrqacCzJXu2Sy89T1EdZiz/qm
         XOvh/u6tCL30ZnYEtFly/2mIttlnBoxeumyGYVaaVBo6iXKYVwXrUcixh7Ed0DLzLMZc
         N0yQ==
X-Received: by 10.67.7.10 with SMTP id cy10mr17549789pad.151.1425579590563;
        Thu, 05 Mar 2015 10:19:50 -0800 (PST)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id l2sm2955520pdb.81.2015.03.05.10.19.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Mar 2015 10:19:49 -0800 (PST)
X-Mailer: git-send-email 2.3.1.167.g7f4ba4b.dirty
In-Reply-To: <54F89D90.6090505@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264856>

made changes to "cat-file" to include a "--literally"
option which prints the type of the object without any
complaints.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/cat-file.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index df99df4..60b9ec4 100644
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
@@ -23,6 +24,14 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 	buf = NULL;
 	switch (opt) {
 	case 't':
+		if (literally) {
+			buf = sha1_object_info_literally(sha1);
+			if (!buf)
+				die("git cat-file --literally -t %s: failed",
+					obj_name);
+			printf("%s\n", buf);
+			return 0;
+		}
 		type = sha1_object_info(sha1, NULL);
 		if (type > 0) {
 			printf("%s\n", typename(type));
@@ -323,7 +332,7 @@ static int batch_objects(struct batch_options *opt)
 }
 
 static const char * const cat_file_usage[] = {
-	N_("git cat-file (-t | -s | -e | -p | <type> | --textconv) <object>"),
+	N_("git cat-file (-t|-s|-e|-p|<type>|--textconv|-t --literally) <object>"),
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
+			  N_("show the type of the given loose object, use for debugging")),
 		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
 			N_("show info and content of objects fed from the standard input"),
 			PARSE_OPT_OPTARG, batch_option_callback },
@@ -380,7 +392,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 
 	git_config(git_cat_file_config, NULL);
 
-	if (argc != 3 && argc != 2)
+	if (argc != 3 && argc != 2 && argc != 4)
 		usage_with_options(cat_file_usage, options);
 
 	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
@@ -405,5 +417,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
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
2.3.1.167.g7f4ba4b.dirty
