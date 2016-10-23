Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C6A620987
	for <e@80x24.org>; Sun, 23 Oct 2016 09:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756394AbcJWJ1e (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:27:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34045 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753174AbcJWJ1X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:27:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id d199so5246033wmd.1
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 02:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h8mg0Njw4P5MZ39ezfpcWtAVmgexZWK5p0SyLyl0PZ8=;
        b=CP5b8f3/Ssi41Og8n0n9mNHy/MduR5WlutBHCfya9Fwb8mKlBG8nPoV4UegbavHdG9
         Qw4G48O3aSyEznJDDC1hKJ0wgXo0buEcLeBxzUuXgFVIfH5jz2y8g7DPOMS7oAFDpGNp
         hmkEVCgFtdPVdg0fMbip9SrERG57fKkPSULuJpaoLC91GEwjKd7qH1S2bemVC3gVw/ru
         7icjdMDsLWVDc49DM3szeKGfnM33PRZM+JVDbEbJUKU91u65wuletZNZd6lavHgqYfGh
         HMrp2SDuZR81qGeGI89orKcRVMln6XNtFLnkY0fIgq5H2g0OFdm7Ml1b8Ej4eWQbw7Fi
         bQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h8mg0Njw4P5MZ39ezfpcWtAVmgexZWK5p0SyLyl0PZ8=;
        b=PryK6q3KgJPseaeELS7PlTk8U81Cp37omknqVE2lZmPn1UJb4DkBcblH06w6W8jsmT
         r2sF8e696+p0FJNSTHJNAp6TcNqxBFZsYBNxjhOLACa1GFNp0mpcPh+In0zQ1gAc5w9t
         MY8/7p1CptPflX3nN5/dI/tSpyNAxJaHw+DiLStGa2kgfrCQU/+jMvzfuEUJsRljcoVc
         fQuq+tqxMXNQr+oyd1zIStJJtI9OyUeNf+Re8wHh00V9S/JllmXlHwwpRiqSmxqwUVsI
         L3ONU9c0BlQFG2jo341ZVJ5I7Z2RchQSifROaCiHlmKxPYeG7UPc32VjHJ9pdcrg6gWP
         mTtQ==
X-Gm-Message-State: AA6/9RkFUpNKUhxOXZ82NJ13DYG8knX2TpfBOebeP0DYHOtJP3eUnTKCvIT+TUN/St/V/A==
X-Received: by 10.28.210.1 with SMTP id j1mr10582673wmg.86.1477214841512;
        Sun, 23 Oct 2016 02:27:21 -0700 (PDT)
Received: from localhost.localdomain (183.187.113.78.rev.sfr.net. [78.113.187.183])
        by smtp.gmail.com with ESMTPSA id x138sm8257569wme.14.2016.10.23.02.27.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Oct 2016 02:27:20 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 10/19] read-cache: regenerate shared index if necessary
Date:   Sun, 23 Oct 2016 11:26:39 +0200
Message-Id: <20161023092648.12086-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.1.462.g7e1e03a
In-Reply-To: <20161023092648.12086-1-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
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
 read-cache.c           | 33 ++++++++++++++++++++++++++++++++-
 t/t1700-split-index.sh |  1 +
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index bb53823..a91fabe 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2216,6 +2216,36 @@ static int write_shared_index(struct index_state *istate,
 	return ret;
 }
 
+static const int default_max_percent_split_change = 20;
+
+int too_many_not_shared_entries(struct index_state *istate)
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
@@ -2233,7 +2263,8 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		if ((v & 15) < 6)
 			istate->cache_changed |= SPLIT_INDEX_ORDERED;
 	}
-	if (istate->cache_changed & SPLIT_INDEX_ORDERED) {
+	if (istate->cache_changed & SPLIT_INDEX_ORDERED ||
+	    too_many_not_shared_entries(istate)) {
 		int ret = write_shared_index(istate, lock, flags);
 		if (ret)
 			return ret;
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index db8c39f..507a1dd 100755
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
2.10.1.462.g7e1e03a

