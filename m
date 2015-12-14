From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 7/8] submodule update: expose parallelism to the user
Date: Mon, 14 Dec 2015 14:54:24 -0800
Message-ID: <1450133665-3783-8-git-send-email-sbeller@google.com>
References: <1450133665-3783-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, j6t@kdbg.org
To: sbeller@google.com, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 14 23:55:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8c21-0001bd-GR
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 23:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbbLNWzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 17:55:41 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36226 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932567AbbLNWzG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 17:55:06 -0500
Received: by pacdm15 with SMTP id dm15so110985034pac.3
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 14:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MQkVb+15lo6j6VBqMLthfHFOnMdSJuRJvZd3+srh8z8=;
        b=Mur+8ojk84RnR/vBCAN5WegsQv24Z/Tzn6DH/iLRZWxvxR8y7XxP/shkk6ztbFayr6
         jRjWxdHnxiA/YcyENuvq0iCSGzLN4P0iGHowkKBDLjHW5OW/R1QQIc7YMCYq+cGzazus
         8Ld4V7OagqBdqSVvpMznzYZNXIxuTA5Fx/SMTdTv91wdc3m3xk5Qwk+IYwxfiogQePa1
         4KPCQ/NAHnWLUHdc4zc0/GQrOJ+DiThRuR/SGkdkvXjnsukUaD+mEw8aLhSTwNq9H09/
         +/4mNMier4/zWFjv90CVFB+iwSPzAZHlAk6wbD6b7duChuQcFkM44gC1EBsYCOvARWcl
         pS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MQkVb+15lo6j6VBqMLthfHFOnMdSJuRJvZd3+srh8z8=;
        b=jtxGcrsQ9D46fpB6iNdp9aQIuOueI82M075dkkjrhm52rcFfKcnsPIHzFyX+osOQ5i
         KZ/DlPuU/5qhwAIF9nSHhGbx8Vj2nQYnDcVnMe2Ryx8Xv7TIviwxMrZ+2FMcT0ffMwmn
         2OnpAmPzuy1QWnUWcrNQFROE9ADncNJ3AdS1ZTTeLG4ZakdnijeqXgXqGfGNZ4zi9quU
         2NTfZgZGeiVuxzBDy75jh4BCIhgyaFKc2B/wsH9DiYmdS33eDKRTxLwaeZMBKeLzjtxj
         4DVlpZwntUEIAh6tqW0HGWjQ/2uiI19EYdEovGi9neKKuQbue38p+Sr+uSxqvm58CAUv
         ppcQ==
X-Gm-Message-State: ALoCoQkqihRDYXjANP1J2ggv/T2jBtyYWOZ+/+9AGqTtmBCuCNiM4jMoQBompqk4pINBSZQgP40cclqwJpAKvydyp/nUoZlPBg==
X-Received: by 10.66.180.48 with SMTP id dl16mr48979132pac.39.1450133706046;
        Mon, 14 Dec 2015 14:55:06 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e502:49aa:9791:cefa])
        by smtp.gmail.com with ESMTPSA id rz10sm45041103pac.29.2015.12.14.14.55.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Dec 2015 14:55:05 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
In-Reply-To: <1450133665-3783-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282438>

Expose possible parallelism either via the "--jobs" CLI parameter or
the "submodule.fetchJobs" setting.

By having the variable initialized to -1, we make sure 0 can be passed
into the parallel processing machine, which will then pick as many parallel
workers as there are CPUs.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt |  7 ++++++-
 builtin/submodule--helper.c     | 18 ++++++++++++++----
 git-submodule.sh                |  9 +++++++++
 t/t7406-submodule-update.sh     | 12 ++++++++++++
 4 files changed, 41 insertions(+), 5 deletions(-)

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
index 9441f20..8002187 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -426,6 +426,7 @@ static int update_clone_task_finished(int result,
 
 static int update_clone(int argc, const char **argv, const char *prefix)
 {
+	int max_jobs = -1;
 	struct string_list_item *item;
 	struct submodule_update_clone pp = SUBMODULE_UPDATE_CLONE_INIT;
 
@@ -446,6 +447,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &pp.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
+		OPT_INTEGER('j', "jobs", &max_jobs,
+			    N_("parallel jobs")),
 		OPT__QUIET(&pp.quiet, N_("do't print cloning progress")),
 		OPT_END()
 	};
@@ -467,10 +470,17 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	gitmodules_config();
 	/* Overlay the parsed .gitmodules file with .git/config */
 	git_config(git_submodule_config, NULL);
-	run_processes_parallel(1, update_clone_get_next_task,
-				  update_clone_start_failure,
-				  update_clone_task_finished,
-				  &pp);
+
+	if (max_jobs < 0)
+		max_jobs = config_parallel_submodules();
+	if (max_jobs < 0)
+		max_jobs = 1;
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
2.6.4.443.ge094245.dirty
