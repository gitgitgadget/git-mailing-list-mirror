From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] clone: add `--shallow-submodules` flag
Date: Tue, 15 Mar 2016 18:12:15 -0700
Message-ID: <1458090737-14030-2-git-send-email-sbeller@google.com>
References: <1458090737-14030-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de, pclouds@gmail.com,
	larsxschneider@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 16 02:12:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag00n-0007we-Rj
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 02:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934093AbcCPBM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 21:12:29 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35382 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbcCPBM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 21:12:27 -0400
Received: by mail-pf0-f182.google.com with SMTP id n5so51482683pfn.2
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 18:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IO0UfZmDIj9rTYM2U+RbmxuHPnwaN/m48wVHHgdjLjk=;
        b=LFezlrIyZ09OjzrgKr8zOyzkX1Y+6EcGIbV9bpcM9pZSkRvmZSoa+fpigRYxl9/TUS
         M2aslun0L3ObEugIvyKAxQ+XO9bYH9zRkCuLDTb+4T7VrXDWJDdrQEXwHW66e2gEvT9r
         Ny2MymxcQ68g42vtXIHVPuagBrBuYTTEkhEMJeRsHX0d62WkCELm32z7ITMp1+B+3NYF
         PYeiOlqakv/VkhI647Slgy2Xrb0KjKAk96FlbZLP+Rxv11d+C0XIHO5c1PeJ7hHvDz5z
         NIf22NgV6S9ycHLEcAKFqR9KMffRw5Q6qcDCTly9FvIT8nEMpAF5l8pxY4aUn6DA9OM3
         DH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IO0UfZmDIj9rTYM2U+RbmxuHPnwaN/m48wVHHgdjLjk=;
        b=TKVuOPbGx4XQ67yI3TIuk92KRI6lu+c1I2XXGJdrAY/qMdz6ElD73nBw834WfJHE5M
         48g0vuLur0AajX1P3wdjbP7JWV+R2507rjHZyeiRS18b6rBLQYZ3rllp6Bn0H+DCTrWU
         xZ06VPa4ApitlcA5gHL0q1OeeNSQ4AYOo+hJos4N4Zy83c3OmpvdBplECLCfeFpDcPKJ
         qgJkPN0QW4agi+0rW3IBNVnHUEUeuqB2wcC6z/CTMr1O4tq6e7f6rKvpwoPy7LIQtjnl
         WV+77/E5J9BElB7RnwkhjhDrqcpMn4mm/g9l1S1vlEV+Wj6qcxd9szds5R/YoffFqVtz
         ulkg==
X-Gm-Message-State: AD7BkJIxxaQ3I3WKE5/UxtQu/SC3KLIVyswS2uJXCYLoyzGcaGqsmor7Bw05mPkbuNF9uOTb
X-Received: by 10.98.80.78 with SMTP id e75mr1577758pfb.147.1458090746677;
        Tue, 15 Mar 2016 18:12:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f8a9:c435:807a:de5e])
        by smtp.gmail.com with ESMTPSA id m10sm642688pfi.32.2016.03.15.18.12.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 18:12:25 -0700 (PDT)
X-Mailer: git-send-email 2.7.0.rc0.42.g8e9204f.dirty
In-Reply-To: <1458090737-14030-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288938>

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
index b004fb4..ecdf308 100644
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
@@ -727,6 +730,10 @@ static int checkout(void)
 		struct argv_array args = ARGV_ARRAY_INIT;
 		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
 
+		if (option_shallow_submodules == 1
+		    || (option_shallow_submodules == -1 && option_depth))
+			argv_array_push(&args, "--depth=1");
+
 		if (max_jobs != -1)
 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
 
-- 
2.7.0.rc0.42.g8e9204f.dirty
