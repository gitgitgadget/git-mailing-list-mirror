Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5513120133
	for <e@80x24.org>; Mon,  6 Mar 2017 21:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932238AbdCFVIL (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 16:08:11 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35511 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754646AbdCFVH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 16:07:59 -0500
Received: by mail-pg0-f44.google.com with SMTP id b129so70424831pgc.2
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 13:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uPJ/DKIkcCKuMHbFogJK3yf1A9OnP4NPqE1Z6fWwan8=;
        b=LCaZ37IDqdGgHXKFpCx113fiGBzBzVZEtLmqOMfgDlE7Q+4rEbPYFICEWN+CF9ZTJY
         ERZNTESw+9SrHCkuHVbhedT+rSpW+Al+CJ62yhfDW+0B6U/RQXPtE5Akxg0B+hBdVUsj
         7zFDlyBkpvAm4IT4N92jtwU2ZGCnPREuwJYbsmbb+3Kb+tNrnNzTYHSkoioFD3/Sw1hO
         RZ3b/TUo5nMpqzkvvF7YHl4T+FGwdLV3rE/9ZPG95jRZByzEsz/isZg/Kq4v20BisE1B
         tRHSGMA09eiaKRca3FTk9ZkY5VRhgBgs/qF6OHYT/fF58+LmRZbeJTz78y6ni9mWLNxY
         rn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uPJ/DKIkcCKuMHbFogJK3yf1A9OnP4NPqE1Z6fWwan8=;
        b=BLhSABaQjcltsExF7dw120nfo2j+ntBj2YmbEzBfN7Y9jS/lBwcZqjrc+iImUdhlN2
         P2TgVhUZo6qGDDE5M7AnX80TZYigleLMSIrfTkfKKv82EtRC00cHmlXoYEYfwpna8gRj
         sptdPceqBsBPQn1EKGRLx05WdElKXeNo8Z2xhMfaD+XERL4n6cs6phutHMLjsmPliVWV
         zo5bsi76VvmzRvLGGfOzDB9af3OQCLCNAxI/Z4N7PY2svF6HrCTDpGepiSiyUYyBm+IT
         q9FgbOrjNIZ/J8cC2bjY7XK64sC5AHyvhiiyncAuBfATFtPIYGRTWPuDW+pEv6bT2884
         dbYg==
X-Gm-Message-State: AMke39k2ZSUu19ZkYQr2M0CqTlv6AuQgSuF0Zr6o/+wOQkxE1ggMp5ZwHjJUU/PnyomDFhzG
X-Received: by 10.99.240.83 with SMTP id s19mr22699642pgj.45.1488833981965;
        Mon, 06 Mar 2017 12:59:41 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:44ae:633a:9d1d:6402])
        by smtp.gmail.com with ESMTPSA id b8sm41602789pgn.6.2017.03.06.12.59.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 12:59:41 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 15/18] read-cache, remove_marked_cache_entries: wipe selected submodules.
Date:   Mon,  6 Mar 2017 12:59:16 -0800
Message-Id: <20170306205919.9713-16-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170306205919.9713-1-sbeller@google.com>
References: <20170302004759.27852-1-sbeller@google.com>
 <20170306205919.9713-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 read-cache.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 9054369dd0..9a2abacf7a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -18,6 +18,8 @@
 #include "varint.h"
 #include "split-index.h"
 #include "utf8.h"
+#include "submodule.h"
+#include "submodule-config.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -520,6 +522,22 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 	return 1;
 }
 
+static void remove_submodule_according_to_strategy(const struct submodule *sub)
+{
+	switch (sub->update_strategy.type) {
+	case SM_UPDATE_UNSPECIFIED:
+	case SM_UPDATE_CHECKOUT:
+	case SM_UPDATE_REBASE:
+	case SM_UPDATE_MERGE:
+		submodule_move_head(sub->path, "HEAD", NULL, \
+				    SUBMODULE_MOVE_HEAD_FORCE);
+		break;
+	case SM_UPDATE_NONE:
+	case SM_UPDATE_COMMAND:
+		; /* Do not touch the submodule. */
+	}
+}
+
 /*
  * Remove all cache entries marked for removal, that is where
  * CE_REMOVE is set in ce_flags.  This is much more effective than
@@ -532,8 +550,13 @@ void remove_marked_cache_entries(struct index_state *istate)
 
 	for (i = j = 0; i < istate->cache_nr; i++) {
 		if (ce_array[i]->ce_flags & CE_REMOVE) {
-			remove_name_hash(istate, ce_array[i]);
-			save_or_free_index_entry(istate, ce_array[i]);
+			const struct submodule *sub = submodule_from_ce(ce_array[i]);
+			if (sub) {
+				remove_submodule_according_to_strategy(sub);
+			} else {
+				remove_name_hash(istate, ce_array[i]);
+				save_or_free_index_entry(istate, ce_array[i]);
+			}
 		}
 		else
 			ce_array[j++] = ce_array[i];
-- 
2.12.0.rc1.52.ge239d7e709.dirty

