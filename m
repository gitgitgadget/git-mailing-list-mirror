From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 7/8] fetch_populated_submodules: use new parallel job processing
Date: Mon, 14 Dec 2015 11:37:17 -0800
Message-ID: <1450121838-7069-8-git-send-email-sbeller@google.com>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org
To: sbeller@google.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 20:38:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Ywf-00044n-Ng
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 20:38:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbbLNTh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 14:37:56 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36480 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbbLNThj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 14:37:39 -0500
Received: by pfbu66 with SMTP id u66so66040182pfb.3
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 11:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aMBzcblsf53KvQDHyQqgJtW1txKvoKucNzyz7YEaUnE=;
        b=emBe55Uf9Km9WF6qDgWwqHygAoD6kBSHuuQTo8WoMTzw6CCqbbYQlFkgzWyexQJgzJ
         OWF+M7hip5Lyc+bjKb/AZ/Hcu0yfiCiMVa+cjzjJITZEhK4+z9dz5F1AqGj3GuiU1ZH8
         hZDlklrI2NGGeRglgeqD6ufakbUw4m6eLVkMrX5cJ2axnf/ExsfRtZkJKBoKrYdobPiE
         K0xyVXOqMKjh2k1FQOyOh79UKKQy0m66u46nUmn7dxDF18pI+2EyH9NgL73p8jTlpQWy
         XSqKPoc9foXyWYiaZXwXimHWoVk3lVGX0FPD5ZswScgICXaLopeLwm6deh9CSGPOgToC
         7bOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aMBzcblsf53KvQDHyQqgJtW1txKvoKucNzyz7YEaUnE=;
        b=C+NYa440uLVoPfpZwrVYQjdyQ29QPvjB/c3SPzH6COu0JOArUeTFZRPlaXyjg92A0v
         b0EnVRhikHMHX8RX5cTReg/4o5zkpRSsDtd4WsL9AQCWfCA50Rbtz5avOEI+DzfOOS7t
         HK1P7JnJa6WFtKzU0qmGtbenAhvZ1ldCRWjKzghIzN/YhW0r2ElAShxmIbg/lMa06h3l
         TvKmQ9+9k/qBJwlRYrz5ab+xNWWRkHqr9+jVvgyotkVjJtCxPQawDZelcY7Sy/aFLEh/
         YaH4werREiB0m+zf4AbDVKkadXaUwZ3RNi7nAYcpImIPtlY6TUdSa5L5vVkTsAbi8BKY
         C9Ng==
X-Gm-Message-State: ALoCoQl9D9iLg0MNJfoaAY2bNOalsFbtxYWBavW9NRkhY0dCjrcEjviGDpIndzARKyAhrYakQ0k2t5nL/c7bR5LA8ZlMeqZY5A==
X-Received: by 10.98.14.67 with SMTP id w64mr38895098pfi.163.1450121858770;
        Mon, 14 Dec 2015 11:37:38 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a894:af1d:9081:95fb])
        by smtp.gmail.com with ESMTPSA id c20sm44123772pfd.17.2015.12.14.11.37.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Dec 2015 11:37:37 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
In-Reply-To: <1450121838-7069-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282394>

In a later patch we enable parallel processing of submodules, this
only adds the possibility for it. So this change should not change
any user facing behavior.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c | 142 +++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 98 insertions(+), 44 deletions(-)

diff --git a/submodule.c b/submodule.c
index 8386477..6a2d786 100644
--- a/submodule.c
+++ b/submodule.c
@@ -12,6 +12,7 @@
 #include "sha1-array.h"
 #include "argv-array.h"
 #include "blob.h"
+#include "thread-utils.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static struct string_list changed_submodule_paths;
@@ -610,37 +611,28 @@ static void calculate_changed_submodule_paths(void)
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
+static int get_next_submodule(struct child_process *cp,
+			      struct strbuf *err, void *data, void **task_cb)
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
 
@@ -652,7 +644,7 @@ int fetch_populated_submodules(const struct argv_array *options,
 			submodule = submodule_from_name(null_sha1, ce->name);
 
 		default_argv = "yes";
-		if (command_line_option == RECURSE_SUBMODULES_DEFAULT) {
+		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
 			if (submodule &&
 			    submodule->fetch_recurse !=
 						RECURSE_SUBMODULES_NONE) {
@@ -675,40 +667,102 @@ int fetch_populated_submodules(const struct argv_array *options,
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
2.6.4.443.ge094245.dirty
