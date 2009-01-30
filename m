From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [TOY PATCH] grep: Add the option '--show-in-pager'
Date: Fri, 30 Jan 2009 17:04:32 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901301702130.3586@pacific.mpi-cbg.de>
References: <cover.1233330920u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 17:06:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSvs7-0003CI-RW
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 17:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbZA3QEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 11:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbZA3QEK
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 11:04:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:47051 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751384AbZA3QEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 11:04:09 -0500
Received: (qmail invoked by alias); 30 Jan 2009 16:04:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp061) with SMTP; 30 Jan 2009 17:04:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199wEQCgq59fGk2Niw3xsLJNtUMEaG/e8peYORaZL
	Y0UcEjtTJhafwu
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1233330920u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107836>

This adds an option to open the matching files in the pager, and if the
pager happens to be "less" and there is only one grep pattern, it also
jumps to the first match right away.

So, 'git grep -p abc' is a short form for 'less +/abc $(grep -l abc)'
except that it works also with spaces in file names, and it does not
start the pager if there was no matching file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Yes, the name '--show-in-pager' sucks, but I have no idea how to 
	make the intention of the option clearer.

 builtin-grep.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 git.c          |    2 +-
 grep.c         |    6 +++++-
 grep.h         |    1 +
 4 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index bebf15c..9d17cea 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -11,6 +11,7 @@
 #include "tree-walk.h"
 #include "builtin.h"
 #include "grep.h"
+#include "string-list.h"
 
 #ifndef NO_EXTERNAL_GREP
 #ifdef __unix__
@@ -379,6 +380,19 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 }
 #endif
 
+static void run_pager(struct grep_opt *opt)
+{
+	char **argv = xmalloc(sizeof(const char *)
+			* (opt->collect_file_names->nr + 1));
+	int i;
+
+	for (i = 0; i < opt->collect_file_names->nr; i++)
+		argv[i] = opt->collect_file_names->items[i].string;
+	argv[opt->collect_file_names->nr] = NULL;
+
+	execvp(argv[0], argv);
+}
+
 static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 {
 	int hit = 0;
@@ -424,6 +438,8 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 			nr--; /* compensate for loop control */
 		}
 	}
+	if (hit && opt->collect_file_names)
+		run_pager(opt);
 	free_grep_patterns(opt);
 	return hit;
 }
@@ -525,6 +541,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	struct grep_opt opt;
 	struct object_array list = { 0, 0, NULL };
 	const char **paths = NULL;
+	struct string_list show_in_pager = { NULL, 0, 0, 1 };
 	int i;
 
 	memset(&opt, 0, sizeof(opt));
@@ -613,6 +630,19 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			opt.unmatch_name_only = 1;
 			continue;
 		}
+		if (!strcmp("-p", arg) ||
+		    !strcmp("--show-in-pager", arg)) {
+			const char *pager = getenv("GIT_PAGER");
+			if (!pager)
+				pager = getenv("PAGER");
+			if (!pager)
+				pager = "less";
+			builtin_grep = 1;
+			opt.name_only = 1;
+			opt.collect_file_names = &show_in_pager;
+			string_list_append(pager, &show_in_pager);
+			continue;
+		}
 		if (!strcmp("-z", arg) ||
 		    !strcmp("--null", arg)) {
 			opt.null_following_name = 1;
@@ -802,6 +832,24 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		paths[1] = NULL;
 	}
 
+	if (show_in_pager.nr && opt.pattern_list && !opt.pattern_list->next) {
+		const char *pager = show_in_pager.items[0].string;
+		int len = strlen(pager);
+
+		if (len > 4 && is_dir_sep(pager[len - 5]))
+			pager += len - 4;
+
+		if (!strcmp("less", pager)) {
+			struct strbuf buf = STRBUF_INIT;
+			strbuf_addf(&buf, "+/%s", opt.pattern_list->pattern);
+			string_list_append(buf.buf, &show_in_pager);
+			strbuf_release(&buf);
+		}
+	}
+
+	if (!show_in_pager.nr)
+		setup_pager();
+
 	if (!list.nr) {
 		if (!cached)
 			setup_work_tree();
@@ -817,6 +865,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		if (grep_object(&opt, paths, real_obj, list.objects[i].name))
 			hit = 1;
 	}
+	if (hit && show_in_pager.nr)
+		run_pager(&opt);
 	free_grep_patterns(&opt);
 	return !hit;
 }
diff --git a/git.c b/git.c
index 3c07567..dbd86ba 100644
--- a/git.c
+++ b/git.c
@@ -305,7 +305,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "fsck-objects", cmd_fsck, RUN_SETUP },
 		{ "gc", cmd_gc, RUN_SETUP },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
-		{ "grep", cmd_grep, RUN_SETUP | USE_PAGER },
+		{ "grep", cmd_grep, RUN_SETUP },
 		{ "help", cmd_help },
 #ifndef NO_CURL
 		{ "http-fetch", cmd_http_fetch, RUN_SETUP },
diff --git a/grep.c b/grep.c
index 062b2b6..051f78d 100644
--- a/grep.c
+++ b/grep.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "grep.h"
 #include "xdiff-interface.h"
+#include "string-list.h"
 
 void append_header_grep_pattern(struct grep_opt *opt, enum grep_header_field field, const char *pat)
 {
@@ -265,7 +266,10 @@ static void show_line(struct grep_opt *opt, const char *bol, const char *eol,
 
 static void show_name(struct grep_opt *opt, const char *name)
 {
-	printf("%s%c", name, opt->null_following_name ? '\0' : '\n');
+	if (opt->collect_file_names)
+		string_list_append(name, opt->collect_file_names);
+	else
+		printf("%s%c", name, opt->null_following_name ? '\0' : '\n');
 }
 
 static int fixmatch(const char *pattern, char *line, regmatch_t *match)
diff --git a/grep.h b/grep.h
index 5102ce3..2b5aa06 100644
--- a/grep.h
+++ b/grep.h
@@ -79,6 +79,7 @@ struct grep_opt {
 	int regflags;
 	unsigned pre_context;
 	unsigned post_context;
+	struct string_list *collect_file_names;
 };
 
 extern void append_grep_pattern(struct grep_opt *opt, const char *pat, const char *origin, int no, enum grep_pat_token t);
-- 
1.6.1.2.531.g6f52
