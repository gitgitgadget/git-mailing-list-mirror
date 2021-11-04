Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94766C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 13:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F83A611C4
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 13:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhKDNra (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 09:47:30 -0400
Received: from host.78.145.23.62.rev.coltfrance.com ([62.23.145.78]:44208 "EHLO
        smtpservice.6wind.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231314AbhKDNr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 09:47:29 -0400
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Nov 2021 09:47:29 EDT
Received: from localhost (dio.dev.6wind.com [10.16.0.86])
        by smtpservice.6wind.com (Postfix) with ESMTP id 44DC26001B;
        Thu,  4 Nov 2021 14:36:49 +0100 (CET)
From:   Robin Jarry <robin.jarry@6wind.com>
To:     git@vger.kernel.org
Cc:     Robin Jarry <robin.jarry@6wind.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [RFC PATCH] receive-pack: run post-receive before reporting status
Date:   Thu,  4 Nov 2021 14:35:47 +0100
Message-Id: <20211104133546.1967308-1-robin.jarry@6wind.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a remote client exits while the pre-receive hook is running,
receive-pack is not killed by SIGPIPE because the signal is ignored.
This is a side effect of commit ec7dbd145bd8 ("receive-pack: allow hooks
to ignore its standard input stream").

The pre-receive hook is not interrupted and does not receive any error
since its stdout is a pipe which is read in an async thread and output
back to the client socket in a side band channel. When writing the data
in the socket, the async thread gets a SIGPIPE which also seems ignored.
This may be a race between the main and the async threads. I do not know
the code well enough to be sure.

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

Execute the post-receive hook before reporting status to the client to
avoid this issue. This is not an ideal solution but I don't know if
allowing hooks to be killed when a client exits is a good idea. Maybe
for pre-receive but definitely not for post-receive.

Signed-off-by: Robin Jarry <robin.jarry@6wind.com>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 builtin/receive-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 49b846d96052..df8bedf71319 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2564,14 +2564,14 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		use_keepalive = KEEPALIVE_ALWAYS;
 		execute_commands(commands, unpack_status, &si,
 				 &push_options);
+		run_receive_hook(commands, "post-receive", 1,
+				 &push_options);
 		if (pack_lockfile)
 			unlink_or_warn(pack_lockfile);
 		if (report_status_v2)
 			report_v2(commands, unpack_status);
 		else if (report_status)
 			report(commands, unpack_status);
-		run_receive_hook(commands, "post-receive", 1,
-				 &push_options);
 		run_update_post_hook(commands);
 		string_list_clear(&push_options, 0);
 		if (auto_gc) {
-- 
2.30.2

