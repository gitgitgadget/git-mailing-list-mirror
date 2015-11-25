From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 8/9] submodule update: expose parallelism to the user
Date: Tue, 24 Nov 2015 17:14:55 -0800
Message-ID: <1448414096-22021-9-git-send-email-sbeller@google.com>
References: <1448414096-22021-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 02:15:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1OgG-0001NO-6y
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 02:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188AbbKYBP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 20:15:29 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34669 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754941AbbKYBPM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 20:15:12 -0500
Received: by padhx2 with SMTP id hx2so39244706pad.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 17:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rJt0FbScqP+A5lG5e6WsNf8/R3a+/G3w0puV/yOSwtg=;
        b=FsKmdXPVGgtH5UnyEQpvCO5h1tyHO/QmcIPksCrr4vi6RJAnnRc15EpUlw836FhTOj
         dA9V1DOuZxA4qmzPx4iQfObsDMNjpREC6myOtSIMhmTyFi+8Fan9TVFPHM3IcQoTCAm0
         0tCzrYsPG1/Wh/i65wcB0fzmrLGelH2Jhl48XFthHtJ7MGLwsHAepFhmvvW9kKM4Ift6
         9qNLz2QhbGhVSoZz4a2MeSsZGZTqi0SBaBeiSscGv9+TXj13D4QiiMFNPStpTu3wAq4r
         EvtpHRPspPtsW7pWKBCqbnAgG4mAp9lns747uA+QmCdUYNcHdSbyOjkHmXbWG/sJTNsx
         z25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rJt0FbScqP+A5lG5e6WsNf8/R3a+/G3w0puV/yOSwtg=;
        b=RJZ0HLOjN24JNx2FLSwI+PQ3OX6YEXKpVdvAPD3It0inb1x54nMvSn3U3e4lsPEOB7
         37DJ8b65eYg2nsD7hvm4EsAXZm6P4ZgixeWUQ7ckmSPsnFXS4kjaOOh0WfD89DwQcqMF
         qSLZqxgNMVUgNuOWR21mDxVXi7ALt1xac0rYhWR/htGSsodGIBXhPD205eW7dOx5uuwm
         om19NQpZTc7FXNDhV0fGEEtFubS3anOq7cKlCOTkp1sXl/5K48DccZDeTwAhijMr2K8p
         HTz6tRtIKnhLDya812nyq++GvOjOCaVHMqu2531L8e0NN9z/ACunLRJZSvll31gsQ5zP
         1C1A==
X-Gm-Message-State: ALoCoQlGSt5HfLIWue6vFjXMftJAhTMTfTOG5wp1XJamhunOL5ETpTOd4nQrNM0Xhn/AlyxVtdcW
X-Received: by 10.66.194.198 with SMTP id hy6mr20343789pac.34.1448414112083;
        Tue, 24 Nov 2015 17:15:12 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5407:71cc:c14:4343])
        by smtp.gmail.com with ESMTPSA id n28sm16770924pfb.8.2015.11.24.17.15.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 17:15:11 -0800 (PST)
X-Mailer: git-send-email 2.6.1.261.g0d9c4c1
In-Reply-To: <1448414096-22021-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281665>

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
index f17687e..a87ff72 100644
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
@@ -374,6 +374,11 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
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
index 27363fa..254824a 100644
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
2.6.1.261.g0d9c4c1
