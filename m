Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC3B920A26
	for <e@80x24.org>; Fri, 22 Sep 2017 23:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbdIVXfS (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 19:35:18 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33817 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbdIVXfR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 19:35:17 -0400
Received: by mail-wr0-f194.google.com with SMTP id k20so1322848wre.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 16:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fyGzxBif1XALKSclSSO1QXC/Y3p1EZIBsJWQQ6dopHQ=;
        b=S/vz6ww70W+p8LYmCWTx4ItxEcBBQf6xt4w3gNrimlxu6RGgWYzPNvC5k1No5NZYFa
         wf3ZakzUqi94Cg9Tw+PhyOI/9oTOoFFNkaJ0H1jhKijpIHSjzeHcRwbZk763V+yrn2Q1
         PE/EYufNV+ntSghrVYUHBQrmlklkUMnMSsjTAUfbz/GO94AOoILM9A6MjWyrM/yaP6c7
         7s7l81XkXlT4nvT2ok+vmPY2N84nc/JMCb3uDbe+S6DbfaDERqKWZwamY1nLc10l2Ks0
         NyCUXhFDA4SDGkqGFWNK7qbZnNe2ra4KZQ+f8tONLxyarStwN3QaMe1eoRJpsF7S1y6A
         BblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fyGzxBif1XALKSclSSO1QXC/Y3p1EZIBsJWQQ6dopHQ=;
        b=nC/c4/iXTkn/eN4E/o+PYg+OTbJ2u6AnjY3YJsakhZDhGmPcrDFKRcP4qOdaeoZ/5x
         OzqxgzCl0M6vvCbWy+vHuO8jMgwwXVBXAr7dnGbj0L3hM3wm1KkopsAE7MqAryMlSeFD
         yAC8aOw1ev12Pjt9+qs+C/meZcApODAgHfUC1zBRuGCCjAZSgoP8RsHbWwf7fn97oAQx
         glz64F2tk9/MBZb3o6DDBny3Dp75vU32Vk0gQsBVYDGHNFWu8UXgj/ENKmNb7gnSz6yP
         Te4NT2bchTbUpr+Ui7Q/PYtxEjBU8TqJHS6fBompZzvkEKt0mK9w4hZFXTOvDa2I1aFb
         SYaQ==
X-Gm-Message-State: AHPjjUivSPmuO4HPwbrOuZ/oe/3TSRnav1z5UJn204cm8Uke6zd2xA28
        ihBXWpkx4CwgPF/Wunt/vuK4Gw==
X-Google-Smtp-Source: AOwi7QDRlBmlLmz/BwYgaJXfDKgeFGYqIFivElP4lUAG3SpHCiXUF4yKusRjXvfw6snIkkJZqBr7eA==
X-Received: by 10.223.182.80 with SMTP id i16mr534164wre.131.1506123316130;
        Fri, 22 Sep 2017 16:35:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id e77sm2071333wmf.27.2017.09.22.16.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Sep 2017 16:35:15 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 1/6] builtin/commit: fix memory leak in `prepare_index()`
Date:   Sat, 23 Sep 2017 01:34:49 +0200
Message-Id: <48b08b7c776220ae8bf1144e297f9ee304f18d27.1506120292.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.727.g9ddaf86
In-Reply-To: <cover.1506120291.git.martin.agren@gmail.com>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net> <cover.1506120291.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Release `pathspec` and the string list `partial`.

When we clear the string list, make sure we do not free the `util`
pointers. That would result in double-freeing, since we set them up as
`item->util = item` in `list_paths()`.

Initialize the string list early, so that we can always release it. That
introduces some unnecessary overhead in various code paths, but means
there is one and only one way out of the function. If we ever accumulate
more things we need to free, it should be straightforward to do so.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Reviewed-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1a0da71a4..ce76b6f96 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -336,7 +336,7 @@ static void refresh_cache_or_die(int refresh_flags)
 static const char *prepare_index(int argc, const char **argv, const char *prefix,
 				 const struct commit *current_head, int is_status)
 {
-	struct string_list partial;
+	struct string_list partial = STRING_LIST_INIT_DUP;
 	struct pathspec pathspec;
 	int refresh_flags = REFRESH_QUIET;
 	const char *ret;
@@ -381,7 +381,8 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			warning(_("Failed to update main cache tree"));
 
 		commit_style = COMMIT_NORMAL;
-		return get_lock_file_path(&index_lock);
+		ret = get_lock_file_path(&index_lock);
+		goto out;
 	}
 
 	/*
@@ -404,7 +405,8 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
 			die(_("unable to write new_index file"));
 		commit_style = COMMIT_NORMAL;
-		return get_lock_file_path(&index_lock);
+		ret = get_lock_file_path(&index_lock);
+		goto out;
 	}
 
 	/*
@@ -430,7 +432,8 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			rollback_lock_file(&index_lock);
 		}
 		commit_style = COMMIT_AS_IS;
-		return get_index_file();
+		ret = get_index_file();
+		goto out;
 	}
 
 	/*
@@ -461,7 +464,6 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			die(_("cannot do a partial commit during a cherry-pick."));
 	}
 
-	string_list_init(&partial, 1);
 	if (list_paths(&partial, !current_head ? NULL : "HEAD", prefix, &pathspec))
 		exit(1);
 
@@ -491,6 +493,9 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	discard_cache();
 	ret = get_lock_file_path(&false_lock);
 	read_cache_from(ret);
+out:
+	string_list_clear(&partial, 0);
+	clear_pathspec(&pathspec);
 	return ret;
 }
 
-- 
2.14.1.727.g9ddaf86

