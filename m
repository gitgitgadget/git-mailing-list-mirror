From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv9 3/6] fetching submodules: respect `submodule.fetchJobs` config option
Date: Tue,  9 Feb 2016 12:54:31 -0800
Message-ID: <1455051274-15256-4-git-send-email-sbeller@google.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org,
	Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Tue Feb 09 21:54:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTFJJ-0001kw-OM
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 21:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbcBIUyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 15:54:51 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34147 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747AbcBIUyt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 15:54:49 -0500
Received: by mail-pa0-f54.google.com with SMTP id ez2so4460962pad.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 12:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NHpBv1hoEM+YiBg+QiaLK3DCTbkjyaQ5gWo3ysFMQkE=;
        b=TiuMl6qmvHIIfuC23aYdPhxwHqpCYwFwjhSCn5OOUg+Ns4Y34W9CCQ9ZcTwfnXMiAX
         6dgvFXGWR0flHEvXGkX/YtXw3nVMAJAKPVs6L/d7Jo90h/xd+weCPDekWSM6VUSIvcur
         yNlGgwqH2W3YbV/g90Mi6nAtrlxeIxWXC8mKplMmeny0Pm7riNflflADjjk+nhwlCE7b
         t3Gq4FcPoqKaMB5Up8dcQSwWIF0kIVYnSt6zsZVl9PFCZLLt7aPvCeqjENuVkAi394QO
         6UJvFFQO5yvxmWwc4MBURbOHyvEwgDJN4Mb7z4LWKi8kjJFxZT7McnH3NnSi7gwT+9JH
         zgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NHpBv1hoEM+YiBg+QiaLK3DCTbkjyaQ5gWo3ysFMQkE=;
        b=DOvDN+aAPfdPWS9zSdzFZlRKHTvrZBGAno2mv94jT0EG3DI0moGH3oJy0joYVCVlBd
         rz6MB2jCAp5vPb6t+aaVvrz3Te9dulnUsQwg16C96unNlaQPipCy8fDdGnd/5VaMUSyT
         oGmQTcuniVeEx2sL5rXWBDfUbXbP/PR3a4PDMKlwJDiTM5/q/4GhYcCvZUZJ1xjSl6OY
         VJP4Y8grdBgHddTu+bG6glDowEIV/zbnY5DYjxbgO50vEXAVh5Vhl1mSd6vLVOD5F1sB
         DBRzFlKobXHB8Ke8TvW9QDoZGIg5hIblUg0X1PsrG7DJ0jcisWIaJg3ggrXm4dE6sb4C
         R0yg==
X-Gm-Message-State: AG10YOQO5O5I9gs0xwbciUkLnmnMmj740zmVK23UlAx0cd9FhV6JKE08dK3TwJcqfXdT6YdL
X-Received: by 10.66.187.77 with SMTP id fq13mr35670032pac.25.1455051288431;
        Tue, 09 Feb 2016 12:54:48 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:9085:4567:f3b3:63e9])
        by smtp.gmail.com with ESMTPSA id 27sm28037118pfh.48.2016.02.09.12.54.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 12:54:47 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.35.gb0f7869.dirty
In-Reply-To: <1455051274-15256-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285860>

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
 submodule.c                 | 17 ++++++++++++++++-
 submodule.h                 |  1 +
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
index b83939c..fd763f5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -15,6 +15,7 @@
 #include "thread-utils.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
+static int parallel_jobs = 1;
 static struct string_list changed_submodule_paths;
 static int initialized_fetch_ref_tips;
 static struct sha1_array ref_tips_before_fetch;
@@ -169,7 +170,13 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 
 int submodule_config(const char *var, const char *value, void *cb)
 {
-	if (starts_with(var, "submodule."))
+	if (!strcmp(var, "submodule.fetchjobs")) {
+		unsigned long val;
+		if (!git_parse_ulong(value, &val) || 0 > val || val >= INT_MAX)
+			die(_("Error parsing submodule.fetchJobs %s"), value);
+		parallel_jobs = val;
+		return 0;
+	} else if (starts_with(var, "submodule."))
 		return parse_submodule_config_option(var, value);
 	else if (!strcmp(var, "fetch.recursesubmodules")) {
 		config_fetch_recurse_submodules = parse_fetch_recurse_submodules_arg(var, value);
@@ -751,6 +758,9 @@ int fetch_populated_submodules(const struct argv_array *options,
 	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
+	if (max_parallel_jobs < 0)
+		max_parallel_jobs = parallel_jobs;
+
 	calculate_changed_submodule_paths();
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
@@ -1097,3 +1107,8 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 	strbuf_release(&rel_path);
 	free((void *)real_work_tree);
 }
+
+int parallel_submodules(void)
+{
+	return parallel_jobs;
+}
diff --git a/submodule.h b/submodule.h
index cbc0003..95babc5 100644
--- a/submodule.h
+++ b/submodule.h
@@ -41,5 +41,6 @@ int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
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
2.7.0.rc0.35.gb0f7869.dirty
