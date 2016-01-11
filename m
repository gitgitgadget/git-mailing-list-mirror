From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 5/8] fetching submodules: respect `submodule.fetchJobs` config option
Date: Mon, 11 Jan 2016 11:41:58 -0800
Message-ID: <1452541321-27810-6-git-send-email-sbeller@google.com>
References: <1452541321-27810-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de
To: sbeller@google.com, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 11 20:42:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIiMM-00057R-6j
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 20:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbcAKTmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 14:42:23 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33368 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934625AbcAKTmU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 14:42:20 -0500
Received: by mail-pf0-f181.google.com with SMTP id e65so49517175pfe.0
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 11:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/3EBM0my+vSxOtuCoJ7npKPpuJF9a6vPc9yVNNzzsRI=;
        b=IJ8AlcRLLQ7aF2wKvRTKf19h99NivVzeoTvVaNVLPlQyLex+gpRfGkG1YTUELQViz4
         QJGC5fuNa4QWKqH+THcNtIinRj9tPgm3OGEzN0wjTHnvAV7VP6UUniSStKS3QisQcXKw
         RrSzuaNXs2NfVsRBe6W//czYnF5NvZxlCnQwr/r8I5KoCSYoCWLn39xj01+JRts8szYZ
         s+OA0mubhj5E94th8AbAGK1mohwAlsFCsM/9t3WjoYiLKL0ZHgOP4yyc2Ik4+RvYTx5E
         PP1HsUtnGWLu5Yd2LkA5y/G/xAcJhcnsMs+8Pmn3ei8BB+pz3I/zNGQ79140dxZkLynX
         em9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/3EBM0my+vSxOtuCoJ7npKPpuJF9a6vPc9yVNNzzsRI=;
        b=cSRO/sQRIIIbtwtmSvFHuqEyYLbeWzUppWe4OFBxUdEH85VPjoTa5Rc8YIbuFNNgxh
         ibljJvVCb/KOk85fpnAGAZWe68Zr0b/hwXoXTPo3g5HvWO6hH+kVD4yVKd7aumRkF/xf
         DKWovUrJQvmYWHHMKfUKy9zyZH30+qDePQY7bemwsiiSOksv9c+GgbciOEc9GDwtFL++
         oDIsD0Z78c59OjDtEHhzuHtpzsC9B79JL7Ag8Dh3oobzZcOHWHnNmekCPOUGCTgoUOHh
         ZSQA6ce5jWzc2lU9Kn5k7CnGpweVw2mLqu9cg50P1cUY2Hq0ehS2YzFHbMfnFM+DD30X
         ozTg==
X-Gm-Message-State: ALoCoQk7E40JIQ6sdz/OMSWgpSnEZQCZQ0NI4QjbCiyJcCeLPnhNt0ZxWA3yUR7cRTyLnyrow20UUXwkwkConPsVlLCFpd//Rw==
X-Received: by 10.98.68.73 with SMTP id r70mr28597761pfa.12.1452541339727;
        Mon, 11 Jan 2016 11:42:19 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:8d8c:9316:e7e7:6f4f])
        by smtp.gmail.com with ESMTPSA id v2sm25077348pfi.93.2016.01.11.11.42.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 11 Jan 2016 11:42:18 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc1.7.gf4541cb.dirty
In-Reply-To: <1452541321-27810-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283709>

This allows to configure fetching and updating in parallel
without having the command line option.

This moved the responsibility to determine how many parallel processes
to start from builtin/fetch to submodule.c as we need a way to communicate
"The user did not specify the number of parallel processes in the command
line options" in the builtin fetch. The submodule code takes care of
the precedence (CLI > config > default)

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt    |  7 +++++++
 builtin/fetch.c             |  2 +-
 submodule-config.c          | 15 +++++++++++++++
 submodule-config.h          |  2 ++
 submodule.c                 |  5 +++++
 t/t5526-fetch-submodules.sh | 14 ++++++++++++++
 6 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2d06b11..eda3276 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2646,6 +2646,13 @@ submodule.<name>.ignore::
 	"--ignore-submodules" option. The 'git submodule' commands are not
 	affected by this setting.
 
+submodule.fetchJobs::
+	This is used to determine how many submodules will be
+	fetched/cloned at the same time. Specifying a positive integer
+	allows up to that number of submodules being fetched in parallel.
+	This is used in fetch and clone operations only. A value of 0 will
+	give some reasonable configuration. It defaults to 1.
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
index 29e21b2..a32259e 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -32,6 +32,7 @@ enum lookup_type {
 
 static struct submodule_cache cache;
 static int is_cache_init;
+static int parallel_jobs = -1;
 
 static int config_path_cmp(const struct submodule_entry *a,
 			   const struct submodule_entry *b,
@@ -239,6 +240,15 @@ static int parse_generic_submodule_config(const char *key,
 					  const char *value,
 					  struct parse_config_parameter *me)
 {
+	if (!strcmp(key, "fetchjobs")) {
+		parallel_jobs = strtol(value, NULL, 10);
+		if (parallel_jobs < 0) {
+			warning("submodule.fetchJobs not allowed to be negative.");
+			parallel_jobs = 1;
+			return 1;
+		}
+	}
+
 	return 0;
 }
 
@@ -482,3 +492,8 @@ void submodule_free(void)
 	cache_free(&cache);
 	is_cache_init = 0;
 }
+
+int config_parallel_submodules(void)
+{
+	return parallel_jobs;
+}
diff --git a/submodule-config.h b/submodule-config.h
index f9e2a29..d9bbf9a 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -27,4 +27,6 @@ const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
 		const char *path);
 void submodule_free(void);
 
+int config_parallel_submodules(void);
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
2.7.0.rc1.7.gf4541cb.dirty
