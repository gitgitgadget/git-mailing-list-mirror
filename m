Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D902A1F404
	for <e@80x24.org>; Thu, 12 Apr 2018 21:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753199AbeDLVYw (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 17:24:52 -0400
Received: from sif.is.scarlet.be ([193.74.71.28]:24107 "EHLO sif.is.scarlet.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752270AbeDLVYv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 17:24:51 -0400
X-Greylist: delayed 961 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Apr 2018 17:24:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scarlet.be;
        s=scarlet; t=1523567308;
        bh=cPz7Ve1B5vuDH+m8uwMYMFnbcSYMLVY2cbajZTO8U4Y=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=TfU0TJ9CLEURJk946j3kZkhtKfTZeURlWs/KbNAEBNSJwZnX0oac3/nqQIq6ji6wx
         8ONdxiOwORPJisFuZoN1j0u3Tuu/UO0ab1vT1CKoJFtXuImrbIJie2Wb8V13ecOriP
         hcY6qL3dcdQeN2W+Fx48HCC54eEd2r3GPlo+hng8=
Received: from localhost.localdomain (ip-83-134-143-61.dsl.scarlet.be [83.134.143.61])
        by sif.is.scarlet.be (8.14.9/8.14.9) with ESMTP id w3CL8Qbf002436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 12 Apr 2018 23:08:28 +0200
X-Scarlet: d=1523567308 c=83.134.143.61
From:   Kim Gybels <kgybels@infogroep.be>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Kim Gybels <kgybels@infogroep.be>
Subject: [PATCH 2/2] daemon: graceful shutdown of client connection
Date:   Thu, 12 Apr 2018 23:07:57 +0200
Message-Id: <20180412210757.7792-3-kgybels@infogroep.be>
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

On Windows, a connection is shutdown when the last open handle to it is
closed. When that last open handle is stdout of our child process, an
abortive shutdown is triggered when said process exits. Ensure a
graceful shutdown of the client connection by keeping an open handle
until we detect our child process has finished. This allows all the data
to be sent to the client, instead of being discarded.

Fixes https://github.com/git-for-windows/git/issues/304

Signed-off-by: Kim Gybels <kgybels@infogroep.be>
---
 daemon.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/daemon.c b/daemon.c
index 6dc95c1b2f..97fadd62d1 100644
--- a/daemon.c
+++ b/daemon.c
@@ -834,9 +834,10 @@ static struct child {
 	struct child *next;
 	struct child_process cld;
 	struct sockaddr_storage address;
+	int connection;
 } *firstborn;
 
-static void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen)
+static void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen, int connection)
 {
 	struct child *newborn, **cradle;
 
@@ -844,6 +845,7 @@ static void add_child(struct child_process *cld, struct sockaddr *addr, socklen_
 	live_children++;
 	memcpy(&newborn->cld, cld, sizeof(*cld));
 	memcpy(&newborn->address, addr, addrlen);
+	newborn->connection = connection;
 	for (cradle = &firstborn; *cradle; cradle = &(*cradle)->next)
 		if (!addrcmp(&(*cradle)->address, &newborn->address))
 			break;
@@ -888,6 +890,7 @@ static void check_dead_children(void)
 			*cradle = blanket->next;
 			live_children--;
 			child_process_clear(&blanket->cld);
+			close(blanket->connection);
 			free(blanket);
 		} else
 			cradle = &blanket->next;
@@ -928,13 +931,13 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 	}
 
 	cld.argv = cld_argv.argv;
-	cld.in = incoming;
+	cld.in = dup(incoming);
 	cld.out = dup(incoming);
 
 	if (start_command(&cld))
 		logerror("unable to fork");
 	else
-		add_child(&cld, addr, addrlen);
+		add_child(&cld, addr, addrlen, incoming);
 }
 
 static void child_handler(int signo)
-- 
2.17.0.windows.1

