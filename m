Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8B1C32773
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 10:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348202AbiHSKJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 06:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348194AbiHSKJA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 06:09:00 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9050BCC0A
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 03:08:53 -0700 (PDT)
Received: (qmail 17684 invoked by uid 109); 19 Aug 2022 10:08:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Aug 2022 10:08:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 946 invoked by uid 111); 19 Aug 2022 10:08:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Aug 2022 06:08:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Aug 2022 06:08:52 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 10/11] run-command: mark unused async callback parameters
Message-ID: <Yv9hNGG2Ft4vT5S7@coredump.intra.peff.net>
References: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The start_async(), etc, functions need a "proc" callback that conforms
to a particular interface. Not every callback needs every parameter
(e.g., the caller might not even ask to open an input descriptor, in
which case there is no point in the callback looking at it). Let's mark
these for -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 2 +-
 convert.c              | 2 +-
 fetch-pack.c           | 2 +-
 send-pack.c            | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index afd36c9c53..6882d526e6 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -465,7 +465,7 @@ static void rp_error(const char *err, ...)
 	va_end(params);
 }
 
-static int copy_to_sideband(int in, int out, void *arg)
+static int copy_to_sideband(int in, int UNUSED(out), void *UNUSED(arg))
 {
 	char data[128];
 	int keepalive_active = 0;
diff --git a/convert.c b/convert.c
index b31a25b536..25d89fa83b 100644
--- a/convert.c
+++ b/convert.c
@@ -619,7 +619,7 @@ struct filter_params {
 	const char *path;
 };
 
-static int filter_buffer_or_fd(int in, int out, void *data)
+static int filter_buffer_or_fd(int UNUSED(in), int out, void *data)
 {
 	/*
 	 * Spawn cmd and feed the buffer contents through its stdin.
diff --git a/fetch-pack.c b/fetch-pack.c
index bda9d0f433..9f2933e868 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -823,7 +823,7 @@ static int everything_local(struct fetch_pack_args *args,
 	return retval;
 }
 
-static int sideband_demux(int in, int out, void *data)
+static int sideband_demux(int UNUSED(in), int out, void *data)
 {
 	int *xd = data;
 	int ret;
diff --git a/send-pack.c b/send-pack.c
index 662f7c2aeb..7e99c64e6b 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -266,7 +266,7 @@ static int receive_status(struct packet_reader *reader, struct ref *refs)
 	return ret;
 }
 
-static int sideband_demux(int in, int out, void *data)
+static int sideband_demux(int UNUSED(in), int out, void *data)
 {
 	int *fd = data, ret;
 	if (async_with_fork())
-- 
2.37.2.928.g0821088f4a

