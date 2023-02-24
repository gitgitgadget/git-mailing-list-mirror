Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53463C677F1
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBXGjc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjBXGjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:39:25 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92DE61F32
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:39:19 -0800 (PST)
Received: (qmail 3681 invoked by uid 109); 24 Feb 2023 06:39:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:39:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31107 invoked by uid 111); 24 Feb 2023 06:39:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:39:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:39:18 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 10/21] run-command: mark error routine parameters as unused
Message-ID: <Y/hbli5wEl8cMTj1@coredump.intra.peff.net>
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After forking but before exec-ing a command, we install special
error/warn/die handlers in the child. These ignore the error messages
they get, since the idea is that they shouldn't be called in the first
place.

Arguably they could pass along that error message _in addition_ to
saying "error() should not be called in a child", but since the whole
point is to avoid any conflicts on stdio/malloc locks, etc, we're better
to just keep these simple. Seeing them trigger is effectively a bug, and
the developer is probably better off grabbing a stack trace.

But we do want to mark the functions so that -Wunused-parameter doesn't
complain.

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index 6bd16acb06..ba617655b2 100644
--- a/run-command.c
+++ b/run-command.c
@@ -341,19 +341,19 @@ static void child_close_pair(int fd[2])
 	child_close(fd[1]);
 }
 
-static void child_error_fn(const char *err, va_list params)
+static void child_error_fn(const char *err UNUSED, va_list params UNUSED)
 {
 	const char msg[] = "error() should not be called in child\n";
 	xwrite(2, msg, sizeof(msg) - 1);
 }
 
-static void child_warn_fn(const char *err, va_list params)
+static void child_warn_fn(const char *err UNUSED, va_list params UNUSED)
 {
 	const char msg[] = "warn() should not be called in child\n";
 	xwrite(2, msg, sizeof(msg) - 1);
 }
 
-static void NORETURN child_die_fn(const char *err, va_list params)
+static void NORETURN child_die_fn(const char *err UNUSED, va_list params UNUSED)
 {
 	const char msg[] = "die() should not be called in child\n";
 	xwrite(2, msg, sizeof(msg) - 1);
-- 
2.39.2.981.g6157336f25

