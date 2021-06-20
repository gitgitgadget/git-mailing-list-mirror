Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068C9C48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF13A6109F
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhFTPOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 11:14:38 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:7256 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230031AbhFTPOc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 11:14:32 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id F1751ED6
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1624201938; x=1626016339;
         bh=wVEwSTb9W40/ToQrLAMmbnizQ/Dtkw76tTg6aM7UZJA=; b=mWKDuPuGPUX8
        YwQWFSMyuD4zh8ygqPxkO/L32wd8oftx91fTZ1yN84JZWJCc0VRkrE9n0MLRsB3C
        JggS+Y1Znfy+AJC/lglgGdFlOZdNWvYWCR6rREf4x79uj6UQPEiwkt+Li/RMAQ77
        Wa0Z+6iFE+wal71ukhyGJMVU2yMj/dLxNCOOIRRT829l6taXscJbIextDPUMMNvf
        0ZrMePiIulmVJ4inZCwwfTHCLp/yrCNJYzQXyhQI/eXoq/QzgqTeQ1XiBPceZEyx
        FPuMklVYg3DD700TR9DbrbZCN1Jww2dcSRg2CLxG66qsDYVFtGVO2dR4xG4OtlMr
        hskCg/Hnwams+fgd0HG5bHaZo/ctWiOetz+2n4Q+stiBG42yZwx2+nMuRCibd8O8
        mppYUXEOBGZvuwVn1EJCRWYPxdF/HNxlHxf6lRYNCm/fN9SHRX78VaeY8U7EhG5n
        4QLGams+UWYtWj+/uhpv2zU5KY08nXCraNonwfNnGmzRJQOoIFqBQmczPhwQ7tyS
        U+S+knQPZEOkZIVjUS4CfWk9alqm0ef+fNOCDkEYHxK4OC2Qp/Qv1QbFY0hY9Hfy
        bo/5nc//FgAo7TlJF9BXqtYHqLO2qCjagl1wN9rvwy9mCMMWMg1YSSrEwU819wlL
        xJTEdlaPdCXiwxfxvHcDEyuWHmWQ4JY=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KaeK9bzvisi5 for <git@vger.kernel.org>;
        Sun, 20 Jun 2021 17:12:18 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 4B407660
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:18 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 39A9934B;
        Sun, 20 Jun 2021 17:12:17 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org
Subject: [PATCH 05/12] diffcore-rename: move old_dir/new_dir definition to plug leak
Date:   Sun, 20 Jun 2021 17:11:57 +0200
Message-Id: <20210620151204.19260-6-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

old_dir/new_dir are free()'d at the end of update_dir_rename_counts,
however if we return early we'll never free those strings. Therefore
we should move all new allocations after the possible early return,
avoiding a leak.

This seems like a fairly recent leak, that started happening since the
early-return was added in:
  1ad69eb0dc (diffcore-rename: compute dir_rename_counts in stages, 2021-02-27)

LSAN output from t0022:

Direct leak of 7 byte(s) in 1 object(s) allocated from:
    #0 0x486804 in strdup ../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
    #1 0xa71e48 in xstrdup wrapper.c:29:14
    #2 0x7db9c7 in update_dir_rename_counts diffcore-rename.c:464:12
    #3 0x7db6ae in find_renames diffcore-rename.c:1062:3
    #4 0x7d76c3 in diffcore_rename_extended diffcore-rename.c:1472:18
    #5 0x7b4cfc in diffcore_std diff.c:6705:4
    #6 0x855e46 in log_tree_diff_flush log-tree.c:846:2
    #7 0x856574 in log_tree_diff log-tree.c:955:3
    #8 0x856574 in log_tree_commit log-tree.c:986:10
    #9 0x9a9c67 in print_commit_summary sequencer.c:1329:7
    #10 0x52e623 in cmd_commit builtin/commit.c:1862:3
    #11 0x4ce83e in run_builtin git.c:475:11
    #12 0x4ccafe in handle_builtin git.c:729:3
    #13 0x4cb01c in run_argv git.c:818:4
    #14 0x4cb01c in cmd_main git.c:949:19
    #15 0x6b3f3d in main common-main.c:52:11
    #16 0x7fe397c7a349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Direct leak of 7 byte(s) in 1 object(s) allocated from:
    #0 0x486804 in strdup ../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
    #1 0xa71e48 in xstrdup wrapper.c:29:14
    #2 0x7db9bc in update_dir_rename_counts diffcore-rename.c:463:12
    #3 0x7db6ae in find_renames diffcore-rename.c:1062:3
    #4 0x7d76c3 in diffcore_rename_extended diffcore-rename.c:1472:18
    #5 0x7b4cfc in diffcore_std diff.c:6705:4
    #6 0x855e46 in log_tree_diff_flush log-tree.c:846:2
    #7 0x856574 in log_tree_diff log-tree.c:955:3
    #8 0x856574 in log_tree_commit log-tree.c:986:10
    #9 0x9a9c67 in print_commit_summary sequencer.c:1329:7
    #10 0x52e623 in cmd_commit builtin/commit.c:1862:3
    #11 0x4ce83e in run_builtin git.c:475:11
    #12 0x4ccafe in handle_builtin git.c:729:3
    #13 0x4cb01c in run_argv git.c:818:4
    #14 0x4cb01c in cmd_main git.c:949:19
    #15 0x6b3f3d in main common-main.c:52:11
    #16 0x7fe397c7a349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 14 byte(s) leaked in 2 allocation(s).

Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
---
 diffcore-rename.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 3375e24659..f7c728fe47 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -455,9 +455,9 @@ static void update_dir_rename_counts(struct dir_rename_info *info,
 				     const char *oldname,
 				     const char *newname)
 {
-	char *old_dir = xstrdup(oldname);
-	char *new_dir = xstrdup(newname);
-	char new_dir_first_char = new_dir[0];
+	char *old_dir;
+	char *new_dir;
+	const char new_dir_first_char = newname[0];
 	int first_time_in_loop = 1;
 
 	if (!info->setup)
@@ -482,6 +482,10 @@ static void update_dir_rename_counts(struct dir_rename_info *info,
 		 */
 		return;
 
+
+	old_dir = xstrdup(oldname);
+	new_dir = xstrdup(newname);
+
 	while (1) {
 		int drd_flag = NOT_RELEVANT;
 
-- 
2.26.2

