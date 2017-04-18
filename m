Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFF7A207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 21:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754377AbdDRVhl (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 17:37:41 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34157 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbdDRVhj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 17:37:39 -0400
Received: by mail-pg0-f44.google.com with SMTP id s64so2404183pgb.1
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 14:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l/by+mbPVn9yxye8Ba0XhXgA4URfBfcG/mJbLimPAgE=;
        b=raBchVLLEUX6qI9/xI62gcLLVtR1Ui7OKvh7ALyaT6ECH/CleqT9fRG+3rLlmUW3sx
         QmCxqW99djYWyBtBNsmRYWDl0BmSHzCVB3BY7s0ffSvZe4TsChuuhNHuYvx8VenJmTLR
         WD5ICKgE8gCbX+2wcRRRuGsCtXYiWTm2pELknGEjoSTd/zJjNlWO7wQeWxTlus0f7oqB
         SZNgKCIIirRQfi4tuTCocdBYlrc5gQz4AN3WwUcSv/Lp6M0n29JN5EM9AS8CmfIizeSk
         SiakFFelT5xERLoZqu9KG851r4EFU6fGTCuLWMZwhW5S+WR6TnecHyZ1OLWDEmqnofhQ
         IyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l/by+mbPVn9yxye8Ba0XhXgA4URfBfcG/mJbLimPAgE=;
        b=ID/4KG8a3XBwUf8YijmWC7DyWjAz2F7kqA510E2VABfeisbP3Mckb3jDEm7w5TRwA7
         ofFzXmSU7lE1mlROOiGv+XsBfIl5Ng4RNy53NYaxGh6B4ZIseh63ih0YqY8a/436+Lxl
         MXiJDtDNQuYkJh02NWUsCDIqwp0PM8A/T3ObWGeVLLStkHXWSa4o3Z6SE5Q0+6UYzTj6
         xG2hDMuW6v/uA5XDo72Bgr93BKyMBP+DB3wDS9jKwYuA7U6lgU0kvWkuKvrwtFA2Ff1u
         ehCBk4kjZYkxNiCmZFBXW53tO5fYmQp24mIB44bwlWsSWMyKaanqjyUoz8Vr+zC3lO1k
         amUw==
X-Gm-Message-State: AN3rC/6vX/BSvNtsE45WzMTRdJTjjVQzJmdiN3ziprDuEr/qn/Pvvq41
        XaGZZVbhBAhK2wpV
X-Received: by 10.99.129.194 with SMTP id t185mr20001779pgd.57.1492551458431;
        Tue, 18 Apr 2017 14:37:38 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c47b:4f4d:6233:ff9f])
        by smtp.gmail.com with ESMTPSA id a184sm313370pfb.118.2017.04.18.14.37.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 14:37:37 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        jonathantanmy@google.com, philipoakley@iee.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 1/4] entry.c: submodule recursing: respect force flag correctly
Date:   Tue, 18 Apr 2017 14:37:22 -0700
Message-Id: <20170418213725.7901-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.642.g1b8cc69eee.dirty
In-Reply-To: <20170418213725.7901-1-sbeller@google.com>
References: <20170418213725.7901-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In case of a non-forced worktree update, the submodule movement is tested
in a dry run first, such that it doesn't matter if the actual update is
done via the force flag. However for correctness, we want to give the
flag as specified by the user. All callers have been inspected and updated
if needed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 entry.c        | 8 ++++----
 unpack-trees.c | 7 ++++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/entry.c b/entry.c
index d2b512da90..d6b263f78e 100644
--- a/entry.c
+++ b/entry.c
@@ -208,7 +208,8 @@ static int write_entry(struct cache_entry *ce,
 		sub = submodule_from_ce(ce);
 		if (sub)
 			return submodule_move_head(ce->name,
-				NULL, oid_to_hex(&ce->oid), SUBMODULE_MOVE_HEAD_FORCE);
+				NULL, oid_to_hex(&ce->oid),
+				state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
 		break;
 	default:
 		return error("unknown file mode for %s in index", path);
@@ -282,12 +283,11 @@ int checkout_entry(struct cache_entry *ce,
 					unlink_or_warn(ce->name);
 
 				return submodule_move_head(ce->name,
-					NULL, oid_to_hex(&ce->oid),
-					SUBMODULE_MOVE_HEAD_FORCE);
+					NULL, oid_to_hex(&ce->oid), 0);
 			} else
 				return submodule_move_head(ce->name,
 					"HEAD", oid_to_hex(&ce->oid),
-					SUBMODULE_MOVE_HEAD_FORCE);
+					state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
 		}
 
 		if (!changed)
diff --git a/unpack-trees.c b/unpack-trees.c
index 6b7356dab2..4b3f9518e5 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -252,14 +252,18 @@ static int check_submodule_move_head(const struct cache_entry *ce,
 				     const char *new_id,
 				     struct unpack_trees_options *o)
 {
+	unsigned flags = SUBMODULE_MOVE_HEAD_DRY_RUN;
 	const struct submodule *sub = submodule_from_ce(ce);
 	if (!sub)
 		return 0;
 
+	if (o->reset)
+		flags |= SUBMODULE_MOVE_HEAD_FORCE;
+
 	switch (sub->update_strategy.type) {
 	case SM_UPDATE_UNSPECIFIED:
 	case SM_UPDATE_CHECKOUT:
-		if (submodule_move_head(ce->name, old_id, new_id, SUBMODULE_MOVE_HEAD_DRY_RUN))
+		if (submodule_move_head(ce->name, old_id, new_id, flags))
 			return o->gently ? -1 :
 				add_rejected_path(o, ERROR_WOULD_LOSE_SUBMODULE, ce->name);
 		return 0;
@@ -308,6 +312,7 @@ static void unlink_entry(const struct cache_entry *ce)
 		case SM_UPDATE_CHECKOUT:
 		case SM_UPDATE_REBASE:
 		case SM_UPDATE_MERGE:
+			/* state.force is set at the caller. */
 			submodule_move_head(ce->name, "HEAD", NULL,
 					    SUBMODULE_MOVE_HEAD_FORCE);
 			break;
-- 
2.12.2.642.g1b8cc69eee.dirty

