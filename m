Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC89F2082E
	for <e@80x24.org>; Sun, 25 Jun 2017 18:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbdFYSVl (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 14:21:41 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34711 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbdFYSVb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 14:21:31 -0400
Received: by mail-wr0-f193.google.com with SMTP id k67so25612201wrc.1
        for <git@vger.kernel.org>; Sun, 25 Jun 2017 11:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t0C57gJA0U/ZQk269MDCjirV45WhPJl9ZIKhu8x8pQE=;
        b=FAU8Vl/vxR/5nJYTtJFi2p6zHclsJzydptfVZJcChEYzrQaFnZCvGHn9RiUfiULtdf
         BvCXt8ALpzePxsh9lw7/F5OPInmnUf9vDwHdMjgazoolZWh9DCneQ/wEOgHqWuohi2bz
         VD3McBocWJ7sbGksoiLPsir9y3/52H/orycc2hCI4m8kXZJujNpoxVepo4ClycLgNjhN
         Bf7HHaysa5fyrbuvQLSO4x48wlBM/WmqftBBCGhrXpdj0I1OmvILPYhsDOGpHww+4p2X
         G14nBmp2RsQMvnZ48yAM3MCVromGkefVeV+64BcbCfvdvsoe9L0V7xMkPGNxeWW62qGt
         mwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t0C57gJA0U/ZQk269MDCjirV45WhPJl9ZIKhu8x8pQE=;
        b=DOAYQuAUwO/2NXG/bcEkju8SCIM1i91+y2rHKFXj6kfmW0dqZ90LIJUtV5issxYdZ6
         qUKr/b+UFM5MV7nKSiTV9D/XEONY7MSGaLakWp8Zmybtt5MM/AJApANJQz8Y9rUU2h8A
         EiJE/H+j5h2227eDt8vSBFwmrK1uSO2t+53gy+TuokxSm1BECD4BV4MV0ufgwItUj5Kj
         arNU29Z1oldF2iQnEVHDeTLT0hAGwa7sLrTOC+9MiRzSrndD8jYwZubb/mVgt1dbQ9e2
         j08uOIFcVAgROjboRAwT5FQQpxIvH9b/6zRQrhZcLXnYWcYrAo4IyTLOtvPl58URLYh6
         c98g==
X-Gm-Message-State: AKS2vOz9nQEpAIlRuvd+17Zmy/7ih1VEoV5SbDhNVOgp+2ZG35Nv2hNr
        bcOXx2VyMWzWklUu
X-Received: by 10.223.172.15 with SMTP id v15mr12760540wrc.84.1498414890172;
        Sun, 25 Jun 2017 11:21:30 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB71F6.dip0.t-ipconnect.de. [93.219.113.246])
        by smtp.gmail.com with ESMTPSA id u13sm13313926wmd.22.2017.06.25.11.21.29
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 25 Jun 2017 11:21:29 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v6 5/6] convert: move multiple file filter error handling to separate function
Date:   Sun, 25 Jun 2017 20:21:24 +0200
Message-Id: <20170625182125.6741-6-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20170625182125.6741-1-larsxschneider@gmail.com>
References: <20170625182125.6741-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactoring the filter error handling is useful for the subsequent patch
'convert: add "status=delayed" to filter process protocol'.

In addition, replace the parentheses around the empty "if" block with a
single semicolon to adhere to the Git style guide.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/convert.c b/convert.c
index 9907e3b9ba..e55c034d86 100644
--- a/convert.c
+++ b/convert.c
@@ -565,6 +565,29 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 	return err;
 }
 
+static void handle_filter_error(const struct strbuf *filter_status,
+				struct cmd2process *entry,
+				const unsigned int wanted_capability) {
+	if (!strcmp(filter_status->buf, "error"))
+		; /* The filter signaled a problem with the file. */
+	else if (!strcmp(filter_status->buf, "abort") && wanted_capability) {
+		/*
+		 * The filter signaled a permanent problem. Don't try to filter
+		 * files with the same command for the lifetime of the current
+		 * Git process.
+		 */
+		 entry->supported_capabilities &= ~wanted_capability;
+	} else {
+		/*
+		 * Something went wrong with the protocol filter.
+		 * Force shutdown and restart if another blob requires filtering.
+		 */
+		error("external filter '%s' failed", entry->subprocess.cmd);
+		subprocess_stop(&subprocess_map, &entry->subprocess);
+		free(entry);
+	}
+}
+
 static int apply_multi_file_filter(const char *path, const char *src, size_t len,
 				   int fd, struct strbuf *dst, const char *cmd,
 				   const unsigned int wanted_capability)
@@ -656,28 +679,10 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 done:
 	sigchain_pop(SIGPIPE);
 
-	if (err) {
-		if (!strcmp(filter_status.buf, "error")) {
-			/* The filter signaled a problem with the file. */
-		} else if (!strcmp(filter_status.buf, "abort")) {
-			/*
-			 * The filter signaled a permanent problem. Don't try to filter
-			 * files with the same command for the lifetime of the current
-			 * Git process.
-			 */
-			 entry->supported_capabilities &= ~wanted_capability;
-		} else {
-			/*
-			 * Something went wrong with the protocol filter.
-			 * Force shutdown and restart if another blob requires filtering.
-			 */
-			error("external filter '%s' failed", cmd);
-			subprocess_stop(&subprocess_map, &entry->subprocess);
-			free(entry);
-		}
-	} else {
+	if (err)
+		handle_filter_error(&filter_status, entry, wanted_capability);
+	else
 		strbuf_swap(dst, &nbuf);
-	}
 	strbuf_release(&nbuf);
 	return !err;
 }
-- 
2.13.1

