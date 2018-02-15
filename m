Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9EA1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 21:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756083AbeBOV4i (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 16:56:38 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33607 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752227AbeBOV40 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 16:56:26 -0500
Received: by mail-wm0-f67.google.com with SMTP id x4so2987441wmc.0
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 13:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JYskc7z8lwAEG8Ll5pZfCoR6P7oDlioSFZ9wQD3MRBU=;
        b=MwC4NbMKIQv9jk2cudouGFktAMcRpiosnQp/qmeNCZfQzqjlOueRgAR9CuQayigiFJ
         uQQmu8vwRTtTC+y8nqbe1qsalNgrinQXwvkD3LFqnF8OuU/e4eqbmcQZty7wH9xGf2eZ
         4Qp6LBf2DZrhVeME1tkvFN7UMTjB6lk7m6ZF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JYskc7z8lwAEG8Ll5pZfCoR6P7oDlioSFZ9wQD3MRBU=;
        b=LQyUS1vLl6qG3NihoqqCf4qyGymmBGB+NuyGAi7pGvi3fllZTC4e9WlGaPzPcjNLuZ
         eGsWN3t6gqyNzCH2oGjGJPpPfUvbf+bHs+CnIH44WNrgTiGov4upDf9vB82JvVxfcSUp
         WlVIO1Ft/W1IVbqGNPzTvfqoS2PH31TiE99MZpC74OpUDt1rJGNumdo0B2GtbsQdlJvq
         kqhpI++QphO1zzXUY6DUD7PwLhdoyESxZzPsifBMNkzHDxiXdp6E1r4YsHuz6Nc0eCeC
         rXsulJJfdggVujJIoeimobSguU/28rIqntUJLQuBi00eKOWytJfcgTUkwxDZBc6665UT
         fGnQ==
X-Gm-Message-State: APf1xPDZmxqJ9sh7VGaPPlnG3qyOS3jJz4UZNhSrba7hGU+lXPvSce9u
        o1Fqhm7IQXJG7CvL+WTsZXtNB2bGbeU=
X-Google-Smtp-Source: AH8x224VSJw/CIiQPGmSh9vWiiAxlr7tzGBk5S8ZfdBjVLS5AOGZpHP1HS2QzmdlZjwnqYmSI77sfA==
X-Received: by 10.80.134.219 with SMTP id 27mr2744487edu.135.1518731784876;
        Thu, 15 Feb 2018 13:56:24 -0800 (PST)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-126-104.cgn.ip.fibianet.dk. [5.186.126.104])
        by smtp.gmail.com with ESMTPSA id d60sm11476124edc.40.2018.02.15.13.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Feb 2018 13:56:24 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 2/3] grep: simplify grep_oid and grep_file
Date:   Thu, 15 Feb 2018 22:56:14 +0100
Message-Id: <20180215215615.21208-3-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180215215615.21208-1-rv@rasmusvillemoes.dk>
References: <20180215215615.21208-1-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the NO_PTHREADS or !num_threads case, this doesn't change
anything. In the threaded case, note that grep_source_init duplicates
its third argument, so there is no need to keep [path]buf.buf alive
across the call of add_work().

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 builtin/grep.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 4a4f15172..593f48d59 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -326,18 +326,17 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 	}
 
 	grep_source_init(&gs, GREP_SOURCE_OID, pathbuf.buf, path, oid);
+	strbuf_release(&pathbuf);
 
 #ifndef NO_PTHREADS
 	if (num_threads) {
 		add_work(opt, &gs);
-		strbuf_release(&pathbuf);
 		return 0;
 	} else
 #endif
 	{
 		int hit;
 
-		strbuf_release(&pathbuf);
 		hit = grep_source(opt, &gs);
 
 		grep_source_clear(&gs);
@@ -356,18 +355,17 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 		strbuf_addstr(&buf, filename);
 
 	grep_source_init(&gs, GREP_SOURCE_FILE, buf.buf, filename, filename);
+	strbuf_release(&buf);
 
 #ifndef NO_PTHREADS
 	if (num_threads) {
 		add_work(opt, &gs);
-		strbuf_release(&buf);
 		return 0;
 	} else
 #endif
 	{
 		int hit;
 
-		strbuf_release(&buf);
 		hit = grep_source(opt, &gs);
 
 		grep_source_clear(&gs);
-- 
2.15.1

