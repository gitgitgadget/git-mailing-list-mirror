From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] use file_exists() to check if a file exists in the worktree
Date: Tue, 19 May 2015 23:44:23 +0200
Message-ID: <555BAEB7.7000807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 19 23:44:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YupJp-0000yk-3Z
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 23:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbbESVox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 17:44:53 -0400
Received: from mout.web.de ([212.227.17.12]:55418 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbbESVov (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 17:44:51 -0400
Received: from [192.168.178.27] ([79.253.161.1]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MfYn9-1YVsZy3ILL-00P1gu; Tue, 19 May 2015 23:44:46
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
X-Provags-ID: V03:K0:+2G8KH1YhwmGUbv0ryl0lhVtk610E6DXQzF9QpIPrevZ2PJwxZI
 TDAQH0YMYg/qwSQkp7hCJp8pyRSGc8yYN02mjK5bY1qKCRKAsKQBJSL3U1k/0aqMEMtzhbW
 Y67mcqM6gtNng2Ur57xYG5IGGpSGg/nWmHGgvKcUor4fXJ7GdcdgGUhQnPgEMj4zIX+4mn+
 oxUj3r8sYjfdbTJNxG0oA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269408>

Call file_exists() instead of open-coding it.  That's shorter, simpler
and the intent becomes clearer.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/blame.c   | 15 +++------------
 builtin/rm.c      |  3 +--
 merge-recursive.c |  3 +--
 sha1_name.c       |  7 +++----
 submodule.c       |  3 +--
 5 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 8d70623..ff97825 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -26,6 +26,7 @@
 #include "userdiff.h"
 #include "line-range.h"
 #include "line-log.h"
+#include "dir.h"
 
 static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] file");
 
@@ -2151,16 +2152,6 @@ static void sanity_check_refcnt(struct scoreboard *sb)
 	}
 }
 
-/*
- * Used for the command line parsing; check if the path exists
- * in the working tree.
- */
-static int has_string_in_work_tree(const char *path)
-{
-	struct stat st;
-	return !lstat(path, &st);
-}
-
 static unsigned parse_score(const char *arg)
 {
 	char *end;
@@ -2656,14 +2647,14 @@ parse_done:
 		if (argc < 2)
 			usage_with_options(blame_opt_usage, options);
 		path = add_prefix(prefix, argv[argc - 1]);
-		if (argc == 3 && !has_string_in_work_tree(path)) { /* (2b) */
+		if (argc == 3 && !file_exists(path)) { /* (2b) */
 			path = add_prefix(prefix, argv[1]);
 			argv[1] = argv[2];
 		}
 		argv[argc - 1] = "--";
 
 		setup_work_tree();
-		if (!has_string_in_work_tree(path))
+		if (!file_exists(path))
 			die_errno("cannot stat path '%s'", path);
 	}
 
diff --git a/builtin/rm.c b/builtin/rm.c
index 3304bff..80b972f 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -84,7 +84,6 @@ static int check_submodules_use_gitfiles(void)
 		const char *name = list.entry[i].name;
 		int pos;
 		const struct cache_entry *ce;
-		struct stat st;
 
 		pos = cache_name_pos(name, strlen(name));
 		if (pos < 0) {
@@ -95,7 +94,7 @@ static int check_submodules_use_gitfiles(void)
 		ce = active_cache[pos];
 
 		if (!S_ISGITLINK(ce->ce_mode) ||
-		    (lstat(ce->name, &st) < 0) ||
+		    !file_exists(ce->name) ||
 		    is_empty_dir(name))
 			continue;
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 1c9c30d..44d85be 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -611,7 +611,6 @@ static char *unique_path(struct merge_options *o, const char *path, const char *
 {
 	struct strbuf newpath = STRBUF_INIT;
 	int suffix = 0;
-	struct stat st;
 	size_t base_len;
 
 	strbuf_addf(&newpath, "%s~", path);
@@ -620,7 +619,7 @@ static char *unique_path(struct merge_options *o, const char *path, const char *
 	base_len = newpath.len;
 	while (string_list_has_string(&o->current_file_set, newpath.buf) ||
 	       string_list_has_string(&o->current_directory_set, newpath.buf) ||
-	       lstat(newpath.buf, &st) == 0) {
+	       file_exists(newpath.buf)) {
 		strbuf_setlen(&newpath, base_len);
 		strbuf_addf(&newpath, "_%d", suffix++);
 	}
diff --git a/sha1_name.c b/sha1_name.c
index 6d10f05..6de8c87 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -6,6 +6,7 @@
 #include "tree-walk.h"
 #include "refs.h"
 #include "remote.h"
+#include "dir.h"
 
 static int get_sha1_oneline(const char *, unsigned char *, struct commit_list *);
 
@@ -1237,14 +1238,13 @@ static void diagnose_invalid_sha1_path(const char *prefix,
 				       const char *object_name,
 				       int object_name_len)
 {
-	struct stat st;
 	unsigned char sha1[20];
 	unsigned mode;
 
 	if (!prefix)
 		prefix = "";
 
-	if (!lstat(filename, &st))
+	if (file_exists(filename))
 		die("Path '%s' exists on disk, but not in '%.*s'.",
 		    filename, object_name_len, object_name);
 	if (errno == ENOENT || errno == ENOTDIR) {
@@ -1271,7 +1271,6 @@ static void diagnose_invalid_index_path(int stage,
 					const char *prefix,
 					const char *filename)
 {
-	struct stat st;
 	const struct cache_entry *ce;
 	int pos;
 	unsigned namelen = strlen(filename);
@@ -1314,7 +1313,7 @@ static void diagnose_invalid_index_path(int stage,
 			    ce_stage(ce), filename);
 	}
 
-	if (!lstat(filename, &st))
+	if (file_exists(filename))
 		die("Path '%s' exists on disk, but not in the index.", filename);
 	if (errno == ENOENT || errno == ENOTDIR)
 		die("Path '%s' does not exist (neither on disk nor in the index).",
diff --git a/submodule.c b/submodule.c
index d491e6a..b8747f5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -891,7 +891,6 @@ int submodule_uses_gitfile(const char *path)
 
 int ok_to_remove_submodule(const char *path)
 {
-	struct stat st;
 	ssize_t len;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	const char *argv[] = {
@@ -904,7 +903,7 @@ int ok_to_remove_submodule(const char *path)
 	struct strbuf buf = STRBUF_INIT;
 	int ok_to_remove = 1;
 
-	if ((lstat(path, &st) < 0) || is_empty_dir(path))
+	if (!file_exists(path) || is_empty_dir(path))
 		return 1;
 
 	if (!submodule_uses_gitfile(path))
-- 
2.4.1
