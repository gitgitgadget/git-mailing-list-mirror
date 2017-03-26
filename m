Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB9D520958
	for <e@80x24.org>; Sun, 26 Mar 2017 16:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbdCZQCC (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 12:02:02 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:58050 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751466AbdCZQCA (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Mar 2017 12:02:00 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 25CEB280B3;
        Sun, 26 Mar 2017 16:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490544114;
        bh=Y9TKrRjp4r0Mm2noMcUOBtJzuLmNiDu/KL2OMH9PtJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0DmIIqXJq9BZ7M15B4exDGLxWx6WzUvTY8vffETY86q0Mm1pkTMUMM6GxtBSOWnCi
         OIhIJFwucXl9Y9H6pW7pSq4vP1OaFTMWQxeUS/1wq+LkIBSQtMjWhDGfl+QbnNVVT7
         YybVKGR5REPDPms11uwcKj9cAEPGhKiULkwdFNSUXW47POieG67WGR2T1aMUuOLlLf
         J0eQGJNAh3Ba4y532173ylbMr+n+U/RGII2pxosGI4x1wsdeu9y1m2cBQY9Ct+NLlc
         NBJwMUbllBm4iLHIrDkvQILoij92iidebiHLiSJfUcaWJ90VXwAxIiRo4FDIyxErdr
         O5yVd/dXC1GqhVmYgGkmJfzTESkpKzjxKUX31oNolSyNdfiE9ombPtZoxge5s6dAbh
         RTzUwdzvQ4cg8MoFP5x9hyKwDAKRC6OBZHij53qYaYzwMDBzjKinoExG60ZyeY1Iaz
         uNqh051tu0VBT8VsceQqW8qQyh+lD1io8hz81ZmwQd4EbtMvgH8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/21] builtin/receive-pack: fix incorrect pointer arithmetic
Date:   Sun, 26 Mar 2017 16:01:28 +0000
Message-Id: <20170326160143.769630-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170326160143.769630-1-sandals@crustytoothpaste.net>
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we had already processed the last newline in a push certificate, we
would end up subtracting NULL from the end-of-certificate pointer when
computing the length of the line.  This would have resulted in an
absurdly large length, and possibly a buffer overflow.  Instead,
subtract the beginning-of-certificate pointer from the
end-of-certificate pointer, which is what's expected.

Note that this situation should never occur, since not only do we
require the certificate to be newline terminated, but the signature will
only be read from the beginning of a line.  Nevertheless, it seems
prudent to correct it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/receive-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index feafb076a4..116f3177a1 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1524,7 +1524,7 @@ static void queue_commands_from_cert(struct command **tail,
 
 	while (boc < eoc) {
 		const char *eol = memchr(boc, '\n', eoc - boc);
-		tail = queue_command(tail, boc, eol ? eol - boc : eoc - eol);
+		tail = queue_command(tail, boc, eol ? eol - boc : eoc - boc);
 		boc = eol ? eol + 1 : eoc;
 	}
 }
