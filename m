From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv20 03/12] fetching submodules: respect `submodule.fetchJobs` config option
Date: Mon, 29 Feb 2016 11:14:01 -0800
Message-ID: <1456773250-5510-4-git-send-email-sbeller@google.com>
References: <1456773250-5510-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 29 20:14:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaTH6-0005dx-IT
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbcB2TOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 14:14:24 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36808 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbcB2TOV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 14:14:21 -0500
Received: by mail-pf0-f180.google.com with SMTP id t66so31166311pfb.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 11:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/4okcSfPw+91lPd8bi/CXDYBovP7/m5zi1/aPybGTuk=;
        b=ZrkGeKCTPCYx2Mrp5QECgIcX5W2rrD6P0ZBS8Rot6+a+RXo9lRZnIFPmvGTIAISVps
         d84AxK+1jYtrTV1ZoOvfTJ70YgxoDW5GE6xB/cIqPH1/tB2v6Cd3Y8yB45nNdNTfUJPD
         pqHQH+Ng4OqZNBnYEusZtm4YwqnW5sH+zgj8WLfc4iU8IyQ8eq96rFnLNGUS7KqvdNBa
         2RDYOVL++bOHAP8qc2nB+zK4eqqfQVhw+7AA58TxhD17YfQUAnXfSlrmJkC1wHxfwo8F
         h0ofqOKHS+PJhLxTLJB8K0nJfv8dw5TAkULqRDCJQZY899LfpWQMcH/ujD22JlnT3F7V
         Zp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/4okcSfPw+91lPd8bi/CXDYBovP7/m5zi1/aPybGTuk=;
        b=LVDVjWytbaClKAP64EpJ3Y0EoIQeFXE/fNoTpGEaRb+jiXqSKL22/deJt1e8WJ9Z0L
         7I9ZkjwTKHIBOzybHsmeoHl2KamrjcLa/4zcbqNHshe2cRGhY+gZ1ivXlnkPRjhw1X85
         A1I1A3NLRvqMv6TkpJjxIj2of0mJufEPLO8oqJIyKGJhiDrG/vroY+lG3STpZxKyA6j+
         rUM7KlR539piOC/GvOoJF80r6/pQkEVHaNI9qr6muP23TOKDtli9OcC5VVhZpG9+d6uC
         jYz3ttfhubYZBq40gnsQhoLSkVsSHp24FEpMYXI/jJO76tvnDoONO51VrvMVS/ugBmAV
         Wvdw==
X-Gm-Message-State: AD7BkJLTa5BGVIUEJKPJKGWOvb5ESYoHoJ+B/uuxCH8f9iX7hZ7dRLLIvdbTDO9lg5FAmKMH
X-Received: by 10.98.66.75 with SMTP id p72mr24662988pfa.50.1456773260924;
        Mon, 29 Feb 2016 11:14:20 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id z7sm39854778pfi.19.2016.02.29.11.14.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 11:14:19 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.37.gb7b9e8e
In-Reply-To: <1456773250-5510-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287878>

This allows to configure fetching and updating in parallel
without having the command line option.

This moved the responsibility to determine how many parallel processes
to start from builtin/fetch to submodule.c as we need a way to communicate
"The user did not specify the number of parallel processes in the command
line options" in the builtin fetch. The submodule code takes care of
the precedence (CLI > config > default).

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
index b38dd51..051f722 100644
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
2.7.0.rc0.37.gb7b9e8e
