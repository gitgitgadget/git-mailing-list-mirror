From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv10 6/7] submodule update: expose parallelism to the user
Date: Thu, 11 Feb 2016 18:03:11 -0800
Message-ID: <1455242592-19352-7-git-send-email-sbeller@google.com>
References: <1455242592-19352-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 12 03:03:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aU357-0000tr-Ou
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 03:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbcBLCDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 21:03:33 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35148 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbcBLCDa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 21:03:30 -0500
Received: by mail-pf0-f181.google.com with SMTP id c10so39662701pfc.2
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 18:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oFtbCUCbUur3F7yThtQ4cbeNTmCiYy0ymGuO6jmL+tg=;
        b=mHQO6O3HWV0sXf4gbihwb4Hu689PuCtErUFVNsC/zQo8lXCaID3jE/YCTNITAp9KNa
         p8uC2H3qCmesbmQ5tqua+9MI+muuF8gq2sSuSHUaasKoSE48mTbq7oDe8c9nm6MiXCnU
         9FhS7vq2u1fCRx5p2c8hh8waPqE30+BLFzxzg0x1tNa53CR0GZuKeYUKfA0TqP/KDpMd
         eh4goc5zXcz5m0m67wdik0TjgFNcKnXVx36WdA2ab66vOMUy7b5T2DhWeBBbeJWsbuUf
         bQ1xVYZHBDiKJLYJtb8Yws3L/W2dsdMRbCTcTt8n1rKASPgz4ArzL1o0zEcfZoIoYWtB
         8b1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oFtbCUCbUur3F7yThtQ4cbeNTmCiYy0ymGuO6jmL+tg=;
        b=fp9z5BDavEPLt9gO2ii3EqtHa4c4CzlJCbiy70EZVmcaY+4quWoPOB165BQO2vuoEb
         P+saC25zncf2WCIdYBXp5BgKpIYMIxST2AVB297m8l4Z271+U0d6/WFSjwUT4xvh5Qi5
         zIVUE//1ej1fGiNAZZFk5/ntKMEKn0LGUNEv1GVtbt1w4ARdAz+p79K1/RdIiB2FOTlE
         yP0A7jkCRbuVb2Cpgt1J1EgqnTiwNZrSDzdiHWFRjmH3D+Ny4dm1U33L4wdma/oroZLs
         cQjUHmguCMzv3GR+zfK5gJQY156koFS7C4mPrL6zIbQm4QBE9YebsAzwK7Hzbt1/dttG
         H85w==
X-Gm-Message-State: AG10YOS9N6jAZPFhpXGk9GlmievnTM+QwZVBkGzQWXWYlypieuO5iCN8z4KH6lvtL4J2UWQV
X-Received: by 10.98.73.6 with SMTP id w6mr72229088pfa.82.1455242609964;
        Thu, 11 Feb 2016 18:03:29 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:994e:7471:3f:c285])
        by smtp.gmail.com with ESMTPSA id 9sm15049160pfc.69.2016.02.11.18.03.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 18:03:29 -0800 (PST)
X-Mailer: git-send-email 2.7.1.292.g18a4ced.dirty
In-Reply-To: <1455242592-19352-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286034>

Expose possible parallelism either via the "--jobs" CLI parameter or
the "submodule.fetchJobs" setting.

By having the variable initialized to -1, we make sure 0 can be passed
into the parallel processing machine, which will then pick as many parallel
workers as there are CPUs.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt |  7 ++++++-
 builtin/submodule--helper.c     | 16 ++++++++++++----
 git-submodule.sh                |  9 +++++++++
 t/t7406-submodule-update.sh     | 12 ++++++++++++
 4 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 1572f05..13adebf 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
 	      [-f|--force] [--rebase|--merge] [--reference <repository>]
-	      [--depth <depth>] [--recursive] [--] [<path>...]
+	      [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
@@ -377,6 +377,11 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
 	clone with a history truncated to the specified number of revisions.
 	See linkgit:git-clone[1]
 
+-j <n>::
+--jobs <n>::
+	This option is only valid for the update command.
+	Clone new submodules in parallel with as many jobs.
+	Defaults to the `submodule.fetchJobs` option.
 
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e865fca..09007a5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -429,6 +429,7 @@ static int update_clone_task_finished(int result,
 static int update_clone(int argc, const char **argv, const char *prefix)
 {
 	const char *update = NULL;
+	int max_jobs = -1;
 	struct string_list_item *item;
 	struct submodule_update_clone pp = SUBMODULE_UPDATE_CLONE_INIT;
 
@@ -449,6 +450,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &pp.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
+		OPT_INTEGER('j', "jobs", &max_jobs,
+			    N_("parallel jobs")),
 		OPT__QUIET(&pp.quiet, N_("do't print cloning progress")),
 		OPT_END()
 	};
@@ -474,10 +477,15 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	gitmodules_config();
 	/* Overlay the parsed .gitmodules file with .git/config */
 	git_config(git_submodule_config, NULL);
-	run_processes_parallel(1, update_clone_get_next_task,
-				  update_clone_start_failure,
-				  update_clone_task_finished,
-				  &pp);
+
+	if (max_jobs < 0)
+		max_jobs = parallel_submodules();
+
+	run_processes_parallel(max_jobs,
+			       update_clone_get_next_task,
+			       update_clone_start_failure,
+			       update_clone_task_finished,
+			       &pp);
 
 	if (pp.print_unmatched) {
 		printf("#unmatched\n");
diff --git a/git-submodule.sh b/git-submodule.sh
index 9f554fb..10c5af9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -645,6 +645,14 @@ cmd_update()
 		--depth=*)
 			depth=$1
 			;;
+		-j|--jobs)
+			case "$2" in '') usage ;; esac
+			jobs="--jobs=$2"
+			shift
+			;;
+		--jobs=*)
+			jobs=$1
+			;;
 		--)
 			shift
 			break
@@ -670,6 +678,7 @@ cmd_update()
 		${update:+--update "$update"} \
 		${reference:+--reference "$reference"} \
 		${depth:+--depth "$depth"} \
+		${jobs:+$jobs} \
 		"$@" | {
 	err=
 	while read mode sha1 stage just_cloned sm_path
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 68ea31d..815b4d1 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -774,4 +774,16 @@ test_expect_success 'submodule update --recursive drops module name before recur
 	 test_i18ngrep "Submodule path .deeper/submodule/subsubmodule.: checked out" actual
 	)
 '
+
+test_expect_success 'submodule update can be run in parallel' '
+	(cd super2 &&
+	 GIT_TRACE=$(pwd)/trace.out git submodule update --jobs 7 &&
+	 grep "7 tasks" trace.out &&
+	 git config submodule.fetchJobs 8 &&
+	 GIT_TRACE=$(pwd)/trace.out git submodule update &&
+	 grep "8 tasks" trace.out &&
+	 GIT_TRACE=$(pwd)/trace.out git submodule update --jobs 9 &&
+	 grep "9 tasks" trace.out
+	)
+'
 test_done
-- 
2.7.1.292.g18a4ced.dirty
