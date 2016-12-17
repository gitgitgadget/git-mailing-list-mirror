Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A01E1FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758563AbcLQO4v (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:51 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36518 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757128AbcLQO4P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:15 -0500
Received: by mail-wm0-f68.google.com with SMTP id m203so10562129wma.3
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4NIKHUy+rgtl+FbCzFDCSksavPyJFpWho8R0Eytg1cE=;
        b=QE7eoy3HyoVNK6YCqORaQH0e/I3izkK3uYd+JPmjxRAkVKmRZ532P6NX6Ot606lBcj
         XTt03IX0j1hIwARLes5adPob3fVg5ezTyCeVOQ+gTq3JeFJ42O3PrRqy5wTHW0lnBTU3
         0F5icWlpL/cP/dgHM/Sxz/1dCyXyKXMoHsr+xJEZXQZow3TN5OkiwrDc6j9/peiCgUSX
         DcNsQeY6Wbg8vNztRfsyO8uNkwfJ0V6Y2hUKNrNeKc1iTPLmMPLSVaM8EQwGvWOksjmW
         +gR+kmja/BINfdcZlEIs3Vsl9S6au8BBFEE5GzzxPHJdkZJUNIo7aIyF08Bte/7Kztqa
         r9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4NIKHUy+rgtl+FbCzFDCSksavPyJFpWho8R0Eytg1cE=;
        b=ZxAwiX3GbcE6u4qjHgeRoGtSB/IiX7c4M3Z4lNzegkGTGgAlzlN2RxOssd8NpchCGW
         UiwA6UTM7A4TtlT7NyNNq06bEYeLyFpPMdDS3jS5/IgJi2dtDcrR6u9M3F8/GC1MdxN0
         Ef18wYBmew0cgJHjbxA/Qo278KvMt1yXh1URf60wyNrVGybJVLaMA2DK6gjtFyqmEoxT
         1tvHUhBQ7PzA4i1bUQFCTYrvo54GZuPe3fml8LJMtUyPIA8R38LMuQbcot2GhCpsXEkk
         IzjXCBU862P1afg/vJPAtvXxncWbQby9MO0d+W2s03DUuocfmVyi0o6jgKeAkdmiud19
         3bYg==
X-Gm-Message-State: AIkVDXIS+ZcQJDMvdKCJTmaQdl6JzR/qsQDsS/uqBYsKI2S6l3CnaISsPyrOaw7gB332eA==
X-Received: by 10.28.227.9 with SMTP id a9mr7271255wmh.85.1481986574274;
        Sat, 17 Dec 2016 06:56:14 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:13 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 10/21] read-cache: regenerate shared index if necessary
Date:   Sat, 17 Dec 2016 15:55:36 +0100
Message-Id: <20161217145547.11748-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
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
index 79aae6bd20..280b01bd6c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2223,6 +2223,36 @@ static int write_shared_index(struct index_state *istate,
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
@@ -2240,6 +2270,8 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
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
2.11.0.49.g2414764.dirty

