Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A2B620451
	for <e@80x24.org>; Tue, 13 Dec 2016 23:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbcLMXQl (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 18:16:41 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35534 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752429AbcLMXQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 18:16:31 -0500
Received: by mail-pg0-f42.google.com with SMTP id p66so768718pga.2
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 15:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u4FvSn2SrQf0mJ1SaOgdWvu+MfgTKrb9y8c65l5olfI=;
        b=Yy0wGHSrrTTosUOb5IjTemSFIkTDnutJkx8obDHMrWyiO5i3Lx3Z/Np4jMBuUDkE6x
         K9k6cFFFh3juY0DmSEupMqLaDUEKYz6O+itWLIqYcS9xKxWD0DCxr3qa3oGVwRROlx+9
         ZDOAyDRAVZTOvZAPXPBrW1ssFw+yOzafZswbojr59276VKC4ZNng3ExgcaW1jcV/PGRU
         pcd9XYdZNycsc4uhHkMuNcLOWmbh0NFEobltn5vJpRy5bhi2mp0MHJwIX+s+0YMjWM5M
         rLpRF6zeQAmzCXcJL8ofyp9Pz9A+MyVL4jXGlj4RJ2Y4RkXclL82xo0GDPxdW66C0+Z3
         DJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u4FvSn2SrQf0mJ1SaOgdWvu+MfgTKrb9y8c65l5olfI=;
        b=MwKNctzrJQLKOlwbZDHJOijCA3h9XJ12BtrUqxK/BmzmvmBSWdzpBuES6ys+Zz8ZXA
         8FL5RbhKokWtPLnKwfw38MW/TFBk6sFwVk49MpKi0ptcs32abA4cdnNvy7CL9iMNjXK8
         jOdcAIWGqVq9N5HCdFpHhVLEUSRC3+umEy90pjUpnjf83Yoei6oTZUZc4bkyx8S0XJkC
         oEXi/iHM8Dq1cITG5XBDTph8v5Q+vX29VAcUCt+6oE+zr5Y8+cAAqhnG0M925ehmaRfb
         FmM7c3ST+9lCTZByFucEXK1iXQ/hYgnXfqMjUnD0/mLKZLri11Adrjg1I78gIHVKPMXz
         X6Xw==
X-Gm-Message-State: AKaTC03rv/KBM9598d4Otmfr+0EBGwuzOsAc93l1xyLEpNMNibqgm5epGEkLfrDmOR2AH/eL
X-Received: by 10.99.185.84 with SMTP id v20mr82146853pgo.98.1481670889234;
        Tue, 13 Dec 2016 15:14:49 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id c15sm82308567pfd.36.2016.12.13.15.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 15:14:48 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v3 06/16] pathspec: copy and free owned memory
Date:   Tue, 13 Dec 2016 15:14:20 -0800
Message-Id: <1481670870-66754-7-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481670870-66754-1-git-send-email-bmwill@google.com>
References: <1481223550-65277-1-git-send-email-bmwill@google.com>
 <1481670870-66754-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'original' string entry in a pathspec_item is only duplicated some
of the time, instead always make a copy of the original and take
ownership of the memory.

Since both 'match' and 'original' string entries in a pathspec_item are
owned by the pathspec struct, they need to be freed when clearing the
pathspec struct (in 'clear_pathspec()') and duplicated when copying the
pathspec struct (in 'copy_pathspec()').

Also change the type of 'match' and 'original' to 'char *' in order to
more explicitly show the ownership of the memory.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 22 ++++++++++++++++++----
 pathspec.h |  4 ++--
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 1f918cb..8f367f0 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -259,8 +259,9 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 		}
 		strbuf_addstr(&sb, match);
 		item->original = strbuf_detach(&sb, NULL);
-	} else
-		item->original = elt;
+	} else {
+		item->original = xstrdup(elt);
+	}
 	item->len = strlen(item->match);
 	item->prefix = prefixlen;
 
@@ -388,8 +389,8 @@ void parse_pathspec(struct pathspec *pathspec,
 			die("BUG: PATHSPEC_PREFER_CWD requires arguments");
 
 		pathspec->items = item = xcalloc(1, sizeof(*item));
-		item->match = prefix;
-		item->original = prefix;
+		item->match = xstrdup(prefix);
+		item->original = xstrdup(prefix);
 		item->nowildcard_len = item->len = strlen(prefix);
 		item->prefix = item->len;
 		pathspec->nr = 1;
@@ -453,13 +454,26 @@ void parse_pathspec(struct pathspec *pathspec,
 
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 {
+	int i;
+
 	*dst = *src;
 	ALLOC_ARRAY(dst->items, dst->nr);
 	COPY_ARRAY(dst->items, src->items, dst->nr);
+
+	for (i = 0; i < dst->nr; i++) {
+		dst->items[i].match = xstrdup(src->items[i].match);
+		dst->items[i].original = xstrdup(src->items[i].original);
+	}
 }
 
 void clear_pathspec(struct pathspec *pathspec)
 {
+	int i;
+
+	for (i = 0; i < pathspec->nr; i++) {
+		free(pathspec->items[i].match);
+		free(pathspec->items[i].original);
+	}
 	free(pathspec->items);
 	pathspec->items = NULL;
 }
diff --git a/pathspec.h b/pathspec.h
index 70a592e..49fd823 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -25,8 +25,8 @@ struct pathspec {
 	unsigned magic;
 	int max_depth;
 	struct pathspec_item {
-		const char *match;
-		const char *original;
+		char *match;
+		char *original;
 		unsigned magic;
 		int len, prefix;
 		int nowildcard_len;
-- 
2.8.0.rc3.226.g39d4020

