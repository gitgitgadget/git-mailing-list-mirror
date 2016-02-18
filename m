From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv13 3/7] fetching submodules: respect `submodule.fetchJobs` config option
Date: Thu, 18 Feb 2016 15:33:14 -0800
Message-ID: <1455838398-12379-4-git-send-email-sbeller@google.com>
References: <1455838398-12379-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 19 00:33:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWY4k-0003zz-Nm
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 00:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948689AbcBRXda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 18:33:30 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35858 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946440AbcBRXd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 18:33:26 -0500
Received: by mail-pf0-f182.google.com with SMTP id e127so39832697pfe.3
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 15:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M6xM1rxwPYvZyH7+ZnXFPydr4qcKPSvm2nxG+5sQ+hY=;
        b=N6pF5s2KVq1bi4PP5HnrSUebs4Dl6tWwX/cYgqLIZZJqlYA332WtwnmF0CbsfPE/33
         O87juW1wD89abISY2uE3V9OOHXsvArgaR2hYDGaz1/TxX3soKPUH/FiPJXx4SIS/bF02
         wHF2hZnkIi6zq5t7PMVrwFbGDiVUr7ipnKNCzv1ydBokMmvjul7bC8xSv1zpcvL3YghM
         uWBVs1MExfpYo6Mu0G6TS6LCgmL4DLBl21cyNupeBYNDUzIsmzOF6DCgvYL55iBeKdea
         ozLqDjLpHvOMfrcKdY6xNgNwLJeBx0SouAr4f4h34OHYCGv8YiWxBhWhE40sdpocvw2C
         6sWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M6xM1rxwPYvZyH7+ZnXFPydr4qcKPSvm2nxG+5sQ+hY=;
        b=HvQFfBsslQq43+PdAtoQ3cAicjDgnJPU0g8PBiSc6KlWGMKBi28eTPuCXakjK6GrY+
         TsZYIkPq3CmkDnff9BCmBp4BoELBbaYr0aoKav+ctqFHTyYmJ8E3n808OwxhX8aGH9BN
         /3rOhvTgWRS4rXEcRmPPQbrue6AtbETf47WnK1V7hSkDfVojvWYf/8DjTeIWJp+KS2jh
         0amZD3mIbUYnZcsbY32yuP3tJDN51jroMT5IB1irz3DodORo5X6upfaj2A8PvoRIX6Pf
         /RBmR7hLTRQ91pp94da17xdJtmu8C1BZDic1fXADbDmuB99HDTRZELKMCR6UF6fG9kLo
         CRJg==
X-Gm-Message-State: AG10YOQi25/8GCOghDRpzUZDnr5FbGZIai9SsVetfO+9thIC1FlTz8UatWZ9DmC7imoKDzTB
X-Received: by 10.98.18.215 with SMTP id 84mr13949616pfs.131.1455838406131;
        Thu, 18 Feb 2016 15:33:26 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d444:f36c:1851:bb54])
        by smtp.gmail.com with ESMTPSA id 16sm12860466pfk.28.2016.02.18.15.33.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 Feb 2016 15:33:25 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.g65aed89
In-Reply-To: <1455838398-12379-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286644>

This allows to configure fetching and updating in parallel
without having the command line option.

This moved the responsibility to determine how many parallel processes
to start from builtin/fetch to submodule.c as we need a way to communicate
"The user did not specify the number of parallel processes in the command
line options" in the builtin fetch. The submodule code takes care of
the precedence (CLI > config > default).

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt    |  6 ++++++
 builtin/fetch.c             |  2 +-
 submodule.c                 | 16 +++++++++++++++-
 submodule.h                 |  2 ++
 t/t5526-fetch-submodules.sh | 14 ++++++++++++++
 5 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2d06b11..3b02732 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2646,6 +2646,12 @@ submodule.<name>.ignore::
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
index 586840d..5aa1c2d 100644
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
index 2891aad..c1211d7 100644
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
@@ -772,6 +778,9 @@ int fetch_populated_submodules(const struct argv_array *options,
 	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
+	if (max_parallel_jobs < 0)
+		max_parallel_jobs = parallel_jobs;
+
 	calculate_changed_submodule_paths();
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
@@ -1118,3 +1127,8 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 	strbuf_release(&rel_path);
 	free((void *)real_work_tree);
 }
+
+int parallel_submodules(void)
+{
+	return parallel_jobs;
+}
diff --git a/submodule.h b/submodule.h
index 3464500..3166608 100644
--- a/submodule.h
+++ b/submodule.h
@@ -26,6 +26,7 @@ struct submodule_update_strategy {
 	enum submodule_update_type type;
 	const char *command;
 };
+#define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED, NULL}
 
 int is_staging_gitmodules_ok(void);
 int update_path_in_gitmodules(const char *oldpath, const char *newpath);
@@ -57,5 +58,6 @@ int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
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
2.7.0.rc0.34.g65aed89
