Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B2B81F991
	for <e@80x24.org>; Wed,  9 Aug 2017 14:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbdHIOw4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 10:52:56 -0400
Received: from 8.mo176.mail-out.ovh.net ([46.105.58.67]:37426 "EHLO
        8.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbdHIOwz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 10:52:55 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id 3E3976BCF1;
        Wed,  9 Aug 2017 16:46:17 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 9 Aug
 2017 16:46:15 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [RFC 2/3] imap-send: use a socketpair instead of pipe to communicate
 with the tunnel
To:     <git@vger.kernel.org>
CC:     <peff@peff.net>
References: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com>
Message-ID: <ac79ae33-db5a-ae90-5e6d-b6364c77266a@morey-chaisemartin.com>
Date:   Wed, 9 Aug 2017 16:46:15 +0200
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
X-Ovh-Tracer-Id: 2321887084909160439
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelkedrkeehgdekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 imap-send.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 10f668eb7..e5ff70096 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -929,18 +929,27 @@ static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, const cha
 static void setup_tunnel(struct imap_server_conf *srvc, int fds[2])
 {
 	struct child_process tunnel = CHILD_PROCESS_INIT;
+	int sock_fds[2];
 
 	imap_info("Starting tunnel '%s'... ", srvc->tunnel);
 
+	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sock_fds))
+		die("failed to create socketpair for proxy");
+
 	argv_array_push(&tunnel.args, srvc->tunnel);
 	tunnel.use_shell = 1;
-	tunnel.in = -1;
-	tunnel.out = -1;
+	tunnel.in = sock_fds[1];
+	/* Duplicate the fd as the child process requires
+	 * 1 for stdin, one for stdout */
+	tunnel.out = dup(sock_fds[1]);
+	if (tunnel.out < 0)
+		die("failed to create fd to proxy");
+
 	if (start_command(&tunnel))
 		die("cannot start proxy %s", srvc->tunnel);
 
-	fds[0] = tunnel.out;
-	fds[1] = tunnel.in;
+	fds[0] = sock_fds[0];
+	fds[1] = sock_fds[0];
 
 	imap_info("ok\n");
 
-- 
2.14.0.3.gb4ff627ec.dirty


