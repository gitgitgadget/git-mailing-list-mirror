From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 15/23] worktree: add --detach option
Date: Mon,  6 Jul 2015 13:30:52 -0400
Message-ID: <1436203860-846-16-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:32:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAFM-0007pX-7M
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbbGFRbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:31:50 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34859 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbbGFRbo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:44 -0400
Received: by igcqs7 with SMTP id qs7so15122780igc.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u9bhuIaJ6VE9/db4FTwmOtsqQqN9ssBZFQadiVa811s=;
        b=JIxAFp3osODN51KXDvrBFaEtvtImVHvPwgY8uE5Lz52CDlMRZ7BAOtaksSYN/Z7Q1D
         IXNpHYQJkfxomN3B8WUFfs/ynYcB2+VqkF+3F3ky573jUFWxXuxfVNKRTXu5l1L+S6ch
         YpHJWkbNsqq7xUPUSWlXwGlihKk0DnYlGYETv7zcpLDru82nmYLc6CevHQynHf/kcva1
         /kSPvkNeoZn6hRy5hiGTKJszesvqKBqrB5mYA6uquQYrIVsRS3Z1y0XsXpPdNqTxwd5w
         hGgyciH25zZU8Dqfq5AA0UKIDm7/MKb+CTyIZrb4Uao0sLpx1TRkKNBNSfPfQ9FNWE6m
         hiIA==
X-Received: by 10.43.139.6 with SMTP id iu6mr38032166icc.32.1436203903978;
        Mon, 06 Jul 2015 10:31:43 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.42
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:43 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273420>

One of git-worktree's roles is to populate the new worktree, much like
git-checkout, and thus, for convenience, ought to support several of the
same shortcuts. Toward this goal, add a --detach option to detach HEAD
in the new worktree.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 6 +++++-
 builtin/worktree.c             | 5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 8891de0..231271b 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,7 +9,7 @@ git-worktree - Manage multiple worktrees
 SYNOPSIS
 --------
 [verse]
-'git worktree add' [-f] <path> <branch>
+'git worktree add' [-f] [--detach] <path> <branch>
 'git worktree prune' [-n] [-v] [--expire <expire>]
 
 DESCRIPTION
@@ -64,6 +64,10 @@ OPTIONS
 	is already checked out by another worktree. This option overrides
 	that safeguard.
 
+--detach::
+	With `add`, detach HEAD in the new worktree. See "DETACHED HEAD" in
+	linkgit:git-checkout[1].
+
 -n::
 --dry-run::
 	With `prune`, do not remove anything; just report what it would
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 8c35023..9dc92b0 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -125,11 +125,12 @@ static int prune(int ac, const char **av, const char *prefix)
 static int add(int ac, const char **av, const char *prefix)
 {
 	struct child_process c;
-	int force = 0;
+	int force = 0, detach = 0;
 	const char *path, *branch;
 	struct argv_array cmd = ARGV_ARRAY_INIT;
 	struct option options[] = {
 		OPT__FORCE(&force, N_("checkout <branch> even if already checked out in other worktree")),
+		OPT_BOOL(0, "detach", &detach, N_("detach HEAD at named commit")),
 		OPT_END()
 	};
 
@@ -144,6 +145,8 @@ static int add(int ac, const char **av, const char *prefix)
 	argv_array_pushl(&cmd, "--to", path, NULL);
 	if (force)
 		argv_array_push(&cmd, "--ignore-other-worktrees");
+	if (detach)
+		argv_array_push(&cmd, "--detach");
 	argv_array_push(&cmd, branch);
 
 	memset(&c, 0, sizeof(c));
-- 
2.5.0.rc1.197.g417e668
