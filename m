From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] grep: Add the option '--open-files-in-pager'
Date: Fri, 26 Mar 2010 11:49:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003261149040.7596@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 26 11:49:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nv76T-0002ca-Tz
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 11:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295Ab0CZKtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 06:49:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:42043 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753232Ab0CZKtT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 06:49:19 -0400
Received: (qmail invoked by alias); 26 Mar 2010 10:49:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 26 Mar 2010 11:49:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+cyTUosNicRcljVI3s2X/2ZMXQPOh6d2Y4DPWuCH
	Ae5QZHaQ3MXK/I
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.40999999999999998
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143220>


This adds an option to open the matching files in the pager, and if the
pager happens to be "less" (or "vi") and there is only one grep pattern,
it also jumps to the first match right away.

The short option was chose as '-O' to avoid clashes with GNU grep's
options (as suggested by Junio).

So, 'git grep -O abc' is a short form for 'less +/abc $(grep -l abc)'
except that it works also with spaces in file names, and it does not
start the pager if there was no matching file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-grep.txt |    8 +++++
 builtin-grep.c             |   71 ++++++++++++++++++++++++++++++++++++++++++++
 git.c                      |    2 +-
 3 files changed, 80 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index e019e76..ab3bb77 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-F | --fixed-strings] [-n]
 	   [-l | --files-with-matches] [-L | --files-without-match]
+	   [-O | --open-files-in-pager]
 	   [-z | --null]
 	   [-c | --count] [--all-match] [-q | --quiet]
 	   [--max-depth <depth>]
@@ -101,6 +102,13 @@ OPTIONS
 	For better compatibility with 'git diff', --name-only is a
 	synonym for --files-with-matches.
 
+-O::
+--open-files-in-pager::
+	Open the matching files in the pager (not the output of 'grep').
+	If the pager happens to be "less" or "vi", and the user
+	specified only one pattern, the first file is positioned at
+	the first match automatically.
+
 -z::
 --null::
 	Output \0 instead of the character that normally follows a
diff --git a/builtin-grep.c b/builtin-grep.c
index 5d83d9b..233c772 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -14,6 +14,7 @@
 #include "userdiff.h"
 #include "grep.h"
 #include "quote.h"
+#include "string-list.h"
 
 #ifndef NO_PTHREADS
 #include "thread-utils.h"
@@ -517,6 +518,31 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	}
 }
 
+static void append_path(struct grep_opt *opt, const void *data, size_t len)
+{
+	struct string_list *path_list = opt->output_priv;
+
+	if (len == 1 && *(char *)data == '\0')
+		return;
+	string_list_append(xstrndup(data, len), path_list);
+}
+
+static void run_pager(struct grep_opt *opt, const char *prefix)
+{
+	struct string_list *path_list = opt->output_priv;
+	char **argv = xmalloc(sizeof(const char *) * (path_list->nr + 1));
+	int i;
+
+	for (i = 0; i < path_list->nr; i++)
+		argv[i] = path_list->items[i].string;
+	argv[path_list->nr] = NULL;
+
+	if (prefix)
+		chdir(prefix);
+	execvp(argv[0], argv);
+	error("Could not run pager %s: %s", argv[0], strerror(errno));
+}
+
 static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 {
 	int hit = 0;
@@ -727,9 +753,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	int cached = 0;
 	int seen_dashdash = 0;
 	int external_grep_allowed__ignored;
+	int show_in_pager = 0;
 	struct grep_opt opt;
 	struct object_array list = { 0, 0, NULL };
 	const char **paths = NULL;
+	struct string_list path_list = { NULL, 0, 0, 0 };
 	int i;
 	int dummy;
 	struct option options[] = {
@@ -810,6 +838,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "all-match", &opt.all_match,
 			"show only matches from files that match all patterns"),
 		OPT_GROUP(""),
+		OPT_BOOLEAN('O', "open-files-in-pager", &show_in_pager,
+			"show matching files in the pager"),
 		OPT_BOOLEAN(0, "ext-grep", &external_grep_allowed__ignored,
 			    "allow calling of grep(1) (ignored by this build)"),
 		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, "show usage",
@@ -862,6 +892,20 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		argc--;
 	}
 
+	if (show_in_pager) {
+		const char *pager = getenv("GIT_PAGER");
+		if (!pager)
+			pager = getenv("PAGER");
+		if (!pager)
+			pager = "less";
+		opt.name_only = 1;
+		opt.null_following_name = 1;
+		opt.output_priv = &path_list;
+		opt.output = append_path;
+		string_list_append(pager, &path_list);
+		use_threads = 0;
+	}
+
 	if (!opt.pattern_list)
 		die("no pattern given.");
 	if (!opt.fixed && opt.ignore_case)
@@ -921,6 +965,29 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		paths[1] = NULL;
 	}
 
+	if (show_in_pager && (cached || list.nr))
+		die ("--open-files-in-pager only works on the worktree");
+
+	if (show_in_pager && opt.pattern_list && !opt.pattern_list->next) {
+		const char *pager = path_list.items[0].string;
+		int len = strlen(pager);
+
+		if (len > 4 && is_dir_sep(pager[len - 5]))
+			pager += len - 4;
+
+		if (!strcmp("less", pager) || !strcmp("vi", pager)) {
+			struct strbuf buf = STRBUF_INIT;
+			strbuf_addf(&buf, "+/%s%s",
+					strcmp("less", pager) ? "" : "*",
+					opt.pattern_list->pattern);
+			string_list_append(buf.buf, &path_list);
+			strbuf_detach(&buf, NULL);
+		}
+	}
+
+	if (!show_in_pager)
+		setup_pager();
+
 	if (!list.nr) {
 		if (!cached)
 			setup_work_tree();
@@ -943,6 +1010,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 
 	if (use_threads)
 		hit |= wait_all();
+
+	if (hit && show_in_pager)
+		run_pager(&opt, prefix);
+
 	free_grep_patterns(&opt);
 	return !hit;
 }
diff --git a/git.c b/git.c
index 4c3028c..4def718 100644
--- a/git.c
+++ b/git.c
@@ -317,7 +317,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "fsck-objects", cmd_fsck, RUN_SETUP },
 		{ "gc", cmd_gc, RUN_SETUP },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
-		{ "grep", cmd_grep, RUN_SETUP | USE_PAGER },
+		{ "grep", cmd_grep, RUN_SETUP },
 		{ "hash-object", cmd_hash_object },
 		{ "help", cmd_help },
 		{ "index-pack", cmd_index_pack },
-- 
1.6.4.313.g3d9e3
