From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv18 10/11] submodule update: expose parallelism to the user
Date: Thu, 25 Feb 2016 15:08:27 -0800
Message-ID: <1456441708-13512-11-git-send-email-sbeller@google.com>
References: <xmqqoab4mnoc.fsf@gitster.mtv.corp.google.com>
 <1456441708-13512-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 26 00:09:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ52C-0008Fv-DC
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414AbcBYXJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:09:21 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35732 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbcBYXJM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:09:12 -0500
Received: by mail-pa0-f42.google.com with SMTP id ho8so40885304pac.2
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bzwcnaYptYuY9KZ67eyN6iS+H214DcghX0hu6JcAoGo=;
        b=Z7U0410fayNGcj9GoGYqc24aph1rLNnzxLO1IXYKwPQiL7TvvPOWhU0fMBwOcl++Fw
         a3Xm2tkshA5z5hc1qdNRk+vLH6B503a02RtO0J+7yXAe6+ci/LxS3pa/xRQmI681Xy4G
         ImeFfUStV8VoAruaGdWIWtdmJORmRjWXIxuFpXm0USNijdb7eRVTTCEWz4K7hjuGXmDT
         CT4QSDB5qot+ntR0IyQSrjhQ6Z1j/MRms2sIyalD34lXpiy4z+0EL5tSLzdoyvAXXD5T
         qVxu+dAgl9YWaKUkX3Xiu7/wiYqs/3Jcxh6qV90DgsoGjfnV5AbFKCElggsseQLqEQ14
         HYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bzwcnaYptYuY9KZ67eyN6iS+H214DcghX0hu6JcAoGo=;
        b=T5FmXKMRzFNagQkDuKSrbmx+5MFLjBRQce2kv4EyFF8f6HXl36cBMkoNqHB/5404IX
         Cz+2bHgeuobKgwPHdqHwCRU5mQJIRkLTKr89uapacRMsiCzAcV/w51CWqmAKj/ZnhbPe
         0kcJzjgi9Tk4Nj4zSbsp/sgrLcuphfvS7OfIagDEPC2WXCfXP/dk5R1yT+2kSRXylD1o
         9A1cJzp0SoYJ+se1Yz7Kmr+CwaCB0Hk1Ab9doi6pLhjkviDZu1LAUlN74Wd/Q42BtZCT
         DHTaiJBXdqm8mR3u25Y/oQUDl5vMTSIi9YUirFVGmSH5RjwkJYDVTmOwo4WXrDX6DoNp
         bP0w==
X-Gm-Message-State: AG10YOQYAdMRDAnLhcLVKZsEIYiURJ6uzAMQ9J14Tm+2vH/TBPouNTcoy+0HOS5v6+xQyPam
X-Received: by 10.67.5.9 with SMTP id ci9mr66938652pad.101.1456441752015;
        Thu, 25 Feb 2016 15:09:12 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a893:1c03:aadb:c3d])
        by smtp.gmail.com with ESMTPSA id v7sm14511318pfi.56.2016.02.25.15.09.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 15:09:11 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.36.g75877e4.dirty
In-Reply-To: <1456441708-13512-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287481>

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
index c852554..882aeca 100644
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
2.7.0.rc0.36.g75877e4.dirty
