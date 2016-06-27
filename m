Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 098931FE4E
	for <e@80x24.org>; Mon, 27 Jun 2016 22:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbcF0WWl (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 18:22:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:33736 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751644AbcF0WWl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 18:22:41 -0400
Received: (qmail 11329 invoked by uid 102); 27 Jun 2016 22:22:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 18:22:40 -0400
Received: (qmail 13932 invoked by uid 107); 27 Jun 2016 22:22:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 18:22:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jun 2016 18:22:38 -0400
Date:	Mon, 27 Jun 2016 18:22:38 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] xread: retry after poll on EAGAIN/EWOULDBLOCK
Message-ID: <20160627222238.GA23645@sigill.intra.peff.net>
References: <20160626232112.721-1-e@80x24.org>
 <20160626232112.721-2-e@80x24.org>
 <20160626234251.GA21668@sigill.intra.peff.net>
 <xmqqoa6mdbu3.fsf@gitster.mtv.corp.google.com>
 <20160627143648.GA2618@sigill.intra.peff.net>
 <CAGZ79kZ94PaOfq3GimWiHULbTE7ihMzL9S=Y+npQ4F5gGwFrsA@mail.gmail.com>
 <20160627201311.GA7039@dcvr.yhbt.net>
 <20160627214947.GA17149@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160627214947.GA17149@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 05:49:48PM -0400, Jeff King wrote:

> So in general I would say that handing non-blocking descriptors to git
> is not safe. I think it's possible to loop on getdelim() when we see
> EAGAIN, but I'm not sure if it's worth it.

The patch for that is below, for the curious. It works with even this:

  {
    for i in H E A D; do
      sleep 1
      printf $i
    done
    printf "\n"
  } | nonblock git cat-file --batch-check

Note that I folded the "did we see EAGAIN" check into my sub-function
(which is the equivalent of your io_wait). You might want to do that in
the xread() code path, too, as it makes the resulting code there a very
nice:

  if (errno == EINTR)
	continue;
  if (handle_nonblock(fd, POLLIN))
	continue;

---
diff --git a/strbuf.c b/strbuf.c
index 1ba600b..2147873 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -452,6 +452,38 @@ int strbuf_getcwd(struct strbuf *sb)
 	return -1;
 }
 
+int handle_nonblock(FILE *fp, short poll_events)
+{
+	if (ferror(fp) && (errno == EAGAIN || errno == EWOULDBLOCK)) {
+		struct pollfd pfd;
+
+		pfd.events = poll_events;
+		pfd.fd = fileno(fp);
+		poll(&pfd, 1, -1);
+		clearerr(fp);
+		return 1;
+	}
+	return 0;
+}
+
+static int getline_stdio_loop(struct strbuf *sb, FILE *fp, int term)
+{
+	int ch;
+	do {
+		errno = 0;
+		flockfile(fp);
+		while ((ch = getc_unlocked(fp)) != EOF) {
+			if (!strbuf_avail(sb))
+				strbuf_grow(sb, 1);
+			sb->buf[sb->len++] = ch;
+			if (ch == term)
+				break;
+		}
+		funlockfile(fp);
+	} while (handle_nonblock(fp, POLLIN));
+	return ch;
+}
+
 #ifdef HAVE_GETDELIM
 int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 {
@@ -465,12 +497,31 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 	/* Translate slopbuf to NULL, as we cannot call realloc on it */
 	if (!sb->alloc)
 		sb->buf = NULL;
+
+	errno = 0;
 	r = getdelim(&sb->buf, &sb->alloc, term, fp);
 
 	if (r > 0) {
 		sb->len = r;
-		return 0;
 	}
+
+	/*
+	 * getdelim will return characters to us even if it sees EAGAIN;
+	 * we want to read all the way to an actual delimiter or EOF.
+	 *
+	 * We can't just loop on getdelim, though, as it wants to write
+	 * the whole buffer itself. So fall back to a stdio loop, which
+	 * can incrementally add to our strbuf.
+	 */
+	if (handle_nonblock(fp, POLLIN)) {
+		getline_stdio_loop(sb, fp, term);
+		/* Propagate real errors */
+		if (ferror(fp))
+			r = -1;
+	}
+	if (r > 0)
+		return 0;
+
 	assert(r == -1);
 
 	/*
@@ -507,15 +558,7 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 		return EOF;
 
 	strbuf_reset(sb);
-	flockfile(fp);
-	while ((ch = getc_unlocked(fp)) != EOF) {
-		if (!strbuf_avail(sb))
-			strbuf_grow(sb, 1);
-		sb->buf[sb->len++] = ch;
-		if (ch == term)
-			break;
-	}
-	funlockfile(fp);
+	ch = getline_stdio_loop(sb, fp, term);
 	if (ch == EOF && sb->len == 0)
 		return EOF;
 
