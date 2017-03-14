Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0B9E20951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbdCNVrM (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:47:12 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33128 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752166AbdCNVrL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:47:11 -0400
Received: by mail-pf0-f182.google.com with SMTP id w189so75909485pfb.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 14:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2cJbn8fNjYEAY44D7cGYlFY+lDA5vvCfdw87gz5PLwA=;
        b=kufRUjgJBX/i6Uv0XK0Ss44kgKoprEPichfg5A3jMFa0n2dF1/xqFf29Zw74hbSSJt
         Ef/R94XnCO2YstnGEC9gYyorzBlu0KfYufXtWwJygelYbK047Kwcg1zgI3oOHomYd/jU
         0qt3rciMExtkGtahS5idITb/uDBrNTnbBBnvXPWqu25baQq+kTU8RgjhZLceooGlvBb4
         00VlQrPUOmeuFX7/uZrs1Q8mUzAVoyDCj5Gh0pHXM7aTTGFMtAC1qgomdg5SKugrehv0
         WLoQzz/fyspa+FCadqdOdjKYq4ibJFxF8l27xEAC5A03fF26YUSQ+g8X9ETZTiy0MrUV
         ylww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2cJbn8fNjYEAY44D7cGYlFY+lDA5vvCfdw87gz5PLwA=;
        b=ShtPldrJkIx3F5gjyYCAaDhI0Zzy81BcaD6pgS2anVm9yXq3hI1UvbSZs68i42Swrz
         /jd33xJ1X19C2bndZFNEKRwJhoUcgU+GSmRiISYV3+uk9Z0+T7qV5W/QoSORb8PdcoEB
         9ygbR6aIOiBTgaW/T0lcGDOvhkx0Xlg4n3/hqvZFFt9wk9DTkjdvAyAToYXcz0OHdg40
         NLU0Ihr3akV/3YxDbVufDfmhFQ/rATrKy2GcY9v5ksY+H7BOmCjlATRBHRvW0GrN9dbX
         9GuVh+ZZFXfUoLgvRyJN4wSPGCGAf9cb/rYt3pdf++unhm9M3W6Dr2pSzRS8VeIaZO3J
         UWfg==
X-Gm-Message-State: AMke39m/WGgSBSevIXptYy8RUcxZ+K68H/7iwRgWjk897J0kACK63ejEuGSNO8OMGWZ4fupF
X-Received: by 10.84.232.134 with SMTP id i6mr59471617plk.101.1489528029801;
        Tue, 14 Mar 2017 14:47:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:8559:2c0d:dab3:f802])
        by smtp.gmail.com with ESMTPSA id x15sm40608904pgc.16.2017.03.14.14.47.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 14:47:09 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 17/19] entry.c: create submodules when interesting
Date:   Tue, 14 Mar 2017 14:46:40 -0700
Message-Id: <20170314214642.7701-18-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.g0cfd38c5f6.dirty
In-Reply-To: <20170314214642.7701-1-sbeller@google.com>
References: <20170309221543.15897-1-sbeller@google.com>
 <20170314214642.7701-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a submodule is introduced with a new revision
we need to create the submodule in the worktree as well.
As 'submodule_move_head' handles edge cases, all we have
to do is call it from within the function that creates
new files in the working tree for workingtree operations.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 entry.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/entry.c b/entry.c
index c6eea240b6..d2b512da90 100644
--- a/entry.c
+++ b/entry.c
@@ -2,6 +2,7 @@
 #include "blob.h"
 #include "dir.h"
 #include "streaming.h"
+#include "submodule.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -146,6 +147,7 @@ static int write_entry(struct cache_entry *ce,
 	unsigned long size;
 	size_t wrote, newsize = 0;
 	struct stat st;
+	const struct submodule *sub;
 
 	if (ce_mode_s_ifmt == S_IFREG) {
 		struct stream_filter *filter = get_stream_filter(ce->name,
@@ -203,6 +205,10 @@ static int write_entry(struct cache_entry *ce,
 			return error("cannot create temporary submodule %s", path);
 		if (mkdir(path, 0777) < 0)
 			return error("cannot create submodule directory %s", path);
+		sub = submodule_from_ce(ce);
+		if (sub)
+			return submodule_move_head(ce->name,
+				NULL, oid_to_hex(&ce->oid), SUBMODULE_MOVE_HEAD_FORCE);
 		break;
 	default:
 		return error("unknown file mode for %s in index", path);
@@ -259,7 +265,31 @@ int checkout_entry(struct cache_entry *ce,
 	strbuf_add(&path, ce->name, ce_namelen(ce));
 
 	if (!check_path(path.buf, path.len, &st, state->base_dir_len)) {
+		const struct submodule *sub;
 		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
+		/*
+		 * Needs to be checked before !changed returns early,
+		 * as the possibly empty directory was not changed
+		 */
+		sub = submodule_from_ce(ce);
+		if (sub) {
+			int err;
+			if (!is_submodule_populated_gently(ce->name, &err)) {
+				struct stat sb;
+				if (lstat(ce->name, &sb))
+					die(_("could not stat file '%s'"), ce->name);
+				if (!(st.st_mode & S_IFDIR))
+					unlink_or_warn(ce->name);
+
+				return submodule_move_head(ce->name,
+					NULL, oid_to_hex(&ce->oid),
+					SUBMODULE_MOVE_HEAD_FORCE);
+			} else
+				return submodule_move_head(ce->name,
+					"HEAD", oid_to_hex(&ce->oid),
+					SUBMODULE_MOVE_HEAD_FORCE);
+		}
+
 		if (!changed)
 			return 0;
 		if (!state->force) {
-- 
2.12.0.rc1.49.g0cfd38c5f6.dirty

