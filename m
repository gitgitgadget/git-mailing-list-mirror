From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] clone: add `--shallow-submodules` flag
Date: Mon, 25 Apr 2016 18:12:27 -0700
Message-ID: <1461633147-23131-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, larsxschneider@gmail.com,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 26 03:12:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aurYS-00017R-3D
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 03:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbcDZBMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 21:12:40 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33748 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbcDZBMj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 21:12:39 -0400
Received: by mail-pf0-f180.google.com with SMTP id 206so48740pfu.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 18:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=WLldCE9b9aN8fRAS9BBFs2nEO8bbkvuCFhEcNFEjDVw=;
        b=B+Iudm9gUi4d5LTzkCIno7SxYbYS2WQ+yKneOxzc0B3IWQEwY9/lZXbBuEDczmBvKX
         T1qHiuHoTc9AMATABZeFwVVd4eIcw0qON/r79Hug1Rn9WugEeIjxFIwZKfJtHaOPCjV2
         Xah3YlczVH0luzBGgE9HOqKcnphlEJ3U99oxBjdBAXa7CD03g1oEqkbHYXRgDoMT9ccm
         PwqoOrXuaNWBz6sLucJPRLzEoDHvG2Frft8jxO13epYTPd4w74qFCVuySpWeX0za++8z
         VdsXv8+nHfC6vbDmOemrk5XU1kMg6yw/0IXkH5yCwxDof/KoMFFDa/S+7uI10ABx6dWO
         nB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WLldCE9b9aN8fRAS9BBFs2nEO8bbkvuCFhEcNFEjDVw=;
        b=FmavKLK70xUqe73oiDpeaQlBQqev15yRV2h7cYyUxm3KuJ6I89ks/mQCPIM1/I3kVQ
         3WY0Riyj3LSKmramLbAIwVHL1GGm/5IP4oV7kPqOcKKJ974yOclUvTJTTpCGglJ8VjZn
         3DQZ/aeU21jhEKAKKzdZQ7YfKLlxz8P4T2cdovhYHxT+cRLHOP+B0utA0xAYDm3XwRP2
         KDl89psPiEVsBRPzRnvt7S/XCtOWI7t9fwJzPCtxUaoHQ1RiMlvP9KcjqIPTfMI45qnz
         VxTOHJZvmh1QobPUjj1QLhjZjN3KKvnbxSvfszVj6H5/N6f/CUz45MRQry6oyYuYfpWR
         QqnQ==
X-Gm-Message-State: AOPr4FX5jC3k+NLYxn5qya4e0OFyBrd+ASQitfal4rjefGQKQNR0iH5UWvLIBmicYIb6K72W
X-Received: by 10.98.9.219 with SMTP id 88mr1310724pfj.0.1461633158413;
        Mon, 25 Apr 2016 18:12:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:74a9:80aa:70b5:e])
        by smtp.gmail.com with ESMTPSA id x184sm31774942pfb.53.2016.04.25.18.12.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 18:12:37 -0700 (PDT)
X-Mailer: git-send-email 2.7.0.rc0.39.gcbc760b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292582>

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
first case (as we would have already transmitted the non shallow over
the network). That is why we want to make the first case the default in
case of a shallow super project. This leads to the inconvenience in the
second case with the shallow super project and unshallow submodules,
as you need to pass `--no-shallow-submodules`.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 This is origin/sb/clone-shallow-passthru, with $pwd instead of $p
 in the tests.
 
 I did not rebase this on 85705cfb (Merge branch 'ss/clone-depth-single-doc',
 2016-01-20) or later, but worked on it with the base unchanged.

 Documentation/git-clone.txt | 13 +++++--
 builtin/clone.c             |  7 ++++
 t/t5614-clone-submodules.sh | 85 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 3 deletions(-)
 create mode 100755 t/t5614-clone-submodules.sh

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 6db7b6d..e1a21b7 100644
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
+	you want to have a shallow superproject clone, but full submodules,
+	also pass `--no-shallow-submodules`.
 
 --[no-]single-branch::
 	Clone only the history leading to the tip of a single branch,
@@ -214,6 +218,9 @@ objects from the source repository into a pack in the cloned repository.
 	repository does not have a worktree/checkout (i.e. if any of
 	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
 
+--[no-]shallow-submodules::
+	All submodules which are cloned will be shallow with a depth of 1.
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
 
diff --git a/t/t5614-clone-submodules.sh b/t/t5614-clone-submodules.sh
new file mode 100755
index 0000000..62044c5
--- /dev/null
+++ b/t/t5614-clone-submodules.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+
+test_description='Test shallow cloning of repos with submodules'
+
+. ./test-lib.sh
+
+pwd=$(pwd)
+
+test_expect_success 'setup' '
+	git checkout -b master &&
+	test_commit commit1 &&
+	test_commit commit2 &&
+	mkdir sub &&
+	(
+		cd sub &&
+		git init &&
+		test_commit subcommit1 &&
+		test_commit subcommit2 &&
+		test_commit subcommit3
+	) &&
+	git submodule add "file://$pwd/sub" sub &&
+	git commit -m "add submodule"
+'
+
+test_expect_success 'nonshallow clone implies nonshallow submodule' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --recurse-submodules "file://$pwd/." super_clone &&
+	(
+		cd super_clone &&
+		git log --oneline >lines &&
+		test_line_count = 3 lines
+	) &&
+	(
+		cd super_clone/sub &&
+		git log --oneline >lines &&
+		test_line_count = 3 lines
+	)
+'
+
+test_expect_success 'shallow clone implies shallow submodule' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --recurse-submodules --depth 2 "file://$pwd/." super_clone &&
+	(
+		cd super_clone &&
+		git log --oneline >lines &&
+		test_line_count = 2 lines
+	) &&
+	(
+		cd super_clone/sub &&
+		git log --oneline >lines &&
+		test_line_count = 1 lines
+	)
+'
+
+test_expect_success 'shallow clone with non shallow submodule' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --recurse-submodules --depth 2 --no-shallow-submodules "file://$pwd/." super_clone &&
+	(
+		cd super_clone &&
+		git log --oneline >lines &&
+		test_line_count = 2 lines
+	) &&
+	(
+		cd super_clone/sub &&
+		git log --oneline >lines &&
+		test_line_count = 3 lines
+	)
+'
+
+test_expect_success 'non shallow clone with shallow submodule' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --recurse-submodules --no-local --shallow-submodules "file://$pwd/." super_clone &&
+	(
+		cd super_clone &&
+		git log --oneline >lines &&
+		test_line_count = 3 lines
+	) &&
+	(
+		cd super_clone/sub &&
+		git log --oneline >lines &&
+		test_line_count = 1 lines
+	)
+'
+
+test_done
-- 
2.8.0.44.g26aa6d4
