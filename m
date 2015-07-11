From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 07/16] worktree: simplify new branch (-b/-B) option checking
Date: Fri, 10 Jul 2015 20:05:37 -0400
Message-ID: <1436573146-3893-8-git-send-email-sunshine@sunshineco.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 08:56:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDohl-0000sQ-85
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 08:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbbGKG4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 02:56:05 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:34866 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbbGKG4D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 02:56:03 -0400
Received: by igcqs7 with SMTP id qs7so26905710igc.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 23:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ozVuTOxlNi1rVx9hzBLyfbmxNAgU15C+Se69ojQx5Rg=;
        b=MuXCp/NkRXIu/7owXRQO9Y49/9MiCpNTOdnQToM2Pc6ey+PiIfPvFIWtaPYjKzP3wp
         sIFJNzljnSIyVXJy4dzB0xswleZRNPrSPFPr8BnO0VaLTFGyMQQHkbMaBUO111luWilY
         auiPHPpaCEAFNqDs3dLT8VCkC38imhREkc3ZhBUc8uXda21beTYDnqmbbTY3UGTTfiXk
         TUpa2+TXrbOK3Q39bpJHvj3iJnbLi3WGfSyF8Go2CsBo61oTH0NgsEhTGyZhD9Bpjs/R
         0WG7gPMOkLHXKw4I3NNxKTUN3YL2kuQHq7CQZXIkhUM6mzxGWoAQSm1GXusrIbITudLg
         d1cA==
X-Received: by 10.107.46.162 with SMTP id u34mr7787924iou.124.1436573194193;
        Fri, 10 Jul 2015 17:06:34 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id g81sm7533321ioi.20.2015.07.10.17.06.33
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jul 2015 17:06:33 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.201.ga12d9f8
In-Reply-To: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273848>

Make 'new_branch' be the name of the new branch for both forced and
non-forced cases; and add boolean 'force_new_branch' to indicate forced
branch creation. This will simplify logic later on when git-worktree
handles branch creation locally rather than delegating it to
git-checkout as part of the worktree population phase.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
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
2.5.0.rc1.201.ga12d9f8
