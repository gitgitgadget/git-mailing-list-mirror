From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv11 3/7] fetching submodules: respect `submodule.fetchJobs` config option
Date: Fri, 12 Feb 2016 15:34:36 -0800
Message-ID: <1455320080-14648-4-git-send-email-sbeller@google.com>
References: <1455320080-14648-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Sat Feb 13 00:34:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUNEo-0005Uj-M5
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 00:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbcBLXex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 18:34:53 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34355 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbcBLXet (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 18:34:49 -0500
Received: by mail-pf0-f172.google.com with SMTP id x65so54750749pfb.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 15:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xFjmk7gIrVU/WJQnjXXiLJnI6AZy38kPcfaoe6PEh1c=;
        b=Qe7T+VO0HV/E3pCr6STccCm03bj3ikN7ApJyxq7pAAlkoZwMTXrSVN7AqQ6qC4xi+V
         UnwKvkbvAULIxe/h6JThY8xLl3Yqid+g9/oWQDB2uL58/k2HJYV1f4ecdR/9GbAowvdQ
         FDtEJzolHH1Ubi3YFcTLx0l69APJL+FfRjy8GG+gN62/hzoXQkbgdWvLVrXlXx4Q04W6
         GC50J3W5TTgLoSvNDkO5Mi9uYzMsY3gBluzKY/YYUIjbAS1fdC0WFsFmKFAL70Ktvolr
         G52LqAwg+TXhSZ1MWSIxdExPnZ63VAgc1E3+bq32pyHgwN22JdBuJLWfdWze8b4+JX8c
         rddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xFjmk7gIrVU/WJQnjXXiLJnI6AZy38kPcfaoe6PEh1c=;
        b=EsR1Ytt3rizqV8SFej369/GwNyBysE/6PactQj8Utj/RuBDxpA710maGSCQO6zJtx9
         QGu4/VdFzrGv16Y6D4ygb28eTQa3oA8fJ/NAFx8c7H1exyD3QXEqsO9tFD5qOgga7n+5
         UXgkT+OlvJwgIV9ucMqVnY8Dd/tgrhPR8hBmJ+8XLaO91Uz+f/MAr0CzhToOCulKNkat
         ZIiu0UyIF7g9FV4ETtzP++O+ZexKfK6MgYQhIj35ppHrLS4/rK+MvQJ7VS3A6FkmfJJq
         OGOgJW995FRjIx5VglyKYGvT7elGZosCtNF4Q3EXnQlHqYxwaifl6VNK5OKGaCGOJuMs
         30OA==
X-Gm-Message-State: AG10YOQQiIK+PhjpNiiz+sxU9bpqm3QL5utq3P2Ka/WXCkP9Ay6mjEh12AEwIm3KZe9ZRIfT
X-Received: by 10.98.93.2 with SMTP id r2mr6051751pfb.64.1455320088247;
        Fri, 12 Feb 2016 15:34:48 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:f1e7:203f:9d1e:8193])
        by smtp.gmail.com with ESMTPSA id mj1sm21864310pab.34.2016.02.12.15.34.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 Feb 2016 15:34:47 -0800 (PST)
X-Mailer: git-send-email 2.7.1.292.g18a4ced.dirty
In-Reply-To: <1455320080-14648-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286086>

This allows to configure fetching and updating in parallel
without having the command line option.

This moved the responsibility to determine how many parallel processes
to start from builtin/fetch to submodule.c as we need a way to communicate
"The user did not specify the number of parallel processes in the command
line options" in the builtin fetch. The submodule code takes care of
the precedence (CLI > config > default).

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt    |  6 ++++++
 builtin/fetch.c             |  2 +-
 submodule.c                 | 16 +++++++++++++++-
 submodule.h                 |  2 ++
 t/t5526-fetch-submodules.sh | 14 ++++++++++++++
 5 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 27f02be..eb9ae85 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2715,6 +2715,12 @@ submodule.<name>.ignore::
 	"--ignore-submodules" option. The 'git submodule' commands are not
 	affected by this setting.
 
+submodule.fetchJobs::
+	Specifies how many submodules are fetched/cloned at the same time.
+	A positive integer allows up to that number of submodules fetched
+	in parallel. A value of 0 will give some reasonable default.
+	If unset, it defaults to 1.
+
 tag.sort::
 	This variable controls the sort ordering of tags when displayed by
 	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8e74213..91f0862 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -37,7 +37,7 @@ static int prune = -1; /* unspecified */
 static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
 static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow;
-static int max_children = 1;
+static int max_children = -1;
 static const char *depth;
 static const char *upload_pack;
 static struct strbuf default_rla = STRBUF_INIT;
diff --git a/submodule.c b/submodule.c
index 8fd4512..263cb2a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -15,6 +15,7 @@
 #include "thread-utils.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
+static int parallel_jobs = 1;
 static struct string_list changed_submodule_paths;
 static int initialized_fetch_ref_tips;
 static struct sha1_array ref_tips_before_fetch;
@@ -169,7 +170,12 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 
 int submodule_config(const char *var, const char *value, void *cb)
 {
-	if (starts_with(var, "submodule."))
+	if (!strcmp(var, "submodule.fetchjobs")) {
+		parallel_jobs = git_config_int(var, value);
+		if (parallel_jobs < 0)
+			die(_("negative values not allowed for submodule.fetchJobs"));
+		return 0;
+	} else if (starts_with(var, "submodule."))
 		return parse_submodule_config_option(var, value);
 	else if (!strcmp(var, "fetch.recursesubmodules")) {
 		config_fetch_recurse_submodules = parse_fetch_recurse_submodules_arg(var, value);
@@ -770,6 +776,9 @@ int fetch_populated_submodules(const struct argv_array *options,
 	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
+	if (max_parallel_jobs < 0)
+		max_parallel_jobs = parallel_jobs;
+
 	calculate_changed_submodule_paths();
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
@@ -1116,3 +1125,8 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 	strbuf_release(&rel_path);
 	free((void *)real_work_tree);
 }
+
+int parallel_submodules(void)
+{
+	return parallel_jobs;
+}
diff --git a/submodule.h b/submodule.h
index 9a86124..7ef3775 100644
--- a/submodule.h
+++ b/submodule.h
@@ -27,6 +27,7 @@ struct submodule_update_strategy {
 	enum submodule_update_type type;
 	const char *command;
 };
+#define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED, NULL}
 
 int is_staging_gitmodules_ok(void);
 int update_path_in_gitmodules(const char *oldpath, const char *newpath);
@@ -58,5 +59,6 @@ int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
 		struct string_list *needs_pushing);
 int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
 void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
+int parallel_submodules(void);
 
 #endif
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 1241146..954d0e4 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -471,4 +471,18 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
 	test_i18ncmp expect.err actual.err
 '
 
+test_expect_success 'fetching submodules respects parallel settings' '
+	git config fetch.recurseSubmodules true &&
+	(
+		cd downstream &&
+		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 7 &&
+		grep "7 tasks" trace.out &&
+		git config submodule.fetchJobs 8 &&
+		GIT_TRACE=$(pwd)/trace.out git fetch &&
+		grep "8 tasks" trace.out &&
+		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 9 &&
+		grep "9 tasks" trace.out
+	)
+'
+
 test_done
-- 
2.7.1.292.g18a4ced.dirty
