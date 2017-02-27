Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3DDF1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbdB0SCP (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:02:15 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35903 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdB0SCD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:02:03 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so14639168wmd.3
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G0nVR4C64YLT7FYhmLACr92YPyt89Sd+NdTOAPrLpmo=;
        b=alk2AZj5UXF1pFM5IXCFuNkdzpTRBqfDRohc7VXS6xZ8Mb8pdeWOTd41K+MJYQzmgI
         ckTK0HHBN/ff5r1daCDyuKaF97dfOSXCCPmVlDlApE/XB5cEgNKqyvlrQ67JgTIIXXpg
         XFjAGN4jFLk2Fed4zoF5ktTLPwNXxh2FhUkyIKcTha4TlzbCNxif0czMtqzKX+pgNoDV
         egF4c710z+XJpvorCejfaolxDuc2BpJ/CGwcX3/rxYhzuTAtzWq9kTKWeQA8c2WZ2kJU
         l9QEYXkrR5X3BmMo7W7HCLdo4OMaBkJIAnLxua6V4xuet7Ev/r6hwRUqKibce8OqFNMP
         uNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G0nVR4C64YLT7FYhmLACr92YPyt89Sd+NdTOAPrLpmo=;
        b=bANACyx+RfDG/yBnY3og96c3oUdWPrtuujmmK/NA6CSM10QnllfNhNxHnZ/JNe+Lfu
         qfphjNRbkDEG7+9hbWTc3VoPnReIaaXfgFCqVl358348UqrJXwL8auu/r/YQ66I3LYY7
         ik07ovtH0n/a9sn8OKH7yvQxVY6qu3ODUC/w4Vq9ebAWKij5L7IpS0Ua8vH87eo6nAcC
         QXJeciDJwFo4cOX6Z7a+S1HsXyQTREdZk6aCHzpbYcWjANyTspg1SeCzvjdsmOEA12xR
         IVPHS82l9Vzbn2PLGc0PTxJ8fKIVQ38KFgrQtqrZSXhRz3y0WjBZnhAiTnsXm0Dxhbi6
         Y8Rg==
X-Gm-Message-State: AMke39kMoxKSAyyWZzdjoXOhBNxlH1Wr35Hgoxo3CxH9YwEZy8b7Tt1Q40DTNQfknCh+Og==
X-Received: by 10.28.184.198 with SMTP id i189mr13617334wmf.26.1488218452139;
        Mon, 27 Feb 2017 10:00:52 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:00:51 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 11/22] read-cache: regenerate shared index if necessary
Date:   Mon, 27 Feb 2017 19:00:08 +0100
Message-Id: <20170227180019.18666-12-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing a new split-index and there is a big number of cache
entries in the split-index compared to the shared index, it is a
good idea to regenerate the shared index.

By default when the ratio reaches 20%, we will push back all
the entries from the split-index into a new shared index file
instead of just creating a new split-index file.

The threshold can be configured using the
"splitIndex.maxPercentChange" config variable.

We need to adjust the existing tests in t1700 by setting
"splitIndex.maxPercentChange" to 100 at the beginning of t1700,
as the existing tests are assuming that the shared index is
regenerated only when `git update-index --split-index` is used.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 read-cache.c           | 32 ++++++++++++++++++++++++++++++++
 t/t1700-split-index.sh |  1 +
 2 files changed, 33 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 99bc274b8d..aeb413a508 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2212,6 +2212,36 @@ static int write_shared_index(struct index_state *istate,
 	return ret;
 }
 
+static const int default_max_percent_split_change = 20;
+
+static int too_many_not_shared_entries(struct index_state *istate)
+{
+	int i, not_shared = 0;
+	int max_split = git_config_get_max_percent_split_change();
+
+	switch (max_split) {
+	case -1:
+		/* not or badly configured: use the default value */
+		max_split = default_max_percent_split_change;
+		break;
+	case 0:
+		return 1; /* 0% means always write a new shared index */
+	case 100:
+		return 0; /* 100% means never write a new shared index */
+	default:
+		break; /* just use the configured value */
+	}
+
+	/* Count not shared entries */
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
+		if (!ce->index)
+			not_shared++;
+	}
+
+	return (int64_t)istate->cache_nr * max_split < (int64_t)not_shared * 100;
+}
+
 int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		       unsigned flags)
 {
@@ -2229,6 +2259,8 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		if ((v & 15) < 6)
 			istate->cache_changed |= SPLIT_INDEX_ORDERED;
 	}
+	if (too_many_not_shared_entries(istate))
+		istate->cache_changed |= SPLIT_INDEX_ORDERED;
 	if (istate->cache_changed & SPLIT_INDEX_ORDERED) {
 		int ret = write_shared_index(istate, lock, flags);
 		if (ret)
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 1659986d8d..df19b812fd 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -8,6 +8,7 @@ test_description='split index mode tests'
 sane_unset GIT_TEST_SPLIT_INDEX
 
 test_expect_success 'enable split index' '
+	git config splitIndex.maxPercentChange 100 &&
 	git update-index --split-index &&
 	test-dump-split-index .git/index >actual &&
 	indexversion=$(test-index-version <.git/index) &&
-- 
2.12.0.22.g0672473d40

