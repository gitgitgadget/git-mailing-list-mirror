Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27AB41F404
	for <e@80x24.org>; Sun, 25 Feb 2018 21:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeBYVMh (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 16:12:37 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33848 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751884AbeBYVMa (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 16:12:30 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1176460E4F;
        Sun, 25 Feb 2018 21:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519593149;
        bh=IrlRGlgbao8xNKtLMd50SaAPoQi2LaIuq7AHKrS+0K4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=h0jnB5bIBY/xpQYd9ruCOGpf8E5esYTimKwHOlDz8KTBboKSR8HgPvwTvoxx5Nff4
         z9o+32X7z0CAAf6RCQDESDCI94LTeIH0um0rB6W8+g3ndNblPmlM9jZLjjDLzCNX2A
         I6kOkynqlhrPQwetULhwjeuUt2YnFoV8C4eR1ezifrR/8dIkYOQJXcT4Qv968VHslc
         D3yW5u6nLslaIf48xFikgKe4+54G6+IqBlTpCyybv8tZqWt8eeMhRc0BZJE/71ooQ1
         TEErICJDbs1jnWx+GJF0bWYCrGr5n8YI/duzdg1aVwBt0HiKbhwDhAGV+Ah4Ukd1Jj
         ofQ+HuShvyx1Ka1HHZ84KaDrMABe77gwGHXRjfsxsfmzim7Ew0Y3RlDLAbWv+LA9BY
         /oo63Z+K6/4rb2BeYEjTIymeKki1qfra8WNW5x84x9YLfwiMIxJJZdu2BF/tRV0osK
         WfJ1BkdJLK9piIqW1y8/+g9ICUSiPv1koYDPTuXY3pL1+WeEUze
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 05/36] resolve-undo: convert struct resolve_undo_info to object_id
Date:   Sun, 25 Feb 2018 21:11:41 +0000
Message-Id: <20180225211212.477570-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd
In-Reply-To: <20180225211212.477570-1-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the sha1 member of this struct to be an array of struct
object_id instead.  This change is needed to convert find_unique_abbrev.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/ls-files.c | 2 +-
 resolve-undo.c     | 8 ++++----
 resolve-undo.h     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 2fc836e330..9df66ba307 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -271,7 +271,7 @@ static void show_ru_info(const struct index_state *istate)
 			if (!ui->mode[i])
 				continue;
 			printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
-			       find_unique_abbrev(ui->sha1[i], abbrev),
+			       find_unique_abbrev(ui->oid[i].hash, abbrev),
 			       i + 1);
 			write_name(path);
 		}
diff --git a/resolve-undo.c b/resolve-undo.c
index b40f3173d3..109c658a85 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -24,7 +24,7 @@ void record_resolve_undo(struct index_state *istate, struct cache_entry *ce)
 	if (!lost->util)
 		lost->util = xcalloc(1, sizeof(*ui));
 	ui = lost->util;
-	hashcpy(ui->sha1[stage - 1], ce->oid.hash);
+	oidcpy(&ui->oid[stage - 1], &ce->oid);
 	ui->mode[stage - 1] = ce->ce_mode;
 }
 
@@ -44,7 +44,7 @@ void resolve_undo_write(struct strbuf *sb, struct string_list *resolve_undo)
 		for (i = 0; i < 3; i++) {
 			if (!ui->mode[i])
 				continue;
-			strbuf_add(sb, ui->sha1[i], 20);
+			strbuf_add(sb, ui->oid[i].hash, the_hash_algo->rawsz);
 		}
 	}
 }
@@ -89,7 +89,7 @@ struct string_list *resolve_undo_read(const char *data, unsigned long size)
 				continue;
 			if (size < 20)
 				goto error;
-			hashcpy(ui->sha1[i], (const unsigned char *)data);
+			hashcpy(ui->oid[i].hash, (const unsigned char *)data);
 			size -= 20;
 			data += 20;
 		}
@@ -145,7 +145,7 @@ int unmerge_index_entry_at(struct index_state *istate, int pos)
 		struct cache_entry *nce;
 		if (!ru->mode[i])
 			continue;
-		nce = make_cache_entry(ru->mode[i], ru->sha1[i],
+		nce = make_cache_entry(ru->mode[i], ru->oid[i].hash,
 				       name, i + 1, 0);
 		if (matched)
 			nce->ce_flags |= CE_MATCHED;
diff --git a/resolve-undo.h b/resolve-undo.h
index 46306455ed..87291904bd 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -3,7 +3,7 @@
 
 struct resolve_undo_info {
 	unsigned int mode[3];
-	unsigned char sha1[3][20];
+	struct object_id oid[3];
 };
 
 extern void record_resolve_undo(struct index_state *, struct cache_entry *);
