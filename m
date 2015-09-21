From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 07/13] fetch_populated_submodules: use new parallel job processing
Date: Mon, 21 Sep 2015 15:39:13 -0700
Message-ID: <1442875159-13027-8-git-send-email-sbeller@google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 00:40:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9kp-0007AG-M6
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933119AbbIUWkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 18:40:03 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36566 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932997AbbIUWjd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:39:33 -0400
Received: by padbj2 with SMTP id bj2so3593798pad.3
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G0XXvDhQ8pKCxhOBEzKEJqks5rPo2PHsNuObzUKo7Bo=;
        b=YJtB+PUSOrMoRe0r4Uo8CFy5LtNhdQgdDJkft/TAGyoBx284LLYllRAbnRjxVvDNt3
         wduxJlceF784nsJ3YPRVuSyWxqAzCpNVhb8X5BkyRivkljBlailtmEGqcNVaZARCc5yY
         VSpju227/SVMeqwgo0h2Za4qpbt/5SDb08EeVthx6j6VegzzdEAHw+kc6B6mv98gXQR/
         wTVtPIzUZ1ANDGfQgyCCmjwEH3y0c1WT5o5FPXWmbysuP12BYUif4pTq6UI9h7PgyXY+
         EtoHBXBE/Q4fh9/R7m0XGZ6AEoInVgh0vuT+5xDYofArj0kBKTEW7tnHvoUD+RGKZBUY
         CTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G0XXvDhQ8pKCxhOBEzKEJqks5rPo2PHsNuObzUKo7Bo=;
        b=TpYjiD1yWj4p5XiD73nhUFCzrBiI6544WF5rzCc6oY5xfMbHUcH780CQdyCbcsAnNZ
         eAfyQe2HhDNWnnJaLkbBAYTKsXPePI5JppN8A/RKbKuCVKmCejY8N97RfedF3fufUH23
         jCFCaix4FX39AVy0B42hNZ0Do2KmaIpu4oFaUcM4ycuwB5omwqRyTfQIx6JI0u2jNnuO
         yk0SQH7JJYQfFOVYLjROSenNmXa44WeM6T6IQjVnxvh76qE+kzoDqjv3tkPXZ62vVaMs
         o1Vr919uw4Rj5GtmBW7iZu7S4JUeJ8R8I+isj8DPC9Vn2jk5DBEOX9ULnQzKhEcYBVtm
         GU8Q==
X-Gm-Message-State: ALoCoQkmnSY3uDXlos8bKKmEPhk/DWR2m2VOiQyMDBvZZ9BHTfG4M2UCf3S+ktKiKp7GT4oes9Bw
X-Received: by 10.68.218.137 with SMTP id pg9mr6141506pbc.160.1442875172967;
        Mon, 21 Sep 2015 15:39:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:a032:5a54:ea65:75ca])
        by smtp.gmail.com with ESMTPSA id qr5sm26493218pbb.26.2015.09.21.15.39.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Sep 2015 15:39:32 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.ge015d2a
In-Reply-To: <1442875159-13027-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278347>

In a later patch we enable parallel processing of submodules, this
only adds the possibility for it. So this change should not change
any user facing behavior.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch.c |   3 +-
 submodule.c     | 119 +++++++++++++++++++++++++++++++++++++++-----------------
 submodule.h     |   2 +-
 3 files changed, 87 insertions(+), 37 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ee1f1a9..6620ed0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1217,7 +1217,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		result = fetch_populated_submodules(&options,
 						    submodule_prefix,
 						    recurse_submodules,
-						    verbosity < 0);
+						    verbosity < 0,
+						    0);
 		argv_array_clear(&options);
 	}
 
diff --git a/submodule.c b/submodule.c
index 1d64e57..a0e06e8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -12,6 +12,7 @@
 #include "sha1-array.h"
 #include "argv-array.h"
 #include "blob.h"
+#include "thread-utils.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static struct string_list changed_submodule_paths;
@@ -615,37 +616,79 @@ static void calculate_changed_submodule_paths(void)
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
+void handle_submodule_fetch_start_err(void *data, struct child_process *cp, struct strbuf *err)
+{
+	struct submodule_parallel_fetch *spf = data;
+	spf->result = 1;
+}
+
+void handle_submodule_fetch_finish( void *data, struct child_process *cp, int retvalue)
+{
+	struct submodule_parallel_fetch *spf = data;
+
+	if (retvalue)
+		spf->result = 1;
+}
+
 int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-			       int quiet)
+			       int quiet, int max_parallel_jobs)
 {
-	int i, result = 0;
-	struct child_process cp = CHILD_PROCESS_INIT;
-	struct argv_array argv = ARGV_ARRAY_INIT;
-	const char *work_tree = get_git_work_tree();
-	if (!work_tree)
+	int i;
+	struct submodule_parallel_fetch spf = SPF_INIT;
+	spf.work_tree = get_git_work_tree();
+	spf.command_line_option = command_line_option;
+	spf.quiet = quiet;
+	spf.prefix = prefix;
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
+			       handle_submodule_fetch_start_err,
+			       handle_submodule_fetch_finish);
+
+	argv_array_clear(&spf.args);
+out:
+	string_list_clear(&changed_submodule_paths, 1);
+	return spf.result;
+}
+
+int get_next_submodule(void *data, struct child_process *cp,
+		       struct strbuf *err)
+{
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
 
@@ -657,7 +700,7 @@ int fetch_populated_submodules(const struct argv_array *options,
 			submodule = submodule_from_name(null_sha1, ce->name);
 
 		default_argv = "yes";
-		if (command_line_option == RECURSE_SUBMODULES_DEFAULT) {
+		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
 			if (submodule &&
 			    submodule->fetch_recurse !=
 						RECURSE_SUBMODULES_NONE) {
@@ -680,40 +723,46 @@ int fetch_populated_submodules(const struct argv_array *options,
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
+			cp->git_cmd = 1;
+			cp->no_stdout = 1;
+			cp->no_stdin = 1;
+			cp->stdout_to_stderr = 1;
+			cp->err = -1;
+			cp->env = local_repo_env;
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
+			return 0;
+		}
 	}
-	argv_array_clear(&argv);
-out:
-	string_list_clear(&changed_submodule_paths, 1);
-	return result;
+	return 1;
 }
 
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
diff --git a/submodule.h b/submodule.h
index 5507c3d..cbc0003 100644
--- a/submodule.h
+++ b/submodule.h
@@ -31,7 +31,7 @@ void set_config_fetch_recurse_submodules(int value);
 void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-			       int quiet);
+			       int quiet, int max_parallel_jobs);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int submodule_uses_gitfile(const char *path);
 int ok_to_remove_submodule(const char *path);
-- 
2.5.0.275.ge015d2a
