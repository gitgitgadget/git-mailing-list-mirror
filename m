From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] clone: add `--shallow-submodules` flag
Date: Tue, 12 Apr 2016 16:48:48 -0700
Message-ID: <1460504929-19208-3-git-send-email-sbeller@google.com>
References: <1460504929-19208-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 01:49:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq83Q-00039d-GH
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965980AbcDLXtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:49:03 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34182 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965122AbcDLXsz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 19:48:55 -0400
Received: by mail-pf0-f174.google.com with SMTP id c20so22734270pfc.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 16:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Udw8utPcOspajSfttxk2G0u9OybiLMGJje/MHjSqyT8=;
        b=B3HrXtZOpOgjazN/qN4iBH4Ygk3XPa6+PS/pwHquZ1slbkqYxNX3oxdfSlMRK46sjo
         YYH/72ITf0syRR7IDaXOSVcTFcjjxwuVKaQnqyewGXGfg46+zt22M7IG6PBlu55SvRMZ
         3RjaFmmtrs9UK488+0jUnu+o5lWqT2hbt1fkUzWsPf3O2bL0pLfya5x7wrxEGPCf456i
         H7kkVRCJCVrEUSJI9rBbIlgrwFqX1RjP5DscexDaDmJETrvLsePPeAtSYeAJAMHz1Lke
         roCI80nXKysNVAGZJQlmuZAOJG9b0gm21VaJ6PSI9BliO9TcMnrTwSLOhr3+0fNROUCu
         zvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Udw8utPcOspajSfttxk2G0u9OybiLMGJje/MHjSqyT8=;
        b=NQwtgeImzvYIOpxPYilLBXCsujs+RpjOQwrdXfWTio+XkFHBkB+9195tQHVk/8Jnc2
         RlE6Glqwphph33ON+wvpXd4C8d5bYus603nAV7uCe9VyHKTrbnrK/JXDGjh5g2DoeM2t
         b4G2Bj2XmA+Zb25gTnHE0o3wvTQ9jnZ4RTQUnhJ3JerS/n9WfIonYDbaVyp0s3pmBAGc
         5UuhKMpUqSfm20Mi9rqYSW4bp6di5EU3TTZHASqdFCFRTX2x9pcHXyHQ9OZpuvCVoM5W
         SybGEEuVzKJZ12pLyh0IIfoFIl8I1WO4YnB33pi8YYrqUmhoFHdrQ0WqiTMjZeQg7aBy
         8gDQ==
X-Gm-Message-State: AOPr4FUk7VYr2ujS5PDY79tVzrDZdRefO8RWVFGOna9Kaep/h6jBwEDf1+M4Vr5fZSmJLjFX
X-Received: by 10.98.65.215 with SMTP id g84mr8508181pfd.94.1460504934589;
        Tue, 12 Apr 2016 16:48:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:705c:1d3d:8d56:4629])
        by smtp.gmail.com with ESMTPSA id d19sm46084800pfj.92.2016.04.12.16.48.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 12 Apr 2016 16:48:54 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.gc776916.dirty
In-Reply-To: <1460504929-19208-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291329>

When creating a shallow clone of a repository with submodules, the depth
argument does not influence the submodules, i.e. the submodules are done
as non-shallow clones. It is unclear what the best default is for the
depth of submodules of a shallow clone, so we need to have the possibility
to do all kinds of combinations:

* shallow super project with shallow submodules
  e.g. build bots starting always from scratch. They want to transmit
  the least amount of network data as well as using the least amount
  of space on their hard drive.
* shallow super project with unshallow submodules
  e.g. The superproject is just there to track a collection of repositories
  and it is not important to have the relationship between the repositories
  intact. However the history of the individual submodules matter.
* unshallow super project with shallow submodules
  e.g. The superproject is the actual project and the submodule is a
  library which is rarely touched.

The new switch to select submodules to be shallow or unshallow supports
all of these three cases.

It is easy to transition from the first to the second case by just
unshallowing the submodules (`git submodule foreach git fetch
--unshallow`), but it is not possible to transition from the second to the
first case (as we wouldd have already transmitted the non shallow over
the network). That is why we want to make the first case the default in
case of a shallow super project. This leads to the inconvenience in the
second case with the shallow super project and unshallow submodules,
as you need to pass `--no-shallow-submodules`.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-clone.txt | 13 ++++++++++---
 builtin/clone.c             |  7 +++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 6db7b6d..20a4577 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -14,8 +14,8 @@ SYNOPSIS
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch]
-	  [--recursive | --recurse-submodules] [--jobs <n>] [--] <repository>
-	  [<directory>]
+	  [--recursive | --recurse-submodules] [--[no-]shallow-submodules]
+	  [--jobs <n>] [--] <repository> [<directory>]
 
 DESCRIPTION
 -----------
@@ -190,7 +190,11 @@ objects from the source repository into a pack in the cloned repository.
 
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
-	specified number of revisions.
+	specified number of revisions. Implies `--single-branch` unless
+	`--no-single-branch` is given to fetch the histories near the
+	tips of all branches. This implies `--shallow-submodules`. If
+	you want to have a shallow clone, but full submodules, also pass
+	`--no-shallow-submodules`.
 
 --[no-]single-branch::
 	Clone only the history leading to the tip of a single branch,
@@ -214,6 +218,9 @@ objects from the source repository into a pack in the cloned repository.
 	repository does not have a worktree/checkout (i.e. if any of
 	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
 
+--shallow-submodules::
+	All submodules which are cloned, will be shallow.
+
 --separate-git-dir=<git dir>::
 	Instead of placing the cloned repository where it is supposed
 	to be, place the cloned repository at the specified directory,
diff --git a/builtin/clone.c b/builtin/clone.c
index 7453244..bd1d598 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -40,6 +40,7 @@ static const char * const builtin_clone_usage[] = {
 
 static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
 static int option_local = -1, option_no_hardlinks, option_shared, option_recursive;
+static int option_shallow_submodules = -1;
 static char *option_template, *option_depth;
 static char *option_origin = NULL;
 static char *option_branch = NULL;
@@ -91,6 +92,8 @@ static struct option builtin_clone_options[] = {
 		    N_("create a shallow clone of that depth")),
 	OPT_BOOL(0, "single-branch", &option_single_branch,
 		    N_("clone only one branch, HEAD or --branch")),
+	OPT_BOOL(0, "shallow-submodules", &option_shallow_submodules,
+		    N_("any cloned submodules will be shallow")),
 	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
@@ -741,6 +744,10 @@ static int checkout(void)
 			die("BUG: option_local out of range");
 		}
 
+		if (option_shallow_submodules == 1
+		    || (option_shallow_submodules == -1 && option_depth))
+			argv_array_push(&args, "--depth=1");
+
 		if (max_jobs != -1)
 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
 
-- 
2.5.0.264.gc776916.dirty
