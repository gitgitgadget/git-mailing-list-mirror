From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv17 10/11] submodule update: expose parallelism to the user
Date: Wed, 24 Feb 2016 19:06:57 -0800
Message-ID: <1456369618-18127-11-git-send-email-sbeller@google.com>
References: <1456369618-18127-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 04:07:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYmHG-000116-0T
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 04:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759907AbcBYDHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 22:07:25 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36282 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759892AbcBYDHW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 22:07:22 -0500
Received: by mail-pf0-f178.google.com with SMTP id e127so24334221pfe.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 19:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QhcLtCbWk8eiikS5cyqkLgj8xVDa6j/vO65un4CTKyw=;
        b=P6T5TgWEyq0kH2DsefuDOh8MrbTAKhdPpLa0A6Pp2wktOYDxfn8/Y58DwkPS1uGWlF
         y2FR4yM8wo1DHQUApPJqzobq5z1pFkijD1WzcWmMRgKhfp08W1cEFS0+Be/1PS4HH205
         LXQC0lasxeINB5AGQVXxl+M0o+G8xQdVO/tNOP2p5mMofw6VntmIdLSE30W2ajtODK4U
         gXW3GpnGTPLfUfhUhNh7PpJygw+9G72P2W8IwlozX3BMRnjQBbl2WlBA3t433MG7QQ/0
         khiBsPh3DArweW0224GvgHw9JiVF66jEbCNe3icnXmf0Q7zN13urVGomp3TqrQqACQIz
         c7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QhcLtCbWk8eiikS5cyqkLgj8xVDa6j/vO65un4CTKyw=;
        b=kkq0a5I5kUDYqfdIOcnt+UlHG0DeVV3wS1NShFS/ciu8mb8piOiTZSSB5R1H54dNlK
         Ni3r25xtWDABQH7TYVyDM72sdGfN7wzM9CnHIMF7BfIhgUhv04mvVadDvP7b/7zM0FzO
         ejXv1VZs0SFE6vdUqgKtyG8k0VbGV7VQkaZpaeK00ZEq1sD2Jm20xOsWMcKk/Mk3RFSf
         Y5msRbOpAIn0+Pw94F+9ZGvVJSvu9m4OJ1onPybpP+z9QrTyn6kDMoIMHbk5azfeGBzF
         UWNhGkRECM6qg6yVVYl3AoEp/IYQ+YJPbyBHpYJ3Ns7G7GT3rTUnL1LZ/uKmMEBSD7FZ
         eIaw==
X-Gm-Message-State: AG10YOQN7BmgbjQTZ/8Pw31bwRdNq2aBvUZi0pFYxdab6bENnF5MA7Ab4taYacnpwlBpmwnD
X-Received: by 10.98.70.139 with SMTP id o11mr59859511pfi.123.1456369636948;
        Wed, 24 Feb 2016 19:07:16 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:74de:af7a:dfba:15a4])
        by smtp.gmail.com with ESMTPSA id qy7sm7964183pab.34.2016.02.24.19.07.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 19:07:16 -0800 (PST)
X-Mailer: git-send-email 2.7.2.373.g1655498.dirty
In-Reply-To: <1456369618-18127-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287323>

Expose possible parallelism either via the "--jobs" CLI parameter or
the "submodule.fetchJobs" setting.

By having the variable initialized to -1, we make sure 0 can be passed
into the parallel processing machine, which will then pick as many parallel
workers as there are CPUs.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt |  7 ++++++-
 builtin/submodule--helper.c     |  8 +++++++-
 git-submodule.sh                |  9 +++++++++
 t/t7406-submodule-update.sh     | 12 ++++++++++++
 4 files changed, 34 insertions(+), 2 deletions(-)

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
index 408ac94..9d94406 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -433,6 +433,7 @@ static int update_clone_task_finished(int result,
 static int update_clone(int argc, const char **argv, const char *prefix)
 {
 	const char *update = NULL;
+	int max_jobs = -1;
 	struct string_list_item *item;
 	struct pathspec pathspec;
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
@@ -453,6 +454,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &suc.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
+		OPT_INTEGER('j', "jobs", &max_jobs,
+			    N_("parallel jobs")),
 		OPT__QUIET(&suc.quiet, N_("don't print cloning progress")),
 		OPT_END()
 	};
@@ -479,7 +482,10 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	gitmodules_config();
 	git_config(submodule_config, NULL);
 
-	run_processes_parallel(1,
+	if (max_jobs < 0)
+		max_jobs = parallel_submodules();
+
+	run_processes_parallel(max_jobs,
 			       update_clone_get_next_task,
 			       update_clone_start_failure,
 			       update_clone_task_finished,
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
2.7.2.373.g1655498.dirty
