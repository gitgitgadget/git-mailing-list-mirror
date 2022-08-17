Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5149DC25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 06:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbiHQGJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 02:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiHQGJo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 02:09:44 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641A86E2D8
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 23:09:43 -0700 (PDT)
Received: (qmail 6641 invoked by uid 109); 17 Aug 2022 06:09:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Aug 2022 06:09:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13731 invoked by uid 111); 17 Aug 2022 06:09:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Aug 2022 02:09:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Aug 2022 02:09:42 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 5/6] pipe_command(): handle ENOSPC when writing to a pipe
Message-ID: <YvyGJiz+CFPcgpML@coredump.intra.peff.net>
References: <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When write() to a non-blocking pipe fails because the buffer is full,
POSIX says we should see EAGAIN. But our mingw_write() compat layer on
Windows actually returns ENOSPC for this case. This is probably
something we want to correct, but given that we don't plan to use
non-blocking descriptors in a lot of places, we can work around it by
just catching ENOSPC alongside EAGAIN. If we ever do fix mingw_write(),
then this patch can be reverted.

We don't actually use a non-blocking pipe yet, so this is still just
preparation.

Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Jeff King <peff@peff.net>
---
Ironically, this ENOSPC bug means that switching away from xwrite() in
the previous patch wasn't necessary (because it's not clever enough to
know that ENOSPC on a pipe means EAGAIN!). But I think handling both
shows the intent, and sets us up better for fixing mingw_write().

 run-command.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index e078c3046f..5fbaa8b5ac 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1377,7 +1377,8 @@ static int pump_io_round(struct io_pump *slots, int nr, struct pollfd *pfd)
 				    io->u.out.len <= MAX_IO_SIZE ?
 				    io->u.out.len : MAX_IO_SIZE);
 			if (len < 0) {
-				if (errno != EINTR && errno != EAGAIN) {
+				if (errno != EINTR && errno != EAGAIN &&
+				    errno != ENOSPC) {
 					io->error = errno;
 					close(io->fd);
 					io->fd = -1;
-- 
2.37.2.881.gb57357660c

