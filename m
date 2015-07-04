From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 15/23] worktree: add --detach option
Date: Fri,  3 Jul 2015 20:17:24 -0400
Message-ID: <1435969052-540-16-git-send-email-sunshine@sunshineco.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 02:19:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBAs-0000N2-TB
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755768AbbGDATN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:19:13 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38546 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755964AbbGDASk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:18:40 -0400
Received: by igrv9 with SMTP id v9so85103050igr.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h7OUPbEq5uK/W9vkAtPWvGdQWMifVSZpj9lDSSWbD7A=;
        b=k2/1MF0E27SWfxEQatZrKTutP/TG05UYQVYj92UXKPbTfV3kzxPiqXxDBV8VWgjPqB
         g6qgkC/CsNN0F9WBWTZuT7/mmxCMPoOSwYjh0Qp+UkZbgbZo83YTePiWjIN/QBkhwgGY
         jVSWGB5gRnxUCupCjxeH4A9jmSLM1G8Oq/q1eSY3FZ3GHN1x7/Y8qaBrwDhu0+JSoTJE
         2+QxOgdgkqyGQ1e/nnAROQ0wFlHncpPNlWz4q1555nUn5IDCU5/Cj0pidYrm/oFQjMcq
         MYxkYSOLqiQRLIEkfDP5ZhkhhpR+FTlELMGh1ook2QhnGGOo8VWZxOPGdx+hHhVRZ+EM
         3eFA==
X-Received: by 10.42.120.201 with SMTP id g9mr1222528icr.23.1435969119684;
        Fri, 03 Jul 2015 17:18:39 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id z195sm7246110iod.33.2015.07.03.17.18.38
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2015 17:18:39 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273328>

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
index 552c8e4..96e2142 100644
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
@@ -65,6 +65,10 @@ OPTIONS
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
index c9d6462..6967369 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -126,11 +126,12 @@ static int prune(int ac, const char **av, const char *prefix)
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
 
@@ -145,6 +146,8 @@ static int add(int ac, const char **av, const char *prefix)
 	argv_array_pushl(&cmd, "--to", path, NULL);
 	if (force)
 		argv_array_push(&cmd, "--ignore-other-worktrees");
+	if (detach)
+		argv_array_push(&cmd, "--detach");
 	argv_array_push(&cmd, branch);
 
 	memset(&c, 0, sizeof(c));
-- 
2.5.0.rc1.197.g417e668
