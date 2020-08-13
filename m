Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68613C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C2220781
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHMPzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:55:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:57884 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgHMPzB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 11:55:01 -0400
Received: (qmail 20315 invoked by uid 109); 13 Aug 2020 15:55:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 15:55:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15095 invoked by uid 111); 13 Aug 2020 15:55:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 11:55:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 11:55:00 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] stop calling UNLEAK() before die()
Message-ID: <20200813155500.GA897132@coredump.intra.peff.net>
References: <20200813155426.GA896769@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200813155426.GA896769@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The point of UNLEAK() is to make a reference to a variable that is about
to go out of scope so that leak-checkers will consider it to be
not-leaked. Doing so right before die() is therefore pointless; even
though we are about to exit the program, the variable will still be on
the stack and accessible to leak-checkers.

These annotations aren't really hurting anything, but they clutter the
code and set a bad example of how to use UNLEAK().

Signed-off-by: Jeff King <peff@peff.net>
---
 bugreport.c | 4 +---
 midx.c      | 8 ++------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/bugreport.c b/bugreport.c
index 09579e268d..7ca0fba1b8 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -175,10 +175,8 @@ int cmd_main(int argc, const char **argv)
 	/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
 	report = open(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
 
-	if (report < 0) {
-		UNLEAK(report_path);
+	if (report < 0)
 		die(_("couldn't create a new file at '%s'"), report_path.buf);
-	}
 
 	if (write_in_full(report, buffer.buf, buffer.len) < 0)
 		die_errno(_("unable to write to %s"), report_path.buf);
diff --git a/midx.c b/midx.c
index a5fb797ede..737420f157 100644
--- a/midx.c
+++ b/midx.c
@@ -807,11 +807,9 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	int result = 0;
 
 	midx_name = get_midx_filename(object_dir);
-	if (safe_create_leading_directories(midx_name)) {
-		UNLEAK(midx_name);
+	if (safe_create_leading_directories(midx_name))
 		die_errno(_("unable to create leading directories of %s"),
 			  midx_name);
-	}
 
 	if (m)
 		packs.m = m;
@@ -1051,10 +1049,8 @@ void clear_midx_file(struct repository *r)
 		r->objects->multi_pack_index = NULL;
 	}
 
-	if (remove_path(midx)) {
-		UNLEAK(midx);
+	if (remove_path(midx))
 		die(_("failed to clear multi-pack-index at %s"), midx);
-	}
 
 	free(midx);
 }
-- 
2.28.0.573.gec6564704b

