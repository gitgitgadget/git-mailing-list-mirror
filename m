From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] submodule update: Expose parallelism to the user
Date: Fri, 23 Oct 2015 11:44:38 -0700
Message-ID: <1445625879-30330-3-git-send-email-sbeller@google.com>
References: <1445625879-30330-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Oct 23 20:45:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZphKj-0005hb-52
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 20:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386AbbJWSov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 14:44:51 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34001 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173AbbJWSop (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 14:44:45 -0400
Received: by padhk11 with SMTP id hk11so125228960pad.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2015 11:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ufeHj0tAT8e1CZInzX884FfY3XbQ9KTI/fxcS3YfhmA=;
        b=edjyxQx/UzZBSC5KT8oypJJqbuNhhyFw1cYytbzpo1XYs9wv5h/2bKUj7HF7V3RMbc
         WSXgvAXWGl1jJLXWsjijRtKVXwYCoLfvmH3kIeMSrfedAyyDhlP1uLXR4wiN+U+P+lQF
         Vtwo16kpAIhD5du7kuz/J8s7Vlzo/BOGL1uV1eC3SgtZ9WkK6S3hKpjHX9MKNnGow20g
         RWv0Q84F4kkGpFqSRq9CqUfr3nySMgnqjRUDQDNuBGgt/se+ckLPrnVJzxjN6mAOEKCH
         V9KqL7s4/HnM9iWmhqLQEPV35gXBGvRINKjJrr9vS3Be/g5z7AHUY1hoTTpr7GOe8564
         KHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ufeHj0tAT8e1CZInzX884FfY3XbQ9KTI/fxcS3YfhmA=;
        b=f2mlN2rU4nQFPubAF4Tr9LZmXKn8+F4S1atjAtvXfuJQYFej0AGX6uTurqSW19rVnj
         BIScK0KZhBld/KX5HsB+Ld0zXvOKoZov5Oduq3htPQE3tHUqyBs6knnMoiPLWIDTpVi9
         cTMbtz0SiCCTAcIeI0CgoT1yxY12GxExFAyRaOad5bY0mBWjQZrJc+5/4L9uagD9wE7s
         828vM20iegvXGmj8wNdjJWPeEBTUaa6It9/uNjfpJCxuZhXRxb8bwUz7tByjcRZHs3S+
         U0+PQ7sM5g0cRRrCVEvV+pOKgedxZBcljERmNSfjDDjxQ7Gw/QVd7lPLWU3SuwIMjzhj
         KlVg==
X-Gm-Message-State: ALoCoQmDNhvilfdWk+5iM/8YhNTzoxhtjmHl55pZoEbCddTQn8iiGuX1pgU3Zl9iPEHJ2/XgNeiP
X-Received: by 10.68.200.35 with SMTP id jp3mr6634920pbc.122.1445625884815;
        Fri, 23 Oct 2015 11:44:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7d77:bdba:3237:8a09])
        by smtp.gmail.com with ESMTPSA id iy1sm20195586pbb.85.2015.10.23.11.44.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 23 Oct 2015 11:44:44 -0700 (PDT)
X-Mailer: git-send-email 2.6.2.280.g74301d6
In-Reply-To: <1445625879-30330-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280104>

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
 3 files changed, 27 insertions(+), 5 deletions(-)

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
index e6bce76..4888e84 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -422,6 +422,7 @@ static int update_clone_task_finished(int result,
 
 static int update_clone(int argc, const char **argv, const char *prefix)
 {
+	int max_jobs = -1;
 	struct string_list_item *item;
 	struct submodule_update_clone pp = SUBMODULE_UPDATE_CLONE_INIT;
 
@@ -442,6 +443,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &pp.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
+		OPT_INTEGER('j', "jobs", &max_jobs,
+			    N_("parallel jobs")),
 		OPT__QUIET(&pp.quiet, N_("do't print cloning progress")),
 		OPT_END()
 	};
@@ -463,10 +466,16 @@ static int update_clone(int argc, const char **argv, const char *prefix)
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
-- 
2.6.2.280.g74301d6
