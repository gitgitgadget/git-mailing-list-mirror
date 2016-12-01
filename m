Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39F111FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753382AbcLAU0L (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:26:11 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35761 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753197AbcLAU0K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:26:10 -0500
Received: by mail-pg0-f54.google.com with SMTP id p66so98576908pga.2
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 12:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L0QfnjpBxJlttIT4G4FyRIDbb6gq2q2R4yreUDlJbsY=;
        b=Vul8A58DjgOb1m/846ExkVFRs3Ph9vmdz5HfwCMB15nMIwOTX4Fy7bC/bzWSr58lLI
         /v1oBr+hhK0diJX/baLdQqAvUL0FA8Zk0If2sjBEvgZtUjEjNWk0yrzEXm/oAnwB5g5d
         XYMj3m5+HqlMR6ITaV2bvPOGcl1Tiu+pjX/SIz5yAniP1zBxYk89M6GA+cOFEKiGURtn
         LeczWyIBR/UgE3733d6KtgLi4QaHItU57FvHXDlsd8wWWunV4JmSoowOI8zrp3A06NvL
         SJe2vxlpwx8qbWAmwuwTkGAP7Ejy1muvgLFiiluKEzJj9r/SmTbfbnzCsD7kkfProzxk
         NdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L0QfnjpBxJlttIT4G4FyRIDbb6gq2q2R4yreUDlJbsY=;
        b=Ggl+dg6khYFbtPHcHstCkOUebS6TqLs2DXSyiNVZ1SAR8G2fSflYHZVdQRmI3ixJsq
         9B8becy0jDOpICB+BQnST6763E6O8E2rpgpEr7kiQd3+r+isGKfNDqBp1ZppYizGLWAh
         ECWYg7FmStW09rm/vexkOkSSAC4FXnHEAjVfzIVZA0wypsBdMfndTLRZDCWUPXgcMVMq
         tZ+7hsmMTYKScSjefmQAKlYTYmrxK9R6HRRp/1lF+tWTtd4Rzh9tRkLEo9jpd+KFjzzH
         pC/abhGKJv5eHS0FDGYJID2HOkPt9qxng38TX3z7lgtNcBmHokvQzPYSxbyuCuigNpiP
         JMyw==
X-Gm-Message-State: AKaTC027DU+qVqLVt4peNnjFlqtBJj/zEQSlED9W2RDzFn+WiIMXlFVsS2jPcDgIGXx31PH1
X-Received: by 10.84.216.6 with SMTP id m6mr89252308pli.130.1480623969711;
        Thu, 01 Dec 2016 12:26:09 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:18d1:181b:bbf2:e96f])
        by smtp.gmail.com with ESMTPSA id p13sm2057790pgf.47.2016.12.01.12.26.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 12:26:09 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 1/5] submodule: use absolute path for computing relative path connecting
Date:   Thu,  1 Dec 2016 12:25:50 -0800
Message-Id: <20161201202554.19944-2-sbeller@google.com>
X-Mailer: git-send-email 2.10.2.613.g22f2156
In-Reply-To: <20161201202554.19944-1-sbeller@google.com>
References: <20161201202554.19944-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current caller of connect_work_tree_and_git_dir passes
an absolute path for the `git_dir` parameter. In the future patch
we will also pass in relative path for `git_dir`. Extend the functionality
of connect_work_tree_and_git_dir to take relative paths for parameters.

We could work around this in the future patch by computing the absolute
path for the git_dir in the calling site, however accepting relative
paths for either parameter makes the API for this function much harder
to misuse.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/submodule.c b/submodule.c
index 6f7d883de9..66c5ce5a24 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1227,23 +1227,25 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 {
 	struct strbuf file_name = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
-	const char *real_work_tree = xstrdup(real_path(work_tree));
+	char *real_git_dir = xstrdup(real_path(git_dir));
+	char *real_work_tree = xstrdup(real_path(work_tree));
 
 	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
 	write_file(file_name.buf, "gitdir: %s",
-		   relative_path(git_dir, real_work_tree, &rel_path));
+		   relative_path(real_git_dir, real_work_tree, &rel_path));
 
 	/* Update core.worktree setting */
 	strbuf_reset(&file_name);
-	strbuf_addf(&file_name, "%s/config", git_dir);
+	strbuf_addf(&file_name, "%s/config", real_git_dir);
 	git_config_set_in_file(file_name.buf, "core.worktree",
-			       relative_path(real_work_tree, git_dir,
+			       relative_path(real_work_tree, real_git_dir,
 					     &rel_path));
 
 	strbuf_release(&file_name);
 	strbuf_release(&rel_path);
-	free((void *)real_work_tree);
+	free(real_work_tree);
+	free(real_git_dir);
 }
 
 int parallel_submodules(void)
-- 
2.10.2.613.g22f2156

