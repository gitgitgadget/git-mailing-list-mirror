From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v8 10/12] git-clean refactor: add wrapper scan_clean_candidates
Date: Fri, 10 May 2013 01:14:14 +0800
Message-ID: <d09dbbd3fc3e9f46bcd9f0444fbdc78e8cd0cb96.1368118918.git.worldhello.net@gmail.com>
References: <cover.1368118918.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 09 19:15:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaUR5-0003HP-Vv
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 19:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab3EIRPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 13:15:14 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:52777 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab3EIRPM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 13:15:12 -0400
Received: by mail-pa0-f52.google.com with SMTP id bg2so2274029pad.39
        for <git@vger.kernel.org>; Thu, 09 May 2013 10:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=axM8OjfSAZ2EFlkFf7bUtFUpdRW/Xc4eHrMwwrOW0CI=;
        b=FiDB+vtC4Wa0Ay35ERZZ6luFiGYiQxY1OxT7OqFLKG5rEQox8oMowrjj05+19+mO4q
         QJwit6+bZtrt00et3NSqTX5pk2KViXIAdprqhqX/JqFWvKGuqe+EEeBhmcUyS+AM2a/e
         Sn7CRY/16oWbGKuXWDeB+lYFM+TnwsUEqC2yK9qyEQW25kZrclcsa+JdI3eo/gJlZqAN
         jnsxhTDiyshrPflRv3EuhJ+e1nQmUA5F6MA+xx2KYb6WSjaVhXKb8dmp2aWyAzfoxpps
         87KcajKNjP4XJrp0beSbHxNTrQbzpU6QOI6LhzN9tG5AOkK9j1N7bWe+DLZUMYhB6oM9
         n61g==
X-Received: by 10.66.177.46 with SMTP id cn14mr14279339pac.4.1368119711959;
        Thu, 09 May 2013 10:15:11 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id pa2sm4407182pac.9.2013.05.09.10.15.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 May 2013 10:15:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g24a8a0f
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
References: <CANYiYbEvYXiRE0OeR5vqBAaOFFpJTPBetQbawZD5EcMCj8veFw@mail.gmail.com> <cover.1368118918.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223757>

Add new wrapper `scan_clean_candidates`, which determines the del_list
(i.e. the cleaning candidates). This function will be reused later in
the interactive git-clean, so we can change flags of git-clean and
refresh the del_list.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c | 169 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 93 insertions(+), 76 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 26d00..232d48 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -295,6 +295,96 @@ static const char *path_relative(const char *in, const char *prefix)
 	return buf;
 }
 
+static void scan_clean_candidates(const char **pathspec,
+				  struct string_list exclude_list,
+				  const char *prefix)
+{
+	struct dir_struct dir;
+	struct exclude_list *el;
+	char *seen = NULL;
+	const char **pathspec_p = pathspec;
+	const char *rel;
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
+			    (matches == MATCHED_EXACTLY)) {
+				rel = path_relative(ent->name, prefix);
+				string_list_append(&del_list, rel);
+			}
+		} else {
+			if (pathspec && !matches)
+				continue;
+			rel = path_relative(ent->name, prefix);
+			string_list_append(&del_list, rel);
+		}
+	}
+
+	free(seen);
+}
+
 static void pretty_print_dels(void)
 {
 	struct string_list list = STRING_LIST_INIT_DUP;
@@ -871,18 +961,15 @@ static void interactive_main_loop(void)
 
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
-	int i, res;
+	int res;
 	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
 	int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
 	struct strbuf abs_path = STRBUF_INIT;
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
@@ -932,78 +1019,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
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
 	pathspec = get_pathspec(prefix, argv);
 
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
-		const char *rel;
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
-			    (matches == MATCHED_EXACTLY)) {
-				rel = path_relative(ent->name, prefix);
-				string_list_append(&del_list, rel);
-			}
-		} else {
-			if (pathspec && !matches)
-				continue;
-			rel = path_relative(ent->name, prefix);
-			string_list_append(&del_list, rel);
-		}
-	}
+	scan_clean_candidates(pathspec, exclude_list, prefix);
 
 	if (interactive && !dry_run && del_list.nr > 0)
 		interactive_main_loop();
@@ -1047,7 +1065,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		}
 		strbuf_reset(&abs_path);
 	}
-	free(seen);
 
 	strbuf_release(&abs_path);
 	string_list_clear(&del_list, 0);
-- 
1.8.3.rc1.341.g24a8a0f
