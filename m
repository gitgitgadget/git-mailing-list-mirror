Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0329EC433E1
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 16:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE97B2177B
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 16:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="ELfjV+qg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbgHDQd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:33:57 -0400
Received: from out0.migadu.com ([94.23.1.103]:11776 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729854AbgHDQdv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 12:33:51 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596558820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MXpAgzSbmbpX7qx+GlMu9Hv05b0oSfjaq6gfY2h+PKI=;
        b=ELfjV+qgTTHU4RJcu+xk+bcy9ALa2oIjePVgfTmKJtgCJRlgsGW+g1k8m+yqQJQ8rIcaIz
        hd4n0X6hPC3P4dNRR1HJhRSgVBJWw8umsc+S3C1sfsnxHgyAW/AYTK9W6EQ0JFHUOL7oyw
        h8RQ6VDLB3S68xJUbL19CZN8OVyYzwQ=
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     git@vger.kernel.org
Cc:     "Raymond E. Pasco" <ray@ameretat.dev>
Subject: [PATCH] apply: Allow "new file" patches on i-t-a entries
Date:   Tue,  4 Aug 2020 12:33:20 -0400
Message-Id: <20200804163320.61167-1-ray@ameretat.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

diff-files recently changed to treat "intent to add" entries as new file
diffs rather than diffs from the empty blob. However, apply refuses to
apply new file diffs on top of existing index entries, except in the
case of renames. This causes "git add -p", which uses apply, to fail
when attempting to stage hunks from a file when intent to add has been
recorded.

This adds an additional check to check_to_create() which tests if the
CE_INTENT_TO_ADD flag is set on an existing index entry, and allows the
apply to proceed if so.
---
cf. <5BDF4B85-7AC1-495F-85C3-D429E3E51106@gmail.com>
 apply.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index 8bff604dbe..b31bd0e866 100644
--- a/apply.c
+++ b/apply.c
@@ -3747,10 +3747,20 @@ static int check_to_create(struct apply_state *state,
 {
 	struct stat nst;
 
-	if (state->check_index &&
-	    index_name_pos(state->repo->index, new_name, strlen(new_name)) >= 0 &&
-	    !ok_if_exists)
-		return EXISTS_IN_INDEX;
+	if (state->check_index) {
+		struct cache_entry *ce = NULL;
+		int intent_to_add;
+		int pos = index_name_pos(state->repo->index, new_name, strlen(new_name));
+		if (pos >= 0)
+			ce = state->repo->index->cache[pos];
+		if (ce && (ce->ce_flags & CE_INTENT_TO_ADD))
+			intent_to_add = 1;
+		else
+			intent_to_add = 0;
+		if (pos >= 0 && !intent_to_add && !ok_if_exists)
+			return EXISTS_IN_INDEX;
+	}
+
 	if (state->cached)
 		return 0;
 
-- 
2.28.0

