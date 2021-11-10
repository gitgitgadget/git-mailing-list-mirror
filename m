Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0762FC433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 09:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9CA761221
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 09:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhKJJdF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 04:33:05 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60647 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhKJJdE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 04:33:04 -0500
Received: (Authenticated sender: robin@jarry.cc)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 39B0C6000B;
        Wed, 10 Nov 2021 09:30:12 +0000 (UTC)
From:   Robin Jarry <robin@jarry.cc>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Jan Smets <jan.smets@nokia.com>,
        Stephen Morton <stephen.morton@nokia.com>,
        Jeff King <peff@peff.net>, Robin Jarry <robin@jarry.cc>
Subject: [PATCH v3] receive-pack: ignore SIGPIPE while reporting status to client
Date:   Wed, 10 Nov 2021 10:29:42 +0100
Message-Id: <20211110092942.1648429-1-robin@jarry.cc>
X-Mailer: git-send-email 2.34.0.rc2.2.gbcf7eca935e4
In-Reply-To: <20211106220358.144886-1-robin@jarry.cc>
References: <20211106220358.144886-1-robin@jarry.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before running the post-receive hook, status info is reported back to
the client. If a remote client exits before or during the status report,
receive-pack is killed by SIGPIPE and post-receive is never executed.

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
Changes since v2:

* Updated commit log with more pertinent info.
* Only ignore SIGPIPE while reporting status, *after* removing the lock
  file.

 builtin/receive-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 49b846d96052..2f4a38adfe2c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2566,10 +2566,12 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 				 &push_options);
 		if (pack_lockfile)
 			unlink_or_warn(pack_lockfile);
+		sigchain_push(SIGPIPE, SIG_IGN);
 		if (report_status_v2)
 			report_v2(commands, unpack_status);
 		else if (report_status)
 			report(commands, unpack_status);
+		sigchain_pop(SIGPIPE);
 		run_receive_hook(commands, "post-receive", 1,
 				 &push_options);
 		run_update_post_hook(commands);
-- 
2.34.0.rc2.2.gbcf7eca935e4

