From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 13/16] worktree: make setup of new HEAD distinct from worktree population
Date: Fri, 10 Jul 2015 20:05:43 -0400
Message-ID: <1436573146-3893-14-git-send-email-sunshine@sunshineco.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 08:50:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDocb-0006MB-4X
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 08:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbbGKGup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 02:50:45 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33984 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbbGKGuo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 02:50:44 -0400
Received: by igvi1 with SMTP id i1so4138604igv.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 23:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iwu9OulFZbvwxOZ2ZNd9tpQc2NeWOSiI6ucd7NJZZx8=;
        b=zcACxG9tOThHZok5qaK91e+EMTQ0EBktNjdd8DtdRY/qaAO49eqekbLzB64PCuRe+d
         JrB+0wZuMmHgSLB7YtuZXAO8BECEV/bWptT/oIfpgZr5YNAPYDtQmD6nxGArstMTX+Vh
         o1eZEfukUDy9vIgn6gViKvsO6VUADUqueu5n8ePjqR4k1JfBY3T3rjfQKe5rriLEc+hW
         1F+Xa0tU9b8eBYkdl0Y49qIIX9u/7Lasghn3nSE7XRLn/P0HYdrIuASu7eu/JXEkqXin
         5nhBTcisR6wu+RTKigyJqP3LN80BGWvf05ZdtJdcZEf1TCXA4w+pA6HZ6YIZAIIejbxV
         hLbg==
X-Received: by 10.50.79.133 with SMTP id j5mr1214351igx.63.1436573199328;
        Fri, 10 Jul 2015 17:06:39 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id g81sm7533321ioi.20.2015.07.10.17.06.38
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jul 2015 17:06:38 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.201.ga12d9f8
In-Reply-To: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273847>

The eventual goal is for git-worktree to populate the new worktree via
"git reset --hard" rather than "git checkout". As a consequence,
git-worktree will no longer be able to delegate to git-branch the
setting of the new worktree's HEAD to the desired branch (or commit, if
detached). Therefore, make git-worktree responsible for setting up HEAD
as either a symbolic reference if associated with a branch, or detached
if not.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

As with the patch which separates branch creation from worktree
population (by using git-branch instead of "git checkout -b"), this
patch invokes git-symbolic-ref and git-update-ref rather than using the
lower-level C API, due to the added value of those commands. If this
proves the wrong approach, then the series can be re-rolled or follow-on
patches can instead use the C API.

 builtin/worktree.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index babdef1..94c1701 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -274,12 +274,20 @@ static int add_worktree(const char *path, const char *refname,
 	setenv(GIT_WORK_TREE_ENVIRONMENT, path, 1);
 	memset(&cp, 0, sizeof(cp));
 	cp.git_cmd = 1;
+
+	if (commit)
+		argv_array_pushl(&cp.args, "update-ref", "HEAD",
+				 sha1_to_hex(commit->object.sha1), NULL);
+	else
+		argv_array_pushl(&cp.args, "symbolic-ref", "HEAD",
+				 symref.buf, NULL);
+	ret = run_command(&cp);
+	if (ret)
+		goto done;
+
+	cp.argv = NULL;
+	argv_array_clear(&cp.args);
 	argv_array_push(&cp.args, "checkout");
-	if (opts->force)
-		argv_array_push(&cp.args, "--ignore-other-worktrees");
-	if (opts->detach)
-		argv_array_push(&cp.args, "--detach");
-	argv_array_push(&cp.args, refname);
 	ret = run_command(&cp);
 	if (!ret) {
 		is_junk = 0;
@@ -288,6 +296,7 @@ static int add_worktree(const char *path, const char *refname,
 		junk_work_tree = NULL;
 		junk_git_dir = NULL;
 	}
+done:
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
 	unlink_or_warn(sb.buf);
-- 
2.5.0.rc1.201.ga12d9f8
