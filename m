Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D0EC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 21:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238336AbiA0Vz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 16:55:59 -0500
Received: from [185.13.181.2] ([185.13.181.2]:59748 "EHLO
        smtpservice.6wind.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S237922AbiA0Vz7 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Jan 2022 16:55:59 -0500
Received: from localhost (dio.dev.6wind.com [10.17.1.86])
        by smtpservice.6wind.com (Postfix) with ESMTP id 5DADC600EE;
        Thu, 27 Jan 2022 22:55:57 +0100 (CET)
From:   Robin Jarry <robin.jarry@6wind.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Robin Jarry <robin.jarry@6wind.com>
Subject: [PATCH v3] receive-pack: check if client is alive before completing the push
Date:   Thu, 27 Jan 2022 22:55:53 +0100
Message-Id: <20220127215553.1386024-1-robin.jarry@6wind.com>
X-Mailer: git-send-email 2.35.0.4.gfdf4c72cdf3d
In-Reply-To: <CHGR6XNP6TV7.15VGVNQUJM9J6@diabtop>
References: <CHGR6XNP6TV7.15VGVNQUJM9J6@diabtop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abort the push operation (i.e. do not migrate the objects from temporary
to permanent storage) if the client has disconnected while the
pre-receive hook was running.

This reduces the risk of inconsistencies on network errors or if the
user hits ctrl-c while the pre-receive hook is running.

Send a keepalive packet (empty) on sideband 2 (the one to report
progress). If the client has exited, receive-pack will be killed via
SIGPIPE and the push will be aborted. This only works when sideband*
capabilities are advertised by the client.

Signed-off-by: Robin Jarry <robin.jarry@6wind.com>
---
v2 -> v3:
    I had missed Documentation/technical/pack-protocol.txt. Using
    sideband 2 to send the keepalive packet works.

 builtin/receive-pack.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9f4a0b816cf9..8b0d56897c9f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1971,6 +1971,15 @@ static void execute_commands(struct command *commands,
 		return;
 	}
 
+	/*
+	 * Send a keepalive packet on sideband 2 (progress info) to ensure that
+	 * the client has not disconnected while pre-receive was running.
+	 */
+	if (use_sideband) {
+		static const char buf[] = "0005\2";
+		write_or_die(1, buf, sizeof(buf) - 1);
+	}
+
 	/*
 	 * Now we'll start writing out refs, which means the objects need
 	 * to be in their final positions so that other processes can see them.
-- 
2.35.0.4.gfdf4c72cdf3d

