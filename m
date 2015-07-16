From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 18/20] worktree: avoid resolving HEAD unnecessarily
Date: Thu, 16 Jul 2015 04:20:23 -0400
Message-ID: <1437034825-32054-19-git-send-email-sunshine@sunshineco.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:22:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFeQe-0000H8-Pp
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 10:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518AbbGPIVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 04:21:55 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:36436 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136AbbGPIVC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 04:21:02 -0400
Received: by ieik3 with SMTP id k3so51220488iei.3
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 01:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kno5GXBZ3MS8FGCgcZhoi3HmK/Tg9SzAMGjP/90WXLc=;
        b=DR4f6rSTtuhiyBhQk/WGX55YwLOpLW2E2RUr+T1+q/ANaXenB3QclzHTO4HZ2Xo6+3
         McizQNZHDuwfkXbTk1B/j2fjL8Jk8QUtRH5+++N8NOT9SK5qF2lFnDwRKHG5wN/hdT0Y
         AdagMKFi0FMlTRoBsXiermDxO2k72lAcBwTYg4XGba/Ci7KcrRJyYnA+rNa8avOVzPu0
         1HYiLWlfXNciEIRStDKLTydWOCMDcYsfqXiT0anYLwdFYqwbUeOiKzUbR0pMeXAE5RKo
         f6Pjkm6+ls1xwzLRI/upi0NYEweCsNd+ajujQ4s5SIRG4iuHF3ekVs+lKjDPSS1DbY3k
         tTEQ==
X-Received: by 10.50.79.168 with SMTP id k8mr1743477igx.77.1437034861796;
        Thu, 16 Jul 2015 01:21:01 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm4581146iod.25.2015.07.16.01.21.01
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 01:21:01 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274018>

Now that git-worktree sets HEAD explicitly to its final value via either
git-symbolic-ref or git-update-ref, rather than relying upon
git-checkout to do so, the "hack" for pacifying is_git_directory() with
a temporary HEAD, though still necessary, can be simplified.

Since the real HEAD is now populated with its proper final value, the
value of the temporary HEAD truly no longer matters, and any value which
looks like an object ID is good enough to satisfy is_git_directory().
Therefore, just set the temporary HEAD to a literal value rather than
going through the effort of resolving the current branch's HEAD.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v1.

 builtin/worktree.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 59609e3..54f2f35 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -192,7 +192,6 @@ static int add_worktree(const char *path, const char *refname,
 	int counter = 0, len, ret;
 	struct strbuf symref = STRBUF_INIT;
 	struct commit *commit = NULL;
-	unsigned char rev[20];
 
 	if (file_exists(path) && !is_empty_dir(path))
 		die(_("'%s' already exists"), path);
@@ -253,20 +252,14 @@ static int add_worktree(const char *path, const char *refname,
 		   real_path(get_git_common_dir()), name);
 	/*
 	 * This is to keep resolve_ref() happy. We need a valid HEAD
-	 * or is_git_directory() will reject the directory. Moreover, HEAD
-	 * in the new worktree must resolve to the same value as HEAD in
-	 * the current tree since the command invoked to populate the new
-	 * worktree will be handed the branch/ref specified by the user.
-	 * For instance, if the user asks for the new worktree to be based
-	 * at HEAD~5, then the resolved HEAD~5 in the new worktree must
-	 * match the resolved HEAD~5 in the current tree in order to match
-	 * the user's expectation.
+	 * or is_git_directory() will reject the directory. Any value which
+	 * looks like an object ID will do since it will be immediately
+	 * replaced by the symbolic-ref or update-ref invocation in the new
+	 * worktree.
 	 */
-	if (!resolve_ref_unsafe("HEAD", 0, rev, NULL))
-		die(_("unable to resolve HEAD"));
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
-	write_file(sb.buf, 1, "%s\n", sha1_to_hex(rev));
+	write_file(sb.buf, 1, "0000000000000000000000000000000000000000\n");
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, 1, "../..\n");
-- 
2.5.0.rc2.378.g0af52e8
