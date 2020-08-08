Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1A0C433DF
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 07:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C939A20866
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 07:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="g8hu1X6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgHHHuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 03:50:37 -0400
Received: from out0.migadu.com ([94.23.1.103]:3744 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgHHHug (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 03:50:36 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596873034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hPeQKFxAssJx5Lfu/P4nxtQNXz5ArYDISlSqf0LkUr0=;
        b=g8hu1X6pt7dINZh2hZaOE1AZvGomJQTAMFXhjvvDvctKVbKJ71JcL9OhKlQGoWfUbqvcCa
        eyHZ36YzPA6phjPShIUY95bUXRToutv5tJ6ChwaYixsOI97C4S/lZPq8IP7LXW7z+tdmGe
        zynoUk8FNJQpORurNBms/h6fk6HcWUQ=
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, "Raymond E. Pasco" <ray@ameretat.dev>
Subject: [PATCH v5 2/3] apply: make i-t-a entries never match worktree
Date:   Sat,  8 Aug 2020 03:49:58 -0400
Message-Id: <20200808074959.35943-3-ray@ameretat.dev>
In-Reply-To: <20200808074959.35943-1-ray@ameretat.dev>
References: <20200806060119.74587-1-ray@ameretat.dev>
 <20200808074959.35943-1-ray@ameretat.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By definition, an intent-to-add index entry can never match the
worktree, because worktrees have no concept of intent-to-add entries.
Therefore, "apply --index" should always fail on intent-to-add paths.

Because check_preimage() calls verify_index_match(), it already fails
for patches other than creation patches, which check_preimage() ignores.
This patch adds a check to check_preimage()'s rough equivalent for
creation patches, check_to_create().

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
 apply.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/apply.c b/apply.c
index 4cba4ce71a..c5ecb64102 100644
--- a/apply.c
+++ b/apply.c
@@ -3740,6 +3740,7 @@ static int check_preimage(struct apply_state *state,
 
 #define EXISTS_IN_INDEX 1
 #define EXISTS_IN_WORKTREE 2
+#define EXISTS_IN_INDEX_AS_ITA 3
 
 static int check_to_create(struct apply_state *state,
 			   const char *new_name,
@@ -3747,11 +3748,21 @@ static int check_to_create(struct apply_state *state,
 {
 	struct stat nst;
 
-	if (state->check_index && !ok_if_exists) {
-		int pos = index_name_pos(state->repo->index, new_name, strlen(new_name));
-		if (pos >= 0 &&
-		    !(state->repo->index->cache[pos]->ce_flags & CE_INTENT_TO_ADD))
-			return EXISTS_IN_INDEX;
+	if (state->check_index && (!ok_if_exists || !state->cached)) {
+		int pos;
+
+		pos = index_name_pos(state->repo->index, new_name, strlen(new_name));
+		if (pos >= 0) {
+			struct cache_entry *ce = state->repo->index->cache[pos];
+
+			/* allow ITA, as they do not yet exist in the index */
+			if (!ok_if_exists && !(ce->ce_flags & CE_INTENT_TO_ADD))
+				return EXISTS_IN_INDEX;
+
+			/* ITA entries can never match working tree files */
+			if (!state->cached && (ce->ce_flags & CE_INTENT_TO_ADD))
+				return EXISTS_IN_INDEX_AS_ITA;
+		}
 	}
 
 	if (state->cached)
@@ -3938,6 +3949,9 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 		case EXISTS_IN_INDEX:
 			return error(_("%s: already exists in index"), new_name);
 			break;
+		case EXISTS_IN_INDEX_AS_ITA:
+			return error(_("%s: does not match index"), new_name);
+			break;
 		case EXISTS_IN_WORKTREE:
 			return error(_("%s: already exists in working directory"),
 				     new_name);
-- 
2.28.0.5.gfc8e108108

