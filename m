From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv9 5/6] submodule update: expose parallelism to the user
Date: Tue,  9 Feb 2016 12:54:33 -0800
Message-ID: <1455051274-15256-6-git-send-email-sbeller@google.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org,
	Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Tue Feb 09 21:54:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTFJK-0001kw-Eo
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 21:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932947AbcBIUyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 15:54:54 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33057 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932682AbcBIUyw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 15:54:52 -0500
Received: by mail-pf0-f175.google.com with SMTP id q63so29501479pfb.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 12:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5gVL7nHcEtjFyi9PWc17QytazUxWqU6ZcEaYkQZI5Uo=;
        b=dBuaIt3y3NWWBP/CbATl19NjQ2HVeRTKfaDOKuZydQ+kVtPdFK79t1Kh8vJZAPTYXM
         6jAIw5tbS/1V6xLMEHpZ98KRELT6Nb5Wi8+i0JTdRSvl5rB5OqX9roc7ySGgS9FGNVVy
         /gESBaGwByvZjXgQV+gvv55ByLHB2WiT938z9sBdAgrQxZnkvcjcbkS6DJZWb9y1HflA
         oOOYiqJnwx2ojHP3W8KGVtVr6lm2C9z2q8HhEcv0V/yV/u9Ly0oTlhqAFIIf8WTkNF/L
         jzT0WY+hhgQ7cTfFup8GHu/OVdwEQ3y7UeDTAbPEKXQuZTSowU2fC4rp7G1Ghe/8KLKR
         nSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5gVL7nHcEtjFyi9PWc17QytazUxWqU6ZcEaYkQZI5Uo=;
        b=BMbAGr1/KMboIZDFW7Tt74lbDwP+k+f5Z3vgyB3Ga8ME04lKVZI6EGoF+doIsMIaRB
         e5yE4znJGW3lBLj84rvEWzMJwU1sBO53n740hIh0ZAczwXiOkveBOCo4Oyyh5L7tH4Kw
         t+N+sq4qyNKKsxZ1s4u6jSSDZsI6lzVZ0tA9VqfuAb+iZaUd0lF5jHdFsBE4Ho6yudlh
         u1P9ZxNZIGKX+RXEmSvl/apvOIwmxMfq1HgiwTgO5ujC6qU1w4qJqMkIcHcGUeDCac/3
         4W8U9yFuKRKqZbkbUMlSZrO7HpdMP2zFB7N3bSt6zM69jd2dPr1GeRX5FckU0M+Cg/qE
         m57A==
X-Gm-Message-State: AG10YORrYDU92ZaKsRjUjaza2Xh4dNzHKDy7yyd1mGSSPf8laTW6kV5m0PZsh5JOoW3bdpfJ
X-Received: by 10.98.66.75 with SMTP id p72mr4645984pfa.50.1455051291259;
        Tue, 09 Feb 2016 12:54:51 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:9085:4567:f3b3:63e9])
        by smtp.gmail.com with ESMTPSA id z7sm52629482pfi.19.2016.02.09.12.54.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 12:54:50 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.35.gb0f7869.dirty
In-Reply-To: <1455051274-15256-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285862>

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
index 53356dc..6c74474 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -427,6 +427,7 @@ static int update_clone_task_finished(int result,
 
 static int update_clone(int argc, const char **argv, const char *prefix)
 {
+	int max_jobs = -1;
 	struct string_list_item *item;
 	struct submodule_update_clone pp = SUBMODULE_UPDATE_CLONE_INIT;
 
@@ -447,6 +448,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &pp.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
+		OPT_INTEGER('j', "jobs", &max_jobs,
+			    N_("parallel jobs")),
 		OPT__QUIET(&pp.quiet, N_("do't print cloning progress")),
 		OPT_END()
 	};
@@ -468,10 +471,15 @@ static int update_clone(int argc, const char **argv, const char *prefix)
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
index dda3929..7fd5142 100755
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
2.7.0.rc0.35.gb0f7869.dirty
