From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv21 03/10] fetching submodules: respect `submodule.fetchJobs` config option
Date: Mon, 29 Feb 2016 18:07:13 -0800
Message-ID: <1456798040-30129-4-git-send-email-sbeller@google.com>
References: <1456798040-30129-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com,
	Jens.Lehmann@web.de, peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 01 03:07:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaZiw-0002xr-Ei
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 03:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbcCACHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 21:07:34 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35967 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbcCACHb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 21:07:31 -0500
Received: by mail-pf0-f170.google.com with SMTP id l6so5429917pfl.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 18:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lWmLE4q3/Bu6NgE5flSGxd9zmH6RLPZBqYQMoXSLwfo=;
        b=Vjuf7y8ZsGREGm3gEB5K+jkBO28551MEs08KmV2JGNbuvd9Ybg7RLBi9VgYmHk9KPK
         BDEHFTXANWkUtOh9foQua8fyRiuj8PwSfRElDPNQPhiQ71/xMxVpKPNGZq7EwlQWsIyY
         P6u4EFXp8jdgrOOJ7Np0gKTwWoIEWtwAF9+HCjPNdH6upyAiFzjtIY2nZQvxwxCka7fz
         wQalFPekE0olUEqmMk3pZIxDg9MqT5dxO7BG6BsH8hc7S+52jqcg44n4YvfbbSyP1Fvr
         fq5G5SBQM4MqfLOdYFw3gmjAA2DhvDXEgjsi2BG3zVXdShyUmUny/+6sVyLAYqBMnQZQ
         U8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lWmLE4q3/Bu6NgE5flSGxd9zmH6RLPZBqYQMoXSLwfo=;
        b=NwrB6OR29cjv7HSfJiD9wW/+ZUko9PfT19S04Kj5YivcSQaV1+ADN3tenaNo5GeE4V
         qmEzWGrKZ8Zy+RPp9+4RXk4dSXS5fB4zeccBsAYFM9tC/z0yZUfcr2+e6x1WOKEZBOBv
         LBum9/GWndcham4PIqZ1cb1aOXPOLsNoMB5xkmz5RrlJsp/YzDV+Bt8WaV8cxKHEXVqs
         c/tZvpMwgp7x3AsiEYPskvy+Gy6CwE16AXwWg3ghWiZCJjx/MbvloJFpgnWkUa0CaJJ+
         U2SdABOLgXTnNPAvlcYBCrAHyz0qeKT12HofHwhmo1cWK/eV5JHJZJtYgWbKkLpiNLpo
         /Ufw==
X-Gm-Message-State: AD7BkJLMWlAXJKOEQWAprkcKImiYniJ/y82ksxed29EuJkHO57JuNi7ovhCPWAuXHckF6piY
X-Received: by 10.98.69.213 with SMTP id n82mr16392096pfi.66.1456798049843;
        Mon, 29 Feb 2016 18:07:29 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id y15sm40893371pfi.16.2016.02.29.18.07.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 18:07:29 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0.1.g68b4e3f
In-Reply-To: <1456798040-30129-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287987>

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
index c3a1300..4bd14de 100644
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
@@ -771,6 +777,9 @@ int fetch_populated_submodules(const struct argv_array *options,
 	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
+	if (max_parallel_jobs < 0)
+		max_parallel_jobs = parallel_jobs;
+
 	calculate_changed_submodule_paths();
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
@@ -1117,3 +1126,8 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
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
2.8.0.rc0.1.g68b4e3f
