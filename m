Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 414D4202DD
	for <e@80x24.org>; Fri, 20 Oct 2017 01:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751504AbdJTBMA (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 21:12:00 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:51197 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbdJTBL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 21:11:57 -0400
Received: by mail-pf0-f195.google.com with SMTP id b6so8566744pfh.7
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 18:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=fX3CGOw7vXHs4/ZYckB+mUto7gMcb5bwBOMdOw6uotA=;
        b=axpqEalIMZQ3ZwPHINQvnewOpEmFx2QzSBwnnmVG1wsFi8/tHxUl0fIFh1rjhOCQ/G
         VQ/FKvLMAd4lgryoPvf+HALXZtVpnd5VNDRkhlYvk1VLz0Qw0A4h0wqMqZp39yEm49Gr
         5opoat4A8w9Urp43zgUxmxtSNOt1JXq5J6yYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=fX3CGOw7vXHs4/ZYckB+mUto7gMcb5bwBOMdOw6uotA=;
        b=BVgXyf+eKiSiB8kNyrQl79eIbyGlpQGCsSFnKvjj6DR87c7Lr0vioxZwXS9E2kAUE2
         piOHSzyb6ZIXgSZ0uZc++gOG7iHQEPvQVI1FFvLpKuJUuTqvBx3fOc04l5bys+Lk45ix
         Dan/9x0e5sXCuKdcP7AeKhkzyHjfBf+EG6DaV0xzNdkfMTCK97lHylrCkOwmE9gnYb7B
         0UuvdPjuxW5oEZM4AWJs6a7xi+vuvn01gTOJHR9JANNxXnzl/uTIbIY5aTJVe6YWC2Tx
         IZiTmhQ8byvyVnp4HbuuS/LvFm3VxVLb7n5MFooapRKMnYrz8pfdSsgaqltNV4Lc/kIv
         YsEQ==
X-Gm-Message-State: AMCzsaXafz+GHn6swHnvbew34ECOMDiIK3yIPovzlJwy8qeGtnTcpQSd
        NW7+OEQj10I2uODRgWbsXSyy8hhN6MA=
X-Google-Smtp-Source: ABhQp+Qu0Rm6m9Js7aU/UAaGnNi59W+2JP5riwehDP44hn/R8tBXWf5g5hScaTr3E0mt+8rXqEPc4A==
X-Received: by 10.84.214.136 with SMTP id j8mr2956894pli.422.1508461916825;
        Thu, 19 Oct 2017 18:11:56 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (V160-vrrp.corp.dropbox.com. [205.189.0.161])
        by smtp.gmail.com with ESMTPSA id x19sm403583pgc.60.2017.10.19.18.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Oct 2017 18:11:56 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Ben Peart <peartben@gmail.com>, Alex Vandiver <alexmv@dropbox.com>
Subject: [PATCH 4/4] fsmonitor: Delay updating state until after split index is merged
Date:   Thu, 19 Oct 2017 18:11:36 -0700
Message-Id: <05670bb6e3c6378119b1649144c80dd6d72bfe29.1508461850.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.0.rc1.417.g05670bb6e
In-Reply-To: <20171020011136.14170-1-alexmv@dropbox.com>
References: <20171020011136.14170-1-alexmv@dropbox.com>
In-Reply-To: <4f8e3dab26cf50cc6aa055605784680f5c33fcfa.1508461850.git.alexmv@dropbox.com>
References: <4f8e3dab26cf50cc6aa055605784680f5c33fcfa.1508461850.git.alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the fsmonitor extension is used in conjunction with the split index
extension, the set of entries in the index when it is first loaded is
only a subset of the real index.  This leads to only the non-"base"
index being marked as CE_FSMONITOR_VALID.

Delay the expansion of the ewah bitmap until after tweak_split_index
has been called to merge in the base index as well.

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 cache.h      |  1 +
 fsmonitor.c  | 38 ++++++++++++++++++++++++--------------
 read-cache.c |  4 ++++
 3 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/cache.h b/cache.h
index 25adcf681..0a4f43ec2 100644
--- a/cache.h
+++ b/cache.h
@@ -348,6 +348,7 @@ struct index_state {
 	unsigned char sha1[20];
 	struct untracked_cache *untracked;
 	uint64_t fsmonitor_last_update;
+	struct ewah_bitmap *fsmonitor_dirty;
 };
 
 extern struct index_state the_index;
diff --git a/fsmonitor.c b/fsmonitor.c
index 7c1540c05..4c2668f57 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -49,20 +49,7 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
 		ewah_free(fsmonitor_dirty);
 		return error("failed to parse ewah bitmap reading fsmonitor index extension");
 	}
-
-	if (git_config_get_fsmonitor()) {
-		/* Mark all entries valid */
-		for (i = 0; i < istate->cache_nr; i++)
-			istate->cache[i]->ce_flags |= CE_FSMONITOR_VALID;
-
-		/* Mark all previously saved entries as dirty */
-		ewah_each_bit(fsmonitor_dirty, fsmonitor_ewah_callback, istate);
-
-		/* Now mark the untracked cache for fsmonitor usage */
-		if (istate->untracked)
-			istate->untracked->use_fsmonitor = 1;
-	}
-	ewah_free(fsmonitor_dirty);
+	istate->fsmonitor_dirty = fsmonitor_dirty;
 
 	trace_printf_key(&trace_fsmonitor, "read fsmonitor extension successful");
 	return 0;
@@ -238,6 +225,29 @@ void remove_fsmonitor(struct index_state *istate)
 
 void tweak_fsmonitor(struct index_state *istate)
 {
+	int i;
+
+	if (istate->fsmonitor_dirty) {
+		/* Mark all entries valid */
+		trace_printf_key(&trace_fsmonitor, "fsmonitor is enabled; cache is %d", istate->cache_nr);
+		for (i = 0; i < istate->cache_nr; i++) {
+			istate->cache[i]->ce_flags |= CE_FSMONITOR_VALID;
+		}
+		trace_printf_key(&trace_fsmonitor, "marked all as valid");
+
+		/* Mark all previously saved entries as dirty */
+		trace_printf_key(&trace_fsmonitor, "setting each bit on %p", istate->fsmonitor_dirty);
+		ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
+
+		/* Now mark the untracked cache for fsmonitor usage */
+		trace_printf_key(&trace_fsmonitor, "setting untracked state");
+		if (istate->untracked)
+			istate->untracked->use_fsmonitor = 1;
+		ewah_free(istate->fsmonitor_dirty);
+	} else {
+		trace_printf_key(&trace_fsmonitor, "fsmonitor not enabled");
+	}
+
 	switch (git_config_get_fsmonitor()) {
 	case -1: /* keep: do nothing */
 		break;
diff --git a/read-cache.c b/read-cache.c
index c18e5e623..3b5cd00a2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -330,6 +330,10 @@ int ie_match_stat(struct index_state *istate,
 		return 0;
 	if (!ignore_fsmonitor && (ce->ce_flags & CE_FSMONITOR_VALID))
 		return 0;
+	if (ce->ce_flags & CE_FSMONITOR_VALID)
+		trace_printf_key(&trace_fsmonitor, "fsmon marked valid for %s", ce->name);
+	if (ignore_fsmonitor)
+		trace_printf_key(&trace_fsmonitor, "Ignoring fsmonitor for %s", ce->name);
 
 	/*
 	 * Intent-to-add entries have not been added, so the index entry
-- 
2.15.0.rc1.417.g05670bb6e

