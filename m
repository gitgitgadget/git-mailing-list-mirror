Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBB871FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 01:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933381AbdDABVp (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 21:21:45 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32870 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933354AbdDABVo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 21:21:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id o81so2036169wmb.0
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 18:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3PUO6EA4o4uclZwhAUcba5RY2Tbn95Q9UN2CvgquJRs=;
        b=XsNnudXsrNmPODxZk8eT1J/O2BwkG7uYfLDxzMjrgd2CIJSU3J4o/O80C0Fzwgvf+U
         jRMPLZrPOa7bnauMBuBYwEQeWn1zyiIu6+9qI0hDvDNsgsa1EmkH5lz/eNDscYYB6Z0X
         MLU2OqFsWIpr0TtBFIjeJXrinqI2sQZxZANBYgL6ch4qxKUQub0r1Jm3KeQcqWLs9gH9
         DGYOJqr2nHgMuzpoGpU/65P/k9ZrUPWG9kGsrUKMAcVHKFMndCGnfCKZDsvOVPriFxPx
         d9ECQpgOwDbnFKnXEWXaNRwA6XSVLEOHqRUXaUiOaHJ6iHsAuglgsplKQUVhZj1gWDZG
         ah4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3PUO6EA4o4uclZwhAUcba5RY2Tbn95Q9UN2CvgquJRs=;
        b=Rm72iAooXZ00LjKJq+cJpO79DGmUNTsphptz+p24ZAO3D51BLiYKOOaz3BTw0tY4Wo
         3f4RQwvPU2MEYwwiHeFwaaBvzMO2xKhQNd2qJtHjsaxk+7x8kJPT8MSI0cFQVvs/xesq
         Ka78uzB+fJhVlpDHDTbAusUgwM7vKfoh/+WUv5lTxB9Czr1dhiokJ8Dnvn+aaRLLGWwp
         T/8AZ/qePRM+wQhuQT7L5meOefkZ2MPGE6oOvlmgGJ18Gp3mERGETrxkEoR2f11oW7z+
         jrCPUmwBvCA+mDVkkX308jJcINDc7uUyN4ERbT9wE6kLbIBhu6kEbE4Lv9BQ701O0PAV
         zOHQ==
X-Gm-Message-State: AFeK/H3Ksd614lW5n1SZTjs2SPYYNShJpSc6Bz7kaTdxnqrbnmEoK8aE
        Wd1jkTps+4c+aA==
X-Received: by 10.28.142.82 with SMTP id q79mr411684wmd.94.1491009702749;
        Fri, 31 Mar 2017 18:21:42 -0700 (PDT)
Received: from localhost.localdomain ([178.156.154.74])
        by smtp.gmail.com with ESMTPSA id w10sm4814982wmw.14.2017.03.31.18.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Mar 2017 18:21:41 -0700 (PDT)
From:   Robert Stanca <robert.stanca7@gmail.com>
To:     git@vger.kernel.org
Cc:     Robert Stanca <robert.stanca7@gmail.com>
Subject: [PATCH] [GSOC] prune_worktrees(): reimplement with dir_iterator
Date:   Sat,  1 Apr 2017 04:21:27 +0300
Message-Id: <1491009687-10419-1-git-send-email-robert.stanca7@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replaces recursive traversing of opendir with dir_iterator

Signed-off-by: Robert Stanca <robert.stanca7@gmail.com>
---
 builtin/worktree.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9993ded..7cfd78c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -10,6 +10,8 @@
 #include "refs.h"
 #include "utf8.h"
 #include "worktree.h"
+#include "iterator.h"
+#include "dir-iterator.h"
 
 static const char * const worktree_usage[] = {
 	N_("git worktree add [<options>] <path> [<branch>]"),
@@ -91,30 +93,25 @@ static void prune_worktrees(void)
 {
 	struct strbuf reason = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
-	DIR *dir = opendir(git_path("worktrees"));
-	struct dirent *d;
+	struct dir_iterator *diter = dir_iterator_begin(git_path("worktrees"));
 	int ret;
-	if (!dir)
-		return;
-	while ((d = readdir(dir)) != NULL) {
-		if (is_dot_or_dotdot(d->d_name))
-			continue;
+
+	while (dir_iterator_advance(diter) == ITER_OK) {
 		strbuf_reset(&reason);
-		if (!prune_worktree(d->d_name, &reason))
+		if (!prune_worktree(diter->relative_path, &reason))
 			continue;
 		if (show_only || verbose)
 			printf("%s\n", reason.buf);
 		if (show_only)
 			continue;
 		strbuf_reset(&path);
-		strbuf_addstr(&path, git_path("worktrees/%s", d->d_name));
+		strbuf_addstr(&path, git_path("worktrees/%s", diter->relative_path));
 		ret = remove_dir_recursively(&path, 0);
 		if (ret < 0 && errno == ENOTDIR)
 			ret = unlink(path.buf);
 		if (ret)
 			error_errno(_("failed to remove '%s'"), path.buf);
 	}
-	closedir(dir);
 	if (!show_only)
 		rmdir(git_path("worktrees"));
 	strbuf_release(&reason);
-- 
2.7.4

