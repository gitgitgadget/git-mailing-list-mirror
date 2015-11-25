From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 6/9] fetching submodules: respect `submodule.fetchJobs` config option
Date: Tue, 24 Nov 2015 17:14:53 -0800
Message-ID: <1448414096-22021-7-git-send-email-sbeller@google.com>
References: <1448414096-22021-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 02:15:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Og6-000180-7M
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 02:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438AbbKYBPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 20:15:18 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35310 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188AbbKYBPK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 20:15:10 -0500
Received: by pacej9 with SMTP id ej9so39162034pac.2
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 17:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y9fHoTNcMUvS3oIyCPCxCqZqRmhA+LylUmvQhgQ6ENk=;
        b=O1HYvC5ic3WfdIqcLPTbac1VZPaAmk1Lt4xIdvl4VeI9xBY3vX19jEbk48e6tImZhc
         CiGg+atmhJn2da0P0NANKKQNt6SXCW6IhJt3cviJMVWgG7kQyb8fTLyCuzXMSWU4Ftjg
         nZSSw5FgodtWfSP+z5f/n4VpJjp5GvzYfSX/iIhhEAHgmmn9MtkWUrTsb/chlx1Gp5Wi
         sUIn740aZ6/mUcsMoT8S5vyn2ICqTa7EU7XmdngL5Jcyr7qMg3hGTBKXJq5F9LVLW5Ns
         vwNbhxbtv1pOziYtYKIqmZcrYwMHLwT+5PTtzxDDMAMkyL9eR1vVLIE6Eoste0bDhoK5
         vZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y9fHoTNcMUvS3oIyCPCxCqZqRmhA+LylUmvQhgQ6ENk=;
        b=XIJ5q9OTDHKLEtv3WRcyBa2ptBnxcgxopBEaU3Rea4/rSOCvIyqKjritivOJD1TpY2
         6MUu+ltNZaJlZQ5EpmTz5YqqleSefSq4Ly4Z3XHabdXJyLRfHblD9YOImissDvi6brEr
         AI3A2Mfo5ltSXxugoiGm3pXUerIPBcqc/ehT+xJ0IR9NnmbdSidU2BvXIU9rLCbOQ1pX
         LfFep1veRTlGQ88Ot2Ra7hCK92VuJ/6NjpcyYDgzQEbAxR/lqfBENZLO9lHM6ToH4vBm
         t9EwtOwICY7GcZOaeIowpbAYr53cPU3g8EH4ftQBqwC1kPMuswcXLQBLcJBSaEkrwFGG
         rrrQ==
X-Gm-Message-State: ALoCoQlyXhCWWepFw5NS4YqcfW28m12E6muQhakr+a8NrxSBKhLJAbEF9VAanqoM5ockURyc7mUu
X-Received: by 10.66.90.194 with SMTP id by2mr47328903pab.2.1448414109484;
        Tue, 24 Nov 2015 17:15:09 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5407:71cc:c14:4343])
        by smtp.gmail.com with ESMTPSA id b15sm16788000pfj.7.2015.11.24.17.15.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 17:15:08 -0800 (PST)
X-Mailer: git-send-email 2.6.1.261.g0d9c4c1
In-Reply-To: <1448414096-22021-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281663>

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
index 391a0c3..9e7c14c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2643,6 +2643,13 @@ submodule.<name>.ignore::
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
index 9cc1c9d..60e6797 100644
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
index c6350eb..e73f850 100644
--- a/submodule.c
+++ b/submodule.c
@@ -749,6 +749,11 @@ int fetch_populated_submodules(const struct argv_array *options,
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
index 1b4ce69..6671994 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -470,4 +470,18 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
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
2.6.1.261.g0d9c4c1
