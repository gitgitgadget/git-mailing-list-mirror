Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78C28200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 10:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755588AbcLZKWs (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:22:48 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35844 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755539AbcLZKWq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:46 -0500
Received: by mail-wm0-f67.google.com with SMTP id m203so52438042wma.3
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t1lhgu45L979B0iaSNYy2Js3DIq8NALLyYjorlUSrLc=;
        b=vMdlAbAP+9js7WgdYp+OxcousRF+ChdeODBs3ZtbCreGwQ93CGIJG52UrL7fT2nhHg
         M4QHtxjTXwD4j/NGCGP8FJahAY1yHr3I/pruJT0O/ZGI1EJUmz/opuJdb4lcXs/XsWF0
         QYxCBaIDOWzXnWmhqk09ESda/CwQ+IXInboo2a5gfQtIcdObPUYl4fG7w03P83JmkZW/
         eFTg9JhfP2sKWxJBaDyq+/Hi+L7Vn9jbxGFO2E70hJGBW2T6NhDEik4eRCtcGDARV8th
         IRLNCl+uEKhDgXTqV8PZ4Qyx4srPziN1WDpB0wwpjBZSsZE0mYUQ8JES2x/Z53XFfRde
         R2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t1lhgu45L979B0iaSNYy2Js3DIq8NALLyYjorlUSrLc=;
        b=GUouv5Ta7qdncAWtigdcpdwcGKsbQkah+J0fmrBu5DByFY/KkxQ7sGiC1j7fF9KZe/
         mX5nCtGd79AVR8zfbRoewz9swYzEjUOlg1ArS+n1MN10gnmb22QgXZVvRVx0hk6Zv30p
         51KCoFIxQe7LVNZ+IkepfN5vOi6r4fsPv9xmFNOpbqtawXrCYXj1JyAUsWX6OUbXejdy
         hEj76rWOOgX1beRlE7doxXAoeHE4yBVjXwqrym6guCiLh4lAerAOP73kD7gD74g9PAgJ
         lb7a3YflP6DbcmgZiuIqYAzOVaQ13uWmQHJgijBjlpN8ualSUcYTDSo/zS3gmrOctdwR
         I6ag==
X-Gm-Message-State: AIkVDXKZmcoEG+mxcKpUi0BmRPn2zZOVHi4VRkeRK43oF8z/kYqmofYdIMMzFL0cP3oCWg==
X-Received: by 10.28.94.76 with SMTP id s73mr27023063wmb.107.1482747764793;
        Mon, 26 Dec 2016 02:22:44 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:44 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 10/21] read-cache: regenerate shared index if necessary
Date:   Mon, 26 Dec 2016 11:22:11 +0100
Message-Id: <20161226102222.17150-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
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
index 732b7fe611..a1aaec5135 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2220,6 +2220,36 @@ static int write_shared_index(struct index_state *istate,
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
+		; /* do nothing: just use the configured value */
+	}
+
+	/* Count not shared entries */
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
+		if (!ce->index)
+			not_shared++;
+	}
+
+	return istate->cache_nr * max_split < not_shared * 100;
+}
+
 int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		       unsigned flags)
 {
@@ -2237,6 +2267,8 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		if ((v & 15) < 6)
 			istate->cache_changed |= SPLIT_INDEX_ORDERED;
 	}
+	if (too_many_not_shared_entries(istate))
+		istate->cache_changed |= SPLIT_INDEX_ORDERED;
 	if (istate->cache_changed & SPLIT_INDEX_ORDERED) {
 		int ret = write_shared_index(istate, lock, flags);
 		if (ret)
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index db8c39f446..507a1dd1ad 100755
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
2.11.0.209.gda91e66374.dirty

