Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5295B20756
	for <e@80x24.org>; Thu, 12 Jan 2017 10:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbdALKux (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 05:50:53 -0500
Received: from faith.eroen.eu ([178.79.147.241]:55050 "EHLO faith.eroen.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751855AbdALKuw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 05:50:52 -0500
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jan 2017 05:50:51 EST
Received: from localhost.localdomain (unknown [10.10.0.18])
        by faith.eroen.eu (Postfix) with ESMTP id 33DDD241B0;
        Thu, 12 Jan 2017 10:42:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=occam.eroen.eu;
        s=faith; t=1484217748;
        bh=x+qb9OgNZmV+d+rdN41gZywIbUyvqwOI3iYHq9U6xjw=;
        h=From:To:Cc:Subject:Date;
        b=Mjw+iIAilP9DHkpx49Gy/aPJHyCE4n6yyygZLiAoj0+6OqksyAZh9WT4l+GQMVPfe
         eIV13Q1AG31SOIfM1PiLDgDrz9h2HruiWXgdBvppm4l55fAaTPTbAiT2Y2Ghj+BL83
         miDGCzcwTt333GOo9Wwze9oMXz6PJ42fZeIBzroE=
From:   eroen <git-scm@occam.eroen.eu>
To:     git@vger.kernel.org
Cc:     eroen <git-scm@occam.eroen.eu>
Subject: [PATCH] imap-send.c: Avoid deprecated openssl 1.1.0 API
Date:   Thu, 12 Jan 2017 11:42:19 +0100
Message-Id: <20170112104219.563497-1-git-scm@occam.eroen.eu>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Library initialization functions are deprecated in openssl 1.1.0 API, as
initialization is handled by openssl internally.

Symbols for deprecated functions are not exported if openssl is built with
`--api=1.1 disable-deprecated`, so their use will cause a build failure.

Reported-by: Lars Wendler (Polynomial-C)

X-Gentoo-Bug: 592466
X-Gentoo-Bug-URL: https://bugs.gentoo.org/show_bug.cgi?id=592466
---
 imap-send.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/imap-send.c b/imap-send.c
index 5c7e27a89..98774360e 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -284,8 +284,10 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
 	int ret;
 	X509 *cert;
 
+#if OPENSSL_VERSION_NUMBER < 0x10100000L
 	SSL_library_init();
 	SSL_load_error_strings();
+#endif
 
 	meth = SSLv23_method();
 	if (!meth) {
-- 
2.11.0

