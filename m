Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4469C4338F
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90CB460E78
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhGYM3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 08:29:18 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:38630 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230407AbhGYM24 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 08:28:56 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 2736E40DA3;
        Sun, 25 Jul 2021 15:08:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1627218526; x=1629032927;
         bh=GNeahixVkafQRAY3BFeO9RDRUhm3PxsrtB3d0UN4CkQ=; b=ZJqy3ZN6rhcs
        N2lRjfl0QkwIYC0QBuppDwKya+Xn/bvWoh3r+KWhZyHNT51nw+OdkUI7DPZa8drk
        IXcaDNPawZvs6vNTd1KdCS8XSu6Jbo7JFlSWqChavK4onadS0oWqXaAverrMLkui
        tWLO3S7tvvv4doD1d9pw9VuNhC6Qyfryyo7c25bf2hRQTelvHMAvzxoC14BrLB1t
        FMyF0g2LE8KAqrK9VAaGXphMlqpfmCKT6Ya4Btc+iYfexrPvy7/nPmGSOOFxFbHa
        W89IQoNYmuUjvmteNtRXXBqrrUtiM5/3lHWR2NNhKJaxhGCKwaUMzKCDQnxPGIue
        YpRFZ4fPxRJHbHwrdj1ZTC/xfxieskzCyl8BvLXXAWoGcErAWNH4P3F2M/HArlU7
        0caotgN94ok7LBs5FPjigakdHo7LqRr4ErpdQA5Gs/zPt91F0dpTwhfxSxme8tBU
        zsP43jPEo4OeXTZJUPrbMUa6ZX84cAshoX+rmLCLiq2hUsrZRp+6v/Z2v8+NyvG3
        nWSbfouD8xXXe26lhEsCYqDNon8yZpDqTPFvPUUmJ+YRMotwuIDDC0PyQi5KJO7D
        fgRq0Gfh5cmWfKq8qSffAZRsV1KNrOzpvxJ/HkTU75nPDuzUvONPtpKZj4/G5YM7
        wMT+5OzinkYXgfq5liiEYbC1TIFNrkg=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b5KcehDG_CDK; Sun, 25 Jul 2021 15:08:46 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 948DD404BD;
        Sun, 25 Jul 2021 15:08:46 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 17A3417C;
        Sun, 25 Jul 2021 15:08:45 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org, phillip.wood123@gmail.com, newren@gmail.com
Subject: [PATCH v2 05/12] diffcore-rename: move old_dir/new_dir definition to plug leak
Date:   Sun, 25 Jul 2021 15:08:23 +0200
Message-Id: <20210725130830.5145-6-andrzej@ahunt.org>
In-Reply-To: <20210725130830.5145-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
 <20210725130830.5145-1-andrzej@ahunt.org>
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
index 2618bb07c1..c95857b51f 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -448,9 +448,9 @@ static void update_dir_rename_counts(struct dir_rename_info *info,
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
@@ -475,6 +475,10 @@ static void update_dir_rename_counts(struct dir_rename_info *info,
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

