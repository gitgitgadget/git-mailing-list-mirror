From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v7 08/10] git-clean refactor: save some options in clean_flags
Date: Wed,  8 May 2013 19:38:53 +0800
Message-ID: <e9af9f5886217f99dedbb7e830bcebece892c891.1368011946.git.worldhello.net@gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
 <ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
 <6a7931a0bb14f8c71479e16175812bedb6b826cb.1368011946.git.worldhello.net@gmail.com>
 <d7302adabb4269dd94698090fb20c739f723f00a.1368011946.git.worldhello.net@gmail.com>
 <e7cf5d7ffd83e238078b4585ac4bef4ec9a48e21.1368011946.git.worldhello.net@gmail.com>
 <ae69a75fa1bbad9827ef3891a33c3bfa6685d914.1368011946.git.worldhello.net@gmail.com>
 <95c019e293fcea899e5e227c35338f696f99525f.1368011946.git.worldhello.net@gmail.com>
 <187bf672e3795601f929f15b102746e5083471c5.1368011946.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 08 13:39:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua2im-0001Lx-7d
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 13:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732Ab3EHLji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 07:39:38 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:59280 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508Ab3EHLjh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 07:39:37 -0400
Received: by mail-pd0-f180.google.com with SMTP id t10so1175388pdi.25
        for <git@vger.kernel.org>; Wed, 08 May 2013 04:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=LyQOr0WGZ1PcSq30Z4fcDOs/GKWVG1528CEJ47cxRvs=;
        b=sAPxfI5YGNPtebEhynuBQ9ctTm3P/of40NiFp3Gy9dk8g+8Z5PxQ7OdARhOIxXHSi5
         3BO0pZU8xrM9HF61B30zKN6R/aj/s8MJNn6xe03zy64jGrsgskrk7MJnPAObkXd+CtyS
         9BWFdL0h5BLawacyI06UAJgE2MHkicr31edWP7VCuiHMxtSPEjf1Gez140h5c14tUcMv
         1ED2nIY0vWD6hfJx3aL96/C+jQCAPurcvXxTAQjoSZ4wYzaRJ8JF3bSvoRfhmzbbQG4v
         hB1QBeik9DWYBySCzjaFxtHUoFf3uDBTAJsiq+enm8o1rkYRR1G9wAChrgADt9nW8z5J
         UHYg==
X-Received: by 10.66.157.130 with SMTP id wm2mr5334799pab.156.1368013176769;
        Wed, 08 May 2013 04:39:36 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id gc5sm32287860pbb.19.2013.05.08.04.39.33
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 04:39:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g1c24ab7
In-Reply-To: <187bf672e3795601f929f15b102746e5083471c5.1368011946.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368011946.git.worldhello.net@gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223666>

Save some options in variable clean_flags, such as -ff (force > 1),
-x (ignored), -X (ignored_only), and -d (remove_directories). We may
change clean_flags later in the interactive git-clean.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 5bb36..d46f3 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -16,7 +16,13 @@
 #include "column.h"
 #include "color.h"
 
+#define CLEAN_OPTS_SHOW_IGNORED		01
+#define CLEAN_OPTS_IGNORED_ONLY		02
+#define CLEAN_OPTS_REMOVE_DIRECTORIES	04
+#define CLEAN_OPTS_REMOVE_NESTED_GIT	010
+
 static int force = -1; /* unset */
+static int clean_flags = 0;
 static int interactive;
 static struct string_list del_list = STRING_LIST_INIT_DUP;
 static const char **the_prefix;
@@ -843,7 +849,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	int i, res;
 	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
 	int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
-	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
 	struct strbuf directory = STRBUF_INIT;
 	struct dir_struct dir;
 	static const char **pathspec;
@@ -879,13 +884,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, *the_prefix, options, builtin_clean_usage,
 			     0);
 
-	memset(&dir, 0, sizeof(dir));
-	if (ignored_only)
-		dir.flags |= DIR_SHOW_IGNORED;
-
-	if (ignored && ignored_only)
-		die(_("-x and -X cannot be used together"));
-
 	if (interactive) {
 		if (!isatty(0) || !isatty(1))
 			die(_("interactive clean can not run without a valid tty; "
@@ -899,15 +897,29 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				  "refusing to clean"));
 	}
 
+	if (read_cache() < 0)
+		die(_("index file corrupt"));
+
 	if (force > 1)
-		rm_flags = 0;
+		clean_flags |= CLEAN_OPTS_REMOVE_NESTED_GIT;
+	if (ignored)
+		clean_flags |= CLEAN_OPTS_SHOW_IGNORED;
+	if (ignored_only)
+		clean_flags |= CLEAN_OPTS_IGNORED_ONLY;
+	if (remove_directories)
+		clean_flags |= CLEAN_OPTS_REMOVE_DIRECTORIES;
 
-	dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
+	memset(&dir, 0, sizeof(dir));
+	if (clean_flags & CLEAN_OPTS_IGNORED_ONLY)
+		dir.flags |= DIR_SHOW_IGNORED;
 
-	if (read_cache() < 0)
-		die(_("index file corrupt"));
+	if (clean_flags & CLEAN_OPTS_IGNORED_ONLY &&
+	    clean_flags & CLEAN_OPTS_SHOW_IGNORED)
+		die(_("-x and -X cannot be used together"));
+
+	dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
 
-	if (!ignored)
+	if (!(clean_flags & CLEAN_OPTS_SHOW_IGNORED))
 		setup_standard_excludes(&dir);
 
 	el = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
@@ -961,7 +973,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		}
 
 		if (S_ISDIR(st.st_mode)) {
-			if (remove_directories || (matches == MATCHED_EXACTLY))
+			if ((clean_flags & CLEAN_OPTS_REMOVE_DIRECTORIES) ||
+			    (matches == MATCHED_EXACTLY))
 				string_list_append(&del_list, ent->name);
 		} else {
 			if (pathspec && !matches)
@@ -981,7 +994,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 		if (S_ISDIR(st.st_mode)) {
 			strbuf_addstr(&directory, item->string);
-			if (remove_dirs(&directory, *the_prefix, rm_flags, dry_run, quiet, &gone))
+			if (remove_dirs(&directory, *the_prefix,
+					clean_flags & CLEAN_OPTS_REMOVE_NESTED_GIT ?
+						0 : REMOVE_DIR_KEEP_NESTED_GIT,
+					dry_run, quiet, &gone))
 				errors++;
 			if (gone && !quiet) {
 				qname = quote_path_relative(directory.buf, directory.len, &buf, *the_prefix);
-- 
1.8.3.rc1.341.g1c24ab7
