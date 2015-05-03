From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v10 3/4] cat-file: teach cat-file a '--allow-unknown-type' option
Date: Sun,  3 May 2015 20:00:01 +0530
Message-ID: <1430663402-26717-3-git-send-email-karthik.188@gmail.com>
References: <55463094.9040204@gmail.com>
 <1430663402-26717-1-git-send-email-karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 03 16:30:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Youui-0005z5-8k
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 16:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641AbbECOac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 10:30:32 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:32923 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbbECOaa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 10:30:30 -0400
Received: by pdbnk13 with SMTP id nk13so140540863pdb.0
        for <git@vger.kernel.org>; Sun, 03 May 2015 07:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QbwtTKZxT8IqPCzrIB0EgJSYh6YNKacp1SDxZpdKGoo=;
        b=zCYOsk5S/JChWQ/rPfQ5dMi8DzhkBojFEWXW7tufGfSHZCm1/6Kj5DrnhvnKPDqLJw
         +x5YrjyTnZZi0zUw0L8cCKqLovSJSBv+0bz00GWisyj6G3+tfRzunUIAyWnBb3nveWkx
         dNLqkCC2pXJmtG2RLh/I3weAcTSR+ozSJpw1tsAmhFlMLXlFeWcziAzpeVMomxlZum+/
         Ckc+a3Amh3MEbeM2s67f1DoU/l5XkznDb6U5E6Zm/UE6bE5FxIKZkLP2WtchG0SmwqMv
         BOPmiyDyLwCeBnS+xcw63PEDKWkjvc1hLnBWjgkK35T21MGkW5ejE3C01ydDWzFAEdij
         D/Pw==
X-Received: by 10.68.204.36 with SMTP id kv4mr33922294pbc.37.1430663430047;
        Sun, 03 May 2015 07:30:30 -0700 (PDT)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id xt9sm10097262pbc.14.2015.05.03.07.30.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 May 2015 07:30:29 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc1.250.gfbd73bd
In-Reply-To: <1430663402-26717-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268265>

'git cat-file' throws an error while trying to print the type or
size of a broken/corrupt object. This is because these objects are
usually of unknown types.

Teach git cat-file a '--allow-unknown-type' option where it prints
the type or size of a broken/corrupt object without throwing
an error.

Modify '-t' and '-s' options to call sha1_object_info_extended()
directly to support the '--allow-unknown-type' option.

Add documentation for 'cat-file --allow-unknown-type'.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

cat-file: add documentation for '--allow-unknown-type' option.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-cat-file.txt |  5 ++++-
 builtin/cat-file.c             | 38 ++++++++++++++++++++++++++------------
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index f6a16f4..499ae7b 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -9,7 +9,7 @@ git-cat-file - Provide content or type and size information for repository objec
 SYNOPSIS
 --------
 [verse]
-'git cat-file' (-t | -s | -e | -p | <type> | --textconv ) <object>
+'git cat-file' (-t [--allow-unknown-type]| -s [--allow-unknown-type]| -e | -p | <type> | --textconv ) <object>
 'git cat-file' (--batch | --batch-check) < <list-of-objects>
 
 DESCRIPTION
@@ -69,6 +69,9 @@ OPTIONS
 	not be combined with any other options or arguments.  See the
 	section `BATCH OUTPUT` below for details.
 
+--allow-unknown-type::
+	Allow -s or -t to query broken/corrupt objects of unknown type.
+
 OUTPUT
 ------
 If '-t' is specified, one of the <type>.
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 53b5376..ecb4888 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -9,13 +9,20 @@
 #include "userdiff.h"
 #include "streaming.h"
 
-static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
+static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
+			int unknown_type)
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
+	if (unknown_type)
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
+	N_("git cat-file (-t [--allow-unknown-type]|-s [--allow-unknown-type]|-e|-p|<type>|--textconv) <object>"),
 	N_("git cat-file (--batch | --batch-check) < <list-of-objects>"),
 	NULL
 };
@@ -359,6 +368,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	int opt = 0;
 	const char *exp_type = NULL, *obj_name = NULL;
 	struct batch_options batch = {0};
+	int unknown_type = 0;
 
 	const struct option options[] = {
 		OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
@@ -369,6 +379,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
 		OPT_CMDMODE(0, "textconv", &opt,
 			    N_("for blob objects, run textconv on object's content"), 'c'),
+		OPT_BOOL( 0, "allow-unknown-type", &unknown_type,
+			  N_("allow -s and -t to work with broken/corrupt objects")),
 		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
 			N_("show info and content of objects fed from the standard input"),
 			PARSE_OPT_OPTARG, batch_option_callback },
@@ -402,5 +414,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	if (batch.enabled)
 		return batch_objects(&batch);
 
-	return cat_one_file(opt, exp_type, obj_name);
+	if (unknown_type && opt != 't' && opt != 's')
+		die("git cat-file --allow-unknown-type: use with -s or -t");
+	return cat_one_file(opt, exp_type, obj_name, unknown_type);
 }
-- 
2.4.0.rc1.250.gfbd73bd
