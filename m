From: Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH] clone: add `--shallow-submodules` flag
Date: Fri, 11 Mar 2016 15:41:23 -0800
Message-ID: <1457739683-1972-1-git-send-email-sbeller@google.com>
Cc: larsxschneider@gmail.com, jrnieder@gmail.com, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 12 00:41:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeWgX-0001N3-DM
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 00:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbcCKXl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 18:41:29 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35379 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbcCKXl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 18:41:27 -0500
Received: by mail-pa0-f42.google.com with SMTP id td3so83793906pab.2
        for <git@vger.kernel.org>; Fri, 11 Mar 2016 15:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=y9ttLXm4RwHDPOg4eEKlVooqGZOMlUMjZMhYoFldFvo=;
        b=EfPrtX12Ibf8oirHCTgV/EyQdvqvV8UmMNCuAg48VPCBQQ4yGLFHS85JSo/cVISdzQ
         /l3MIoV3juG7HHZkPWakWGhs7847T+9UvktaF03PAstFV0assqY3Ba57wShetf+0KOBL
         2eUMXT2n8MPLRFP1EhB7HngYAQ3wIJhWF1W+rEihDEFNBG/eyhixchyNrbez2m6wltzq
         9jrYXPLoY0bd/tcG9winYGyZA3dHRQ83ExcTSDme+9IJg5+JIb1FOPKdDep8mL1dxT4a
         lTqIMScisHu2dYRgB8jNH3gTPzNovy3+KQrfeEL/hBXtsxFRaT/V3S5yKEZiIrI/0aoE
         K/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y9ttLXm4RwHDPOg4eEKlVooqGZOMlUMjZMhYoFldFvo=;
        b=lgiHlHY8t9ylqoPotglNEvwVnONfzQE/SBJFtQuVnA6PgOe3Jf/cB+TcM3R8O3ExWe
         AVQgQEs6+p1Htlb66YOZKcCe0FIAbakpOxofzpDeBYPVNUBIx0PqfFhw7YuaH309IGRg
         ryEU7eKL1flYtlJjmArZJ9BDyo+FqFjHUtt/Rfe9Dj8tWlN7i3Lz1WIdabB9bxdPOaiq
         XpVHIWPooghCiq3iuTVZ5sFbzXYkziluwGxwpREZV82fJjFEU8Nn0hjBD4cYrixt4quB
         5mlCl6pKDgnid5EHFNx1IVUlUxChUU2lGTDBoiJKZckQSgeNL48S7tJpfmfMyjn5TJDq
         unNg==
X-Gm-Message-State: AD7BkJLzmpDASoPEG2ADx1ocAJhn6sU46GvN/sE+It4D7T1fEz0x4iO+HM6vBHE/LbfU2V2s
X-Received: by 10.66.191.202 with SMTP id ha10mr19959494pac.8.1457739686971;
        Fri, 11 Mar 2016 15:41:26 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:8cc:f6f0:d9f0:1172])
        by smtp.gmail.com with ESMTPSA id d28sm15361822pfj.68.2016.03.11.15.41.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 11 Mar 2016 15:41:26 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.42.g42a5408.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288720>

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
A few notes:
 * This applies on top of sb/submodule-parallel-update
 * I am aware of the current release cycle, and I ought to not add shiny
   new features. But scanning the list revealed no bugs I could jump at to fix.
 * Lars made some unit tests for a very similar case a few weeks ago, but they
   were not applied as there was no intention to fix it. So I am hoping we can
   reuse some of these tests for this patch.
 * Currently I have the opinion that thinking about (un)shallow projects should
   be rather binary.  Either you want the full history or you want as least as
   possible. (Who wants to have a --depth 42? Some people have argued that you
   can use the depth to avoid large binaries which were part of the history in
   the past. But I'd counter that argument by pointing out the --depth argument
   is a workaround for such a use case. What you really want in that situation
   is a setting to clone history since a certain point in time/DAG, or a setting
   to clone up to a certain depth such that the filesize of the packed objects
   is smaller than some threshold.)
   
   If we were to allow specifying the depth for submodules, we'd need to discuss
   how to specify them for individual submodules i.e. clone submodule A with
   depth 4 and submodule B with depth 10. but that problem is solved easier
   by first doing a shallow clone with depth 1 of all submodules and then deepen
   them individually.
   
   So binary shallowness (depth = 1 or infinity) it is.

Thanks,
Stefan

 Documentation/git-clone.txt | 13 ++++++++++---
 builtin/clone.c             |  6 ++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

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
index b004fb4..cfa01fe 100644
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
@@ -727,6 +730,9 @@ static int checkout(void)
 		struct argv_array args = ARGV_ARRAY_INIT;
 		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
 
+		if (option_shallow_submodules && option_depth)
+			argv_array_pushf(&args, "--depth=1");
+
 		if (max_jobs != -1)
 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
 
-- 
2.7.0.rc0.42.g42a5408.dirty
