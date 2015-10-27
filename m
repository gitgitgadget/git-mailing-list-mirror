From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 9/9] fetching submodules: Respect `submodule.jobs` config option
Date: Tue, 27 Oct 2015 11:15:53 -0700
Message-ID: <1445969753-418-10-git-send-email-sbeller@google.com>
References: <1445969753-418-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 19:16:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr8nj-0003ch-Pa
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 19:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbbJ0SQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 14:16:42 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34152 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965119AbbJ0SQM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 14:16:12 -0400
Received: by padhk11 with SMTP id hk11so229741679pad.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 11:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hn2IOuoOw6qIz4ULtloEfxf8q8t14PMHzAcUlejSnZo=;
        b=ndJ9WJWrTZM7iVDpcNWcN5Lze5/9VkvXUYDvMjDAaxB2K4TDLaW1mnUL27Dtjy2hpc
         S79T7wi7aBmwH27zJg3S3ainkcK8NIQ0HqKHuF5xgEcagivYFHzmkAVz6eEjhUA+MDtP
         /mbQO2hv4TfKnlT9HOws1Ug4V7MJ/4Bn9V/gc8Mdt7HzQmDOTNnPxZrLAD6ayJZVuCD9
         nqqevYNatCbz/6HzcJchcge0Mg33UWLDOkOjy2IRUxkjozOWWEIbSwT+IAvmUtwiHjUo
         /I8P9ytvzcs8deU4nYa8+ChBxv91P+0k7sx8YJjyoXVx1JFKdoU1pZMBxBSQlnSbfhFn
         uAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hn2IOuoOw6qIz4ULtloEfxf8q8t14PMHzAcUlejSnZo=;
        b=TjZSjK8nsWmcFMv2cWkt4Fn8KPrHsIQVnOpqgrxgZ/n7NqZn/si89125RJKc1laedK
         sgBf9oI3J8q3ZVPmfu+6+AHrsiB1Oj67asjR3CKiA2lt6brr9tZwEuE4PE9t+jEfvoxz
         XVkaBk4Xgs6pJsb+J3ObuFLV2aXmd6uNdJzVUIGAvNSRXojazoDhh4a4FpVGUswhwW0X
         HC+JzUAlsIHzH7wHPdN7ENpWyhKj6WJp3xgf5c4AF9Z38nkBMm1Zy6bMC0LMDHrGoxPF
         wheuNxzTDtNGnp6EoqywaGgRSwVKFiZMNMyts1aDOXkJHOMN0Ny8Y76ybR8Q+MYQixmE
         Amog==
X-Gm-Message-State: ALoCoQlTg1YGrkpgd3SqFjh/lPG+fPNXl8BNipFD9nn5EVQsavLkLRSh+UlcKYBXQO9pCYMoRkRR
X-Received: by 10.68.130.198 with SMTP id og6mr29739092pbb.85.1445969772026;
        Tue, 27 Oct 2015 11:16:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:582c:77b:3135:2d26])
        by smtp.gmail.com with ESMTPSA id d13sm40898886pbu.20.2015.10.27.11.16.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 27 Oct 2015 11:16:11 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.283.g1a79c94.dirty
In-Reply-To: <1445969753-418-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280281>

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
 submodule-config.c          |  9 +++++++++
 submodule-config.h          |  2 ++
 submodule.c                 |  5 +++++
 t/t5526-fetch-submodules.sh | 14 ++++++++++++++
 6 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 315f271..0b733d7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2575,6 +2575,13 @@ submodule.<name>.ignore::
 	"--ignore-submodules" option. The 'git submodule' commands are not
 	affected by this setting.
 
+submodule::jobs
+	This is used to determine how many submodules can be operated on in
+	parallel. Specifying a positive integer allows up to that number
+	of submodules being fetched in parallel. Specifying 0 the number
+	of cpus will be taken as the maximum number. Currently this is
+	used in fetch and clone operations only.
+
 tag.sort::
 	This variable controls the sort ordering of tags when displayed by
 	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
diff --git a/builtin/fetch.c b/builtin/fetch.c
index f28eac6..b1399dc 100644
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
index 1cea404..07bdcdf 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -32,6 +32,7 @@ enum lookup_type {
 
 static struct submodule_cache cache;
 static int is_cache_init;
+static int parallel_jobs = -1;
 
 static int config_path_cmp(const struct submodule_entry *a,
 			   const struct submodule_entry *b,
@@ -235,6 +236,9 @@ static int parse_generic_submodule_config(const char *var,
 					  const char *key,
 					  const char *value)
 {
+	if (!strcmp(key, "jobs")) {
+		parallel_jobs = strtol(value, NULL, 10);
+	}
 	return 0;
 }
 
@@ -483,3 +487,8 @@ void submodule_free(void)
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
index c21b265..4822605 100644
--- a/submodule.c
+++ b/submodule.c
@@ -759,6 +759,11 @@ int fetch_populated_submodules(const struct argv_array *options,
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
index 1b4ce69..5c3579c 100755
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
+		grep "7 children" trace.out &&
+		git config submodule.jobs 8 &&
+		GIT_TRACE=$(pwd)/trace.out git fetch &&
+		grep "8 children" trace.out &&
+		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 9 &&
+		grep "9 children" trace.out
+	)
+'
+
 test_done
-- 
2.5.0.283.g1a79c94.dirty
