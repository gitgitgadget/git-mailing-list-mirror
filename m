Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC0C02035B
	for <e@80x24.org>; Mon, 10 Jul 2017 13:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932107AbdGJNan (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 09:30:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:35430 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932093AbdGJNan (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 09:30:43 -0400
Received: (qmail 18083 invoked by uid 109); 10 Jul 2017 13:30:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 13:30:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5431 invoked by uid 111); 10 Jul 2017 13:30:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 09:30:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jul 2017 09:30:40 -0400
Date:   Mon, 10 Jul 2017 09:30:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] building git with clang/gcc address sanitizer
Message-ID: <20170710133040.yom65mjol3nmf2it@sigill.intra.peff.net>
References: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 09:24:18AM -0400, Jeff King wrote:

> You can also try:
> 
>   make SANITIZE=thread test
> 
> but it's not clean. I poked at some of the errors, and I don't think
> there a problem in practice (though they may be worth cleaning up in the
> name of code hygiene).

Here's an example that I fixed up long ago, but never quite had the
stomach to seriously propose.

If it were the last one, it might be worth applying to get a clean run
of "make test", but I think it's just one of many.

-- >8 --
Date: Mon, 8 Dec 2014 03:02:34 -0500
Subject: [PATCH] transport-helper: initialize debug flag before starting
 threads

The transport_debug() function uses a static variable to
lazily cache the boolean value of $TRANSPORT_DEBUG. If a
program uses transport-helper's bidirectional_transfer_loop
(as remote-ext and remote-fd do), then two threads may both
try to write the variable at the same time.

We can fix this by initializing the variable right before
starting the threads.

Noticed by "-fsanitize=thread". This probably isn't a
problem in practice, as both threads will write the same
value, and we are unlikely to see a torn write on an "int"
(i.e., on sane platforms a write to an int is atomic).

Signed-off-by: Jeff King <peff@peff.net>
---
 transport-helper.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 33cff38cc..76f19ddb0 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1113,17 +1113,23 @@ int transport_helper_init(struct transport *transport, const char *name)
 /* This should be enough to hold debugging message. */
 #define PBUFFERSIZE 8192
 
+static int transport_debug_enabled(void)
+{
+	static int debug_enabled = -1;
+
+	if (debug_enabled < 0)
+		debug_enabled = getenv("GIT_TRANSLOOP_DEBUG") ? 1 : 0;
+	return debug_enabled;
+}
+
 /* Print bidirectional transfer loop debug message. */
 __attribute__((format (printf, 1, 2)))
 static void transfer_debug(const char *fmt, ...)
 {
 	va_list args;
 	char msgbuf[PBUFFERSIZE];
-	static int debug_enabled = -1;
 
-	if (debug_enabled < 0)
-		debug_enabled = getenv("GIT_TRANSLOOP_DEBUG") ? 1 : 0;
-	if (!debug_enabled)
+	if (!transport_debug_enabled())
 		return;
 
 	va_start(args, fmt);
@@ -1292,6 +1298,10 @@ static int tloop_spawnwait_tasks(struct bidirectional_transfer_state *s)
 	pthread_t ptg_thread;
 	int err;
 	int ret = 0;
+
+	/* initialize static global debug flag as a side effect */
+	transport_debug_enabled();
+
 	err = pthread_create(&gtp_thread, NULL, udt_copy_task_routine,
 		&s->gtp);
 	if (err)
-- 
2.13.2.1071.gcd8104b61

