Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03D941F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932546AbeCLC3x (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:29:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34290 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932419AbeCLC2T (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Mar 2018 22:28:19 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4A21F605AA;
        Mon, 12 Mar 2018 02:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520821698;
        bh=4nWq7y3ZoqEDQTm2Yg2s/goQYU7iRXnlnBlgazIemAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=wT2/318Z1eXFQdZ7Hfh9o65CZm3mghD3wK98ryQBCZtisIuUVhcWtXfcuWJ6FnRca
         0nRg+vzWio5RyUVpT7A4P7B+aRJLOiDhHmcJfIu9OiV55LP1blIQZf8DiLWUrVoTKl
         jvaepf/xlufusGHSWz+C0jmTPTyRxQqLa6qkJuJeRwNyHm5rPtx8Nwv+8G9VSQekAT
         V8ecNtBRqgjyNiCIH6sjf53lEUYpVa21sQ41AnH+s9vCkGiw2YFITeOZmDfrHNsyK3
         1EZE9Dy2KiMCZm4LTQdNZKoTYhMF1SJgfoM1nHHUmcKFy985xZvJRARvQcZH6O0mT/
         eQePZ4svKUtMfAJQQq/mTMBcfgcYxlEDbOMlEhY4KmJV/Jr1d66ASsSR8cR1F4lFTh
         iyEIaU3Vwtey46tvW+r9su95qpnezEpGwYoyenfu1NGrH6EGfp1/l0l8SGte4usy/b
         QHFU22yKCFGfgJIuCscBhl5lI2MmD9/u9puaOXo54Zs/LupY3uT
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 05/36] resolve-undo: convert struct resolve_undo_info to object_id
Date:   Mon, 12 Mar 2018 02:27:25 +0000
Message-Id: <20180312022756.483934-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.660.g709887971b
In-Reply-To: <20180312022756.483934-1-sandals@crustytoothpaste.net>
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the sha1 member of this struct to be an array of struct
object_id instead.  This change is needed to convert find_unique_abbrev.

Convert some instances of hard-coded constants to use the_hash_algo as
well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/ls-files.c |  2 +-
 resolve-undo.c     | 15 ++++++++-------
 resolve-undo.h     |  2 +-
 3 files changed, 10 insertions(+), 9 deletions(-)

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
index b40f3173d3..aed95b4b35 100644
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
@@ -55,6 +55,7 @@ struct string_list *resolve_undo_read(const char *data, unsigned long size)
 	size_t len;
 	char *endptr;
 	int i;
+	const unsigned rawsz = the_hash_algo->rawsz;
 
 	resolve_undo = xcalloc(1, sizeof(*resolve_undo));
 	resolve_undo->strdup_strings = 1;
@@ -87,11 +88,11 @@ struct string_list *resolve_undo_read(const char *data, unsigned long size)
 		for (i = 0; i < 3; i++) {
 			if (!ui->mode[i])
 				continue;
-			if (size < 20)
+			if (size < rawsz)
 				goto error;
-			hashcpy(ui->sha1[i], (const unsigned char *)data);
-			size -= 20;
-			data += 20;
+			memcpy(ui->oid[i].hash, (const unsigned char *)data, rawsz);
+			size -= rawsz;
+			data += rawsz;
 		}
 	}
 	return resolve_undo;
@@ -145,7 +146,7 @@ int unmerge_index_entry_at(struct index_state *istate, int pos)
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
