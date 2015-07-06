From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 14/23] worktree: add --force option
Date: Mon,  6 Jul 2015 13:30:51 -0400
Message-ID: <1436203860-846-15-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:31:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAFC-0007jC-C4
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046AbbGFRbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:31:45 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37451 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbbGFRbn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:43 -0400
Received: by igau2 with SMTP id u2so16961470iga.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bZsU6y5k3uCP76vRtcHtbzrVAjuL7Vfol2Cdscx+qHA=;
        b=nNK2EG4+/CGj4mrSvxrleQIFX2XkOuaHNmP+DjjrpPlVQokGmxBx9Pjjzi+MyitZ5a
         46p3CWIVnP5WXI4ymiQzEEnUnPU6H1oA0yjjbDkAdYhALcsWIOYSMfbDHC7NX7BaJF6+
         Es2s+iF0Ppqh+o547u3anOA8ayDNFoQopJOhic+y7BOLu8G+tVvVAii1nP08nusq7JC8
         GgyLPsEDH1BmNZsGnlIoIB1lgTsLu67V+AkutddEUWXtZfcU2rfdsByXc0fjrX5Xt2yG
         d1kaMKr6ujG8YATX7YPGACPNydjqWve2xXxbDSVchf4UR3U880ZGypt1VysryeRDIcBu
         RsrQ==
X-Received: by 10.42.210.2 with SMTP id gi2mr36841059icb.58.1436203902853;
        Mon, 06 Jul 2015 10:31:42 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.42
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:42 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273419>

By default, "git worktree add" refuses to create a new worktree when
the requested branch is already checked out elsewhere. Add a --force
option to override this safeguard.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 8 +++++++-
 builtin/worktree.c             | 6 +++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index def3027..8891de0 100644
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
@@ -58,6 +58,12 @@ Prune working tree information in $GIT_DIR/worktrees.
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
index e0749c0..8c35023 100644
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
@@ -125,9 +125,11 @@ static int prune(int ac, const char **av, const char *prefix)
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
 
@@ -140,6 +142,8 @@ static int add(int ac, const char **av, const char *prefix)
 
 	argv_array_push(&cmd, "checkout");
 	argv_array_pushl(&cmd, "--to", path, NULL);
+	if (force)
+		argv_array_push(&cmd, "--ignore-other-worktrees");
 	argv_array_push(&cmd, branch);
 
 	memset(&c, 0, sizeof(c));
-- 
2.5.0.rc1.197.g417e668
