From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 7/8] submodule update: expose parallelism to the user
Date: Wed, 28 Oct 2015 16:21:43 -0700
Message-ID: <1446074504-6014-8-git-send-email-sbeller@google.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
 <1446074504-6014-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 00:22:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zra2u-00033w-EU
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 00:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756444AbbJ1XWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 19:22:12 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34995 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756410AbbJ1XWI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 19:22:08 -0400
Received: by pasz6 with SMTP id z6so20297273pas.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 16:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WXIuBG4+9MKQIeJ5AjEhdNiFqtXKgCdR2s52Noj/sEo=;
        b=WMF91l01jdle3vkzNvDtH/v+pJKDYUMFhgTydiY25wFFuTj+6ZqHq/PMPxpdkG4+Kt
         o0w/V5ZFlX43mKoPcCC4qBP/mWnUrb8i8Sj8qMeIg6r36HE5EBFUfQGlWkauwNLjHE2Y
         /mkHJXS2gBmDqmuRzJpwI5BfITzIORpfkzzzCbYluc7USrm4gyaOYHqwA3EBboPVPacn
         UzofyZ21pkQ6DakSbfMVbut8DGuAQO+1W6GplTyPy8b4RAST9YIthzseYbvwvBDZa5jx
         xMgLsUS2ctmgHwTUTBGwdLnEO5LEyzAlUt7NK3ko+K+gvnp00lG7UfRHrtx1FCdmCi7t
         FNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WXIuBG4+9MKQIeJ5AjEhdNiFqtXKgCdR2s52Noj/sEo=;
        b=K8M9n4bYjcHIV9TVv6Hz38RhFQ6lYrafGHWTANkCWku3uLHMQiAXpI7/sldEnT5XlO
         MazhEhGkY0NKpTFKTpm8+FxHA5Fs9ciLfgpYSEhULT1Qe5WavnsrxcBtyA8OgwzWBIfU
         uOILLlRUnrpjhiTA51JheO5NCmF0CKYiDfXxr3ZBevBem2AmCDXfKxjRQ+yk3Pn+DtFV
         6KcFspRi40FKG9cWI432KJ+dnlsdDwxIXU/eucbpCgxEIPP6NQMyZoUi3/m5EnMSBMIm
         VbDgGkHB6wpuLrwpnjJqUDVfewqi87E+K2hS871OgDsoWdFyCz4LYqL8oN1Ggj/+hajs
         MNdQ==
X-Gm-Message-State: ALoCoQmIYhr4wNyPUuiv6UEr34ShAsFGOPsXjNNa8yTVfdlKPU9Tc9K/OmQtk7omJ6UfVZdkl8Lb
X-Received: by 10.68.109.34 with SMTP id hp2mr29650183pbb.9.1446074527901;
        Wed, 28 Oct 2015 16:22:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:202f:ecb0:ea3e:b8f7])
        by smtp.gmail.com with ESMTPSA id bt1sm5090439pbb.88.2015.10.28.16.22.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 Oct 2015 16:22:07 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.281.g4ed9cdb
In-Reply-To: <1446074504-6014-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280425>

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
index f17687e..c70fafd 100644
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
+	Defaults to the `submodule.jobs` option.
 
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1ec1b85..67dba1c 100644
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
@@ -472,10 +475,17 @@ static int update_clone(int argc, const char **argv, const char *prefix)
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
2.5.0.281.g4ed9cdb
