Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B925C71136
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 21:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355195AbjHQVPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 17:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355173AbjHQVPR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 17:15:17 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57593358E
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 14:15:16 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D9E1A20E6F;
        Thu, 17 Aug 2023 17:15:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=V
        2S1QjKwOOJGhfqhbbjdJZj0zzMWtZfosjkmIW6bFUM=; b=tkDRSUW/7kUyiIXWI
        gtP/Jxr6Di2TXQ7fwi8fpxdi282Efpje6SxMgacefZ2U0SmVmzpZB3yQ8U2YUrfX
        hGJcHllMt1TihFDko22OhhXRHxtoi5a0zpErsE62P3sf1PcjvMpKKN1/A3EzyZGY
        5IDW/SyRiZFYqhUw3VNqsEhSq0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D362320E6E;
        Thu, 17 Aug 2023 17:15:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 07D6E20E6D;
        Thu, 17 Aug 2023 17:15:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] diff: --dirstat leakfix
Date:   Thu, 17 Aug 2023 14:15:10 -0700
Message-ID: <xmqqbkf5bcbl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26F0A1AE-3D43-11EE-B2E9-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The dirstat_dir structure holds a list of files that had "damages"
and is used to summarize the change by directory.  It, specifically
its .files member, was allocated, used, and then left behind,
leaking.

What is tricky is that dir.files[] array is allocated and walked by
not pointing into the array with an incrementing offset, but by
incrementing the beginning of the array, so we need to remember the
original address of dir.files[] array before letting gather_dirstat()
walk over it, and free the original address once we are done.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                  | 14 ++++++++++++--
 t/t4047-diff-dirstat.sh |  2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git c/diff.c w/diff.c
index 648f6717a5..03d0cfc700 100644
--- c/diff.c
+++ w/diff.c
@@ -2977,6 +2977,7 @@ static void show_dirstat(struct diff_options *options)
 	unsigned long changed;
 	struct dirstat_dir dir;
 	struct diff_queue_struct *q = &diff_queued_diff;
+	struct dirstat_file *to_free;
 
 	dir.files = NULL;
 	dir.alloc = 0;
@@ -3060,13 +3061,17 @@ static void show_dirstat(struct diff_options *options)
 		dir.nr++;
 	}
 
+	to_free = dir.files;
+
 	/* This can happen even with many files, if everything was renames */
 	if (!changed)
-		return;
+		goto free_return;
 
 	/* Show all directories with more than x% of the changes */
 	QSORT(dir.files, dir.nr, dirstat_compare);
 	gather_dirstat(options, &dir, changed, "", 0);
+free_return:
+	free(to_free);
 }
 
 static void show_dirstat_by_line(struct diffstat_t *data, struct diff_options *options)
@@ -3074,6 +3079,7 @@ static void show_dirstat_by_line(struct diffstat_t *data, struct diff_options *o
 	int i;
 	unsigned long changed;
 	struct dirstat_dir dir;
+	struct dirstat_file *to_free;
 
 	if (data->nr == 0)
 		return;
@@ -3104,13 +3110,17 @@ static void show_dirstat_by_line(struct diffstat_t *data, struct diff_options *o
 		dir.nr++;
 	}
 
+	to_free = dir.files;
+
 	/* This can happen even with many files, if everything was renames */
 	if (!changed)
-		return;
+		goto free_return;
 
 	/* Show all directories with more than x% of the changes */
 	QSORT(dir.files, dir.nr, dirstat_compare);
 	gather_dirstat(options, &dir, changed, "", 0);
+free_return:
+	free(to_free);
 }
 
 static void free_diffstat_file(struct diffstat_file *f)
diff --git c/t/t4047-diff-dirstat.sh w/t/t4047-diff-dirstat.sh
index 7fec2cb9cd..70224c3da1 100755
--- c/t/t4047-diff-dirstat.sh
+++ w/t/t4047-diff-dirstat.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='diff --dirstat tests'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # set up two commits where the second commit has these files
