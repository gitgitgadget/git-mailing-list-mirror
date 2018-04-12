Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 431C11F404
	for <e@80x24.org>; Thu, 12 Apr 2018 21:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753184AbeDLVYu (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 17:24:50 -0400
Received: from sif.is.scarlet.be ([193.74.71.28]:24107 "EHLO sif.is.scarlet.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752270AbeDLVYt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 17:24:49 -0400
X-Greylist: delayed 961 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Apr 2018 17:24:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scarlet.be;
        s=scarlet; t=1523567307;
        bh=Pj0oEiK5D1fczj4A/iO6u8o9rD78DjhdYVSp9cd1vzs=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=COrtf1zBFlUy05ZQDaFZh6qOpfDaQ2SlIRyctoPM1kdkPkeIGydcJidfHK6TiNMhS
         +yZfsgnXUfBM/ec6izXG69Mel9X+e9ErK8NDgjlyLyq+AgpUbT3LLnecjBLi/WIGge
         kHFtHPFxeMvFDlVgznHv8sAjp0TYwfjnBAIlDI40=
Received: from localhost.localdomain (ip-83-134-143-61.dsl.scarlet.be [83.134.143.61])
        by sif.is.scarlet.be (8.14.9/8.14.9) with ESMTP id w3CL8Qbe002436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 12 Apr 2018 23:08:27 +0200
X-Scarlet: d=1523567307 c=83.134.143.61
From:   Kim Gybels <kgybels@infogroep.be>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Kim Gybels <kgybels@infogroep.be>
Subject: [PATCH 1/2] daemon: use timeout for uninterruptible poll
Date:   Thu, 12 Apr 2018 23:07:56 +0200
Message-Id: <20180412210757.7792-2-kgybels@infogroep.be>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20180412210757.7792-1-kgybels@infogroep.be>
References: <20180412210757.7792-1-kgybels@infogroep.be>
X-DCC-scarlet.be-Metrics: sif 20001; Body=6 Fuz1=6 Fuz2=6
X-Virus-Scanned: clamav-milter 0.98.1-exp at sif
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The poll provided in compat/poll.c is not interrupted by receiving
SIGCHLD. Use a timeout for cleaning up dead children in a timely manner.

Signed-off-by: Kim Gybels <kgybels@infogroep.be>
---
 daemon.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index fe833ea7de..6dc95c1b2f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1147,6 +1147,7 @@ static int service_loop(struct socketlist *socklist)
 {
 	struct pollfd *pfd;
 	int i;
+	int poll_timeout = -1;
 
 	pfd = xcalloc(socklist->nr, sizeof(struct pollfd));
 
@@ -1161,8 +1162,13 @@ static int service_loop(struct socketlist *socklist)
 		int i;
 
 		check_dead_children();
-
-		if (poll(pfd, socklist->nr, -1) < 0) {
+#ifdef NO_POLL
+		poll_timeout = live_children ? 100 : -1;
+#endif
+		int ret = poll(pfd, socklist->nr, poll_timeout);
+		if  (ret == 0) {
+			continue;
+		} else if (ret < 0) {
 			if (errno != EINTR) {
 				logerror("Poll failed, resuming: %s",
 				      strerror(errno));
-- 
2.17.0.windows.1

