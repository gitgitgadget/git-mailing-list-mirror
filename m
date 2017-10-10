Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9253820372
	for <e@80x24.org>; Tue, 10 Oct 2017 04:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbdJJEGP (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 00:06:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54544 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751596AbdJJEGK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 00:06:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0253AC87A;
        Tue, 10 Oct 2017 00:06:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=VYYH
        1Zi3qMJi/J3Dgt81cOsHDt0=; b=Ryvwn49ZXRkoxc8BkFgeULlBrsYrFv0kJo5Y
        ZFaN3s21DkhgOz0WMYE8Fzr1SIsBfVl3IRn2WujJCJZI3M3f4QqZj4hqATwwVtSz
        9Wj+lwGIWyup8FM5F/q1v+vhMeFO9ZGKN9T0lCJ1amizVWhbsleuQRByVR54B7ii
        XMLGjoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=UKGOEE
        3TiKiR4JJkAGxIvIKSxcxA2OB4TERAthk7ZcZPFablIHns1tr8RIoIf2iisMPy+v
        IuM+cD1avKYNIdLH4hk7rX3AOnEoDf1bQr8OyA8xVAEnQmDH9Cyxy1v/Sbt9SIjG
        KTUhdGoB0H0PZ41R39q65/YfFhAC/G5vtIIAc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9106AC879;
        Tue, 10 Oct 2017 00:06:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 525E6AC876;
        Tue, 10 Oct 2017 00:06:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] merge-ours: do not use cmd_*() as a subroutine
Date:   Tue, 10 Oct 2017 13:06:04 +0900
Message-Id: <20171010040604.26029-3-gitster@pobox.com>
X-Mailer: git-send-email 2.15.0-rc0-209-g4adfc7b6b1
In-Reply-To: <20171010040604.26029-1-gitster@pobox.com>
References: <xmqqr2vlbgyk.fsf@gitster.mtv.corp.google.com>
 <20171010040604.26029-1-gitster@pobox.com>
X-Pobox-Relay-ID: 58A90B32-AD70-11E7-A0B5-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The call to cmd_diff_index() "git merge-ours" makes has been working
by accident that the function did not call exit(3), and the caller
exited almost immediately after making a call, but it sets a bad
precedent for people to cut and paste.

For finding out if the index exactly matches the HEAD (or a given
tree-ish), there is index_differs_from() which is exactly written
for that purpose.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge-ours.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 684411694f..beb0623d56 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -9,26 +9,24 @@
  */
 #include "git-compat-util.h"
 #include "builtin.h"
+#include "diff.h"
 
 static const char builtin_merge_ours_usage[] =
 	"git merge-ours <base>... -- HEAD <remote>...";
 
-static const char *diff_index_args[] = {
-	"diff-index", "--quiet", "--cached", "HEAD", "--", NULL
-};
-#define NARGS (ARRAY_SIZE(diff_index_args) - 1)
-
 int cmd_merge_ours(int argc, const char **argv, const char *prefix)
 {
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(builtin_merge_ours_usage);
 
 	/*
-	 * We need to exit with 2 if the index does not match our HEAD tree,
-	 * because the current index is what we will be committing as the
-	 * merge result.
+	 * The contents of the current index becomes the tree we
+	 * commit.  The index must match HEAD, or this merge cannot go
+	 * through.
 	 */
-	if (cmd_diff_index(NARGS, diff_index_args, prefix))
+	if (read_cache() < 0)
+		die_errno("read_cache failed");
+	if (index_differs_from("HEAD", 0, 0))
 		exit(2);
 	exit(0);
 }
-- 
2.15.0-rc0-203-g4c8d0e28b1

