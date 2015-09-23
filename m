From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 07/14] fetch_populated_submodules: use new parallel job processing
Date: Tue, 22 Sep 2015 18:45:25 -0700
Message-ID: <1442972732-12118-8-git-send-email-sbeller@google.com>
References: <1442972732-12118-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 03:46:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeZ8J-0007Dx-KW
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 03:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760002AbbIWBpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 21:45:54 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:32799 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbbIWBpp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 21:45:45 -0400
Received: by pacex6 with SMTP id ex6so25232908pac.0
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 18:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PEJIF7SqKj6mjxfodivKe3jfV883xII4abEqNvJfKLE=;
        b=OSNTZWlZ17jzdXViHgTjbXRkVgGCm0x02PEEZipNDfLTY5mDqAhbX7HP297LTs+ETA
         xs9qgF6K/sBdQDkZ/XEJliRYLgaitNavEam31pWfEnxCTcq06SRfUyEJVCV0q3yYk9dk
         OfpF06dqi+wMHvc/mLRBHbIx68tMVWdPXhVewxA4533F9t898CMBARQ9D7uLHtPhze2s
         40jmyDBBs6khPBt65nJwQJJxC39fWpI4D0bX1eA5zhaxA+/iANx7D94jl0cYWwk7GmGe
         CfEp5d7EjRhJogPQFOPCWK0Rk8Dk9jDNIrd9XiK78Log4JqJ+0y/d4WBMfkJMQLoKO0P
         e38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PEJIF7SqKj6mjxfodivKe3jfV883xII4abEqNvJfKLE=;
        b=W6enNy9wNg5J2fi/lwcZvQGH51aYCCne2zXfxnNfcDrZKa4riv4KRyPOFJLC7GPq/4
         y+qDA7kYgv1HYeqQHX+OcQSha91AmsjblmRtUfW8nrrhWj/kVjdpW9b74SxXSTHsaaUK
         JTybiVIceq/nJPm/VSMSXiWzdwHfUcpy82PcF62/wZWxIcshSnwuvgGcP9EIb/3HlZFg
         0R6lpGh+mQ8CPOGBI71Vjiwu56vJH4GXDw+VU7xCjJa2SfQb44i7MCT8xBC6XfIuGVY3
         LH+sZvoTY9diqXJHek3hr4TQ+3DQAe6S+2sPRpO++hCOTuedbEqVYIr7e55yQvQFJMIG
         PYmA==
X-Gm-Message-State: ALoCoQk359bkdVHd00gflVm7n7di4weG2OyliMw6m2QYWP0SGRwrsZrgH/f3mVKvbWqqBO/oQED/
X-Received: by 10.66.139.231 with SMTP id rb7mr34317806pab.5.1442972745128;
        Tue, 22 Sep 2015 18:45:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c149:8175:4df1:ed3a])
        by smtp.gmail.com with ESMTPSA id c16sm4599022pbu.37.2015.09.22.18.45.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 22 Sep 2015 18:45:44 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.272.ga84127c.dirty
In-Reply-To: <1442972732-12118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278458>

In a later patch we enable parallel processing of submodules, this
only adds the possibility for it. So this change should not change
any user facing behavior.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 119 +++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 85 insertions(+), 34 deletions(-)

diff --git a/submodule.c b/submodule.c
index 1d64e57..d7c7a6e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -12,6 +12,7 @@
 #include "sha1-array.h"
 #include "argv-array.h"
 #include "blob.h"
+#include "thread-utils.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static struct string_list changed_submodule_paths;
@@ -615,37 +616,82 @@ static void calculate_changed_submodule_paths(void)
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
 
@@ -657,7 +703,7 @@ int fetch_populated_submodules(const struct argv_array *options,
 			submodule = submodule_from_name(null_sha1, ce->name);
 
 		default_argv = "yes";
-		if (command_line_option == RECURSE_SUBMODULES_DEFAULT) {
+		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
 			if (submodule &&
 			    submodule->fetch_recurse !=
 						RECURSE_SUBMODULES_NONE) {
@@ -680,40 +726,45 @@ int fetch_populated_submodules(const struct argv_array *options,
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
2.5.0.272.ga84127c.dirty
