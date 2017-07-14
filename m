Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D91A720357
	for <e@80x24.org>; Fri, 14 Jul 2017 22:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbdGNW2t (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 18:28:49 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35857 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbdGNW2s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 18:28:48 -0400
Received: by mail-pf0-f173.google.com with SMTP id q86so51309971pfl.3
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 15:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xFvUkUutcivGg7OtH48ssFSKSDDbXgMnOMjKfOrs+Ag=;
        b=gqlwOa1F0sG+dOAIBKhfhz92h+CF8t6MLzHg1dqcHMJd1FA2Rh+NyOnS5WK+0u9Biq
         XOnoU0O/X0hDRAb0wetHY5AXxk0KiDio1xZb/BGw8ImCWfE1VFUB4/7Eug0zO6Xv/IkE
         gISGnnhFfz1DqPGdcPef/JUrLXgu3JeWDHuOnHU7yio7/LRf91tW4Gxd34L+o6P4uUC8
         yj4Sg4Fm29Ky4tG3qCuqAKCSse8uDo+JybbtVfN9fBI9oNu/Ah5kbGe0B64aWN0Z/94s
         UATgB7JYTFAGWPUSoN50tyomEonsHrR43FIfKduTaooMHMswHDuA8gXiD4QSrvG3qkbr
         wN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xFvUkUutcivGg7OtH48ssFSKSDDbXgMnOMjKfOrs+Ag=;
        b=HUneq20LWwVLvwWuiohpj/1YRy2XUx5eFwkzf7P1zW4/ClkHiUIY8hLOYnwz+YqDUr
         qb8NqPDwVyKP+Lykea8UeiUlwV+FEbklUWJe4MZo2ovA/MRsJI5Ysijy022bBCHqd56M
         2z1uTIkK2fcSXYt6DBKeS+WkelmHinvNFBjCwciFqvTpS6kweAo5/RojnYLKJnirqo/Z
         nckoebdmFey9FoEZlI+5o4by7dQr07Zl515QS1JF05WUc6O9hANEbCoFCdczzLO7x8ZA
         WgGxMKQljnhEP6ZPq/zRmarsrwlCnvaMPZUM45R/QLkNiZdnw+kXcOevVivZmVb5sxSK
         YQIQ==
X-Gm-Message-State: AIVw113aJH05hzRBYWlhoq/gjogrWA63fo0WZKII9z9ptfOl12Ndf8CL
        r/Wzcqya7DTlZb0ZnIgthw==
X-Received: by 10.98.53.134 with SMTP id c128mr7642832pfa.36.1500071327374;
        Fri, 14 Jul 2017 15:28:47 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 204sm19749989pfc.32.2017.07.14.15.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jul 2017 15:28:46 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, jacob.keller@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 1/3] repo_read_index: don't discard the index
Date:   Fri, 14 Jul 2017 15:28:24 -0700
Message-Id: <20170714222826.81148-2-bmwill@google.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c-goog
In-Reply-To: <20170714222826.81148-1-bmwill@google.com>
References: <20170711220408.173269-1-bmwill@google.com>
 <20170714222826.81148-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have 'repo_read_index()' behave more like the other read_index family of
functions and don't discard the index if it has already been populated
and instead rely on the quick return of read_index_from which has:

  /* istate->initialized covers both .git/index and .git/sharedindex.xxx */
  if (istate->initialized)
    return istate->cache_nr;

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 repository.c | 2 --
 repository.h | 8 ++++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/repository.c b/repository.c
index edca90740..8e60af1d5 100644
--- a/repository.c
+++ b/repository.c
@@ -235,8 +235,6 @@ int repo_read_index(struct repository *repo)
 {
 	if (!repo->index)
 		repo->index = xcalloc(1, sizeof(*repo->index));
-	else
-		discard_index(repo->index);
 
 	return read_index_from(repo->index, repo->index_file);
 }
diff --git a/repository.h b/repository.h
index 417787f3e..7f5e24a0a 100644
--- a/repository.h
+++ b/repository.h
@@ -92,6 +92,14 @@ extern int repo_submodule_init(struct repository *submodule,
 			       const char *path);
 extern void repo_clear(struct repository *repo);
 
+/*
+ * Populates the repository's index from its index_file, an index struct will
+ * be allocated if needed.
+ *
+ * Return the number of index entries in the populated index or a value less
+ * than zero if an error occured.  If the repository's index has already been
+ * populated then the number of entries will simply be returned.
+ */
 extern int repo_read_index(struct repository *repo);
 
 #endif /* REPOSITORY_H */
-- 
2.13.2.932.g7449e964c-goog

