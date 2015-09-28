From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 7/8] fetch_populated_submodules: use new parallel job processing
Date: Mon, 28 Sep 2015 16:14:05 -0700
Message-ID: <1443482046-25569-8-git-send-email-sbeller@google.com>
References: <1443482046-25569-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 29 01:14:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZghdJ-0007i2-JP
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 01:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950AbbI1XOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 19:14:48 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:32845 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755AbbI1XOa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 19:14:30 -0400
Received: by pacex6 with SMTP id ex6so186731967pac.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 16:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uhoYWavn/2Wf9s0gn44NqZg1kBlf1Ap88blUueUNCsg=;
        b=eDFE7u2VOrhJewqnrgn0a47ryeqK/0yXEvLqPw0FB6ingdGUZKUnvCB5XF2fux7hhK
         Tev+x73QEWFKXrqkMCYXA0VYaXIaC8pmPy9rx17ByhS0wrD5qagl8lXKNT0WcDbMKlgq
         Qg/QpCjx7s5uL3vl3H0uy8scL4wBFRFhP7Nx/iC1WWUwM0R8ETc7lm8gYdTqX84IvFAL
         Oay2dVI7mm7M/5BfzsgXMdnFbKye0Cu3Fwi2jkQ7YFrSJ/9Zmgi9pTTlJ5/OfY5v8gvw
         siYaB9QJ0zb/q5mV+EkT4659EKXv8o+NssAsqqMgSuPUBdM6wva2cUUM6RNsXOtG+ABk
         RESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uhoYWavn/2Wf9s0gn44NqZg1kBlf1Ap88blUueUNCsg=;
        b=fi4aJAmZ/ycikG7djjea4G9wnwiq6KLcjqEqCYYaT7otpvmsFSBMurGFkIV0J8f0VI
         CendIKi7st7baQR34rNU2Lzx/6wyle2wZA39zvF2y0YaShcf3CbcVdxswzkQ5OP18ZHj
         cVtNtnE8ap7NT60fm2GGJA04Shs6oU/qnyXZcg20HpyGgizqJg9dNC7LDOU2eroRrtgv
         1cBqkywjR5X5NOWM2FeYVVEeOjL3rCG14vlLp6oRmXG5Tk0XUCMGrnXY7xLg7J4wdtNz
         DLCQTefV4EJvKRJzO3On5azUa67sDZA3e8VjKraXzUTIAiwByn16X6w+LO+LtocvdIqD
         ERKg==
X-Gm-Message-State: ALoCoQkMgp5jfArJkMzkIOJlE9raqna5Ua99J7u32U6VfzUomtLadf+lNtzARQl65cbatx30uU+U
X-Received: by 10.66.233.202 with SMTP id ty10mr11323481pac.36.1443482069707;
        Mon, 28 Sep 2015 16:14:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:79ce:7412:e4be:3e39])
        by smtp.gmail.com with ESMTPSA id kv9sm21653319pab.39.2015.09.28.16.14.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Sep 2015 16:14:29 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.273.g6fa2560.dirty
In-Reply-To: <1443482046-25569-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278808>

In a later patch we enable parallel processing of submodules, this
only adds the possibility for it. So this change should not change
any user facing behavior.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c | 126 ++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 92 insertions(+), 34 deletions(-)

diff --git a/submodule.c b/submodule.c
index 1d64e57..8134fe7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -12,6 +12,7 @@
 #include "sha1-array.h"
 #include "argv-array.h"
 #include "blob.h"
+#include "thread-utils.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static struct string_list changed_submodule_paths;
@@ -615,37 +616,89 @@ static void calculate_changed_submodule_paths(void)
 	initialized_fetch_ref_tips = 0;
 }
 
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
+int get_next_submodule(void *data, struct child_process *cp,
+		       struct strbuf *err);
+
+static int fetch_start_failure(void *data, struct child_process *cp,
+			       struct strbuf *err)
+{
+	struct submodule_parallel_fetch *spf = data;
+
+	spf->result = 1;
+
+	return 0;
+}
+
+static int fetch_finish(void *data, struct child_process *cp,
+			struct strbuf *err, int retvalue)
+{
+	struct submodule_parallel_fetch *spf = data;
+
+	if (retvalue)
+		spf->result = 1;
+
+	return 0;
+}
+
 int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
 			       int quiet)
 {
-	int i, result = 0;
-	struct child_process cp = CHILD_PROCESS_INIT;
-	struct argv_array argv = ARGV_ARRAY_INIT;
-	const char *work_tree = get_git_work_tree();
-	if (!work_tree)
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
 		goto out;
 
 	if (read_cache() < 0)
 		die("index file corrupt");
 
-	argv_array_push(&argv, "fetch");
+	argv_array_push(&spf.args, "fetch");
 	for (i = 0; i < options->argc; i++)
-		argv_array_push(&argv, options->argv[i]);
-	argv_array_push(&argv, "--recurse-submodules-default");
+		argv_array_push(&spf.args, options->argv[i]);
+	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
-	cp.env = local_repo_env;
-	cp.git_cmd = 1;
-	cp.no_stdin = 1;
-
 	calculate_changed_submodule_paths();
+	run_processes_parallel(max_parallel_jobs, &spf,
+			       get_next_submodule,
+			       fetch_start_failure,
+			       fetch_finish);
+
+	argv_array_clear(&spf.args);
+out:
+	string_list_clear(&changed_submodule_paths, 1);
+	return spf.result;
+}
 
-	for (i = 0; i < active_nr; i++) {
+int get_next_submodule(void *data, struct child_process *cp,
+		       struct strbuf *err)
+{
+	int ret = 0;
+	struct submodule_parallel_fetch *spf = data;
+
+	for ( ; spf->count < active_nr; spf->count++) {
 		struct strbuf submodule_path = STRBUF_INIT;
 		struct strbuf submodule_git_dir = STRBUF_INIT;
 		struct strbuf submodule_prefix = STRBUF_INIT;
-		const struct cache_entry *ce = active_cache[i];
+		const struct cache_entry *ce = active_cache[spf->count];
 		const char *git_dir, *default_argv;
 		const struct submodule *submodule;
 
@@ -657,7 +710,7 @@ int fetch_populated_submodules(const struct argv_array *options,
 			submodule = submodule_from_name(null_sha1, ce->name);
 
 		default_argv = "yes";
-		if (command_line_option == RECURSE_SUBMODULES_DEFAULT) {
+		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
 			if (submodule &&
 			    submodule->fetch_recurse !=
 						RECURSE_SUBMODULES_NONE) {
@@ -680,40 +733,45 @@ int fetch_populated_submodules(const struct argv_array *options,
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
-out:
-	string_list_clear(&changed_submodule_paths, 1);
-	return result;
+	return 0;
 }
 
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
-- 
2.5.0.273.g6fa2560.dirty
