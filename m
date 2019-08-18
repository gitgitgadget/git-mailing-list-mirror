Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C4021F4B6
	for <e@80x24.org>; Sun, 18 Aug 2019 20:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfHRUFc (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:32 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57922 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726247AbfHRUFc (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:32 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8B76060736;
        Sun, 18 Aug 2019 20:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158730;
        bh=/nmn0i5q3JUP/cv3g4NowB0M04ikozX42rCfItcnQoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=n4ihViONEKbGi78gKna3QsAjBi7QC85vMNSZG8Fo7QvMxP17us4ckn7kYTJV9piXn
         AePaiIovaXKsyFPh4PaHwNx4NTOH7u8NRfNMOOLGcPHonspEydc5BzZKlct25P97mw
         g8LhKwzdBquP7mM4phusl3vFwkjV97qXuQtJP3mRqYeRZxKXuWcn6mp2LObC2j3FuH
         ngudiScIdbQMp90I4EaAxpTpaZoLd3gOuqRbH/7bC8msXTLtHye7IZLtqXy9XbfQat
         UX905TJnxO7ZcoRf2r2i1pMDnAibdLlFas5LPaZdOLCv+Etn5U/bEOq7+7BXoLa5Y7
         dq2TZYxfTymXS2x7Y2y9pw8grnwMG0jmAmnC+ztdlNI96UC8HTzn9P8Mg0XosxQFRK
         WzjI9WbhvaazwWRk7DPr/ouiWijQxpCtjqXRFFQhPAatU96M3nLu0o/60G/8Ekp81c
         dmxMbvZ2ZqfCWrweeDBsK8IZJMQfpgRjn7BlrH9d4YwUlFV3PlB
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 01/26] builtin/replace: make hash size independent
Date:   Sun, 18 Aug 2019 20:04:02 +0000
Message-Id: <20190818200427.870753-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using GIT_SHA1_HEXSZ and hard-coded constants, switch to
using the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/replace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 644b21ca8d..4b00f1d84e 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -272,7 +272,7 @@ static int import_object(struct object_id *oid, enum object_type type,
 			return error(_("unable to spawn mktree"));
 		}
 
-		if (strbuf_read(&result, cmd.out, 41) < 0) {
+		if (strbuf_read(&result, cmd.out, the_hash_algo->hexsz + 1) < 0) {
 			error_errno(_("unable to read from mktree"));
 			close(fd);
 			close(cmd.out);
@@ -358,14 +358,15 @@ static int replace_parents(struct strbuf *buf, int argc, const char **argv)
 	struct strbuf new_parents = STRBUF_INIT;
 	const char *parent_start, *parent_end;
 	int i;
+	const unsigned hexsz = the_hash_algo->hexsz;
 
 	/* find existing parents */
 	parent_start = buf->buf;
-	parent_start += GIT_SHA1_HEXSZ + 6; /* "tree " + "hex sha1" + "\n" */
+	parent_start += hexsz + 6; /* "tree " + "hex sha1" + "\n" */
 	parent_end = parent_start;
 
 	while (starts_with(parent_end, "parent "))
-		parent_end += 48; /* "parent " + "hex sha1" + "\n" */
+		parent_end += hexsz + 8; /* "parent " + "hex sha1" + "\n" */
 
 	/* prepare new parents */
 	for (i = 0; i < argc; i++) {
