From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 5/8] fetching submodules: Respect `submodule.jobs` config option
Date: Wed, 28 Oct 2015 16:21:41 -0700
Message-ID: <1446074504-6014-6-git-send-email-sbeller@google.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
 <1446074504-6014-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 00:22:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zra2p-00030j-M7
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 00:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756418AbbJ1XWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 19:22:08 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:32896 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756013AbbJ1XWG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 19:22:06 -0400
Received: by padhy1 with SMTP id hy1so14340070pad.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 16:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vNBKKHJdoHjigb4rfzZQjNut50l2ur4V55o/vPumFC4=;
        b=U7kTQ3R2BkRmP9fxWLhK9HQKc7Fx+ZBnKixnwZdIoKYHMABBlJ6sbZ4uHAkMi5av56
         GCTjQB6AdZNs7tC3i8zXvqd7M4L+fcDd6AzJATJqavjsCEikqvVndsvyrUkX80UeEo2o
         CxYLdkenj8a9YOInMmewUQnYstsk3tLwlm92Mf3h059yEqkK+W08y9I8NAchrZeLaOym
         asCf/e5rY8ZunRE7M/cIISmSw4qNp1cGZkYmH8c3FHncPxnEv6z/TRCSe2Zoh+ORMv0Z
         TkrfTMdSAu2G7GiP2BXmGUIYnBXQgXNKdYvEKVXjHwX1In1a/YamZmKkSWY7Wgv00YOD
         wopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vNBKKHJdoHjigb4rfzZQjNut50l2ur4V55o/vPumFC4=;
        b=TPc4BBVMmIyI1c4IzCPvkL/3gmD38Keu18Q1GRNnfeuDlf0N3cTc3qnJTQBuFjNyq6
         K+OKTEaHrwvE4hnVxF1bNYE9opT+Sq/P2bdTo4ZDFHc33grlc9hbtsD1sVSC3BLY1Cj4
         x6JOSx9c0pq20q+ITmUiBAqKNU5qVOob7i45ksXYek6MdVTRA4RD/x5WY/Is1lndo3tw
         +07MHOHtOCy32vqdXEs7UFh+AG3oQw/L5QyD3XSPwRVnVspIMNmOKKZuM8clNRXoVFmR
         NZ0twZ3UGCsB9lYcLXsv+hHFqeKppvRC3mFCcC0QYnq3GIgjNcyRzvuksdNM/HeFTwue
         WSSw==
X-Gm-Message-State: ALoCoQkMi9V3PmtD0ZnfJjWWnmnrVJA8BCAJr2Geb1AD1whVcUuEvWFObHGjqZhJOho1MZU9v6B6
X-Received: by 10.68.131.106 with SMTP id ol10mr37245968pbb.14.1446074525404;
        Wed, 28 Oct 2015 16:22:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:202f:ecb0:ea3e:b8f7])
        by smtp.gmail.com with ESMTPSA id kp4sm47426153pbc.34.2015.10.28.16.22.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 Oct 2015 16:22:04 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.281.g4ed9cdb
In-Reply-To: <1446074504-6014-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280424>

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
index 391a0c3..785721a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2643,6 +2643,13 @@ submodule.<name>.ignore::
 	"--ignore-submodules" option. The 'git submodule' commands are not
 	affected by this setting.
 
+submodule.jobs::
+	This is used to determine how many submodules can be operated on in
+	parallel. Specifying a positive integer allows up to that number
+	of submodules being fetched in parallel. This is used in fetch
+	and clone operations only. A value of 0 will give some reasonable
+	default. The defaults may change with different versions of Git.
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
index 0257ea3..188ba02 100644
--- a/submodule.c
+++ b/submodule.c
@@ -752,6 +752,11 @@ int fetch_populated_submodules(const struct argv_array *options,
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
2.5.0.281.g4ed9cdb
