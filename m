Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F71D1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752847AbcLFVxo (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:53:44 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34001 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbcLFVxN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:53:13 -0500
Received: by mail-pg0-f54.google.com with SMTP id x23so153559419pgx.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 13:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u4FvSn2SrQf0mJ1SaOgdWvu+MfgTKrb9y8c65l5olfI=;
        b=Wp3FKuVrLgQGGkPR4OYlXEUHVBqPNntdFr0IiwyaV75G55c/zptDVQBtmnFmOtbhBU
         gf5AzjLsfJiAMCtcTFxP0WK6hpkrGfue0NMdxrLvjZyH0c2UcLOSOzoX5WNOg/4GJQWl
         kDHPSyxchuXJNExBLlS0HiV55b6m8r8T3prxqkH4LP6l0wT0aASnrLMpXSr9UVfpuSpk
         R+VBMxc+7qqp26UhgeuuTm2pZ+/xUurYFwuCZ3KkNqbZgNBrFBNX2LMCyqBNHKxn54Tn
         kdKGJAcVDUFLN/rPvUpHnb6Eym1Ge+GQ9RSx5yzqDKBHlxgfMW+FSlf1P6yYUXoaUxb+
         ht+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u4FvSn2SrQf0mJ1SaOgdWvu+MfgTKrb9y8c65l5olfI=;
        b=k5EtzB59NZGzjcHPtZzdSivuIR5D+Bsm3T/8OeEeUz8qzCxche1oOwhqeooCb9LVNk
         OK/TF9gCb5ViT+cg35uAN7NtLfTaxItp+6YixKydlLKBHVJvq1Wb9PM28ZepE8vauBam
         oAR9AKGkJ3J8HfaWtaNCsR2HykzhoIhnl9rLojrOtoi7E1qptacW0WeQHLsP6+S3dwVR
         a6vgbOKgS3M2N4QXkq35JYjLs/ZsIudepAOpXRZGEpDHBwcux64CoFtxy/iDX1pdj9nq
         gQypyeTR/Qe6V/YhQrMaY3+ch/mELQ8480zNuKe91BArMW31+yKpHN0UnQpHwmIvOT/b
         GlbA==
X-Gm-Message-State: AKaTC020b8OihnCiX0Uw7k814csZde6q+bLUfQxOw1ZxItMtHFTn9OQ6H2Nsjkojg+nKtNjo
X-Received: by 10.84.217.216 with SMTP id d24mr140892452plj.10.1481061144870;
        Tue, 06 Dec 2016 13:52:24 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y89sm36940228pfk.83.2016.12.06.13.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 13:52:24 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 06/17] pathspec: copy and free owned memory
Date:   Tue,  6 Dec 2016 13:51:35 -0800
Message-Id: <1481061106-117775-7-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481061106-117775-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
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

