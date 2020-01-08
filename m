Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44108C00523
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 07:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C9520692
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 07:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgAHHKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 02:10:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:60016 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725944AbgAHHKK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 02:10:10 -0500
Received: (qmail 19954 invoked by uid 109); 8 Jan 2020 07:10:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Jan 2020 07:10:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7717 invoked by uid 111); 8 Jan 2020 07:15:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Jan 2020 02:15:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Jan 2020 02:10:09 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] transport: don't flush when disconnecting stateless-rpc
 helper
Message-ID: <20200108071009.GA1675456@coredump.intra.peff.net>
References: <20200108033451.GN6570@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200108033451.GN6570@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 08, 2020 at 03:34:51AM +0000, brian m. carlson wrote:

> A colleague (Jon Simons) today pointed out an interesting behavior of
> git ls-remote with protocol v2: it makes a second POST request and sends
> only a flush packet.  This can be demonstrated with the following:
> 
>   GIT_CURL_VERBOSE=1 git -c protocol.version=2 ls-remote origin
> 
> The Content-Length header on the second request will be exactly 4 bytes.
> 
> I'm not sure exactly how to fix this by looking at remote-curl.c, but I
> suspect that we can avoid sending a request if all we're going to do is
> send a flush packet.  If I were a bit more familiar with the code, I'd
> send a patch, but I'm not.

Yeah, in theory remote-curl could be smarter about turning such a
pointless request into a noop. But I think the root cause is actually on
the ls-remote side. How about this?

-- >8 --
Subject: transport: don't flush when disconnecting stateless-rpc helper

Since ba227857d2 (Reduce the number of connects when fetching,
2008-02-04), when we disconnect a git transport, we send a final flush
packet. This cleanly tells the other side that we're done, and avoids
the other side complaining "the remote end hung up unexpectedly" (though
we'd only see that for transports that pass along the server stderr,
like ssh or local-host).

But when we've initiated a v2 stateless-connect session over a transport
helper, there's no point in sending this flush packet. Each operation
we've performed is self-contained, and the other side is fine with us
hanging up between operations.

But much worse, by sending the flush packet we may cause the helper to
issue an entirely new request _just_ to send the flush packet. So we can
incur an extra network request just to say "by the way, we have nothing
more to send".

Let's drop this extra flush packet. As the test shows, this reduces the
number of POSTs required for a v2 ls-remote over http from 2 to 1.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5702-protocol-v2.sh | 12 ++++++++++++
 transport.c            |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index e73067d23f..7fd7102c87 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -665,6 +665,18 @@ test_expect_success 'fetch from namespaced repo respects namespaces' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ls-remote with v2 http sends only one POST' '
+	test_when_finished "rm -f log" &&
+
+	git ls-remote "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" >expect &&
+	GIT_TRACE_CURL="$(pwd)/log" git -c protocol.version=2 \
+		ls-remote "$HTTPD_URL/smart/http_parent" >actual &&
+	test_cmp expect actual &&
+
+	grep "Send header: POST" log >posts &&
+	test_line_count = 1 posts
+'
+
 test_expect_success 'push with http:// and a config of v2 does not request v2' '
 	test_when_finished "rm -f log" &&
 	# Till v2 for push is designed, make sure that if a client has
diff --git a/transport.c b/transport.c
index 83379a037d..1fdc7dac1a 100644
--- a/transport.c
+++ b/transport.c
@@ -737,7 +737,7 @@ static int disconnect_git(struct transport *transport)
 {
 	struct git_transport_data *data = transport->data;
 	if (data->conn) {
-		if (data->got_remote_heads)
+		if (data->got_remote_heads && !transport->stateless_rpc)
 			packet_flush(data->fd[1]);
 		close(data->fd[0]);
 		close(data->fd[1]);
-- 
2.25.0.rc1.618.gb996734ace

