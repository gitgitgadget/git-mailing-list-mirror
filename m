Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6981B1F858
	for <e@80x24.org>; Mon, 14 Nov 2016 19:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932462AbcKNTkw (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 14:40:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:42986 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751532AbcKNTkv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 14:40:51 -0500
Received: (qmail 17405 invoked by uid 109); 14 Nov 2016 19:40:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Nov 2016 19:40:51 +0000
Received: (qmail 4098 invoked by uid 111); 14 Nov 2016 19:41:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Nov 2016 14:41:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2016 14:40:49 -0500
Date:   Mon, 14 Nov 2016 14:40:49 -0500
From:   Jeff King <peff@peff.net>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, spearce@spearce.org
Subject: Re: [PATCH] remote-curl: don't hang when a server dies before any
 output
Message-ID: <20161114194049.mktpsvgdhex2f4zv@sigill.intra.peff.net>
References: <1478729910-26232-1-git-send-email-dturner@twosigma.com>
 <20161114182431.e7jjnq422c4xobdb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161114182431.e7jjnq422c4xobdb@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2016 at 01:24:31PM -0500, Jeff King wrote:

>   2. Have remote-curl understand enough of the protocol that it can
>      abort rather than hang.
> 
>      I think that's effectively the approach of your patch, but for one
>      specific case. But could we, for example, make sure that everything
>      we proxy is a complete set of pktlines and ends with a flush? And
>      if not, then we hang up on fetch-pack.
> 
>      I _think_ that would work, because even the pack is always encased
>      in pktlines for smart-http.

So something like this. It turned out to be a lot uglier than I had
hoped because we get fed the data from curl in odd-sized chunks, so we
need a state machine.

But it does seem to work. At least it doesn't seem to break anything in
the test suite, and it fixes the new tests you added. I'd worry that
there's some obscure case where the response isn't packetized in the
same way.

---
diff --git a/remote-curl.c b/remote-curl.c
index f14c41f4c..605357d77 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -403,6 +403,18 @@ struct rpc_state {
 	struct strbuf result;
 	unsigned gzip_request : 1;
 	unsigned initial_buffer : 1;
+
+	enum {
+		RPC_PKTLINE_ERROR, /* bogus hex chars in length */
+		RPC_PKTLINE_INITIAL, /* no packets received yet */
+		RPC_PKTLINE_1, /* got one hex char */
+		RPC_PKTLINE_2, /* got two hex chars */
+		RPC_PKTLINE_3, /* got three hex chars */
+		RPC_PKTLINE_DATA, /* reading data; pktline_len holds remaining */
+		RPC_PKTLINE_END_OF_PACKET, /* last packet completed */
+		RPC_PKTLINE_FLUSH, /* last packet was flush */
+	} pktline_state;
+	size_t pktline_len;
 };
 
 static size_t rpc_out(void *ptr, size_t eltsize,
@@ -451,11 +463,77 @@ static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
 }
 #endif
 
+static void update_pktline_state(struct rpc_state *rpc,
+				 const char *buf, size_t len)
+{
+#define READ_ONE_HEX(shift) do { \
+	int val = hexval(buf[0]); \
+	if (val < 0) { \
+		warning("error on %d", *buf); \
+		rpc->pktline_state = RPC_PKTLINE_ERROR; \
+		return; \
+	} \
+	rpc->pktline_len |= val << shift; \
+	buf++; \
+	len--; \
+} while(0)
+
+	while (len > 0) {
+		switch (rpc->pktline_state) {
+		case RPC_PKTLINE_ERROR:
+			/* previous error; there is no recovery */
+			return;
+
+		/* We can start a new pktline at any of these states */
+		case RPC_PKTLINE_INITIAL:
+		case RPC_PKTLINE_FLUSH:
+		case RPC_PKTLINE_END_OF_PACKET:
+			rpc->pktline_len = 0;
+			READ_ONE_HEX(12);
+			rpc->pktline_state = RPC_PKTLINE_1;
+			break;
+
+		case RPC_PKTLINE_1:
+			READ_ONE_HEX(8);
+			rpc->pktline_state = RPC_PKTLINE_2;
+			break;
+
+		case RPC_PKTLINE_2:
+			READ_ONE_HEX(4);
+			rpc->pktline_state = RPC_PKTLINE_3;
+			break;
+
+		case RPC_PKTLINE_3:
+			READ_ONE_HEX(0);
+			if (rpc->pktline_len) {
+				rpc->pktline_state = RPC_PKTLINE_DATA;
+				rpc->pktline_len -= 4;
+			} else
+				rpc->pktline_state = RPC_PKTLINE_FLUSH;
+			break;
+
+		case RPC_PKTLINE_DATA:
+			if (len < rpc->pktline_len) {
+				rpc->pktline_len -= len;
+				len = 0;
+			} else {
+				buf += rpc->pktline_len;
+				len -= rpc->pktline_len;
+				rpc->pktline_len = 0;
+				rpc->pktline_state = RPC_PKTLINE_END_OF_PACKET;
+			}
+			break;
+		}
+	}
+#undef READ_ONE_HEX
+}
+
 static size_t rpc_in(char *ptr, size_t eltsize,
 		size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
 	struct rpc_state *rpc = buffer_;
+	update_pktline_state(rpc, ptr, size);
 	write_or_die(rpc->in, ptr, size);
 	return size;
 }
@@ -659,6 +737,8 @@ static int post_rpc(struct rpc_state *rpc)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, rpc);
 
+	rpc->pktline_state = RPC_PKTLINE_INITIAL;
+
 	err = run_slot(slot, NULL);
 	if (err == HTTP_REAUTH && !large_request) {
 		credential_fill(&http_auth);
@@ -667,6 +747,11 @@ static int post_rpc(struct rpc_state *rpc)
 	if (err != HTTP_OK)
 		err = -1;
 
+	if (rpc->pktline_state != RPC_PKTLINE_FLUSH) {
+		error("invalid or truncated response from http server");
+		err = -1;
+	}
+
 	curl_slist_free_all(headers);
 	free(gzip_body);
 	return err;
