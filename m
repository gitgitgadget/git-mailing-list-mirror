From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 2/2] cat-file: add --literally option.
Date: Wed, 25 Feb 2015 16:38:05 +0530
Message-ID: <1424862485-13576-1-git-send-email-karthik.188@gmail.com>
References: <54EDACC9.5080204@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 12:08:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQZpH-0001iF-Kj
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 12:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbbBYLIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 06:08:19 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:44737 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbbBYLIS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 06:08:18 -0500
Received: by padet14 with SMTP id et14so4438106pad.11
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 03:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4QWLGEINimFxJaHVRGVixykK1pzah5SDr/V2LKqvZbA=;
        b=xCmGcWXSC2z9FyDSKXIieQ1mbzSkX3zSeNKa8xVHl96UkIbaDfcx0JkGWdWk+O/np8
         czP7biG2gJYPlovOLI+urOepQzfxRZ3hZnw3VUNf0TPHGq4GOLr8ZoSuxVb01eqHebX1
         vwM6htckajz4Ey9zWHxZm5//JOCsR5Q5tca2yTrsguEqwHIOXVu2XQp1McoWo9Ge/sIC
         U1ypgxJRY7QckyNhPRp4e88norymOyFibbWBKP6/VecHqAhlpRJB/M/o6dSI2++yA6a5
         LPjXUmM1hFdRM9dCdRMqskhxoJnIJX6w2bTUraM47wMPrSElz8LdiTVz84kM3rypR9s1
         gGzQ==
X-Received: by 10.70.103.162 with SMTP id fx2mr4755940pdb.24.1424862498148;
        Wed, 25 Feb 2015 03:08:18 -0800 (PST)
Received: from nayak.localdomain ([182.48.234.2])
        by mx.google.com with ESMTPSA id g11sm42120621pat.24.2015.02.25.03.08.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Feb 2015 03:08:17 -0800 (PST)
X-Mailer: git-send-email 2.3.1.129.g11acff1.dirty
In-Reply-To: <54EDACC9.5080204@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264385>

Add --literally option which when used with -t option
gives the type of the object given, irrelevant of the type
and its contents.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/cat-file.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index df99df4..1db94fe 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -107,6 +107,29 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 	return 0;
 }
 
+static int cat_one_file_literally(int opt, const char *exp_type, const char *obj_name)
+{
+	unsigned char sha1[20];
+	unsigned char type[32];
+	struct object_context obj_context;
+	struct object_info oi = {NULL};
+	int retval = 0;
+
+	if (get_sha1_with_context(obj_name, 0, sha1, &obj_context))
+		die("Not a valid object name %s", obj_name);
+
+	retval = has_sha1_file(sha1);
+	if (!retval)
+		return retval;
+
+	if(sha1_object_type_literally(sha1, type))
+		die("git cat-file -t --literally %s: invalid object", obj_name);
+
+	printf("%s\n", type);
+
+	return retval;
+}
+
 struct expand_data {
 	unsigned char sha1[20];
 	enum object_type type;
@@ -324,7 +347,7 @@ static int batch_objects(struct batch_options *opt)
 
 static const char * const cat_file_usage[] = {
 	N_("git cat-file (-t | -s | -e | -p | <type> | --textconv) <object>"),
-	N_("git cat-file (--batch | --batch-check) < <list-of-objects>"),
+	N_("git cat-file (-t|-s|-e|-p|<type>|--textconv|-t --literally) <object>"),
 	NULL
 };
 
@@ -359,6 +382,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	int opt = 0;
 	const char *exp_type = NULL, *obj_name = NULL;
 	struct batch_options batch = {0};
+	int literally = 0;
 
 	const struct option options[] = {
 		OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
@@ -369,6 +393,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
 		OPT_SET_INT(0, "textconv", &opt,
 			    N_("for blob objects, run textconv on object's content"), 'c'),
+		OPT_BOOL( 0, "literally", &literally,
+			  N_("show the type of the gicen loose object, use for debugging")),
 		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
 			N_("show info and content of objects fed from the standard input"),
 			PARSE_OPT_OPTARG, batch_option_callback },
@@ -380,7 +406,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 
 	git_config(git_cat_file_config, NULL);
 
-	if (argc != 3 && argc != 2)
+	if (argc != 3 && argc != 2 && (!literally && argc != 4))
 		usage_with_options(cat_file_usage, options);
 
 	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
@@ -405,5 +431,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	if (batch.enabled)
 		return batch_objects(&batch);
 
+	if (literally && opt == 't')
+		return cat_one_file_literally(opt, exp_type, obj_name);
+	else if (literally)
+		usage_with_options(cat_file_usage, options);
+
 	return cat_one_file(opt, exp_type, obj_name);
 }
-- 
2.3.1.129.g11acff1.dirty
