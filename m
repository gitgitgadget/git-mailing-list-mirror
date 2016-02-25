From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv18 03/11] fetching submodules: respect `submodule.fetchJobs` config option
Date: Thu, 25 Feb 2016 15:08:20 -0800
Message-ID: <1456441708-13512-4-git-send-email-sbeller@google.com>
References: <xmqqoab4mnoc.fsf@gitster.mtv.corp.google.com>
 <1456441708-13512-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 26 00:09:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ52R-0008RA-DC
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbcBYXJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:09:05 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33070 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbcBYXJD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:09:03 -0500
Received: by mail-pf0-f170.google.com with SMTP id q63so40546514pfb.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hyQKtDIspE1griLlNRvKiX73FKWsDkjW9Q9/I5NjPB0=;
        b=H0W6cgkeAED8QpxVOqKMe1O4ptwNwQuK/V9ohXyKoQEc5ViuIK/UfoAHvAhAhM7524
         Nn6PzAjkn8eW29gtc+nX6cgOZerCVy0hd/c4N1MAVAGvIbcXmJmszd4nR6F6m3TdZA5M
         SA8hR8lijHvSqllwuXMX6dUu5uN7HfaA2wjhiPX5xEcTBg6lfXbNWL+fhOc1g/UkWNzP
         /MTH4GXigXXjIm/SjvDbYGMF9ftPR8vpttSWQUa4Kgp/H4YKPjq5/RN4UCWSA3EYfc31
         hbPPLH4HS6ID5mvlV3byMvrZZ4GBj+Ld0UtJdtxGXniYF79NifI0bT7HEqVNILIUTebS
         RQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hyQKtDIspE1griLlNRvKiX73FKWsDkjW9Q9/I5NjPB0=;
        b=FdOHy/0vkE42echsGufdWdQtaL7fYCkzFY1xvCANcassk435fAWtJHzJRSd009/bUI
         I4NNIo/lTGbpBUtJrDTK4sRpy/Mfb+i+bM7hVPGgjdhfsXhZWDR7rjwYJpB3O/yyKjmA
         8uRuYrvPfs64VaizHHsK3LH14s+9RywFwD8Cv7388cPaouFXew3exqcuU8N6do8VeTRn
         PAh8PYxsAUjGuVjnybgGbklufuupjIMiBFd4SGDCIlsiJZIIO9uxUUURqHYfIlaMbMAw
         4/QdvinNIUYPjL8+bmghWM5VEZceT929JcqRJCYdCWZVHH9cz9v7qtEaO71+0LXtDGGC
         gaeg==
X-Gm-Message-State: AG10YORML5uHcuQB4mego4sHIY6HH/OXSDylKZt4bwXNmQeOyO1UfUBzfA2XFJfY0GbsXCOK
X-Received: by 10.98.13.68 with SMTP id v65mr66367414pfi.150.1456441742022;
        Thu, 25 Feb 2016 15:09:02 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a893:1c03:aadb:c3d])
        by smtp.gmail.com with ESMTPSA id g10sm14492704pfd.92.2016.02.25.15.09.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 15:09:00 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.36.g75877e4.dirty
In-Reply-To: <1456441708-13512-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287484>

This allows to configure fetching and updating in parallel
without having the command line option.

This moved the responsibility to determine how many parallel processes
to start from builtin/fetch to submodule.c as we need a way to communicate
"The user did not specify the number of parallel processes in the command
line options" in the builtin fetch. The submodule code takes care of
the precedence (CLI > config > default).

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
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
2.7.0.rc0.36.g75877e4.dirty
