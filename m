From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 6/9] fetching submodules: respect `submodule.jobs` config option
Date: Fri, 13 Nov 2015 17:06:59 -0800
Message-ID: <1447463222-12589-7-git-send-email-sbeller@google.com>
References: <1447463222-12589-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 02:07:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxPJa-0003cP-QA
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 02:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbbKNBHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 20:07:34 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34546 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbbKNBHV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 20:07:21 -0500
Received: by padhx2 with SMTP id hx2so115653632pad.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 17:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aUY0qxWk5FgTokoIH1Y70rHoRhz62ypPhhPho/6crzA=;
        b=oMiABDCxiTdOba+UQYSs96Vi3lampb6zUm0+j369s/MQy1AQkpvvc7MpI7NMKt7Mui
         tAPjsbQs1CvGR8KnPnVbFBeiu2iaoOvrHE8pw4SUU9EeZYtMq+H/qpLVd8dN7y6DBhe8
         CpoqMnsnKPsCVVUPQIF3ATbIubo2ZYYH3P4mOehhcQmGKt3m2LLoe4bdOchcr5YBhEbL
         CxqcXoy572ubH2aSxOXDuWxA6flYHGOXb/FCmpGDJI16sQV5gRNLCRBa1ynoDhJOORL6
         CLZkLJTB7mrgCf4Vgo54ZPLNmrCXLIzhAF+fqM3h6eeqZVf2gIh8ODSvAst84k3lMMhJ
         Pvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aUY0qxWk5FgTokoIH1Y70rHoRhz62ypPhhPho/6crzA=;
        b=AMTYvOGJ6M4lMNhNB/N5Pe3568WcNzNl4acatHGZ6DSS2BFD5zWi7EbggHNfDqp4X9
         uRtM1ZT7atvcSvbe6QoB5TAY4LdIucSxlhVphAaxKXnXHAf4nqZGgTrxke74z9iY0Yn4
         9HSVtCSJwMtlkQn0N5jS8ccberb6h2NlV8fHI2ETC5SuwI3uEkKdwJaJVN3QL+3Vv9TI
         ENu8jvJfX94RCMrzC+EiTiSm35yfwb3Exj+z1QuJ7l5etvIVfsNSlmJLPV0ScZjV/qjA
         PfpHd/OOHrERiYydMYakKefMpLJ5UPVGM7LgK2V3/S81Ox7pvfES1/ApojebmfQWfOQY
         dQtg==
X-Gm-Message-State: ALoCoQmmVUu28/9WMMTx1dU4h6kGiTesqrVod7VPq/QL8nOkWojo1gCHRsieK8WuhORDzzfDl4Gb
X-Received: by 10.68.231.7 with SMTP id tc7mr36956447pbc.108.1447463240758;
        Fri, 13 Nov 2015 17:07:20 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:f5eb:b7b9:3afa:a95c])
        by smtp.gmail.com with ESMTPSA id yz3sm22640511pbb.37.2015.11.13.17.07.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 13 Nov 2015 17:07:20 -0800 (PST)
X-Mailer: git-send-email 2.6.3.369.gea52ac0
In-Reply-To: <1447463222-12589-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281292>

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
2.6.3.369.gea52ac0
