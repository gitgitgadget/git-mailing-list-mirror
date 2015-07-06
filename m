From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 16/23] worktree: add -b/-B options
Date: Mon,  6 Jul 2015 13:30:53 -0400
Message-ID: <1436203860-846-17-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:31:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAFD-0007jC-MB
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbbGFRbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:31:49 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37479 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034AbbGFRbp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:45 -0400
Received: by igau2 with SMTP id u2so16962326iga.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ri+v77h6swEw5C5USojwS0E0x+RQYMSkgi+XIPz8vdo=;
        b=RQuncHF15shvHysAJXEMRAK2Atc0vtcs+XszHRbGleTDpSbRKgCt7FvuEvKwaRVmZk
         tmlGXSbaq3ml381Y80nVkF76mep6JFoj+M8xQHPHM2/6Qqpi4bEAZ5tLQPIVjXZH31of
         lpHgG2R6M3jtc5x2ayfsOBDl6r5k814X9ck53V8eD3cKNvgVo+l2zf4Ip7CyogSYNLAE
         gZn/kbOl615SOxl6fnfrGV/gPOd1Ru9cD6+cXOiwBZoPMNv8pJWOkIvUUYVhEMRkDHNO
         iN/uCal6YpWlgSS28xIybGH2iVbWFpJR1Cy4upT2IOC0gcNyyuCJT/R540GfCTrZqQIY
         eC5A==
X-Received: by 10.107.135.22 with SMTP id j22mr48005iod.20.1436203905219;
        Mon, 06 Jul 2015 10:31:45 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.44
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:44 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273417>

One of git-worktree's roles is to populate the new worktree, much like
git-checkout, and thus, for convenience, ought to support several of the
same shortcuts. Toward this goal, add -b/-B options to create a new
branch and check it out in the new worktree.

(For brevity, only -b is mentioned in the synopsis; -B is omitted.)

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 13 ++++++++++---
 builtin/worktree.c             | 11 +++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 231271b..f44cd78 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,7 +9,7 @@ git-worktree - Manage multiple worktrees
 SYNOPSIS
 --------
 [verse]
-'git worktree add' [-f] [--detach] <path> <branch>
+'git worktree add' [-f] [--detach] [-b <new-branch>] <path> <branch>
 'git worktree prune' [-n] [-v] [--expire <expire>]
 
 DESCRIPTION
@@ -64,6 +64,14 @@ OPTIONS
 	is already checked out by another worktree. This option overrides
 	that safeguard.
 
+-b <new-branch>::
+-B <new-branch>::
+	With `add`, create a new branch named `<new-branch>` starting at
+	`<branch>`, and check out `<new-branch>` into the new worktree.
+	By default, `-b` refuses to create a new branch if it already
+	exists. `-B` overrides this safeguard, resetting `<new-branch>` to
+	`<branch>`.
+
 --detach::
 	With `add`, detach HEAD in the new worktree. See "DETACHED HEAD" in
 	linkgit:git-checkout[1].
@@ -133,8 +141,7 @@ make the emergency fix, remove it when done, and then resume your earlier
 refactoring session.
 
 ------------
-$ git branch emergency-fix master
-$ git worktree add ../temp emergency-fix
+$ git worktree add -b emergency-fix ../temp master
 $ pushd ../temp
 # ... hack hack hack ...
 $ git commit -a -m 'emergency fix for boss'
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9dc92b0..d6d0eee 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -126,15 +126,22 @@ static int add(int ac, const char **av, const char *prefix)
 {
 	struct child_process c;
 	int force = 0, detach = 0;
+	const char *new_branch = NULL, *new_branch_force = NULL;
 	const char *path, *branch;
 	struct argv_array cmd = ARGV_ARRAY_INIT;
 	struct option options[] = {
 		OPT__FORCE(&force, N_("checkout <branch> even if already checked out in other worktree")),
+		OPT_STRING('b', NULL, &new_branch, N_("branch"),
+			   N_("create a new branch")),
+		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
+			   N_("create or reset a branch")),
 		OPT_BOOL(0, "detach", &detach, N_("detach HEAD at named commit")),
 		OPT_END()
 	};
 
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (new_branch && new_branch_force)
+		die(_("-b and -B are mutually exclusive"));
 	if (ac != 2)
 		usage_with_options(worktree_usage, options);
 
@@ -145,6 +152,10 @@ static int add(int ac, const char **av, const char *prefix)
 	argv_array_pushl(&cmd, "--to", path, NULL);
 	if (force)
 		argv_array_push(&cmd, "--ignore-other-worktrees");
+	if (new_branch)
+		argv_array_pushl(&cmd, "-b", new_branch, NULL);
+	if (new_branch_force)
+		argv_array_pushl(&cmd, "-B", new_branch_force, NULL);
 	if (detach)
 		argv_array_push(&cmd, "--detach");
 	argv_array_push(&cmd, branch);
-- 
2.5.0.rc1.197.g417e668
