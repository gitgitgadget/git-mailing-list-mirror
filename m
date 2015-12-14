From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/8] fetching submodules: respect `submodule.fetchJobs` config option
Date: Mon, 14 Dec 2015 14:54:22 -0800
Message-ID: <1450133665-3783-6-git-send-email-sbeller@google.com>
References: <1450133665-3783-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, j6t@kdbg.org
To: sbeller@google.com, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 14 23:55:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8c27-0001gP-1V
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 23:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbbLNWzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 17:55:38 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33084 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932552AbbLNWzD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 17:55:03 -0500
Received: by pfnn128 with SMTP id n128so113008424pfn.0
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 14:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0qjpanQOJBIEkKcnE1mLr/MEBfuOGFcYT0LTetAgdnU=;
        b=DmnshUuzaL5X7E1YymcsiskTTSs1WTTFSP4saPFlWBjUZMb+X+qMOb5fuv/HybrGr3
         3Gg1EQlXAQ5iKqGnrwAOKsOa/tdfWQg0nlpjkm2KaByoI679O+FrwSEamVaHpOJGasLF
         bvuyFIiDhQYVhCNvfE7CQLGY0TJFDg4OnmLrw6ydK4fFBtVC1NKp0sTUMwTNv0+vOOid
         oU477EshvToU68pKRPMKipqhM5nX4l+K69mSudIrLNkoDvNUnsVSNP+Q/xfn1t88wOB8
         WFZA+L0Q3Hc2oVfSv50aOKqbM+yxFA8wrGp8/TQdyHxXXxia+J4YRLijYC1ym3uyeSim
         X1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0qjpanQOJBIEkKcnE1mLr/MEBfuOGFcYT0LTetAgdnU=;
        b=KjAXsbtUV3Z5W6E6xQcxOm7w5+s96ZI+XlB5oJHAKFmeGpalSJsp5Te4dsOzDccHow
         KQeI4laqV2MYoV/PUiRh5VcepA0CWTVdGDwQF9LHlNd0FWzFvCsbdiLBpD8kzVLcVd0G
         pHDqhKqTKQ+JS+BL+H0LFkkuLhphvEvMgnII6Pbz0S7ilFXAw79oJelxgzAQ02xk8h96
         SfXWKiWEyA0DqWRP05VlKihL4xPeE/rZBf1x1K2A6VJe+kScSfhAUsXstAdsBi6PLmnS
         BW/+ALYtOs+6A/lN9+wWSY9G3aXfLvhMlYU6TT9jbsLu1mRKkMVlA/wYOZQuhy6bRngi
         O7Gw==
X-Gm-Message-State: ALoCoQktk3RZslD3BUPUp2P46Ydd5ydkaY5Q19tNhCreMsrS1al9/vyNnwUafv4GnDkj4eAPkcPRbwnKNudKQ7dq8k7nBfq9ug==
X-Received: by 10.98.8.20 with SMTP id c20mr39624568pfd.65.1450133703041;
        Mon, 14 Dec 2015 14:55:03 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e502:49aa:9791:cefa])
        by smtp.gmail.com with ESMTPSA id hw7sm45077526pac.12.2015.12.14.14.55.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Dec 2015 14:55:02 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
In-Reply-To: <1450133665-3783-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282440>

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
index 0b48734..d97c8f5 100644
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
2.6.4.443.ge094245.dirty
