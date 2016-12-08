Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B04911FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 18:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932110AbcLHS7h (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:59:37 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36290 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753083AbcLHS7e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:59:34 -0500
Received: by mail-pg0-f42.google.com with SMTP id f188so176158879pgc.3
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u4FvSn2SrQf0mJ1SaOgdWvu+MfgTKrb9y8c65l5olfI=;
        b=RD/6YN0E5/YyTAx/RFkpOOQL7dLk14xxTlENs3jNy/MgePUkD8SDt8YWj0HHc47Ryl
         46+FOddW62+Eon5Zv4h00riM/mDBdaO2vWpJJfi9JufVdxUvbtL+EwSkkhu8vbSMLpLW
         c8J8gy4OKtZK/PCT0B520KZTvNwyYi4uvfawtAq5EByZ6rv1Qr2wFNqxqvxWBFqukuZI
         OoI4GVQ0VlNp9F6/RFmb/U4ftMYjTWgbimwwIBL3BuJvFn5ljRse7cBf0vYOzd9/AP0K
         SDQq0ve44FoVpy5GnUx3dv6Noc7HPSAjLRjRa2p795Kz3hKGeDPVwHmAkHOHcU7EzZcB
         Y+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u4FvSn2SrQf0mJ1SaOgdWvu+MfgTKrb9y8c65l5olfI=;
        b=iWTu2qmvmhNSEMhXTo3y4lASQnGuPsWJ06ou2CEuL/Vqm3sIrWwZ6WDsScdMeq3tun
         p8QeNmajutpgpJnfFFyK2xmG1wNJ2P1l65RTkm9VAMp8kNyilW6gGNYbj/RXB2E0REzL
         aolWOViS7Jg+wxDRx5stFuLELpF+gORsQOBRr77U/90r/iFoVWimjFZzW//E+yMuW60S
         JFxta2wTleTWK5atiG9pqVkiGXBk88gDZ+yXvBatzIbsBwFYzl+emUVvk5D5xJ8Mo7tv
         jbd4kY4iVEf5K1XcCyfx84XubzpjtlZ61waXMBi3DHyT/B9WDYQkce3+Orqxdo7JpHX/
         QQ7w==
X-Gm-Message-State: AKaTC012WqAHXG6oV9fcoBC2Su4mpgGdDpPH7j/Tx2FNJ9gDH3fkpmpAZHJcMC5MgFBZah8s
X-Received: by 10.99.235.10 with SMTP id t10mr132559350pgh.95.1481223573256;
        Thu, 08 Dec 2016 10:59:33 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id p64sm51815634pfi.88.2016.12.08.10.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 10:59:32 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v2 06/16] pathspec: copy and free owned memory
Date:   Thu,  8 Dec 2016 10:59:00 -0800
Message-Id: <1481223550-65277-7-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481223550-65277-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481223550-65277-1-git-send-email-bmwill@google.com>
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

