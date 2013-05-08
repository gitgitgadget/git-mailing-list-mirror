From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v7 09/10] git-clean refactor: wrap in scan_clean_candidates
Date: Wed,  8 May 2013 19:38:54 +0800
Message-ID: <ebfb3ccf679c26734af655878cf84fff170c96c5.1368011946.git.worldhello.net@gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
 <ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
 <6a7931a0bb14f8c71479e16175812bedb6b826cb.1368011946.git.worldhello.net@gmail.com>
 <d7302adabb4269dd94698090fb20c739f723f00a.1368011946.git.worldhello.net@gmail.com>
 <e7cf5d7ffd83e238078b4585ac4bef4ec9a48e21.1368011946.git.worldhello.net@gmail.com>
 <ae69a75fa1bbad9827ef3891a33c3bfa6685d914.1368011946.git.worldhello.net@gmail.com>
 <95c019e293fcea899e5e227c35338f696f99525f.1368011946.git.worldhello.net@gmail.com>
 <187bf672e3795601f929f15b102746e5083471c5.1368011946.git.worldhello.net@gmail.com>
 <e9af9f5886217f99dedbb7e830bcebece892c891.1368011946.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 08 13:39:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua2im-0001Lx-OH
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 13:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749Ab3EHLjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 07:39:41 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:33591 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508Ab3EHLjk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 07:39:40 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so1164606pbc.30
        for <git@vger.kernel.org>; Wed, 08 May 2013 04:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=7YSyw2Gl3GST/JjCGBIHsy+osLpdLleo9W60NvDj1ds=;
        b=YCmw8tic1Nx+NecnIjz28VuKUCA4OWKmyzEK9ABV5sziCJ+BiifKBzvV1dgyeCoWzJ
         Znf4HzlifaGs1MrqP3SwkN6XMVgJNDBp+nmGQA64tZzg6mBGl4y+qGlYNtcdjNEjkZMf
         CAsFDUqdky8wCBPNxOLH0Q/18UToLvjkKmszmPisLybV+0451F0eoyDCktllF4tDfVUi
         h+3HY6MhP6VqnNqw8GWlgMaww5ovp1p9I5fz8U7LOvWcaZAK6jjSBEIF1+IR7YyQZ27J
         nS5MB7aP8YGpK97aNajzko44IVI4UGS7qG0d6iBCltkRbhnEk6b5FM2wGeiQjeqxoJQ4
         4kng==
X-Received: by 10.66.245.75 with SMTP id xm11mr7637942pac.40.1368013180380;
        Wed, 08 May 2013 04:39:40 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id gc5sm32287860pbb.19.2013.05.08.04.39.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 04:39:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g1c24ab7
In-Reply-To: <e9af9f5886217f99dedbb7e830bcebece892c891.1368011946.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368011946.git.worldhello.net@gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223663>

Add new function `scan_clean_candidates`, which determines the del_list
(i.e. the cleaning candidates). This function will be reused later in
the interactive git-clean, so we can change flags of git-clean and
refresh the del_list.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c | 169 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 92 insertions(+), 77 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index d46f3..0d8561 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -254,6 +254,95 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	return ret;
 }
 
+static void scan_clean_candidates(const char **pathspec, struct string_list exclude_list)
+{
+	struct dir_struct dir;
+	struct exclude_list *el;
+	char *seen = NULL;
+	const char **pathspec_p = pathspec;
+	int pathspec_nr = 0;
+	int i;
+
+	while (pathspec_p && *(pathspec_p++))
+		pathspec_nr++;
+
+	memset(&dir, 0, sizeof(dir));
+	if (clean_flags & CLEAN_OPTS_IGNORED_ONLY)
+		dir.flags |= DIR_SHOW_IGNORED;
+
+	if (clean_flags & CLEAN_OPTS_IGNORED_ONLY &&
+	    clean_flags & CLEAN_OPTS_SHOW_IGNORED)
+		die(_("-x and -X cannot be used together"));
+
+	dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
+
+	if (!(clean_flags & CLEAN_OPTS_SHOW_IGNORED))
+		setup_standard_excludes(&dir);
+
+	el = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
+	for (i = 0; i < exclude_list.nr; i++)
+		add_exclude(exclude_list.items[i].string, "", 0, el, -(i+1));
+
+	fill_directory(&dir, pathspec);
+
+	if (pathspec)
+		seen = xmalloc(pathspec_nr > 0 ? pathspec_nr : 1);
+
+	string_list_clear(&del_list, 0);
+
+	for (i = 0; i < dir.nr; i++) {
+		struct dir_entry *ent = dir.entries[i];
+		int len, pos;
+		int matches = 0;
+		struct cache_entry *ce;
+		struct stat st;
+
+		/*
+		 * Remove the '/' at the end that directory
+		 * walking adds for directory entries.
+		 */
+		len = ent->len;
+		if (len && ent->name[len-1] == '/')
+			len--;
+		pos = cache_name_pos(ent->name, len);
+		if (0 <= pos)
+			continue;	/* exact match */
+		pos = -pos - 1;
+		if (pos < active_nr) {
+			ce = active_cache[pos];
+			if (ce_namelen(ce) == len &&
+			    !memcmp(ce->name, ent->name, len))
+				continue; /* Yup, this one exists unmerged */
+		}
+
+		/*
+		 * we might have removed this as part of earlier
+		 * recursive directory removal, so lstat() here could
+		 * fail with ENOENT.
+		 */
+		if (lstat(ent->name, &st))
+			continue;
+
+		if (pathspec) {
+			memset(seen, 0, pathspec_nr > 0 ? pathspec_nr : 1);
+			matches = match_pathspec(pathspec, ent->name, len,
+						 0, seen);
+		}
+
+		if (S_ISDIR(st.st_mode)) {
+			if ((clean_flags & CLEAN_OPTS_REMOVE_DIRECTORIES) ||
+			    (matches == MATCHED_EXACTLY))
+				string_list_append(&del_list, ent->name);
+		} else {
+			if (pathspec && !matches)
+				continue;
+			string_list_append(&del_list, ent->name);
+		}
+	}
+
+	free(seen);
+}
+
 static void pretty_print_dels()
 {
 	struct string_list list = STRING_LIST_INIT_DUP;
@@ -846,18 +935,15 @@ static void interactive_main_loop()
 
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
-	int i, res;
+	int res;
 	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
 	int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
 	struct strbuf directory = STRBUF_INIT;
-	struct dir_struct dir;
 	static const char **pathspec;
 	struct strbuf buf = STRBUF_INIT;
-	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
-	struct exclude_list *el;
 	struct string_list_item *item;
+	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
 	const char *qname;
-	char *seen = NULL;
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("do not print names of files removed")),
 		OPT__DRY_RUN(&dry_run, N_("dry run")),
@@ -909,79 +995,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (remove_directories)
 		clean_flags |= CLEAN_OPTS_REMOVE_DIRECTORIES;
 
-	memset(&dir, 0, sizeof(dir));
-	if (clean_flags & CLEAN_OPTS_IGNORED_ONLY)
-		dir.flags |= DIR_SHOW_IGNORED;
-
-	if (clean_flags & CLEAN_OPTS_IGNORED_ONLY &&
-	    clean_flags & CLEAN_OPTS_SHOW_IGNORED)
-		die(_("-x and -X cannot be used together"));
-
-	dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
-
-	if (!(clean_flags & CLEAN_OPTS_SHOW_IGNORED))
-		setup_standard_excludes(&dir);
-
-	el = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
-	for (i = 0; i < exclude_list.nr; i++)
-		add_exclude(exclude_list.items[i].string, "", 0, el, -(i+1));
-
 	pathspec = get_pathspec(*the_prefix, argv);
 
-	fill_directory(&dir, pathspec);
-
-	if (pathspec)
-		seen = xmalloc(argc > 0 ? argc : 1);
-
-	for (i = 0; i < dir.nr; i++) {
-		struct dir_entry *ent = dir.entries[i];
-		int len, pos;
-		int matches = 0;
-		struct cache_entry *ce;
-		struct stat st;
-
-		/*
-		 * Remove the '/' at the end that directory
-		 * walking adds for directory entries.
-		 */
-		len = ent->len;
-		if (len && ent->name[len-1] == '/')
-			len--;
-		pos = cache_name_pos(ent->name, len);
-		if (0 <= pos)
-			continue;	/* exact match */
-		pos = -pos - 1;
-		if (pos < active_nr) {
-			ce = active_cache[pos];
-			if (ce_namelen(ce) == len &&
-			    !memcmp(ce->name, ent->name, len))
-				continue; /* Yup, this one exists unmerged */
-		}
-
-		/*
-		 * we might have removed this as part of earlier
-		 * recursive directory removal, so lstat() here could
-		 * fail with ENOENT.
-		 */
-		if (lstat(ent->name, &st))
-			continue;
-
-		if (pathspec) {
-			memset(seen, 0, argc > 0 ? argc : 1);
-			matches = match_pathspec(pathspec, ent->name, len,
-						 0, seen);
-		}
-
-		if (S_ISDIR(st.st_mode)) {
-			if ((clean_flags & CLEAN_OPTS_REMOVE_DIRECTORIES) ||
-			    (matches == MATCHED_EXACTLY))
-				string_list_append(&del_list, ent->name);
-		} else {
-			if (pathspec && !matches)
-				continue;
-			string_list_append(&del_list, ent->name);
-		}
-	}
+	scan_clean_candidates(pathspec, exclude_list);
 
 	if (interactive && !dry_run && del_list.nr > 0)
 		interactive_main_loop();
@@ -1016,7 +1032,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 			}
 		}
 	}
-	free(seen);
 
 	strbuf_release(&directory);
 	string_list_clear(&exclude_list, 0);
-- 
1.8.3.rc1.341.g1c24ab7
