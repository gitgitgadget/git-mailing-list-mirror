From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] submodule update: learn `--recommended-depth` option
Date: Wed, 25 May 2016 15:00:06 -0700
Message-ID: <20160525220006.27138-4-sbeller@google.com>
References: <20160525220006.27138-1-sbeller@google.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 00:00:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5gqp-0007VI-6o
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 00:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbcEYWAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 18:00:22 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35960 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbcEYWAS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 18:00:18 -0400
Received: by mail-pa0-f50.google.com with SMTP id eu11so12634161pad.3
        for <git@vger.kernel.org>; Wed, 25 May 2016 15:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2aK3VxrFn7mUOrNeREDADaZEJECcb61hGXfrTvBWfbY=;
        b=gT8/4Vnjlypw3/yxeLQXCrBpamgL8dBRxmsx5P0vVQgcP68GHtbcEIZaLktH7Zh5b+
         pkqRpGYcjdo72JGbAH0U6P9IEgohKhuYIoyVSUKOpgFadC+FRhLTJJn5LDnqjTMxCbil
         VthLCmQM9UPsMCINbQrLu/BSSGwBs1l6N2fn4AiZF/6JRPXbleV2A6V3QTc5N4CNmfcF
         0Bnzzatz4rrb/v1YsyTE8L6i+MvcGxsBoeogHQ6/hhFCCg30gg9lhe+n74QdLaTZp+po
         xHTIVMWIdpJZUni8sOZPORr/Kl2s37NIdg82KDe5DbWHLJVUOOdVHXuqBV2sxAkb8yUl
         AK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2aK3VxrFn7mUOrNeREDADaZEJECcb61hGXfrTvBWfbY=;
        b=cWGQOF6VYVaEDHiK8ApOmq0Y7l5YObtP7+STLpVF2ZzyWLXG9n3Axcnw+ObNG3qE92
         Nw1Q5Xx6oBfoCZ/5Dt9ToUs2TRtcDjw7JRmGMoD6xKfGkUQ8Tw/0lAFDK0Fkg4BuqXBB
         aCGi1B4UsdHQ8KtsYeIIiYBWYpr3AOTv7XSNYUhqxerK1pQ+OhPWvK8lBRPaM7WWUKiv
         89sH4uHp7sEubsaPCeGpPNtM6AWAvZN4SjMXobREzL+fhPaCQcL+Al/lBD8QPcAe4qCg
         ZZ45hzBP+ehq05XdepPn5GRh/kiw+AHm7Q0xlTtOswu1iNu8akif+NIRkCfrkMNPV1+H
         9pEg==
X-Gm-Message-State: ALyK8tIFsG31YY5sPwXqI0MvyIhZ4qGpcGf7RYkJfj4wmYAUImx+dS8ZhclbCZYXL/siOuDF
X-Received: by 10.66.170.168 with SMTP id an8mr9036777pac.47.1464213617243;
        Wed, 25 May 2016 15:00:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9ded:7fc0:154a:2e3b])
        by smtp.gmail.com with ESMTPSA id b67sm704301pfc.74.2016.05.25.15.00.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 May 2016 15:00:16 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc0.3.g892bdd0.dirty
In-Reply-To: <20160525220006.27138-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295596>

Sometimes the history of a submodule is not considered important by
the projects upstream. To make it easier for downstream users, allow
a field 'submodule.<name>.depth' in .gitmodules, which can be used
to indicate the recommended depth.

This field is honored in the initial clone by default, it can be
ignored by giving the `--no-recommended-depth` option.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt | 10 ++++++++--
 builtin/submodule--helper.c     |  8 +++++++-
 git-submodule.sh                |  9 ++++++++-
 t/t5614-clone-submodules.sh     | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 9226c43..c928c0d 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -15,8 +15,9 @@ SYNOPSIS
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
-	      [-f|--force] [--rebase|--merge] [--reference <repository>]
-	      [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]
+	      [--[no-]recommended-depth] [-f|--force] [--rebase|--merge]
+	      [--reference <repository>] [--depth <depth>] [--recursive]
+	      [--jobs <n>] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
@@ -384,6 +385,11 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
 	clone with a history truncated to the specified number of revisions.
 	See linkgit:git-clone[1]
 
+--[no-]recommended-depth::
+	This option is only valid for the update command.
+	The initial clone of a submodule will use the recommended
+	`submodule.<name>.depth` as provided by the .gitmodules file.
+
 -j <n>::
 --jobs <n>::
 	This option is only valid for the update command.
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8da263f..70bf2f2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -581,6 +581,7 @@ struct submodule_update_clone {
 
 	/* configuration parameters which are passed on to the children */
 	int quiet;
+	int use_recommended_depth;
 	const char *reference;
 	const char *depth;
 	const char *recursive_prefix;
@@ -593,7 +594,7 @@ struct submodule_update_clone {
 	unsigned quickstop : 1;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
-	SUBMODULE_UPDATE_STRATEGY_INIT, 0, NULL, NULL, NULL, NULL, \
+	SUBMODULE_UPDATE_STRATEGY_INIT, 0, -1, NULL, NULL, NULL, NULL, \
 	STRING_LIST_INIT_DUP, 0}
 
 
@@ -698,6 +699,9 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		argv_array_push(&child->args, "--quiet");
 	if (suc->prefix)
 		argv_array_pushl(&child->args, "--prefix", suc->prefix, NULL);
+	if (suc->use_recommended_depth && sub->recommended_depth > 0)
+		argv_array_pushf(&child->args, "--depth=%d",
+			sub->recommended_depth);
 	argv_array_pushl(&child->args, "--path", sub->path, NULL);
 	argv_array_pushl(&child->args, "--name", sub->name, NULL);
 	argv_array_pushl(&child->args, "--url", url, NULL);
@@ -780,6 +784,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 			      "specified number of revisions")),
 		OPT_INTEGER('j', "jobs", &max_jobs,
 			    N_("parallel jobs")),
+		OPT_BOOL(0, "recommended-depth", &suc.use_recommended_depth,
+			    N_("whether the initial clone should follow the depth recommendation")),
 		OPT__QUIET(&suc.quiet, N_("don't print cloning progress")),
 		OPT_END()
 	};
diff --git a/git-submodule.sh b/git-submodule.sh
index 7698102..794d98a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -9,7 +9,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommended-depth] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
@@ -559,6 +559,12 @@ cmd_update()
 		--checkout)
 			update="checkout"
 			;;
+		--recommended-depth)
+			recommended_depth="--recommended-depth"
+			;;
+		--no-recommended-depth)
+			recommended_depth="--no-recommended-depth"
+			;;
 		--depth)
 			case "$2" in '') usage ;; esac
 			depth="--depth=$2"
@@ -601,6 +607,7 @@ cmd_update()
 		${update:+--update "$update"} \
 		${reference:+--reference "$reference"} \
 		${depth:+--depth "$depth"} \
+		${recommended_depth:+"$recommended_depth"} \
 		${jobs:+$jobs} \
 		"$@" || echo "#unmatched"
 	} | {
diff --git a/t/t5614-clone-submodules.sh b/t/t5614-clone-submodules.sh
index 62044c5..c25eac0 100755
--- a/t/t5614-clone-submodules.sh
+++ b/t/t5614-clone-submodules.sh
@@ -82,4 +82,38 @@ test_expect_success 'non shallow clone with shallow submodule' '
 	)
 '
 
+test_expect_success 'clone follows recommended depth' '
+	test_when_finished "rm -rf super_clone" &&
+	git config -f .gitmodules submodule.sub.depth 1 &&
+	git add .gitmodules &&
+	git commit -m "recommed depth for sub" &&
+	git clone --recurse-submodules --no-local "file://$pwd/." super_clone &&
+	(
+		cd super_clone &&
+		git log --oneline >lines &&
+		test_line_count = 4 lines
+	) &&
+	(
+		cd super_clone/sub &&
+		git log --oneline >lines &&
+		test_line_count = 1 lines
+	)
+'
+
+test_expect_success 'get unshallow recommended shallow submodule' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --no-local "file://$pwd/." super_clone &&
+	(
+		cd super_clone &&
+		git submodule update --init --no-recommended-depth &&
+		git log --oneline >lines &&
+		test_line_count = 4 lines
+	) &&
+	(
+		cd super_clone/sub &&
+		git log --oneline >lines &&
+		test_line_count = 3 lines
+	)
+'
+
 test_done
-- 
2.9.0.rc0.3.g892bdd0.dirty
