From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v8 09/12] git-clean refactor: save some options in clean_flags
Date: Fri, 10 May 2013 01:14:13 +0800
Message-ID: <004346e031386fb325433117bc7d1b282c1740ff.1368118918.git.worldhello.net@gmail.com>
References: <cover.1368118918.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 09 19:15:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaUR5-0003HP-Eb
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 19:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930Ab3EIRPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 13:15:11 -0400
Received: from mail-da0-f50.google.com ([209.85.210.50]:64989 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab3EIRPI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 13:15:08 -0400
Received: by mail-da0-f50.google.com with SMTP id i23so1704643dad.9
        for <git@vger.kernel.org>; Thu, 09 May 2013 10:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=eoZ9aN/tjo5UU4QKVB9fMDoFBPzGfiLHZspkpKjQKsk=;
        b=I7qEw2ap8aaXtMUMcE6oE9/oMv8gf4z/I6pAUPGGOfqxEiDdT44SMlg/i3F0R3dOlI
         c0GCVOxqAwBewpdCuEWFTprWByNlQqm/h0D8/AHrr/BhZmPbQP9W2GqPiHizof90NlVf
         jcThsonKhOZ/MnO0eICgUn5kDENHOhY4Wh4jE/WOzp1iQq6eo0qxq0St+Q91f2QFOaT+
         7VJXCkDl0W9cKL2UQ5fWdjZ3ZQuRRlb/5hmLEEUwMOl9tYOM2QeEQIOVNRh07LUV+I+1
         G1V+AYc4COc6nZsP4C4R8s09+P6ovrGh/camvCSJ53g/QkL/a3i7jnFX88nAsatRx1OU
         QpqA==
X-Received: by 10.68.37.68 with SMTP id w4mr13525220pbj.105.1368119707824;
        Thu, 09 May 2013 10:15:07 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id pa2sm4407182pac.9.2013.05.09.10.15.03
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 May 2013 10:15:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g24a8a0f
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
References: <CANYiYbEvYXiRE0OeR5vqBAaOFFpJTPBetQbawZD5EcMCj8veFw@mail.gmail.com> <cover.1368118918.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223759>

Save some options in variable clean_flags, such as -ff (force > 1),
-x (ignored), -X (ignored_only), and -d (remove_directories). We may
change clean_flags later in the interactive git-clean.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 85345..26d00 100644
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
 static unsigned int colopts;
@@ -868,7 +874,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	int i, res;
 	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
 	int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
-	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
 	struct strbuf abs_path = STRBUF_INIT;
 	struct dir_struct dir;
 	static const char **pathspec;
@@ -902,13 +907,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, builtin_clean_usage,
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
@@ -922,15 +920,29 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
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
@@ -980,7 +992,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		}
 
 		if (S_ISDIR(st.st_mode)) {
-			if (remove_directories || (matches == MATCHED_EXACTLY)) {
+			if ((clean_flags & CLEAN_OPTS_REMOVE_DIRECTORIES) ||
+			    (matches == MATCHED_EXACTLY)) {
 				rel = path_relative(ent->name, prefix);
 				string_list_append(&del_list, rel);
 			}
@@ -1012,7 +1025,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 			continue;
 
 		if (S_ISDIR(st.st_mode)) {
-			if (remove_dirs(&abs_path, prefix, rm_flags, dry_run, quiet, &gone))
+			if (remove_dirs(&abs_path, prefix,
+					clean_flags & CLEAN_OPTS_REMOVE_NESTED_GIT ?
+						0 : REMOVE_DIR_KEEP_NESTED_GIT,
+					dry_run, quiet, &gone))
 				errors++;
 			if (gone && !quiet) {
 				qname = quote_path_relative(item->string, -1, &buf, NULL);
-- 
1.8.3.rc1.341.g24a8a0f
