From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 6/9] fetching submodules: respect `submodule.fetchJobs` config option
Date: Thu,  4 Feb 2016 14:09:33 -0800
Message-ID: <1454623776-3347-7-git-send-email-sbeller@google.com>
References: <1454623776-3347-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 04 23:10:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRS6A-0007Fz-Ir
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 23:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756378AbcBDWJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 17:09:56 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36463 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965262AbcBDWJw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 17:09:52 -0500
Received: by mail-pa0-f49.google.com with SMTP id yy13so22213917pab.3
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 14:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XE9+nbIaONrRT6qb2aKdb58Hi7wmhtRJOLCVP+tOFYY=;
        b=pxVPsF0FLeeQER+GCFKMccM33Fg+aORBnw1X0zpWeqYkm41+ugXamp33CIYYPph1Yv
         DII5k6B/6UL0ZPItI4saPBGts/Ay41T03BZo2uTbKibuwwGYOTpSjVvheTECc01Gc+fm
         3v4DJdKR5AoGJYP6l7YsojFv+cAkCe3wYvQC3k5bTS+M3uAIm37AVdJY8wpH+lxntdF9
         8QHVo35KR/bh7qXi4fJPF+azZJk8rug5cV4CgbRfVkfcLO/K7/s301k717zoYxOiFpY+
         aDa6WA5Kkru3dj07zVrqir310OC5sPjwrMO0tP6ljkIJQVQEdI0ZUi+tvhpuv15iD8nY
         tJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XE9+nbIaONrRT6qb2aKdb58Hi7wmhtRJOLCVP+tOFYY=;
        b=HG8CxIHb2gZdx0jMKLLEToVQuzYTd72eerBmYcuAGi006n0S/Vij9i1sUB4QnUPQqA
         WuVsLJ9ijWEvR3iz4OPSuNnvd1uaUkf0g4/X+mQIoYIbv28Im6sUc8t94Qr+UUNg0VzS
         BJ40e2UTdxhMnarLYdCGPn0RqI3jG6N22u8kwslypYLGn+X8wtXpRW+u15995tsJuYRx
         sMY6vNjf0XhCsVxEfl5jep+2SPKsL0w4o+dcP/hcfbdBbeNECb7iF5jhsQ2iwi885qQ8
         XcfMx9KtyEen1pZ0ep6f99XoCP3zJ73Q/slD5zDoDZM2XHhW8tZ4wBEF5K02jHH+ZVk1
         vAgA==
X-Gm-Message-State: AG10YOQqGWZ56rkdTQ5ieVQt4hjoXGN88xgdBcub1NfD2zxbbZonqvJIBsjDF1aLbBvGlZLr
X-Received: by 10.66.62.195 with SMTP id a3mr14824515pas.8.1454623792063;
        Thu, 04 Feb 2016 14:09:52 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5194:ebf5:4051:c1fd])
        by smtp.gmail.com with ESMTPSA id i13sm19313524pfi.95.2016.02.04.14.09.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2016 14:09:51 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.41.gd102984.dirty
In-Reply-To: <1454623776-3347-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285502>

This allows to configure fetching and updating in parallel
without having the command line option.

This moved the responsibility to determine how many parallel processes
to start from builtin/fetch to submodule.c as we need a way to communicate
"The user did not specify the number of parallel processes in the command
line options" in the builtin fetch. The submodule code takes care of
the precedence (CLI > config > default)

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt    |  6 ++++++
 builtin/fetch.c             |  2 +-
 submodule-config.c          | 13 +++++++++++++
 submodule-config.h          |  2 ++
 submodule.c                 |  5 +++++
 t/t5526-fetch-submodules.sh | 14 ++++++++++++++
 6 files changed, 41 insertions(+), 1 deletion(-)

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
diff --git a/submodule-config.c b/submodule-config.c
index 2841c5e..339b59d 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -32,6 +32,7 @@ enum lookup_type {
 
 static struct submodule_cache cache;
 static int is_cache_init;
+static unsigned long parallel_jobs = -1;
 
 static int config_path_cmp(const struct submodule_entry *a,
 			   const struct submodule_entry *b,
@@ -233,6 +234,13 @@ static int parse_generic_submodule_config(const char *key,
 					  const char *value,
 					  struct parse_config_parameter *me)
 {
+	if (!strcmp(key, "fetchjobs")) {
+		if (!git_parse_ulong(value, &parallel_jobs)) {
+			warning(_("Error parsing submodule.fetchJobs; Defaulting to 1."));
+			parallel_jobs = 1;
+		}
+	}
+
 	return 0;
 }
 
@@ -479,3 +487,8 @@ void submodule_free(void)
 	cache_free(&cache);
 	is_cache_init = 0;
 }
+
+unsigned long config_parallel_submodules(void)
+{
+	return parallel_jobs;
+}
diff --git a/submodule-config.h b/submodule-config.h
index f9e2a29..bab1e8d 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -27,4 +27,6 @@ const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
 		const char *path);
 void submodule_free(void);
 
+unsigned long config_parallel_submodules(void);
+
 #endif /* SUBMODULE_CONFIG_H */
diff --git a/submodule.c b/submodule.c
index b83939c..eb7d54b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -751,6 +751,11 @@ int fetch_populated_submodules(const struct argv_array *options,
 	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
+	if (max_parallel_jobs < 0)
+		max_parallel_jobs = config_parallel_submodules();
+	if (max_parallel_jobs < 0)
+		max_parallel_jobs = 1;
+
 	calculate_changed_submodule_paths();
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
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
2.7.0.rc0.41.gd102984.dirty
