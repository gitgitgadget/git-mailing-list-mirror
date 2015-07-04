From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 14/23] worktree: add --force option
Date: Fri,  3 Jul 2015 20:17:23 -0400
Message-ID: <1435969052-540-15-git-send-email-sunshine@sunshineco.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 02:19:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBAk-0000Hi-61
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756048AbbGDATG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:19:06 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36899 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755957AbbGDASj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:18:39 -0400
Received: by igblr2 with SMTP id lr2so84924982igb.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=48O/+x1KLyUiqgI51NkZnW/HkpeQeBbxDtKzioUKlhM=;
        b=X3E8jJAfoCFTztHd2Kd9/alhYB5PB83zBt2LvdD6z9hpRucEYDgfL8nX1lCHQ6HKP+
         AvycPG4FYA12ayQWhdmoc0mTgqiURYCp8ubuoOd4MQjgaDVO8kSPMaTpOkZ0UQ1RuD+/
         LDQhSNt95bsQel8q+vxsNdl51gsIfXaLh9pPZWTJeTwuhl4H1i2A0Omtz46rS2a4Be6i
         uCe1Bb5DrXMYenm8GDTnBfkSTTL6Ngv9+8phsq2YXqcBhKFmfZcEfhLY43ZI6WQUMt7f
         eUC5fTjUGiLLIipEPQ4B7a8W0M5wSlJ4lVrooL/Y4C6u1zcdUdRyU6BhlyP7tbIMxhyR
         9BYg==
X-Received: by 10.50.112.73 with SMTP id io9mr54824025igb.18.1435969118801;
        Fri, 03 Jul 2015 17:18:38 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id z195sm7246110iod.33.2015.07.03.17.18.38
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2015 17:18:38 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273326>

By default, "git worktree add" refuses to create a new worktree when
the requested branch is already checked out elsewhere. Add a --force
option to override this safeguard.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 8 +++++++-
 builtin/worktree.c             | 6 +++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 59191f9..552c8e4 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,7 +9,7 @@ git-worktree - Manage multiple worktrees
 SYNOPSIS
 --------
 [verse]
-'git worktree add' <path> <branch>
+'git worktree add' [-f] <path> <branch>
 'git worktree prune' [-n] [-v] [--expire <expire>]
 
 DESCRIPTION
@@ -59,6 +59,12 @@ Prune working tree information in $GIT_DIR/worktrees.
 OPTIONS
 -------
 
+-f::
+--force::
+	By default, `add` refuses to create a new worktree when	`<branch>`
+	is already checked out by another worktree. This option overrides
+	that safeguard.
+
 -n::
 --dry-run::
 	With `prune`, do not remove anything; just report what it would
diff --git a/builtin/worktree.c b/builtin/worktree.c
index b82861e..c9d6462 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -6,7 +6,7 @@
 #include "run-command.h"
 
 static const char * const worktree_usage[] = {
-	N_("git worktree add <path> <branch>"),
+	N_("git worktree add [<options>] <path> <branch>"),
 	N_("git worktree prune [<options>]"),
 	NULL
 };
@@ -126,9 +126,11 @@ static int prune(int ac, const char **av, const char *prefix)
 static int add(int ac, const char **av, const char *prefix)
 {
 	struct child_process c;
+	int force = 0;
 	const char *path, *branch;
 	struct argv_array cmd = ARGV_ARRAY_INIT;
 	struct option options[] = {
+		OPT__FORCE(&force, N_("checkout <branch> even if already checked out in other worktree")),
 		OPT_END()
 	};
 
@@ -141,6 +143,8 @@ static int add(int ac, const char **av, const char *prefix)
 
 	argv_array_push(&cmd, "checkout");
 	argv_array_pushl(&cmd, "--to", path, NULL);
+	if (force)
+		argv_array_push(&cmd, "--ignore-other-worktrees");
 	argv_array_push(&cmd, branch);
 
 	memset(&c, 0, sizeof(c));
-- 
2.5.0.rc1.197.g417e668
