From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 08/11] fetching submodules: respect `submodule.jobs` config option
Date: Tue,  3 Nov 2015 16:37:11 -0800
Message-ID: <1446597434-1740-9-git-send-email-sbeller@google.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 01:37:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztm4z-0002iH-Dw
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 01:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbbKDAhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 19:37:31 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36304 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756127AbbKDAh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 19:37:29 -0500
Received: by pacdm15 with SMTP id dm15so9426428pac.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 16:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0/KxUya1iTa/L8h8/Bkgq6delUpX98wn9U5rcHPrl/o=;
        b=PhmcRqVA7+vlFUAfApu376VGnLWqHwyl9SJl5LjqROPpaVvbDGxV3MuTa6dpl1CEij
         fOqAaCdzlifHhcOMkAORD9HJQ7Y5eiZo9ONkT+6PdGtNilil0tPczPsJdMww4LsD+mqR
         w2OTLZZ4nZ8WGYFNkTot5adMwimz9HVfVPyHoJegB9DC0xw6xrSXNDym+3c2dcBsEzch
         WYy957SdprTCb3vKXehX7kZDoteHakYODwz1qHxCtRD9GMkwQBPe/3egCVLZc5mBEubo
         WPpFJwgN/fOrTtw1gPj3OURJxq4eevzSLfQizxsVuC6IgPqnjyPBRBmytHporFKzP6pj
         Wkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0/KxUya1iTa/L8h8/Bkgq6delUpX98wn9U5rcHPrl/o=;
        b=Xj1MbwMIzNz8IIltCSLtdpafn7S/PGznpBchUNrQviKIePFELZLe5o8px1Ri3mypjZ
         iDSRURKs1PSNSFkcR1ojdbDdPpdg/w5ncWlAYuorT2oNqD/9PFJTdVnZuX8EC44L8cBA
         onPf8RMv66gWgxEek7kDm5wLaMizQLbp/heQbIh/UvqsupOvzHI/xIk9G7RC68qJw0/O
         iPVCkvlZl9tAJwwLF5gTToU05jf7kG2tv5gUKObrp/gKb5UOy6JEBYBkVrJ7Ffo4XeoS
         t9wsJHXU3jJP5Zo0zcshO1b4Hhm1tvI1dpevMNdappBminWdQh49Pn4Sqjy/Ee13f5Yv
         RhqQ==
X-Gm-Message-State: ALoCoQmy4wj4DK+t+N+O1yHLYutIqir3uo3ifrF6Q+39LwgX5d9Cz4A3w6RwGR1qV72dnQko5XRy
X-Received: by 10.68.190.5 with SMTP id gm5mr36658279pbc.81.1446597447968;
        Tue, 03 Nov 2015 16:37:27 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:799e:c67e:2702:f55])
        by smtp.gmail.com with ESMTPSA id mk5sm31787579pab.44.2015.11.03.16.37.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Nov 2015 16:37:27 -0800 (PST)
X-Mailer: git-send-email 2.6.1.247.ge8f2a41.dirty
In-Reply-To: <1446597434-1740-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280835>

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
index 391a0c3..70e1b88 100644
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
+	configuration. It defaults to 1.
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
index 29e21b2..475551a 100644
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
+	if (!strcmp(key, "jobs")) {
+		parallel_jobs = strtol(value, NULL, 10);
+		if (parallel_jobs < 0) {
+			warning("submodule.jobs not allowed to be negative.");
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
2.6.1.247.ge8f2a41.dirty
