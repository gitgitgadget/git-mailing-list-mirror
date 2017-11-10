Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57DCA1F43C
	for <e@80x24.org>; Fri, 10 Nov 2017 09:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbdKJJ6N (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 04:58:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:52200 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751496AbdKJJ6M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 04:58:12 -0500
Received: (qmail 17707 invoked by uid 109); 10 Nov 2017 09:58:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Nov 2017 09:58:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 473 invoked by uid 111); 10 Nov 2017 09:58:23 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Nov 2017 04:58:23 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Nov 2017 09:58:09 +0000
Date:   Fri, 10 Nov 2017 09:58:09 +0000
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Joseph Strauss <josephst@bhphoto.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug - Status - Space in Filename
Message-ID: <20171110095808.igydpwweyceu6qcf@sigill.intra.peff.net>
References: <655aaa9d2abf4be1b6ade0574d88c999@EXMBX01B.bhphotovideo.local>
 <xmqqvaikjfoj.fsf@gitster.mtv.corp.google.com>
 <20171109132939.3v2z6sf22b4tnwpq@sigill.intra.peff.net>
 <xmqqvaijhs5b.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvaijhs5b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 09:52:16AM +0900, Junio C Hamano wrote:

> > That said, if this is the only place that has this funny quoting, it may
> > not be worth polluting the rest of the code with the idea that quoting
> > spaces is a good thing to do.
> 
> Sounds sane.  We can probably use a helper like this:
> 
> static char *quote_path_with_sp(const char *in, const char *prefix, struct strbuf *out)
> {
> 	const char dq = '"';
> 
> 	quote_path(in, prefix, out);
> 	if (out->buf[0] != dq && strchr(out->buf, ' ') != NULL) {
> 		strbuf_insert(out, 0, &dq, 1);
> 		strbuf_addch(out, dq);
> 	}
> 	return out->buf;
> }
> 
> which allows the current users like shortstatus_status() to become a
> lot shorter.

Are there callers who don't just print the result? If not, we could just
always emit. That's slightly more efficient since it drops the expensive
strbuf_insert (though there are already so many copies going on in
quote_path_relative that it hardly matters). But it also drops the need
for the caller to know about the strbuf at all.

Like:
diff --git a/wt-status.c b/wt-status.c
index 937a87bbd5..4f4706a6e2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1703,6 +1703,18 @@ static void wt_shortstatus_unmerged(struct string_list_item *it,
 	}
 }
 
+static void emit_path(const char *in, const char *prefix)
+{
+	struct strbuf buf = STRBUF_INIT;
+	quote_path(in, prefix, &buf);
+	if (buf.buf[0] != '"' && strchr(buf.buf, ' ') != NULL) {
+		putchar('"');
+		strbuf_addch(&buf, '"');
+	}
+	fwrite(buf.buf, 1, buf.len, stdout);
+	strbuf_release(&buf);
+}
+
 static void wt_shortstatus_status(struct string_list_item *it,
 			 struct wt_status *s)
 {
@@ -1722,26 +1734,12 @@ static void wt_shortstatus_status(struct string_list_item *it,
 		if (d->head_path)
 			fprintf(stdout, "%s%c", d->head_path, 0);
 	} else {
-		struct strbuf onebuf = STRBUF_INIT;
-		const char *one;
 		if (d->head_path) {
-			one = quote_path(d->head_path, s->prefix, &onebuf);
-			if (*one != '"' && strchr(one, ' ') != NULL) {
-				putchar('"');
-				strbuf_addch(&onebuf, '"');
-				one = onebuf.buf;
-			}
-			printf("%s -> ", one);
-			strbuf_release(&onebuf);
+			emit_path(d->head_path, s->prefix);
+			printf(" -> ");
 		}
-		one = quote_path(it->string, s->prefix, &onebuf);
-		if (*one != '"' && strchr(one, ' ') != NULL) {
-			putchar('"');
-			strbuf_addch(&onebuf, '"');
-			one = onebuf.buf;
-		}
-		printf("%s\n", one);
-		strbuf_release(&onebuf);
+		emit_path(it->string, s->prefix);
+		putchar('\n');
 	}
 }
 

Though really I am fine with any solution that puts this pattern into a
helper function rather than repeating it inline.

-Peff
