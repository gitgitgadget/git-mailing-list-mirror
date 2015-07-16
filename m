From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 17/20] worktree: make setup of new HEAD distinct from worktree population
Date: Thu, 16 Jul 2015 04:20:22 -0400
Message-ID: <1437034825-32054-18-git-send-email-sunshine@sunshineco.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:21:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFeQT-0000B2-Dr
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 10:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318AbbGPIVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 04:21:04 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33981 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954AbbGPIVB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 04:21:01 -0400
Received: by iebmu5 with SMTP id mu5so50728686ieb.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 01:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=max6atTydVqfqVCaQiqF+KOOxKlgS4by5hznZuET2s0=;
        b=L/hfmPqCCoEFnYCScJsHQNK+nSQMdn8SotqNlWsfl7tBrUKedffbPxQ/z49MiCQdFQ
         0drvEsHBrgdoeqocbLAD35JoEvCBP4dyCcDaNcxgUsMZHG7RQgcFySgKu8Hgzpj2hz3g
         YUnQxP/UpOFsjxeCRNwB7i0eKKR0F9qF/+2luwqsOdFMYoEQQ7V/88wvm92bdoi/1o7u
         Tr/BwjK4LEftGltYu6ZAJzia6Q06xylOikNXaGF6u4WicExHP575nDsGUfQoF3LYq/9c
         Y30T6jPAh5k893pBDZupQdpkIfKNAstbk4LWl4nUESrklPO+gFk9lf9x0FCZD5aW3Xw8
         AI6g==
X-Received: by 10.50.78.232 with SMTP id e8mr1658020igx.24.1437034861086;
        Thu, 16 Jul 2015 01:21:01 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm4581146iod.25.2015.07.16.01.21.00
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 01:21:00 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274015>

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

Changes since v1: reword commit message.

 builtin/worktree.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index e8f3f30..59609e3 100644
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
