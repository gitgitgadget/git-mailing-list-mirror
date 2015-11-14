From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 8/9] submodule update: expose parallelism to the user
Date: Fri, 13 Nov 2015 17:07:01 -0800
Message-ID: <1447463222-12589-9-git-send-email-sbeller@google.com>
References: <1447463222-12589-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 02:07:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxPJa-0003cP-7D
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 02:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbbKNBHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 20:07:33 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34967 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbbKNBHX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 20:07:23 -0500
Received: by pacej9 with SMTP id ej9so8888520pac.2
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 17:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kFGRDGITcngYqCv8BHF9mfUiAzuJwXAUwmDN4RF/XSo=;
        b=bK1RENEs5f4IZKHbqpq+VNfzvSFbsme+Pz7LWa7vixeWRxkw0VP/ct7r+hJqn1YzY3
         6kcF66P2/pMQDLFo71dGVXJse/T1TqG++FhJp9W1C0SpYvRGiJF0kWyEUBbpBntrEN8Q
         9DqUhXS1A7iKGeQa0jDDbwRrCZYMMCuBKWCjFPU4emMIvfNxqD+zfTF9Rg+TFECX9Cw7
         WG8sisYyv3Her5WmTRnGogNAwu6Nj0NzUqjllefeIatBv1j6xu7LnbtSe+ac1qx+1J5u
         ov22+myM2OmH+ES9IqlCfo5tHqEMQiu80uOdrIPen86USS/+HXPDeUx9WZ/r9DPHoJBu
         kM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kFGRDGITcngYqCv8BHF9mfUiAzuJwXAUwmDN4RF/XSo=;
        b=TVxyrAmOhNzLcf+yjzJDVClGpp7xtZtODpHCHqFd+tVAW0KE1VDzMHl2prY1o6fMIp
         Zf3L+SbV/bpjSeW1YY+73aYShzbywe/GpBxEyLsIre//IeKzJEj9U5P3PjaF3Af/6XFb
         GoPcg6a0bcqEp8FgnGwKqeiV0uiUUz+YuH8xVIHc7pz/mDfHSNV9q5L3llykiqVH5HLX
         J2xSWPiL6yxUEGS6Zt1EU0r1tq7Zzk8yBsbi/KJshbFWjUYdXFGOE6TEBb+0/CDJan5+
         FWAK1Fm2h2jvGhyK2cy3yyyHtqlJG45gSHEGXxOYHQYOaNh4oe9aia7cGl1zawUK7M8w
         k1bQ==
X-Gm-Message-State: ALoCoQnMYI+PbKLRUeuePQBZMyyDFvXC4e4HqRISGg4IH9PevkOdX4+vg++7EgRowhIP/pvMOK8P
X-Received: by 10.66.55.105 with SMTP id r9mr36398839pap.137.1447463243033;
        Fri, 13 Nov 2015 17:07:23 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:f5eb:b7b9:3afa:a95c])
        by smtp.gmail.com with ESMTPSA id cn4sm22610296pbc.94.2015.11.13.17.07.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 13 Nov 2015 17:07:22 -0800 (PST)
X-Mailer: git-send-email 2.6.3.369.gea52ac0
In-Reply-To: <1447463222-12589-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281295>

Expose possible parallelism either via the "--jobs" CLI parameter or
the "submodule.jobs" setting.

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
index 95b45a2..662d329 100644
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
2.6.3.369.gea52ac0
