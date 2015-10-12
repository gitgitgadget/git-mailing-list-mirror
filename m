From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 7/8] fetch_populated_submodules: use new parallel job processing
Date: Mon, 12 Oct 2015 11:47:20 -0700
Message-ID: <1444675641-14866-8-git-send-email-sbeller@google.com>
References: <1444675641-14866-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 12 20:47:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zli8X-0006Ox-F0
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 20:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbbJLSrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 14:47:45 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34763 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbbJLSrf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 14:47:35 -0400
Received: by padhy16 with SMTP id hy16so160547265pad.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 11:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XxI8aTa+gL65v5twgbeRouio9rlIcCGMTQnKUkSHzPA=;
        b=IUNUjNPdGpBgHqiPeRqrSAyK5btjuhHS5azOFksRMEATCKCTvEVIcqBjArIRd6LiuV
         uehyaf75eEV04NtAix/wgMNoohDkDEKtsKtrbyf2oW/GgO3cBfIKaSP2BdYvYwnMTjOP
         yyimFEURKCKj7sEv2r34n7DWXoZ5umJ9IH32XQQoceIzSk576sYus9ACr8xmFyc34J6E
         fjuij7mvsxmsgaCVgVF5fQyA06+ZB+HFnRJzzfiaut4NDx5L5GTTfX4epjSBCcFKVyzV
         AmRZemShu1MWKBqAzHd2BY6C5QFnnApJvsbvCWG5eiYwwhpqVuM7i73LiAhz6YeMtlS6
         VQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XxI8aTa+gL65v5twgbeRouio9rlIcCGMTQnKUkSHzPA=;
        b=MuTk09f53hihIIGdAasWxXutHoHa48C59MjWv7ob7RISItIyjd4djlZv2KETSV4faY
         H6jc8zZ7gauTFRskefOrvyNydc9U6G1ok942tSO0KWm2fGm5EuamITLvFenB4XrRJAWw
         HMAbhmGrCMwGNcI78U0rbWcMKQXDbhfKMBhcXOAeQgcBnYXEXMTomO0W43Xmx5tziaQJ
         5JTVZEVsiyazPBJ/dhbdxAIMxqy6IF5eSYeAeHPxzNfUa1JCamWKy2ggX6A4wIgknVLr
         qb4f1LxrLIobpZ/tngWsEuuwPdKfk+OHDmWLV8RjmE/Yxu2nTNmwlVzRYSYaxCIN9gXs
         T9mA==
X-Gm-Message-State: ALoCoQkFmI51yUY5C9ZLfQPn4jPY0Be/A6CpRyfpA1nSd9Y3hcoAjj6lABeEnBoVK9J9HqmtQWF7
X-Received: by 10.66.101.39 with SMTP id fd7mr35207734pab.3.1444675654884;
        Mon, 12 Oct 2015 11:47:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:5950:8bdc:8939:e460])
        by smtp.gmail.com with ESMTPSA id pu5sm19663856pbc.58.2015.10.12.11.47.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 11:47:34 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.268.g453a26a
In-Reply-To: <1444675641-14866-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279398>

In a later patch we enable parallel processing of submodules, this
only adds the possibility for it. So this change should not change
any user facing behavior.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 145 ++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 101 insertions(+), 44 deletions(-)

diff --git a/submodule.c b/submodule.c
index 1d64e57..8fdd2cb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -12,6 +12,7 @@
 #include "sha1-array.h"
 #include "argv-array.h"
 #include "blob.h"
+#include "thread-utils.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static struct string_list changed_submodule_paths;
@@ -615,37 +616,28 @@ static void calculate_changed_submodule_paths(void)
 	initialized_fetch_ref_tips = 0;
 }
 
-int fetch_populated_submodules(const struct argv_array *options,
-			       const char *prefix, int command_line_option,
-			       int quiet)
+struct submodule_parallel_fetch {
+	int count;
+	struct argv_array args;
+	const char *work_tree;
+	const char *prefix;
+	int command_line_option;
+	int quiet;
+	int result;
+};
+#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0}
+
+static int get_next_submodule(void **task_cb, struct child_process *cp,
+			      struct strbuf *err, void *data)
 {
-	int i, result = 0;
-	struct child_process cp = CHILD_PROCESS_INIT;
-	struct argv_array argv = ARGV_ARRAY_INIT;
-	const char *work_tree = get_git_work_tree();
-	if (!work_tree)
-		goto out;
-
-	if (read_cache() < 0)
-		die("index file corrupt");
-
-	argv_array_push(&argv, "fetch");
-	for (i = 0; i < options->argc; i++)
-		argv_array_push(&argv, options->argv[i]);
-	argv_array_push(&argv, "--recurse-submodules-default");
-	/* default value, "--submodule-prefix" and its value are added later */
-
-	cp.env = local_repo_env;
-	cp.git_cmd = 1;
-	cp.no_stdin = 1;
-
-	calculate_changed_submodule_paths();
+	int ret = 0;
+	struct submodule_parallel_fetch *spf = data;
 
-	for (i = 0; i < active_nr; i++) {
+	for ( ; spf->count < active_nr; spf->count++) {
 		struct strbuf submodule_path = STRBUF_INIT;
 		struct strbuf submodule_git_dir = STRBUF_INIT;
 		struct strbuf submodule_prefix = STRBUF_INIT;
-		const struct cache_entry *ce = active_cache[i];
+		const struct cache_entry *ce = active_cache[spf->count];
 		const char *git_dir, *default_argv;
 		const struct submodule *submodule;
 
@@ -657,7 +649,7 @@ int fetch_populated_submodules(const struct argv_array *options,
 			submodule = submodule_from_name(null_sha1, ce->name);
 
 		default_argv = "yes";
-		if (command_line_option == RECURSE_SUBMODULES_DEFAULT) {
+		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
 			if (submodule &&
 			    submodule->fetch_recurse !=
 						RECURSE_SUBMODULES_NONE) {
@@ -680,40 +672,105 @@ int fetch_populated_submodules(const struct argv_array *options,
 					default_argv = "on-demand";
 				}
 			}
-		} else if (command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
+		} else if (spf->command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
 			if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
 				continue;
 			default_argv = "on-demand";
 		}
 
-		strbuf_addf(&submodule_path, "%s/%s", work_tree, ce->name);
+		strbuf_addf(&submodule_path, "%s/%s", spf->work_tree, ce->name);
 		strbuf_addf(&submodule_git_dir, "%s/.git", submodule_path.buf);
-		strbuf_addf(&submodule_prefix, "%s%s/", prefix, ce->name);
+		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, ce->name);
 		git_dir = read_gitfile(submodule_git_dir.buf);
 		if (!git_dir)
 			git_dir = submodule_git_dir.buf;
 		if (is_directory(git_dir)) {
-			if (!quiet)
-				fprintf(stderr, "Fetching submodule %s%s\n", prefix, ce->name);
-			cp.dir = submodule_path.buf;
-			argv_array_push(&argv, default_argv);
-			argv_array_push(&argv, "--submodule-prefix");
-			argv_array_push(&argv, submodule_prefix.buf);
-			cp.argv = argv.argv;
-			if (run_command(&cp))
-				result = 1;
-			argv_array_pop(&argv);
-			argv_array_pop(&argv);
-			argv_array_pop(&argv);
+			child_process_init(cp);
+			cp->dir = strbuf_detach(&submodule_path, NULL);
+			cp->env = local_repo_env;
+			cp->git_cmd = 1;
+			cp->no_stdin = 1;
+			cp->stdout_to_stderr = 1;
+			cp->err = -1;
+			if (!spf->quiet)
+				strbuf_addf(err, "Fetching submodule %s%s\n",
+					    spf->prefix, ce->name);
+			argv_array_init(&cp->args);
+			argv_array_pushv(&cp->args, spf->args.argv);
+			argv_array_push(&cp->args, default_argv);
+			argv_array_push(&cp->args, "--submodule-prefix");
+			argv_array_push(&cp->args, submodule_prefix.buf);
+			ret = 1;
 		}
 		strbuf_release(&submodule_path);
 		strbuf_release(&submodule_git_dir);
 		strbuf_release(&submodule_prefix);
+		if (ret) {
+			spf->count++;
+			return 1;
+		}
 	}
-	argv_array_clear(&argv);
+	return 0;
+}
+
+static int fetch_start_failure(struct child_process *cp,
+			       struct strbuf *err,
+			       void *cb, void *task_cb)
+{
+	struct submodule_parallel_fetch *spf = cb;
+
+	spf->result = 1;
+
+	return 0;
+}
+
+static int fetch_finish(int retvalue, struct child_process *cp,
+			struct strbuf *err, void *cb, void *task_cb)
+{
+	struct submodule_parallel_fetch *spf = cb;
+
+	if (retvalue)
+		spf->result = 1;
+
+	return 0;
+}
+
+int fetch_populated_submodules(const struct argv_array *options,
+			       const char *prefix, int command_line_option,
+			       int quiet)
+{
+	int i;
+	int max_parallel_jobs = 1;
+	struct submodule_parallel_fetch spf = SPF_INIT;
+
+	spf.work_tree = get_git_work_tree();
+	spf.command_line_option = command_line_option;
+	spf.quiet = quiet;
+	spf.prefix = prefix;
+
+	if (!spf.work_tree)
+		goto out;
+
+	if (read_cache() < 0)
+		die("index file corrupt");
+
+	argv_array_push(&spf.args, "fetch");
+	for (i = 0; i < options->argc; i++)
+		argv_array_push(&spf.args, options->argv[i]);
+	argv_array_push(&spf.args, "--recurse-submodules-default");
+	/* default value, "--submodule-prefix" and its value are added later */
+
+	calculate_changed_submodule_paths();
+	run_processes_parallel(max_parallel_jobs,
+			       get_next_submodule,
+			       fetch_start_failure,
+			       fetch_finish,
+			       &spf);
+
+	argv_array_clear(&spf.args);
 out:
 	string_list_clear(&changed_submodule_paths, 1);
-	return result;
+	return spf.result;
 }
 
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
-- 
2.5.0.268.g453a26a
