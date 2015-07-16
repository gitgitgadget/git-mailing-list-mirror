From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 10/20] worktree: simplify new branch (-b/-B) option checking
Date: Thu, 16 Jul 2015 04:20:15 -0400
Message-ID: <1437034825-32054-11-git-send-email-sunshine@sunshineco.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:22:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFeR0-0000Py-47
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 10:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289AbbGPIWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 04:22:21 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:33442 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930AbbGPIU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 04:20:56 -0400
Received: by ietj16 with SMTP id j16so50960896iet.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 01:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oJjitr7ylXR+sl83Rm8k5vX2gMR/kDqD3sCRanAxM8I=;
        b=Kf+LPvJooyVA2UcHWL7F8uzP0SRReLoVXCtmtLVhbjAeeyBNBUyCbGg/achqcYDBBe
         30rXGbGuCMtwRtndo6pb0J+5pjZPX5217E+GXQXcXMXEjsXIzFxo5ZXQL7x4GPDG0pmM
         a9wyLpAF+ZxTgJDyHf9I7mXIGcSpWUk6QSdj3vwmeVzn+6gZ3RCGvwR5oLXAWCUD+WDW
         rjicWbIslUiSaNMggcUmvxZtkznGbTR9mXYIqf93UyxaIR64Pq/a4i3RajCGw4kSzBpR
         n2SbExvokmpAMuvO8BzHhq/DBEo32Q+0ha3D58oG5kszpqovqrcaIe4Si14e5/jJUQld
         sA1w==
X-Received: by 10.107.37.14 with SMTP id l14mr11225367iol.12.1437034855902;
        Thu, 16 Jul 2015 01:20:55 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm4581146iod.25.2015.07.16.01.20.55
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 01:20:55 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274023>

Make 'new_branch' be the name of the new branch for both forced and
non-forced cases; and add boolean 'force_new_branch' to indicate forced
branch creation. This will simplify logic later on when git-worktree
handles branch creation locally rather than delegating it to
git-checkout as part of the worktree population phase.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v1.

 builtin/worktree.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 69248ba..c267410 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -272,7 +272,7 @@ static int add_worktree(const char *path, const char **child_argv)
 
 static int add(int ac, const char **av, const char *prefix)
 {
-	int force = 0, detach = 0;
+	int force = 0, detach = 0, force_new_branch;
 	const char *new_branch = NULL, *new_branch_force = NULL;
 	const char *path, *branch;
 	struct argv_array cmd = ARGV_ARRAY_INIT;
@@ -295,7 +295,11 @@ static int add(int ac, const char **av, const char *prefix)
 	path = prefix ? prefix_filename(prefix, strlen(prefix), av[0]) : av[0];
 	branch = ac < 2 ? "HEAD" : av[1];
 
-	if (ac < 2 && !new_branch && !new_branch_force) {
+	force_new_branch = !!new_branch_force;
+	if (force_new_branch)
+		new_branch = new_branch_force;
+
+	if (ac < 2 && !new_branch) {
 		int n;
 		const char *s = worktree_basename(path, &n);
 		new_branch = xstrndup(s, n);
@@ -305,9 +309,8 @@ static int add(int ac, const char **av, const char *prefix)
 	if (force)
 		argv_array_push(&cmd, "--ignore-other-worktrees");
 	if (new_branch)
-		argv_array_pushl(&cmd, "-b", new_branch, NULL);
-	if (new_branch_force)
-		argv_array_pushl(&cmd, "-B", new_branch_force, NULL);
+		argv_array_pushl(&cmd, force_new_branch ? "-B" : "-b",
+				 new_branch, NULL);
 	if (detach)
 		argv_array_push(&cmd, "--detach");
 	argv_array_push(&cmd, branch);
-- 
2.5.0.rc2.378.g0af52e8
