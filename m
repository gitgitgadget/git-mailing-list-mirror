From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/9] submodule update: expose parallelism to the user
Date: Tue, 27 Oct 2015 11:15:49 -0700
Message-ID: <1445969753-418-6-git-send-email-sbeller@google.com>
References: <1445969753-418-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 19:16:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr8nP-0003IA-3x
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 19:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbbJ0SQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 14:16:24 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36112 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965090AbbJ0SQH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 14:16:07 -0400
Received: by pacfv9 with SMTP id fv9so239722536pac.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ifRYjDHt9wGYLAfT0+KisYLd+G/EPTGMV1RMENB1Omo=;
        b=eecRgPz8/6EIqBekHrN9SLbQ8E3QcFxWUDI62hHneC4ucUUrTUtSzKEdJkmLySTYLI
         agw5BSj55v6258jE16JRLKuI/qLeAY224HYsN5PyA8BZQeN43/j2sWNK7dbB8YItLn5F
         XyGIeAmGfDIdyUmgm1UybFsmTqMdowt9riVnUzgPtgEdhYk3Ilf/Cs3vs/SQmQlpQJf6
         hWs7KejyJX3r429E+iks5MO3gqSffcLr6gT307zOnXyXphD7GH5sptvCXuDGYNL9vDE5
         75kUV2qTVAzKjp6eNQCCkrk/iaZqf/CD9hzKUHBFV6itd7GRzm1KMLwEbuOGOHGoPzS0
         KXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ifRYjDHt9wGYLAfT0+KisYLd+G/EPTGMV1RMENB1Omo=;
        b=IaA9rFWLu6wGElt/p2Tb04Jt5CM4vxwlbddCMF/upuk6sDDF1+n4bcYfrcsiRsgKfH
         zQywTPsjI1glHD+5fkDrLqf5+g0ytZkqlm+rDxd9YRZ0gp61NaZmyLuUZ65DrGVij0+M
         vCmWQ09FjlAx9o3qibODENENS/hSnR6YvJruVJiHPwaOnjfdmW12IqSxH530La5MZXWC
         9nmKswX3ns23kOmeEKnS2d2jmjperjfOwd75aGGwOjNc1hOXoP06oFynFrNpAHEv26sw
         vWrBERQcMoNO1RbNvq/AlGVdx2RuvOBirtNIy0OBqWrwXjVg+IibAO9Eu2XK10zn4bBZ
         3IjA==
X-Gm-Message-State: ALoCoQmKqWi3T1obxXJynVxN+wG1myftbcnk+gQ0DRRwaP7derM3jYddp4CyN+IXKBNgJNNc7xmF
X-Received: by 10.68.217.41 with SMTP id ov9mr29642532pbc.118.1445969767072;
        Tue, 27 Oct 2015 11:16:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:582c:77b:3135:2d26])
        by smtp.gmail.com with ESMTPSA id sx1sm40877935pbc.36.2015.10.27.11.16.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 27 Oct 2015 11:16:06 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.283.g1a79c94.dirty
In-Reply-To: <1445969753-418-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280280>

Expose possible parallelism either via the "--jobs" CLI parameter or
the "submodule.jobs" setting.

By having the variable initialized to -1, we make sure 0 can be passed
into the parallel processing machine, which will then pick as many parallel
workers as there are CPUs.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt |  6 +++++-
 builtin/submodule--helper.c     | 17 +++++++++++++----
 git-submodule.sh                |  9 +++++++++
 t/t7406-submodule-update.sh     | 12 ++++++++++++
 4 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index f17687e..f5429fa 100644
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
@@ -374,6 +374,10 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
 	clone with a history truncated to the specified number of revisions.
 	See linkgit:git-clone[1]
 
+-j::
+--jobs::
+	This option is only valid for the update command.
+	Clone new submodules in parallel with as many jobs.
 
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1ec1b85..c3d438a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -431,6 +431,7 @@ static int update_clone_task_finished(int result,
 
 static int update_clone(int argc, const char **argv, const char *prefix)
 {
+	int max_jobs = -1;
 	struct string_list_item *item;
 	struct submodule_update_clone pp = SUBMODULE_UPDATE_CLONE_INIT;
 
@@ -451,6 +452,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &pp.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
+		OPT_INTEGER('j', "jobs", &max_jobs,
+			    N_("parallel jobs")),
 		OPT__QUIET(&pp.quiet, N_("do't print cloning progress")),
 		OPT_END()
 	};
@@ -472,10 +475,16 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	gitmodules_config();
 	/* Overlay the parsed .gitmodules file with .git/config */
 	git_config(git_submodule_config, NULL);
-	run_processes_parallel(1, update_clone_get_next_task,
-				  update_clone_start_failure,
-				  update_clone_task_finished,
-				  &pp);
+
+	if (max_jobs == -1)
+		if (git_config_get_int("submodule.jobs", &max_jobs))
+			max_jobs = 1;
+
+	run_processes_parallel(max_jobs,
+			       update_clone_get_next_task,
+			       update_clone_start_failure,
+			       update_clone_task_finished,
+			       &pp);
 
 	if (pp.print_unmatched) {
 		printf("#unmatched\n");
diff --git a/git-submodule.sh b/git-submodule.sh
index ea883b9..c2dfb16 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -636,6 +636,14 @@ cmd_update()
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
@@ -661,6 +669,7 @@ cmd_update()
 		${update:+--update "$update"} \
 		${reference:+--reference "$reference"} \
 		${depth:+--depth "$depth"} \
+		${jobs:+$jobs} \
 		"$@" | {
 	err=
 	while read mode sha1 stage just_cloned sm_path
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index dda3929..05ea66f 100755
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
+	 grep "7 children" trace.out &&
+	 git config submodule.jobs 8 &&
+	 GIT_TRACE=$(pwd)/trace.out git submodule update &&
+	 grep "8 children" trace.out &&
+	 GIT_TRACE=$(pwd)/trace.out git submodule update --jobs 9 &&
+	 grep "9 children" trace.out
+	)
+'
 test_done
-- 
2.5.0.283.g1a79c94.dirty
