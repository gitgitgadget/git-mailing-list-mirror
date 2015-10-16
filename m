From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 12/12] WIP/broken Clone all outstanding submodules in parallel
Date: Thu, 15 Oct 2015 18:52:13 -0700
Message-ID: <1444960333-16003-13-git-send-email-sbeller@google.com>
References: <1444960333-16003-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 03:52:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmuCC-0002He-My
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 03:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbbJPBwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 21:52:34 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34350 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbbJPBwa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 21:52:30 -0400
Received: by payp3 with SMTP id p3so56449613pay.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 18:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z0MvxPvE4ZxeFW0sg4d9bgvaCl/1VIGxJTTIHQVrO+U=;
        b=BHbSOhNJwt6E4+Mnzto8wACMuYLJJ+/5AFjap4JIP2+ZClcF8AeY6XiQFFz3wwWC3D
         TX/pAHJpEClXiXmh3DK7PR+O4HqUChs92AVZCV3uKTrQuAYq6vqlIwbbMXqZV1EsNtzx
         IvGIOSxabk/SbZMMZs00gANwxeAEE4TOGSvUbBGxHH+Mpk49MAlFDJqzwENSZyboMVg2
         vyXjjr1Kpu0wo0BPd8Jg2qzORvg/rcNRwveSY/G6lM+Br+XvuXOE0AjjnjVO7KgSMm/3
         SDbrdaLFPKnvSTi0suwhUZQgK5esx+0J/+CHisMVSS20Or2U1Zd6zfnyVEva1+RYx+j7
         ZMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z0MvxPvE4ZxeFW0sg4d9bgvaCl/1VIGxJTTIHQVrO+U=;
        b=jfgnRktOQfJk5zLrXYW8B+uLQBHWKczd61cDOGoVhurGcd9rbnOiYYvyQqkWYcAUmy
         VpXr4kyn9P1ePhOb2rdkk7A30HP5UiUEu1pYX8d8Bp15R8o6BDe+V/1GukcK0/7r/eje
         10ti+Ow/HhQ5G7XveSLP5Kkh4os/Sr/RXnPy9R6KGrBD3X3+mgPoKI0R/kD0VjzKupFt
         yVNQ/yzLsegs0i1jNArFyCkRefwGaB/LrpGCXQWozUtu/YaVdiXoK3RZGG+vNRvVx+CT
         wqIgYeArt03UlQ5fLs14XzhB/jvyfYbHZgW5RpOXwndCGtjTm+A5DKDq21cTFnY0h5+x
         NwEw==
X-Gm-Message-State: ALoCoQl3hZnl70MY4hXxeLwH0ZH92wSxs1k6kPEW/CLw3aJN4XJHY/bSlnf5JwaYtB2mNdzkJLQW
X-Received: by 10.66.219.162 with SMTP id pp2mr13371455pac.59.1444960349650;
        Thu, 15 Oct 2015 18:52:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8909:dd69:53c0:2cb6])
        by smtp.gmail.com with ESMTPSA id be3sm17761433pbc.88.2015.10.15.18.52.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 18:52:29 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.277.gfdc362b.dirty
In-Reply-To: <1444960333-16003-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279721>

Our tests scream at this patch, it's just to show what I plan to do.
Essentially moving the content of the loop into the get_next_task
callback from the run_processes_parallel.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 181 +++++++++++++++++++++++++++++---------------
 1 file changed, 119 insertions(+), 62 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fa8c008..c66aa53 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -289,65 +289,40 @@ static void fill_clone_command(struct child_process *cp, int quiet,
 		argv_array_push(&cp->args, depth);
 }
 
-static int module_list_or_clone(int argc, const char **argv, const char *prefix)
-{
-	int i;
-	int quiet;
-	char *reference = NULL, *depth = NULL;
-	char *update = NULL;
+struct submodule_list_or_clone {
 	struct pathspec pathspec;
-	struct module_list list = MODULE_LIST_INIT;
-	struct string_list projectlines = STRING_LIST_INIT_DUP;
-	struct string_list_item *item;
-
-	struct option module_list_options[] = {
-		OPT_STRING(0, "prefix", &prefix,
-			   N_("path"),
-			   N_("alternative anchor for relative paths")),
-		OPT_STRING(0, "update", &update,
-			   N_("string"),
-			   N_("update command for submodules")),
-		OPT_STRING(0, "reference", &reference, "<repository>",
-			N_("Use the local reference repository "
-			   "instead of a full clone")),
-		OPT_STRING(0, "depth", &depth, "<depth>",
-			N_("Create a shallow clone truncated to the "
-			   "specified number of revisions")),
-		OPT__QUIET(&quiet, N_("do't print cloning progress")),
-		OPT_END()
-	};
-
-	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper list [--prefix=<path>] [<path>...]"),
-		NULL
-	};
-
-	argc = parse_options(argc, argv, prefix, module_list_options,
-			     git_submodule_helper_usage, 0);
-
-	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
-		printf("#unmatched\n");
-		return 1;
-	}
+	struct module_list list;
+	struct string_list projectlines;
+	int count;
+	int quiet;
+	char *reference;
+	char *depth;
+	char *update;
+	char *env_prefix;
+	const char *prefix;
+	int print_unmatched;
+};
 
-	gitmodules_config();
-	/* Overlay the parsed .gitmodules file with .git/config */
-	git_config(git_submodule_config, NULL);
+static int get_next_task(void **pp_task_cb,
+			 struct child_process *cp,
+			 struct strbuf *err,
+			 void *pp_cb)
+{
+	struct submodule_list_or_clone *pp = pp_cb;
 
-	for (i = 0; i < list.nr; i++) {
+	for (; pp->count < pp->list.nr; pp->count++) {
 		const struct submodule *sub = NULL;
 		const char *displaypath = NULL;
-		const struct cache_entry *ce = list.entries[i];
+		const struct cache_entry *ce = pp->list.entries[pp->count];
 		struct strbuf sb = STRBUF_INIT;
 		const char *update_module = NULL;
 		const char *url = NULL;
 		int just_cloned = 0;
 
-		char *env_prefix = getenv("prefix");
 		if (ce_stage(ce)) {
-			if (env_prefix)
+			if (pp->env_prefix)
 				fprintf(stderr, "Skipping unmerged submodule %s/%s\n",
-					env_prefix, ce->name);
+					pp->env_prefix, ce->name);
 			else
 				fprintf(stderr, "Skipping unmerged submodule %s\n",
 					ce->name);
@@ -355,13 +330,13 @@ static int module_list_or_clone(int argc, const char **argv, const char *prefix)
 		}
 
 		sub = submodule_from_path(null_sha1, ce->name);
-		if (env_prefix)
-			displaypath = relative_path(env_prefix, ce->name, &sb);
+		if (pp->env_prefix)
+			displaypath = relative_path(pp->env_prefix, ce->name, &sb);
 		else
 			displaypath = ce->name;
 
-		if (update)
-			update_module = update;
+		if (pp->update)
+			update_module = pp->update;
 		if (!update_module)
 			update_module = sub->update;
 		if (!update_module)
@@ -385,7 +360,7 @@ static int module_list_or_clone(int argc, const char **argv, const char *prefix)
 			 * Only mention uninitialized submodules when its
 			 * path have been specified
 			 */
-			if (pathspec.nr)
+			if (pp->pathspec.nr)
 				fprintf(stderr, _("Submodule path '%s' not initialized\n"
 					"Maybe you want to use 'update --init'?"), displaypath);
 			continue;
@@ -396,23 +371,105 @@ static int module_list_or_clone(int argc, const char **argv, const char *prefix)
 		just_cloned = !file_exists(sb.buf);
 
 		if (just_cloned) {
-			struct child_process cp = CHILD_PROCESS_INIT;
-			fill_clone_command(&cp, quiet, prefix, ce->name,
-					   sub->name, url, reference, depth);
-
-			if (run_command(&cp)) {
-				printf("#unmatched\n");
-				return 1;
-			}
+			fill_clone_command(cp, pp->quiet, pp->prefix, ce->name,
+					   sub->name, url, pp->reference, pp->depth);
+			return 1;
 		}
 		strbuf_reset(&sb);
 		strbuf_addf(&sb, "%06o %s %d %d\t%s\n", ce->ce_mode,
 				sha1_to_hex(ce->sha1), ce_stage(ce),
 				just_cloned, ce->name);
-		string_list_append(&projectlines, sb.buf);
+		string_list_append(&pp->projectlines, sb.buf);
+	}
+	return 0;
+}
+
+static int start_failure(struct child_process *cp,
+			 struct strbuf *err,
+			 void *pp_cb,
+			 void *pp_task_cb)
+{
+	struct submodule_list_or_clone *pp = pp_cb;
+
+	pp->print_unmatched = 1;
+
+	return 1;
+}
+
+static int task_finished(int result,
+			 struct child_process *cp,
+			 struct strbuf *err,
+			 void *pp_cb,
+			 void *pp_task_cb)
+{
+	struct submodule_list_or_clone *pp = pp_cb;
+
+	if (!result)
+		return 0;
+	else {
+		pp->print_unmatched = 1;
+		return 1;
+	}
+}
+
+static int module_list_or_clone(int argc, const char **argv, const char *prefix)
+{
+	struct submodule_list_or_clone pp;
+	struct string_list_item *item;
+
+	struct option module_list_options[] = {
+		OPT_STRING(0, "prefix", &pp.prefix,
+			   N_("path"),
+			   N_("alternative anchor for relative paths")),
+		OPT_STRING(0, "update", &pp.update,
+			   N_("string"),
+			   N_("update command for submodules")),
+		OPT_STRING(0, "reference", &pp.reference, "<repository>",
+			N_("Use the local reference repository "
+			   "instead of a full clone")),
+		OPT_STRING(0, "depth", &pp.depth, "<depth>",
+			N_("Create a shallow clone truncated to the "
+			   "specified number of revisions")),
+		OPT__QUIET(&pp.quiet, N_("do't print cloning progress")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper list [--prefix=<path>] [<path>...]"),
+		NULL
+	};
+
+	pp.prefix = NULL;
+	pp.list.entries = NULL;
+	pp.list.alloc = 0;
+	pp.list.nr = 0;
+	string_list_init(&pp.projectlines, 1);
+	pp.count = 0;
+	pp.reference = NULL;
+	pp.depth = NULL;
+	pp.update = NULL;
+	pp.env_prefix = getenv("prefix");
+	pp.print_unmatched = 0;
+
+	argc = parse_options(argc, argv, prefix, module_list_options,
+			     git_submodule_helper_usage, 0);
+
+	if (module_list_compute(argc, argv, pp.prefix, &pp.pathspec, &pp.list) < 0) {
+		printf("#unmatched\n");
+		return 1;
+	}
+
+	gitmodules_config();
+	/* Overlay the parsed .gitmodules file with .git/config */
+	git_config(git_submodule_config, NULL);
+
+	run_processes_parallel(1, get_next_task, start_failure, task_finished, &pp);
+	if (pp.print_unmatched) {
+		printf("#unmatched\n");
+		return 1;
 	}
 
-	for_each_string_list_item(item, &projectlines) {
+	for_each_string_list_item(item, &pp.projectlines) {
 		utf8_fprintf(stdout, "%s", item->string);
 	}
 	return 0;
-- 
2.5.0.277.gfdc362b.dirty
