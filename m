From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 19/22] worktree: make setup of new HEAD distinct from worktree population
Date: Fri, 17 Jul 2015 19:00:14 -0400
Message-ID: <1437174017-81687-20-git-send-email-sunshine@sunshineco.com>
References: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 01:01:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGEdL-0002NX-Bf
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 01:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114AbbGQXBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 19:01:33 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33441 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010AbbGQXBb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 19:01:31 -0400
Received: by ietj16 with SMTP id j16so86626495iet.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 16:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NQx+s739vqdVDldsEho+cSg7W66wReTIq6GeosCgOP8=;
        b=K4/bG9KSj993c6nEda+S59+19kVxWzNFySbJRhRNotohwbcRU7tIe+NETwxrfhJg+1
         r8TkvO0taExbHnYs86RcMmAOU2QL+aY1pX+/nSUS7oDEzr0TAry9Enrl6TudZ7IPuK2A
         J0ydyFTU04rulKqcnLvp8ZzTCicVxz0Iscro/ll05pnGR0VF+E3HVTMtXjUXPt64+xI7
         +3uFi64MwSoh6xwxctftRGfAcBMp8A8Ay0cnZiHxbLsk1YragALRGw2+YZlYZCEs4mma
         W91oyOZ8ivlO6mD2IQSvcUCoAjUGZbpphRGTNd5zaiym8KbRgqvkXOhZMGsLUJaPeUa8
         JVyQ==
X-Received: by 10.50.136.194 with SMTP id qc2mr974634igb.6.1437174090046;
        Fri, 17 Jul 2015 16:01:30 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id 140sm8414824ion.16.2015.07.17.16.01.29
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 16:01:29 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274134>

git-worktree currently conflates setting of HEAD in the new worktree and
initial worktree population into a single git-checkout invocation which
requires git-checkout to have special knowledge that it is operating on
a newly created worktree. The eventual goal is to rid git-checkout of
that overly-intimate knowledge.

Once these operations are separate, git-worktree will no longer be able
to delegate to git-branch the setting of the new worktree's HEAD to the
desired branch (or commit, if detached). Therefore, make git-worktree
itself responsible for setting up HEAD as either a symbolic reference,
if associated with a branch, or detached, if not.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v2.

 builtin/worktree.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index cf35b2a..79d088c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -278,12 +278,21 @@ static int add_worktree(const char *path, const char *refname,
 	argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
 	memset(&cp, 0, sizeof(cp));
 	cp.git_cmd = 1;
+
+	if (commit)
+		argv_array_pushl(&cp.args, "update-ref", "HEAD",
+				 sha1_to_hex(commit->object.sha1), NULL);
+	else
+		argv_array_pushl(&cp.args, "symbolic-ref", "HEAD",
+				 symref.buf, NULL);
+	cp.env = child_env.argv;
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
 	cp.env = child_env.argv;
 	ret = run_command(&cp);
 	if (!ret) {
@@ -293,6 +302,7 @@ static int add_worktree(const char *path, const char *refname,
 		junk_work_tree = NULL;
 		junk_git_dir = NULL;
 	}
+done:
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
 	unlink_or_warn(sb.buf);
-- 
2.5.0.rc2.378.g0af52e8
