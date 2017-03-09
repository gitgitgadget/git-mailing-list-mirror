Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07286202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753818AbdCIWQ1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:16:27 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35646 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753281AbdCIWQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:16:25 -0500
Received: by mail-pg0-f48.google.com with SMTP id b129so31148537pgc.2
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 14:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zeD6szu/+5bTQ5Aibs+vZwGk3ZcXdrmvov1l8eVBiew=;
        b=N/Npo1oUwvi9gfEdGbrQ64L//UbqOMuhaVZO04BJxyuvTL75JcGcd2a/Cn0pTn3QsZ
         RBNLkZCi2VWKrvcxK835MOFh3hOJ2G73Scbw9lKai5ULvWpZFUMGBNFGN/41nkwg7Sfm
         gwbGrTEKvOFQh7iwTr0c3S9GEMa6AZLbZUFlVYHCVAFgZ9JvqznGkk6EC/U8g3ICMY2+
         BcmxQ0/G0/b+IGuR0Mu62eXTeAZs+5ZP7CrcOnXfWyKFEEs9yqQoIpnG2TN5WxxsPVu4
         RGMwD1EfmT8hRz9cP1Ubb9/XD7XMCnBFeITRCssdIArtzkOJGOwvbWfsssiCngu5RIL4
         5dCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zeD6szu/+5bTQ5Aibs+vZwGk3ZcXdrmvov1l8eVBiew=;
        b=j8Dsrr+JGltr7lqIcdgncOBnNH9cZnEzCVpdO/NBs9WMv2D4wSzZzH20tENFBcCM3t
         yEmp3tEbWFMX/eA2Up/7JIxeHoPaThr+doBMkEeR4kJOfbVY9W7LLoL8cgvNcSuCEwLH
         EqtDkhpvMk8R0iT+fQAZCN6mkwCPvPL1hMDhWg6xuR+J3Jrz/SzIh43pRKjlbf80ueyI
         3ApthpqubjV2iy6RSHJghaiJLOQaJEhFzgfpp4xzs+2/gQjxn+2HAaw/27aUA/YiNmRe
         AOElg7DoUqMMbkkORIWHv5S9cM0JN6sMuv60brYfkglvHMoYYI0ViuLlIBKTedwEIb6U
         P+vA==
X-Gm-Message-State: AMke39nRiWc6kN6uycBjIlWNP6jB+07XN62TPJKL2RjipyMaq/c8/1v8u7A1GH56iZ6yIYdO
X-Received: by 10.99.211.21 with SMTP id b21mr16396241pgg.166.1489097774417;
        Thu, 09 Mar 2017 14:16:14 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:7494:19e8:830b:a2d7])
        by smtp.gmail.com with ESMTPSA id z74sm14316786pfd.70.2017.03.09.14.16.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 14:16:13 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 15/17] entry.c: create submodules when interesting
Date:   Thu,  9 Mar 2017 14:15:41 -0800
Message-Id: <20170309221543.15897-16-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.45.gf291f29c2e
In-Reply-To: <20170309221543.15897-1-sbeller@google.com>
References: <20170306205919.9713-1-sbeller@google.com>
 <20170309221543.15897-1-sbeller@google.com>
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
2.12.0.rc1.45.g207f5fbb2b

