Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3181BC83F14
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 21:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjH1Vs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbjH1Vsa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 17:48:30 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED701A6
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 14:48:24 -0700 (PDT)
Received: (qmail 601 invoked by uid 109); 28 Aug 2023 21:48:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Aug 2023 21:48:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4577 invoked by uid 111); 28 Aug 2023 21:48:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 17:48:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 17:48:23 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 21/22] gc: mark unused descriptors in scheduler callbacks
Message-ID: <20230828214823.GU3831137@coredump.intra.peff.net>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828214604.GA3830831@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Each of the scheduler update callbacks gets the descriptor of the lock
file, but only the crontab updater needs it. We have to retain the
unused descriptors because these are dispatched from a table of function
pointers, but we should mark them to silence -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/gc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 1f53b66c7b..369bd43fb2 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1934,7 +1934,7 @@ static int launchctl_add_plists(void)
 	       launchctl_schedule_plist(exec_path, SCHEDULE_WEEKLY);
 }
 
-static int launchctl_update_schedule(int run_maintenance, int fd)
+static int launchctl_update_schedule(int run_maintenance, int fd UNUSED)
 {
 	if (run_maintenance)
 		return launchctl_add_plists();
@@ -2115,7 +2115,7 @@ static int schtasks_schedule_tasks(void)
 	       schtasks_schedule_task(exec_path, SCHEDULE_WEEKLY);
 }
 
-static int schtasks_update_schedule(int run_maintenance, int fd)
+static int schtasks_update_schedule(int run_maintenance, int fd UNUSED)
 {
 	if (run_maintenance)
 		return schtasks_schedule_tasks();
@@ -2556,7 +2556,7 @@ static int systemd_timer_setup_units(void)
 	return ret;
 }
 
-static int systemd_timer_update_schedule(int run_maintenance, int fd)
+static int systemd_timer_update_schedule(int run_maintenance, int fd UNUSED)
 {
 	if (run_maintenance)
 		return systemd_timer_setup_units();
-- 
2.42.0.505.g4c6fb48dec

