Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E71C83F1A
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 21:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjH1Vsd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjH1VsN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 17:48:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EACF9
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 14:48:11 -0700 (PDT)
Received: (qmail 585 invoked by uid 109); 28 Aug 2023 21:48:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Aug 2023 21:48:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4562 invoked by uid 111); 28 Aug 2023 21:48:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 17:48:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 17:48:10 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 16/22] imap-send: mark unused parameters with NO_OPENSSL
Message-ID: <20230828214810.GP3831137@coredump.intra.peff.net>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828214604.GA3830831@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier patches annotating unused parameters in imap-send missed a few
cases in code that is compiled only with NO_OPENSSL. These need to
retain the extra parameters to match the interfaces used when we compile
with openssl support.

Note in the case of socket_perror() that the function declaration and
parts of its code are shared between the two cases, and only the openssl
code looks at "sock". So we can't simply mark the parameter as always
unused. Instead, we can add a noop statement that references it. This is
ugly, but should be portable.

Signed-off-by: Jeff King <peff@peff.net>
---
 imap-send.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 06386e0b3b..996651e4f8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -206,10 +206,14 @@ static void socket_perror(const char *func, struct imap_socket *sock, int ret)
 		else
 			fprintf(stderr, "%s: unexpected EOF\n", func);
 	}
+	/* mark as used to appease -Wunused-parameter with NO_OPENSSL */
+	(void)sock;
 }
 
 #ifdef NO_OPENSSL
-static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int verify)
+static int ssl_socket_connect(struct imap_socket *sock UNUSED,
+			      int use_tls_only UNUSED,
+			      int verify UNUSED)
 {
 	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
 	return -1;
@@ -904,7 +908,9 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 
 #else
 
-static char *cram(const char *challenge_64, const char *user, const char *pass)
+static char *cram(const char *challenge_64 UNUSED,
+		  const char *user UNUSED,
+		  const char *pass UNUSED)
 {
 	die("If you want to use CRAM-MD5 authenticate method, "
 	    "you have to build git-imap-send with OpenSSL library.");
-- 
2.42.0.505.g4c6fb48dec

