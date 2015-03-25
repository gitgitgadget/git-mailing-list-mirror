From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 2/2] cat-file: teach cat-file a '--literally' option
Date: Wed, 25 Mar 2015 12:52:06 +0530
Message-ID: <1427268126-16964-1-git-send-email-karthik.188@gmail.com>
References: <5512618B.2060402@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 08:22:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yafdu-0008D1-HP
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 08:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbbCYHWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 03:22:18 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:32891 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbbCYHWR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 03:22:17 -0400
Received: by pdnc3 with SMTP id c3so19729706pdn.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2015 00:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qTfssQ5VnOJgChJSFJWdke1F0uVuXP6mgQrWFgPXrUM=;
        b=ksJ61Pb0xIhP1HxnwZzRUI3EXMPDcJ7U4Okq5CCx0PkeXkBjGCAu0rZDJ79rV804sX
         qQZ6Z2hnGXQI/QwtKucK3RPXZ523b8TbSg7cgIP4ZYFytNbYizaesCFHuO2X8JB5pixS
         v5d4k8aksasR63QysG6fLd+AEWG5KTdZeEGS0umkXjCJOSyjYcFstbYF7++7Cj3As8dV
         S1KQfQaXqaBxzOq3+VGEp5X8gNrargQ4jHAlF+RNb8JXqBTMG/RlJkupjCLKF7+cVrd6
         9AXuBB5vAyfRwkxYKgcoizzZUqI7ptQOW9GQIR1TGDCBuMlXEWBHDvZ7RYT6yOh+Lr8Q
         OjRQ==
X-Received: by 10.68.168.225 with SMTP id zz1mr14383356pbb.3.1427268136867;
        Wed, 25 Mar 2015 00:22:16 -0700 (PDT)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id da2sm1381242pbb.75.2015.03.25.00.22.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Mar 2015 00:22:16 -0700 (PDT)
X-Mailer: git-send-email 2.3.1.170.g5319d60.dirty
In-Reply-To: <5512618B.2060402@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266270>

Currently 'git cat-file' throws an error while trying to
print the type or size of a broken/corrupt object which is
created using 'git hash-object --literally'. This is
because these objects are usually of unknown types.

Teach git cat-file a '--literally' option where it prints
the type or size of a broken/corrupt object without throwing
an error.

Modify '-t' and '-s' options to call sha1_object_info_extended()
directly to support the '--literally' option.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/cat-file.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index df99df4..6fee461 100644
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
@@ -323,7 +338,7 @@ static int batch_objects(struct batch_options *opt)
 }
 
 static const char * const cat_file_usage[] = {
-	N_("git cat-file (-t | -s | -e | -p | <type> | --textconv) <object>"),
+	N_("git cat-file (-t [--literally]|-s [--literally]|-e|-p|<type>|--textconv) <object>"),
 	N_("git cat-file (--batch | --batch-check) < <list-of-objects>"),
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
-- 
2.3.1.170.g5319d60.dirty
