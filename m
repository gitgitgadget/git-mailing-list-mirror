Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1736AC433F5
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 22:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8B560E8B
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 22:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbhKFWIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 18:08:11 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:37039 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbhKFWIL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 18:08:11 -0400
Received: (Authenticated sender: robin@jarry.cc)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 1F56D1C0004;
        Sat,  6 Nov 2021 22:05:26 +0000 (UTC)
From:   Robin Jarry <robin@jarry.cc>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Jan Smets <jan.smets@nokia.com>,
        Stephen Morton <stephen.morton@nokia.com>,
        Jeff King <peff@peff.net>, Robin Jarry <robin@jarry.cc>
Subject: [PATCH v2] receive-pack: ignore SIGPIPE while reporting status to client
Date:   Sat,  6 Nov 2021 23:03:59 +0100
Message-Id: <20211106220358.144886-1-robin@jarry.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211104133546.1967308-1-robin.jarry@6wind.com>
References: <20211104133546.1967308-1-robin.jarry@6wind.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a remote client exits while the pre-receive hook is running,
receive-pack is not killed by SIGPIPE because the signal is ignored.
This is a side effect of commit ec7dbd145bd8 (receive-pack: allow hooks
to ignore its standard input stream, 2014-09-12).

The pre-receive hook itself is not interrupted and does not receive any
error since its stdout is a pipe which is read in an async thread and
output back to the client socket in a side band channel.

After the pre-receive has exited the SIGPIPE default handler is restored
and if the hook did not report any error, objects are migrated from
temporary to permanent storage.

Before running the post-receive hook, status info is reported back to
the client. Since the client has died, receive-pack is killed by SIGPIPE
and post-receive is never executed.

The post-receive hook is often used to send email notifications (see
contrib/hooks/post-receive-email), update bug trackers, start automatic
builds, etc. Not executing it after an interrupted yet "successful" push
can lead to inconsistencies.

Ignore SIGPIPE before reporting status to the client to increase the
chances of post-receive running if pre-receive was successful. This does
not guarantee 100% consistency but it should resist early disconnection
by the client.

Signed-off-by: Robin Jarry <robin@jarry.cc>
---
Ideally, pre-receive should not be allowed to succeed if the client has
disconnected before objects have been migrated from temporary to
permanent storage. But that is another topic, and I think it would
complement this patch.

 builtin/receive-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 49b846d96052..5fe7992028d4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2564,12 +2564,14 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		use_keepalive = KEEPALIVE_ALWAYS;
 		execute_commands(commands, unpack_status, &si,
 				 &push_options);
+		sigchain_push(SIGPIPE, SIG_IGN);
 		if (pack_lockfile)
 			unlink_or_warn(pack_lockfile);
 		if (report_status_v2)
 			report_v2(commands, unpack_status);
 		else if (report_status)
 			report(commands, unpack_status);
+		sigchain_pop(SIGPIPE);
 		run_receive_hook(commands, "post-receive", 1,
 				 &push_options);
 		run_update_post_hook(commands);
-- 
2.30.2

