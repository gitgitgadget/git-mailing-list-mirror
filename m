Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BCAC83F17
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 23:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241301AbjH2Xq3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 19:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241332AbjH2Xpz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 19:45:55 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC76E55
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 16:45:34 -0700 (PDT)
Received: (qmail 14938 invoked by uid 109); 29 Aug 2023 23:45:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Aug 2023 23:45:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19911 invoked by uid 111); 29 Aug 2023 23:45:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Aug 2023 19:45:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Aug 2023 19:45:33 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 16/22] imap-send: mark unused parameters with NO_OPENSSL
Message-ID: <20230829234533.GN227214@coredump.intra.peff.net>
References: <20230829234305.GA226944@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829234305.GA226944@coredump.intra.peff.net>
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
2.42.0.528.g7950723a09

