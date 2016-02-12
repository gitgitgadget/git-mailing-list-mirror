From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv11 6/7] submodule update: expose parallelism to the user
Date: Fri, 12 Feb 2016 15:34:39 -0800
Message-ID: <1455320080-14648-7-git-send-email-sbeller@google.com>
References: <1455320080-14648-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Sat Feb 13 00:35:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUNEp-0005Uj-JS
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 00:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbcBLXez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 18:34:55 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33038 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbcBLXex (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 18:34:53 -0500
Received: by mail-pf0-f174.google.com with SMTP id q63so54711969pfb.0
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 15:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o6GsKOdlaR/bkM+rkE9FyBUZS858nVYs1XYEFBXoI54=;
        b=hruDanuUQ/APYYXcDQpqTmH0hIkmG673MxpYgiY4/huO0VbbJmR81k3rUirTHKkv4c
         Xna5RVxJEEVaNuuOTq3lUpHCq9wztZKc4NTa0bt0wrtP3QU1fg7PhKVYcmfELkxoCGZk
         RqBs+t47S5wP2O7XSlYsgznBffsX89qNM/T3DZa81nLhUyNau6e0IOIJl/pwBz+/yL30
         IxzpN2uDrlP+z0SvD36xny+hbv+CGOEIPVX6g8oilMRM1kH2Yo3T9n38xgzUOMzUKU0i
         AQW3/HlqMyLG8siK9qRLW1O9ByF2sjg0BWImR6OkliR5bzq2rgPSlyB8HfywSut0+06f
         mqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o6GsKOdlaR/bkM+rkE9FyBUZS858nVYs1XYEFBXoI54=;
        b=EBi2dEb3dPXft277B3UnHjeN/shRxPApI3dVEPuj0CijPB+E53KD3zaxnuLzIL1pU0
         SmTvCC8s7xbDmy7tYpJQQoJ4GMj+HBqG8Syqiz8J8/m6IrGke//S8AnFgzPJFQxVFYgw
         D81gMXv82ApVaVNCeckxcqpcoxg7VIcIvXOK4VZ6E7L0tyfDMVtGDeKC0czFetGf7D5l
         FvluhP5bMKbBI4iv6zwLSExvNgzSHCdXv7AtuECrpJi4X8duC7wra25UaVm4YF27FUP6
         lz4hcb014bbSfya5DplQrbT/1EPYYvqDn7ztC53Sgw4oH7k35PKhyePRFyCEwaVlaMlS
         dXkA==
X-Gm-Message-State: AG10YOQP1OSMFYkMWkevaYXwIjKUh+XsRO0GKkzjwruNi9gr95Llh6HPB9NOWevEFV4+hgMm
X-Received: by 10.98.72.193 with SMTP id q62mr5976603pfi.117.1455320092353;
        Fri, 12 Feb 2016 15:34:52 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:f1e7:203f:9d1e:8193])
        by smtp.gmail.com with ESMTPSA id l62sm21858821pfj.7.2016.02.12.15.34.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 Feb 2016 15:34:51 -0800 (PST)
X-Mailer: git-send-email 2.7.1.292.g18a4ced.dirty
In-Reply-To: <1455320080-14648-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286088>

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
index 7629a41..65bdc14 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -424,6 +424,7 @@ static int update_clone_task_finished(int result,
 static int update_clone(int argc, const char **argv, const char *prefix)
 {
 	const char *update = NULL;
+	int max_jobs = -1;
 	struct string_list_item *item;
 	struct submodule_update_clone pp = SUBMODULE_UPDATE_CLONE_INIT;
 
@@ -444,6 +445,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &pp.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
+		OPT_INTEGER('j', "jobs", &max_jobs,
+			    N_("parallel jobs")),
 		OPT__QUIET(&pp.quiet, N_("do't print cloning progress")),
 		OPT_END()
 	};
@@ -469,10 +472,15 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	gitmodules_config();
 	/* Overlay the parsed .gitmodules file with .git/config */
 	git_config(submodule_config, NULL);
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
