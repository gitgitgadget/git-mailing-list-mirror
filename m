Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031D8C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 19:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350999AbiA1TsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 14:48:16 -0500
Received: from [185.13.181.2] ([185.13.181.2]:60116 "EHLO
        smtpservice.6wind.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S239494AbiA1TsP (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Jan 2022 14:48:15 -0500
Received: from localhost (dio.dev.6wind.com [10.17.1.86])
        by smtpservice.6wind.com (Postfix) with ESMTP id E2BA360100;
        Fri, 28 Jan 2022 20:48:13 +0100 (CET)
From:   Robin Jarry <robin.jarry@6wind.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Robin Jarry <robin.jarry@6wind.com>
Subject: [PATCH v4] receive-pack: check if client is alive before completing the push
Date:   Fri, 28 Jan 2022 20:48:11 +0100
Message-Id: <20220128194811.3396281-1-robin.jarry@6wind.com>
X-Mailer: git-send-email 2.35.0.4.g44a5d4affccf
In-Reply-To: <20220127215553.1386024-1-robin.jarry@6wind.com>
References: <20220127215553.1386024-1-robin.jarry@6wind.com>
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
progress). If the client has exited the write() operation should fail
and the push will be aborted. This only works when sideband*
capabilities are advertised by the client.

Note: if the write() operation fails, receive-pack will likely be killed
via SIGPIPE and even so, since the client is likely gone already, the
error strings will go nowhere. I only added them for code consistency.

Signed-off-by: Robin Jarry <robin.jarry@6wind.com>
---
v3 -> v4:
  - reworded the comment block s/ensure/notice/
  - used write_in_full() instead of write_or_die()
  - set error_string fields for code consistency

 builtin/receive-pack.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9f4a0b816cf9..f8b9a9312733 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1971,6 +1971,22 @@ static void execute_commands(struct command *commands,
 		return;
 	}
 
+	/*
+	 * Send a keepalive packet on sideband 2 (progress info) to notice
+	 * a client that has disconnected (e.g. killed with ^C) while
+	 * pre-receive was running.
+	 */
+	if (use_sideband) {
+		static const char buf[] = "0005\2";
+		if (write_in_full(1, buf, sizeof(buf) - 1) < 0) {
+			for (cmd = commands; cmd; cmd = cmd->next) {
+				if (!cmd->error_string)
+					cmd->error_string = "pusher went away";
+			}
+			return;
+		}
+	}
+
 	/*
 	 * Now we'll start writing out refs, which means the objects need
 	 * to be in their final positions so that other processes can see them.
-- 
2.35.0.4.g44a5d4affccf

