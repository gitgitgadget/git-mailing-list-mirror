From: Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH 4/4] submodule: add infrastructure to fetch submodules in parallel
Date: Thu,  6 Aug 2015 10:35:24 -0700
Message-ID: <1438882524-21215-5-git-send-email-sbeller@google.com>
References: <1438882524-21215-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, hvoigt@hvoigt.net, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 19:37:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNP6D-0002pe-Gl
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 19:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755905AbbHFRg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 13:36:56 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35940 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755558AbbHFRfj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 13:35:39 -0400
Received: by pacrr5 with SMTP id rr5so32251484pac.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 10:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=riWqtUnUB4kwsIpoGXSSLfypxDu0zhMAQ4GZ+JhhIVs=;
        b=SW6FS52hAlLBWdrDHcskgNZLdbUksqK3iSCXGEhsB9q33vIWC5QkwpSV9RXdjI9JRl
         mlybu5Wyjy8qV5FAT7nMI2vIgesxkILb3pig/L1+MgWqZ/1qQLX524l+GMp7uQ5rsEB1
         iLKOenHeuJvxm9l+ZVqBHKvzhQJnlODsHJt7VXXKR+HXeB+gbJGNKxjWkHvP9j8E/9oZ
         J8u4OHg4rkBj6USa4nh7+mnlDReNCoQ49m1xCsMPNvPYqdwSlKQGT/5WcVAOYgcduPw5
         /A2kk6uTtYGZ9Vzb/ud5RI2YG4Di+7pSJ1M51vdDyIUyS7clFP6R5ZvTvn4luHzipysF
         w5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=riWqtUnUB4kwsIpoGXSSLfypxDu0zhMAQ4GZ+JhhIVs=;
        b=NkxdNUy4f+DRpZz2b08KS2Hp1AYXzsQ1fUrKn/NL2/j/v0SdAdiT+uWL5W892mhKoe
         6q+ODu0GkTEkcMacdt4II590sF+SUx74ICldLD6uwoAWsUrISIS1sjjhF6MNZjktQTg+
         uiNheNppLp726tmsp+V0v9RI/NmxgiOmgM2B7q9u7Ri/HO7w3SleXNgZCYZjOmvW6tae
         RLtmiYyHyfd6I46cs6nHnft08ODfiXQmW4qpIR6TeIj87wSnu1AY1njYu/Qgb3r6vDHs
         CYqMWtYwn6oxzqNIeVNTkfr5DSstH0UJmGRkRcnHyXTWjqDWoBoMjOamzaVigGf7EHo3
         vHXQ==
X-Gm-Message-State: ALoCoQmWGHLzXu/5UZfb1oJxPtnq2Bh/fvLv5Aee5sB29DvfJ6tD2MvRTr94c0ye0QVZj7a7ceqn
X-Received: by 10.67.8.71 with SMTP id di7mr5681090pad.46.1438882538429;
        Thu, 06 Aug 2015 10:35:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8060:d893:ee2c:36a5])
        by smtp.gmail.com with ESMTPSA id t2sm7219664pdo.81.2015.08.06.10.35.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Aug 2015 10:35:38 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.239.g9728e1d.dirty
In-Reply-To: <1438882524-21215-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275430>

This makes use of the new workdispatcher to fetch a number
of submodules at the same time.

Still todo: sort the output of the fetch commands. I am unsure
if this should be hooked into the workdispatcher as the problem
of sorted output will appear likely again, so a general solution
would not hurt.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch.c |  3 ++-
 submodule.c     | 74 ++++++++++++++++++++++++++++++++++++++++++++-------------
 submodule.h     |  2 +-
 3 files changed, 60 insertions(+), 19 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8d5b2db..9053e8b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1207,7 +1207,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		result = fetch_populated_submodules(&options,
 						    submodule_prefix,
 						    recurse_submodules,
-						    verbosity < 0);
+						    verbosity < 0,
+						    1);
 		argv_array_clear(&options);
 	}
 
diff --git a/submodule.c b/submodule.c
index 872967f..0b2842b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -11,6 +11,7 @@
 #include "sha1-array.h"
 #include "argv-array.h"
 #include "blob.h"
+#include "workdispatcher.h"
 
 static struct string_list config_name_for_path;
 static struct string_list config_fetch_recurse_submodules_for_name;
@@ -696,13 +697,49 @@ const char* submodule_name_for_path(const char* path)
 		return NULL;
 }
 
+struct submodule_parallel_fetch {
+	struct child_process cp;
+	struct argv_array argv;
+	struct strbuf sb;
+	int quiet;
+};
+
+void submodule_parallel_fetch_init(struct submodule_parallel_fetch *spf)
+{
+	child_process_init(&spf->cp);
+	argv_array_init(&spf->argv);
+	strbuf_init(&spf->sb, 0);
+	spf->quiet = 0;
+}
+
+void *run_command_and_cleanup(void *arg)
+{
+	struct submodule_parallel_fetch *spf = arg;
+	void *ret = NULL;
+
+	if (!spf->quiet)
+		puts(spf->sb.buf);
+
+	spf->cp.argv = spf->argv.argv;
+
+	if (run_command(&spf->cp))
+		ret = (void *)1;
+
+	strbuf_release(&spf->cp);
+	argv_array_clear(spf->argv);
+	free(spf);
+	return ret;
+}
+
 int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-			       int quiet)
+			       int quiet, int max_parallel_jobs)
 {
 	int i, result = 0;
-	struct child_process cp = CHILD_PROCESS_INIT;
+	struct workdispatcher *wd;
+	struct return_values *rv;
 	struct argv_array argv = ARGV_ARRAY_INIT;
+	struct submodule_parallel_fetch *spf;
 	const char *name_for_path;
 	const char *work_tree = get_git_work_tree();
 	if (!work_tree)
@@ -717,12 +754,9 @@ int fetch_populated_submodules(const struct argv_array *options,
 	argv_array_push(&argv, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
-	cp.env = local_repo_env;
-	cp.git_cmd = 1;
-	cp.no_stdin = 1;
-
 	calculate_changed_submodule_paths();
 
+	wd = create_workdispatcher(&run_command_and_cleanup, max_parallel_jobs);
 	for (i = 0; i < active_nr; i++) {
 		struct strbuf submodule_path = STRBUF_INIT;
 		struct strbuf submodule_git_dir = STRBUF_INIT;
@@ -771,24 +805,30 @@ int fetch_populated_submodules(const struct argv_array *options,
 		if (!git_dir)
 			git_dir = submodule_git_dir.buf;
 		if (is_directory(git_dir)) {
+			spf = xmalloc(sizeof(*spf));
+			submodule_parallel_fetch_init(spf);
+			spf->cp.env = local_repo_env;
+			spf->cp.git_cmd = 1;
+			spf->cp.no_stdin = 1;
+			spf->cp.dir = strbuf_detach(&submodule_path, NULL);
+			spf->quiet = quiet;
 			if (!quiet)
-				printf("Fetching submodule %s%s\n", prefix, ce->name);
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
+				strbuf_addf(&spf->sb, "Fetching submodule %s%s", prefix, ce->name);
+			argv_array_copy(&argv, &spf->argv);
+			argv_array_push(&spf->argv, default_argv);
+			argv_array_push(&spf->argv, "--submodule-prefix");
+			argv_array_push(&spf->argv, submodule_prefix.buf);
+			add_task(wd, spf);
 		}
 		strbuf_release(&submodule_path);
 		strbuf_release(&submodule_git_dir);
 		strbuf_release(&submodule_prefix);
 	}
 	argv_array_clear(&argv);
+	rv = wait_workdispatcher(wd);
+	for (i = 0; i < rv->count; i++)
+		if (rv->ret[i])
+			result = 1;
 out:
 	string_list_clear(&changed_submodule_paths, 1);
 	return result;
diff --git a/submodule.h b/submodule.h
index e3dd854..51195ea 100644
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
2.5.0.239.g9728e1d.dirty
