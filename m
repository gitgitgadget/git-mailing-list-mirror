Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9050DC433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD7F2073B
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="jabJFqhM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390597AbgEYUA2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38806 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390550AbgEYUAS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 16:00:18 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3F90D60CFE;
        Mon, 25 May 2020 19:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436786;
        bh=CS7+T0CXvW4akc/aSvSaw17PrrQZy823QbT+zlFofqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=jabJFqhMxxm6lkEbIrjNbmicdHDvueU/K0zqKq5Y933A0Kd32mlDn65duwzDSinEq
         02yKUZOOlvvbQZHTU5KBgIy84rTRqW/bYNKbrojscE2S30+viGzKmUbsbu7XLNndtR
         iljQBpiuxPAtHhXnPEexhmWKltM8JfRk7olY59FJgemLcYF7iRq8bDq6MnlbobACzA
         gh4wTZoHpvns7EtdkXPqQlkNHdsX8LgVK1Y+O4wJpTD8eUK74fdQckjN3V9GR2Pv27
         i85Z/oIAUrZY7nPlqKbBXs8N7qh1XEzYFROC53ewz9SWH9dTofjqVnkKel4FZ9wQz6
         QueJuDh2fedIT/8RF8OX6QSA1W/4mjWPY0PbYuX5HsVecljzZBMss+2jlQAd4VEiT/
         l2NpYqLBE61cbgWstPgdSPtfzxvqX7GlKSu5eifn0HSnsHiwW10VVvB7Kr1l0hnVuL
         PNTcPvqlrZih+vgb80UgFpDjf4I/02qtS64yhlmBLfEKmW3/hAp
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 08/44] pkt-line: add a member for hash algorithm
Date:   Mon, 25 May 2020 19:58:54 +0000
Message-Id: <20200525195930.309665-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200525195930.309665-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200525195930.309665-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a member for the hash algorithm currently in use to the packet
reader so it can parse references correctly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 pkt-line.c | 1 +
 pkt-line.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index a0e87b1e81..a4aea075de 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -479,6 +479,7 @@ void packet_reader_init(struct packet_reader *reader, int fd,
 	reader->buffer_size = sizeof(packet_buffer);
 	reader->options = options;
 	reader->me = "git";
+	reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
 }
 
 enum packet_read_status packet_reader_read(struct packet_reader *reader)
diff --git a/pkt-line.h b/pkt-line.h
index fef3a0d792..4cd9435e9a 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -166,6 +166,9 @@ struct packet_reader {
 
 	unsigned use_sideband : 1;
 	const char *me;
+
+	/* hash algorithm in use */
+	const struct git_hash_algo *hash_algo;
 };
 
 /*
