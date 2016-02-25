From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/7] submodule update: expose parallelism to the user
Date: Wed, 24 Feb 2016 17:42:04 -0800
Message-ID: <1456364525-21190-7-git-send-email-sbeller@google.com>
References: <1456364525-21190-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 02:42:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYkwl-0000Lz-If
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 02:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758184AbcBYBmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 20:42:20 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34093 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757717AbcBYBmS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 20:42:18 -0500
Received: by mail-pf0-f175.google.com with SMTP id x65so23142071pfb.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 17:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=psfe7Fwmk8N1ax7BMPT927wUfW9F1e1CArvXT76OJOk=;
        b=JTp2UAdRjnAEm39GErj6H+V3ky66W7bLb61Wry0IM6KKnU3p5gG7O3llsizH77lN8W
         aqHA36flmsMAtd25xtlfFss5/WqnQuEPAuPT0gVDNYe05mK/Syw5SY4FJhrh2EfGPaSa
         2br54XOY0spWEZObZzOst8pYUBFZ4Wg5KvkagXQY6QZyO9JeFAMX55xoXhV21PbFlKnT
         eRUzw13gLSumOw1+isvhsi13ii3qSvo3Y7S2Ll49uNzbBVyxDNH8P/8gh7Vp9l3wcm/J
         jYR+326FqNZGjgESW1ErmK1QRqk4GQwM4BawnLbiBVeLnsdhRpu+73WDG8cfBfDVsY8H
         ngLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=psfe7Fwmk8N1ax7BMPT927wUfW9F1e1CArvXT76OJOk=;
        b=bCGOUAMnA/14/C5+pzyAZhVBRmEGcE0Vc/t7pfTGV3nP78HRXiAqJjAk25FE2xopRw
         lUA6tlMGaPVY7OkY1KygD75piMSVqnqia5aW+nXg+JeWLbkLJvu+zJbF4RDS25X3MAoT
         E7Q/gQma4d/cQ+RILDfAkD/72S122BmVK7/92kiZC7/0e5C4s+jNmftFq8UvYqFORv6p
         snGu8WzFpOhml/LyRoQLGH4rm5rWu8fAEYBPpa1Llm5cQn8k4JVEb8Q9tp7TWOkTi0fb
         bNOCiGO6uBVGrasPlysXrG51B5sa5Wa3wxWpEsnm9SX0HvfKVx046061V5yQMTYsq3UI
         tnqQ==
X-Gm-Message-State: AG10YOQNtu/FGoAvd4y2x7kWQ3roZukpedZBTCzn77YcxrjGvDILDuZX3wAIFzbchfqUVBzm
X-Received: by 10.98.74.17 with SMTP id x17mr59550285pfa.14.1456364537409;
        Wed, 24 Feb 2016 17:42:17 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:74de:af7a:dfba:15a4])
        by smtp.gmail.com with ESMTPSA id e1sm7750080pas.1.2016.02.24.17.42.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 17:42:16 -0800 (PST)
X-Mailer: git-send-email 2.7.2.335.g3f96d05
In-Reply-To: <1456364525-21190-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287307>

Expose possible parallelism either via the "--jobs" CLI parameter or
the "submodule.fetchJobs" setting.

By having the variable initialized to -1, we make sure 0 can be passed
into the parallel processing machine, which will then pick as many parallel
workers as there are CPUs.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index 85fb702..32254cd 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -429,6 +429,7 @@ static int update_clone_task_finished(int result,
 static int update_clone(int argc, const char **argv, const char *prefix)
 {
 	const char *update = NULL;
+	int max_jobs = -1;
 	struct string_list_item *item;
 	struct pathspec pathspec;
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
@@ -449,6 +450,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &suc.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
+		OPT_INTEGER('j', "jobs", &max_jobs,
+			    N_("parallel jobs")),
 		OPT__QUIET(&suc.quiet, N_("don't print cloning progress")),
 		OPT_END()
 	};
@@ -475,10 +478,15 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	gitmodules_config();
 	/* Overlay the parsed .gitmodules file with .git/config */
 	git_config(submodule_config, NULL);
-	run_processes_parallel(1, update_clone_get_next_task,
-				  update_clone_start_failure,
-				  update_clone_task_finished,
-				  &suc);
+
+	if (max_jobs < 0)
+		max_jobs = parallel_submodules();
+
+	run_processes_parallel(max_jobs,
+			       update_clone_get_next_task,
+			       update_clone_start_failure,
+			       update_clone_task_finished,
+			       &suc);
 
 	/*
 	 * We saved the output and put it out all at once now.
diff --git a/git-submodule.sh b/git-submodule.sh
index a6a82d2..86018ee 100755
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
@@ -671,6 +679,7 @@ cmd_update()
 		${update:+--update "$update"} \
 		${reference:+--reference "$reference"} \
 		${depth:+--depth "$depth"} \
+		${jobs:+$jobs} \
 		"$@" || echo "#unmatched"
 	} | {
 	err=
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
2.7.2.335.g3f96d05
