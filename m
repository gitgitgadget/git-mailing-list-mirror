Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF516C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 23:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F5020792
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 23:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="V+j6IJs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHDXku (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 19:40:50 -0400
Received: from out1.migadu.com ([91.121.223.63]:24532 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgHDXku (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 19:40:50 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596584448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=femYbbNQgsbpy/ixJhgZf7Zn0I+/Q86eANj9Qy5qMPU=;
        b=V+j6IJs/pZcft/zAJ4jqp5zM7WTgdZFiaO5cQQ34Jbo6QCn/R50Me6clFY8j97U0XjsbXA
        EZkpaDCOWTLZF3xqGpAaS/eATiB2mGCdzRX6dQUOh+KQ/6XZbtxHVskSsWd6nO5C6hodeU
        yxTl/6moRqiw+6Z0B4bI30TbGEHkzfM=
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     git@vger.kernel.org
Cc:     "Raymond E. Pasco" <ray@ameretat.dev>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] apply: allow "new file" patches on i-t-a entries
Date:   Tue,  4 Aug 2020 19:40:03 -0400
Message-Id: <20200804234003.8948-1-ray@ameretat.dev>
In-Reply-To: <20200804223155.7727-1-ray@ameretat.dev>
References: <20200804223155.7727-1-ray@ameretat.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

diff-files recently changed to treat changes to paths marked "intent to
add" in the index as new file diffs rather than diffs from the empty
blob.  However, apply refuses to apply new file diffs on top of existing
index entries, except in the case of renames. This causes "git add -p",
which uses apply, to fail when attempting to stage hunks from a file
when intent to add has been recorded.

This changes the logic in check_to_create() which checks if an entry
already exists in an index in two ways: first, we only search for an
index entry at all if ok_if_exists is false; second, we check for the
CE_INTENT_TO_ADD flag on any index entries we find and allow the apply
to proceed if it is set.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
No substantive changes - fixed a poor explanation in the commit message.

 apply.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index 8bff604dbe..4cba4ce71a 100644
--- a/apply.c
+++ b/apply.c
@@ -3747,10 +3747,13 @@ static int check_to_create(struct apply_state *state,
 {
 	struct stat nst;
 
-	if (state->check_index &&
-	    index_name_pos(state->repo->index, new_name, strlen(new_name)) >= 0 &&
-	    !ok_if_exists)
-		return EXISTS_IN_INDEX;
+	if (state->check_index && !ok_if_exists) {
+		int pos = index_name_pos(state->repo->index, new_name, strlen(new_name));
+		if (pos >= 0 &&
+		    !(state->repo->index->cache[pos]->ce_flags & CE_INTENT_TO_ADD))
+			return EXISTS_IN_INDEX;
+	}
+
 	if (state->cached)
 		return 0;
 
-- 
2.28.0.1.g70e0b8363a

