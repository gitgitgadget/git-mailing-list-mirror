Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB87D1F744
	for <e@80x24.org>; Mon, 18 Jul 2016 05:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbcGRE7O (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 00:59:14 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41576 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbcGRE7M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 00:59:12 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E883D1F744;
	Mon, 18 Jul 2016 04:59:11 +0000 (UTC)
Date:	Mon, 18 Jul 2016 04:59:11 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: [PATCH] daemon: ignore ENOTSOCK from setsockopt
Message-ID: <20160718045911.GA7227@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In inetd mode, we are not guaranteed stdin or stdout is a
socket; callers could filter the data through a pipe
or be testing with regular files.

This prevents t5802 from polluting syslog.

Signed-off-by: Eric Wong <e@80x24.org>
---
 daemon.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/daemon.c b/daemon.c
index 46dddac..a844951 100644
--- a/daemon.c
+++ b/daemon.c
@@ -673,9 +673,11 @@ static void set_keep_alive(int sockfd)
 {
 	int ka = 1;
 
-	if (setsockopt(sockfd, SOL_SOCKET, SO_KEEPALIVE, &ka, sizeof(ka)) < 0)
-		logerror("unable to set SO_KEEPALIVE on socket: %s",
-			strerror(errno));
+	if (setsockopt(sockfd, SOL_SOCKET, SO_KEEPALIVE, &ka, sizeof(ka)) < 0) {
+		if (errno != ENOTSOCK)
+			logerror("unable to set SO_KEEPALIVE on socket: %s",
+				strerror(errno));
+	}
 }
 
 static int execute(void)
-- 
EW
