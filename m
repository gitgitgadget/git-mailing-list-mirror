Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 214A41F991
	for <e@80x24.org>; Wed,  9 Aug 2017 14:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753261AbdHIOqK (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 10:46:10 -0400
Received: from 6.mo176.mail-out.ovh.net ([46.105.44.204]:50075 "EHLO
        6.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbdHIOqK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 10:46:10 -0400
X-Greylist: delayed 111458 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Aug 2017 10:46:09 EDT
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id 7C5E46BB40;
        Wed,  9 Aug 2017 16:46:08 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 9 Aug
 2017 16:46:08 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [RFC 1/3] imap-send: move tunnel setup to its own function
To:     <git@vger.kernel.org>
CC:     <peff@peff.net>
References: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com>
Message-ID: <fd231e01-1eb2-17a8-52e8-19d9c0a2d4a3@morey-chaisemartin.com>
Date:   Wed, 9 Aug 2017 16:46:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101
 Thunderbird/55.0
MIME-Version: 1.0
In-Reply-To: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.136.234]
X-ClientProxiedBy: CAS3.indiv2.local (172.16.1.3) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 2319353810013972471
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelkedrkeehgdekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 imap-send.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index b2d0b849b..10f668eb7 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -926,6 +926,27 @@ static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, const cha
 	return 0;
 }
 
+static void setup_tunnel(struct imap_server_conf *srvc, int fds[2])
+{
+	struct child_process tunnel = CHILD_PROCESS_INIT;
+
+	imap_info("Starting tunnel '%s'... ", srvc->tunnel);
+
+	argv_array_push(&tunnel.args, srvc->tunnel);
+	tunnel.use_shell = 1;
+	tunnel.in = -1;
+	tunnel.out = -1;
+	if (start_command(&tunnel))
+		die("cannot start proxy %s", srvc->tunnel);
+
+	fds[0] = tunnel.out;
+	fds[1] = tunnel.in;
+
+	imap_info("ok\n");
+
+	return;
+}
+
 static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *folder)
 {
 	struct credential cred = CREDENTIAL_INIT;
@@ -943,21 +964,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *f
 	/* open connection to IMAP server */
 
 	if (srvc->tunnel) {
-		struct child_process tunnel = CHILD_PROCESS_INIT;
-
-		imap_info("Starting tunnel '%s'... ", srvc->tunnel);
-
-		argv_array_push(&tunnel.args, srvc->tunnel);
-		tunnel.use_shell = 1;
-		tunnel.in = -1;
-		tunnel.out = -1;
-		if (start_command(&tunnel))
-			die("cannot start proxy %s", srvc->tunnel);
-
-		imap->buf.sock.fd[0] = tunnel.out;
-		imap->buf.sock.fd[1] = tunnel.in;
-
-		imap_info("ok\n");
+		setup_tunnel(srvc, imap->buf.sock.fd);
 	} else {
 #ifndef NO_IPV6
 		struct addrinfo hints, *ai0, *ai;
-- 
2.14.0.3.gb4ff627ec.dirty


