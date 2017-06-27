Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A33220401
	for <e@80x24.org>; Tue, 27 Jun 2017 12:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753008AbdF0MLC (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 08:11:02 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36714 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752791AbdF0MK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 08:10:58 -0400
Received: by mail-wr0-f194.google.com with SMTP id 77so31680816wrb.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 05:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eVoG8bat0IXNG/PXiGhVyTf19MbcLYxpEfxhDvCZAZg=;
        b=f9KyUhQhLn3TA6RSve/qTqjQaJAgT82R1hFVMqHKRoSErND21C32vhSZp08D7Mflg/
         OQ5AP/A4sUKb0dKVGKKCOG8kSWuoSqdqKQLbHIEaJQQ46sRXGp1vWY+eIfai6qO8scpk
         nXrMbu78OV2a+viktfXm9MoGtFgNq4wKgBDm+1aPUlmC9L2EXhVQd/U0g49RjbYlazuA
         cD+sJnxLvs7MeRvcHjU03IHogogImjgbeBMqm9ta5u800e0gAsr+8h8th7eth8Oi5OXS
         NhKcPaOH/SAJ4g9j7x2//Gh3cvT8/58mZKSDNNbtFZeRz69b168DVM834QxpRdzCOXQm
         b52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eVoG8bat0IXNG/PXiGhVyTf19MbcLYxpEfxhDvCZAZg=;
        b=AyJ8Mh2J5ozUlBoXesoxKixfceImzovtbJEAZWrQqQ/o/qJORcxrqfrKnTwQ7RVMSu
         F8sEnop4LH6vq4VW7zAFG9f2vgixr2LuQtNqcqYA/S1fv8N/RqPNcCH8xg+Oy309ghxz
         MkjgZqKnXX+AkH4t7mWthHNm+VAKOlWwnt9cEekpcnGbTRztbdUULrDFbVg1furxMfnk
         50aq14XibzlCFcfJK4P7ky8ZnKPs16QILn+HPUlclTbCkJ+PogmB/PTyQ9mE0PDPEf2A
         I7EbXnrB6PeONhdUa4DLXqtsAJvs+mm6oyRj4sLea+Khn9A2L0h57jSab2FuJOjda+Wo
         JbUg==
X-Gm-Message-State: AKS2vOxXsApHgqzoFU1F6+OwJo9bw3SYPKwRQTFoz516JcizAaFS6kds
        JXvHCsZpVEkVGh1E
X-Received: by 10.223.153.165 with SMTP id y34mr16107581wrb.41.1498565451469;
        Tue, 27 Jun 2017 05:10:51 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 32sm17873976wry.31.2017.06.27.05.10.48
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 05:10:50 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v7 5/6] convert: move multiple file filter error handling to separate function
Date:   Tue, 27 Jun 2017 14:10:26 +0200
Message-Id: <20170627121027.99209-6-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170627121027.99209-1-larsxschneider@gmail.com>
References: <20170627121027.99209-1-larsxschneider@gmail.com>
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
2.13.2

