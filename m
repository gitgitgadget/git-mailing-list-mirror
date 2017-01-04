Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94B6420754
	for <e@80x24.org>; Wed,  4 Jan 2017 18:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966941AbdADSFg (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 13:05:36 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:32854 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761456AbdADSE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 13:04:28 -0500
Received: by mail-pf0-f175.google.com with SMTP id d2so83429767pfd.0
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 10:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=28bV5FSlzrSbj0oLHEL/hreEPmvHtHtJ5f3XGbrkH3M=;
        b=TpxmhmbUag7p4CqCK687q7Q4PAKn5ux6hlE1TwN+iQZv6w06zzwJ1oMOO5O3imKn3z
         +j9hG45/gIXxlD+zni/JmHLAjOWRf0pdmIIlGPUVp0aczl/eAA9O0DgvL2MIhSP36vTP
         La/VkJl2tSCGfaf/QrohPnG3h06QRM3XlLwEnDJQwO5ffPkktujWG4/Etu3cswAmT4XF
         Nw4O7ttx8aqMQ64Rsns6hxx2qpuyY6yBTqJ7mHl04pr6/Z1JmcxuKKVBU47j8Q09FdOq
         z9ZKH9oGU1JIq64BFIlOq2JnzMltjaCB3XbrZWpTrbMpZAtQoCAHDwV0FzedoYBpNz4Y
         gsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=28bV5FSlzrSbj0oLHEL/hreEPmvHtHtJ5f3XGbrkH3M=;
        b=SxLAQnAzRoXpT3CyVuIdBGYmcUGLL54vBipnV83gANAB4CkxlD7m3cZmkLAgNQ0Equ
         CDm0CIMzhBfhkebV+y+cDp/yUyTERvxD+NM5yKZmEQT/VBMhskDoeyjbHyKkLE33nNu+
         VQNTmPsiSRos/4pjEHKum/tbQ26bz3OfcIJ0JtUuXtIGaaEpVaD9h0SlJu0aBat45K6z
         cW+WVcHTewM8+Wsk20AN7eOSz2RD34B3TRDhKH0AZCGl3EeN5wdPh98tUipRHIRU8c5s
         xcIs8psN+ZtUCWmlNdQcNJiZuh3GLYJr8oELo8vMlMFYyX7FNVnwi8IZQOP9c3rYOaj/
         ajSg==
X-Gm-Message-State: AIkVDXIFLWP/upc6i1waRvhnvNRlThGQ3SJ60YkMDqn40NsErU0M+fcFVsaDu53McUSolyJ/
X-Received: by 10.98.12.138 with SMTP id 10mr62341807pfm.82.1483553068081;
        Wed, 04 Jan 2017 10:04:28 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id o68sm148337150pfb.42.2017.01.04.10.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 10:04:27 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v5 06/16] pathspec: copy and free owned memory
Date:   Wed,  4 Jan 2017 10:04:01 -0800
Message-Id: <20170104180411.150000-7-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170104180411.150000-1-bmwill@google.com>
References: <20170103184241.128409-1-bmwill@google.com>
 <20170104180411.150000-1-bmwill@google.com>
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

