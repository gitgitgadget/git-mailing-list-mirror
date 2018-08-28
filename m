Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2087D1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbeH2BOW (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:14:22 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53994 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH2BOU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:14:20 -0400
Received: by mail-it0-f65.google.com with SMTP id p79-v6so4746768itp.3
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oe25CAAzFqcB895a6QXhooMFHUtox8Yzni00iOW9tOk=;
        b=FFg3cKieo416rhPESjz5yJV8CDqfRcbp8Fg3JNdREo9y8BwsOgTeIc6M64o36QGODT
         HackWisFIJwbX8DFa41hqPQQjt2dRcDrDSVSinM4zmQQfni1Wgvi9oDQcQVDmHR8HdUg
         Uxthf2mXPJ504xzKS3GuaLUkNTBSjNThZ8ez2TJxE7JxoI75NdtyahJ94BwUMH22W6CX
         f/1GRBSWZmnKj2vM2u4n7wViyPxE4BXXWX79KiFNenrB2RAx7YpIZNvAU9JAF/QZDG88
         hQnspxiO13D95OiRj4E4DkP2kOuqF6SHPeDes4hualh6eVDPM91aHUwT0tjyUjCaD1lm
         leLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=oe25CAAzFqcB895a6QXhooMFHUtox8Yzni00iOW9tOk=;
        b=kIH9GhMKgjcV4B+gI64Jt1hVqSOfcbTy8oAfb848K6kjFPrWi3TcXvQi4jBUoWw+P9
         N06S04r8/90JRv8Yd8OSH6CvlebCQNAVUu+2bxMBTxoPtD9f4Rd24SP31DfSncdAdWPM
         cUwAb1thVr7h9UolWitc3b8dG0q+/v+Artq3H1E/N1o5FZkDawv4+15MEKteR5PCSidh
         tPT8/tV+EaNA6uQXJznpZUYGMREZpL4MdEK4eSIfAvval3azOlH970Qc1TdC3MbSaQFw
         Kjw4jz5RnUOyAG8uFRS7ONDifU8l4FDtNN9F8nTFuWDhGhYkqGvzlDi896/N2CrS/I56
         SNQw==
X-Gm-Message-State: APzg51BLjp2q+zdihfLwcQMxy/UkZjQLX8ZrWPyWzwlt0N55k3cKTC0x
        fjB/PJ/kU86ZPNHBrJWdVpaOgixY
X-Google-Smtp-Source: ANB0VdbWGzq34YoUwMPwiQkO0wlQ2VHc+tVyua7RmrdRuPNeg0q4RYWFU4nXo5JuNkBQLYGFaE+E8A==
X-Received: by 2002:a24:184a:: with SMTP id 71-v6mr3337428itr.56.1535491249441;
        Tue, 28 Aug 2018 14:20:49 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id o1-v6sm1090344iop.12.2018.08.28.14.20.48
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 14:20:49 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/9] worktree: generalize delete_git_dir() to reduce code duplication
Date:   Tue, 28 Aug 2018 17:20:20 -0400
Message-Id: <20180828212026.21989-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180828212026.21989-1-sunshine@sunshineco.com>
References: <20180828212026.21989-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

prune_worktrees() and delete_git_dir() both remove worktree
administrative entries from .git/worktrees, and their implementations
are nearly identical. The only difference is that prune_worktrees() is
also capable of removing a bogus non-worktree-related file from
.git/worktrees.

Simplify by extending delete_git_dir() to handle the little bit of
extra functionality needed by prune_worktrees(), and drop the
effectively duplicate code from the latter.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index a8128289cc..0affcb476c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -47,16 +47,17 @@ static int git_worktree_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static int delete_git_dir(struct worktree *wt)
+static int delete_git_dir(const char *id)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int ret = 0;
+	int ret;
 
-	strbuf_addstr(&sb, git_common_path("worktrees/%s", wt->id));
-	if (remove_dir_recursively(&sb, 0)) {
+	strbuf_addstr(&sb, git_common_path("worktrees/%s", id));
+	ret = remove_dir_recursively(&sb, 0);
+	if (ret < 0 && errno == ENOTDIR)
+		ret = unlink(sb.buf);
+	if (ret)
 		error_errno(_("failed to delete '%s'"), sb.buf);
-		ret = -1;
-	}
 	strbuf_release(&sb);
 	return ret;
 }
@@ -130,10 +131,8 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 static void prune_worktrees(void)
 {
 	struct strbuf reason = STRBUF_INIT;
-	struct strbuf path = STRBUF_INIT;
 	DIR *dir = opendir(git_path("worktrees"));
 	struct dirent *d;
-	int ret;
 	if (!dir)
 		return;
 	while ((d = readdir(dir)) != NULL) {
@@ -146,18 +145,12 @@ static void prune_worktrees(void)
 			printf("%s\n", reason.buf);
 		if (show_only)
 			continue;
-		git_path_buf(&path, "worktrees/%s", d->d_name);
-		ret = remove_dir_recursively(&path, 0);
-		if (ret < 0 && errno == ENOTDIR)
-			ret = unlink(path.buf);
-		if (ret)
-			error_errno(_("failed to remove '%s'"), path.buf);
+		delete_git_dir(d->d_name);
 	}
 	closedir(dir);
 	if (!show_only)
 		rmdir(git_path("worktrees"));
 	strbuf_release(&reason);
-	strbuf_release(&path);
 }
 
 static int prune(int ac, const char **av, const char *prefix)
@@ -882,7 +875,7 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 	 * continue on even if ret is non-zero, there's no going back
 	 * from here.
 	 */
-	ret |= delete_git_dir(wt);
+	ret |= delete_git_dir(wt->id);
 
 	free_worktrees(worktrees);
 	return ret;
-- 
2.19.0.rc1.350.ge57e33dbd1

