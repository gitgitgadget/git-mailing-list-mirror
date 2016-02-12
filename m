From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv10 3/7] fetching submodules: respect `submodule.fetchJobs` config option
Date: Thu, 11 Feb 2016 18:03:08 -0800
Message-ID: <1455242592-19352-4-git-send-email-sbeller@google.com>
References: <1455242592-19352-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 12 03:03:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aU35D-0000x0-FL
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 03:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbcBLCD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 21:03:29 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34066 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbcBLCD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 21:03:26 -0500
Received: by mail-pf0-f181.google.com with SMTP id x65so39094418pfb.1
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 18:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xFjmk7gIrVU/WJQnjXXiLJnI6AZy38kPcfaoe6PEh1c=;
        b=b87ju3g15+bp0KPrI6kjM323qJVIUy4OxEryMcaG5uHAp+xSF5+DOLHo8Niphr/f9D
         qAoDDGxo+CUvC8Rq/NU75QUTgexhqv/dqj9ot/bfPW1gZkVFIP56REf/y6a20wL6kRON
         3/tma/JciAX0GHeRJf+xnkvLM+YbUcbnYmQfoufWNQfX0vLRcobTLy83upB9r9DbGcu7
         PWxNg+arc5AnjYEwO/EcWqQgOywKjp/7lsGEc8pW0aul/Btjh0DrcE+SWUgaBdmh/D1h
         LItZgKROepEhgf4RMHoRAsKyYyNRzY7VCiBGu8pbTl9/dtF29UP2i52T7dy50JLX09Ho
         JcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xFjmk7gIrVU/WJQnjXXiLJnI6AZy38kPcfaoe6PEh1c=;
        b=I2Uvq4Erb9QZhMu3yrrug3T5WJKjRgulvdaWBoFRuFNVLF3ZgsoCSzkyCs22cIe/Qt
         9oQDyaGkPwEYAPNs7z5eH5ihDK9FDzyVqMo/M9778+H8Tz9zvKPw6GHtDjKAZnLsh8s3
         V6ftRrwj6jjlH6SVBGF18+FK8jiD8SIr5xi2pMZJ4ynaQPVjw0BlXf5XL4oi49soy6HK
         uLj+EsN7oz0Nw9PPgrS+W3r21bqKi77J5k87dBQUs5nv67CEAP/xFGmcu/mjlXUfIT0n
         sCoA781LpmM461tODwmQLnFIWGrtxAQsU5PDdBMaZVgLz+FoZSHKmSXAATfZXM7PDv8Q
         Mqkw==
X-Gm-Message-State: AG10YOTkMfU08WTDzlRQWJjJPZUN91H+BWuD0kpIsCDli4wlG0qRL3KYDXnlcasD7Saho6Gq
X-Received: by 10.98.73.8 with SMTP id w8mr71098631pfa.106.1455242605670;
        Thu, 11 Feb 2016 18:03:25 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:994e:7471:3f:c285])
        by smtp.gmail.com with ESMTPSA id 70sm15045880pfs.78.2016.02.11.18.03.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 18:03:24 -0800 (PST)
X-Mailer: git-send-email 2.7.1.292.g18a4ced.dirty
In-Reply-To: <1455242592-19352-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286032>

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
