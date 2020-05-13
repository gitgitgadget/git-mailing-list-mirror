Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33232C2D0FB
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036FA20675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="G5pFvIV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbgEMAyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:54:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38118 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726031AbgEMAym (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:42 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 01CB460CF2;
        Wed, 13 May 2020 00:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331281;
        bh=CS7+T0CXvW4akc/aSvSaw17PrrQZy823QbT+zlFofqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=G5pFvIV7aJTum1AjrMhRfP+lVMECC0BN79RfVZdYlrs2SurHkBEse8Ldddh1s5/Nl
         VTxNv7SP46nN56o2fB6kdWLhsPntH78Z+QaQO1tVHuTgwZo2cewjW4ihjbZ0h8Vwsc
         P1mdC9emx6yBYb/8hZo3lgDFVNCMQZ3EGD+S4Cx8KOq7jm95tOmOUlg2DKmR9vPQrg
         2Nwe9wxHdKyHzYo0J1apzpI6nHSYT1V5zl8UIYgqWq/NxKbdTGJl6aeLs7NstOZoEy
         tkF/0VXCzcvvPJOGKeP3hepeH3zlZjFOh7/u60bFra+qxBLSISJaf797i3bWUusVDB
         WuFLROFYngpuf1jtFGKYXYPACdkKPPHrNa0yH/lX5yOEm/qrn5kSejhnYSpQhFs/Uw
         mfihVLjIjKJOGdHgKgGsx0Xit603Ue0ESosaPFvVDBjqroEnjeTJsREvqUeBIaNgfS
         6u4TkbQRHUjZUsO1IIl8pPmyx/qs7xCKwXGMsGfLByqGLzYHOa/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 08/44] pkt-line: add a member for hash algorithm
Date:   Wed, 13 May 2020 00:53:48 +0000
Message-Id: <20200513005424.81369-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
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
