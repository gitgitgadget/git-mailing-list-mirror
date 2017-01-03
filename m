Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 140201FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 18:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965498AbdACSxM (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 13:53:12 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36848 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760669AbdACSxG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 13:53:06 -0500
Received: by mail-pf0-f177.google.com with SMTP id 189so78115017pfz.3
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 10:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=28bV5FSlzrSbj0oLHEL/hreEPmvHtHtJ5f3XGbrkH3M=;
        b=EfMhterXPRgsTHWBB+YBKvaWWnQyNYyulVh9ZMODDKn4qHHLo6cwVa+II6tSIfEFZU
         3yjk5/ZDZptqwXZ4Hn58dqxZvUgQr5lB5moJBGmlb2rSU9Cl0t0Y998UYb7wK11fjKkH
         64ss+sRTNPmyfNemngqHzELIXTNGJ6R6EVhabY5V/7KLuebLIDAOGCDYB3W14uP71l6j
         rSW9+BLDtWmd31P0JsL1mxjYjzBWCi9XZ6sr+lR+scuJwkVEuEPfmz6KCSm4FG2PVy7+
         WSutDyr4qwsbmFoaXBSPbTTjRCl/KvWwU+5xvd6waI0R6EccFzP+6iUMqYxEn8K6oflP
         CbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=28bV5FSlzrSbj0oLHEL/hreEPmvHtHtJ5f3XGbrkH3M=;
        b=e6hmVLxSA05PzTvMxKl9K9Rg4g9/9CiX99oAqWChCMswpQH3KcjoVcObRhX4JCArpg
         c/RqB2w7mk1WCiQqoLFKjOfEXNbjpvqXWa/RzNOk9OqeljkAgv56mL4YY8zfk6DOuUeC
         49JBSooHNX4qqukRq3On/bJ9jaZRRzWGRcI1MaK1J0MSyj9gLiDmume4GdQcCyMDLIU0
         DgQQ/lcc+0WSlv2v3AAsQQjs2KWdfx8DoRzgHac+KV8lHURU8x8jJGNWApeM9lAYooYW
         c1xfSKm5QnPRIzjyJKVEkEmkbwQonjksx1B3/OFBMjwznGmtvuy4jsKQJFl64aTDpnGe
         fLVA==
X-Gm-Message-State: AIkVDXL+6sslorWNJByeoi7tsJjiqhP4pYgA/zOcvk241NUHNXMt05hUoTXcfOMgE8N186j1
X-Received: by 10.84.192.1 with SMTP id b1mr137792187pld.113.1483468987003;
        Tue, 03 Jan 2017 10:43:07 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id e5sm141421338pfd.77.2017.01.03.10.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 10:43:05 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v4 06/16] pathspec: copy and free owned memory
Date:   Tue,  3 Jan 2017 10:42:31 -0800
Message-Id: <20170103184241.128409-7-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170103184241.128409-1-bmwill@google.com>
References: <1481670870-66754-1-git-send-email-bmwill@google.com>
 <20170103184241.128409-1-bmwill@google.com>
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
 pathspec.c | 23 +++++++++++++++++++----
 pathspec.h |  4 ++--
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 1f918cbae..b8faa8f46 100644
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
@@ -453,13 +454,27 @@ void parse_pathspec(struct pathspec *pathspec,
 
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
+	pathspec->nr = 0;
 }
diff --git a/pathspec.h b/pathspec.h
index 70a592e91..49fd823dd 100644
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
2.11.0.390.gc69c2f50cf-goog

