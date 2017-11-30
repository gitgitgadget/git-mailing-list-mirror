Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08B1120A40
	for <e@80x24.org>; Thu, 30 Nov 2017 03:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753031AbdK3Dza (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 22:55:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:44062 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751959AbdK3Dza (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 22:55:30 -0500
Received: (qmail 9771 invoked by uid 109); 30 Nov 2017 03:55:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Nov 2017 03:55:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24695 invoked by uid 111); 30 Nov 2017 03:55:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 29 Nov 2017 22:55:48 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Nov 2017 22:55:27 -0500
Date:   Wed, 29 Nov 2017 22:55:27 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Doron Behar <doron.behar@gmail.com>, git@vger.kernel.org,
        Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: Re: imap-send with gmail: curl_easy_perform() failed: URL using
 bad/illegal format or missing URL
Message-ID: <20171130035527.GB25577@sigill.intra.peff.net>
References: <20171129171301.l3coiflkfyy533yz@NUC.localdomain>
 <20171130020445.GF15098@aiede.mtv.corp.google.com>
 <20171130032832.GA25577@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171130032832.GA25577@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 29, 2017 at 10:28:32PM -0500, Jeff King wrote:

>  2. Setting GIT_TRACE_CURL=1 may dump more verbose information. But one
>     caveat: if you get as far as authenticating, then the trace will
>     contain your password. We redact HTTP auth from the trace output,
>     but not imap ones.

I tried my hand at a patch, but it ended up a lot more complicated than
I would have liked. Thoughts?

diff --git a/http.c b/http.c
index 713525f38e..fcc9001af6 100644
--- a/http.c
+++ b/http.c
@@ -560,7 +560,7 @@ static void set_curl_keepalive(CURL *c)
 }
 #endif
 
-static void redact_sensitive_header(struct strbuf *header)
+static void redact_http_header(struct strbuf *header)
 {
 	const char *sensitive_header;
 
@@ -577,7 +577,60 @@ static void redact_sensitive_header(struct strbuf *header)
 	}
 }
 
-static void curl_dump_header(const char *text, unsigned char *ptr, size_t size, int hide_sensitive_header)
+static void redact_imap_header(struct strbuf *header)
+{
+	const char *p;
+
+	/* skip past the command tag */
+	p = strchr(header->buf, ' ');
+	if (!p)
+		return; /* no tag */
+	p++;
+
+	if (skip_prefix(p, "AUTHENTICATE ", &p)) {
+		/* the first token is the auth type, which is OK to log */
+		while (*p && !isspace(*p))
+			p++;
+		/* the rest is an opaque blob; fall through to redact */
+	} else if (skip_prefix(p, "LOGIN ", &p)) {
+		/* fall through to redact both login and password */
+	} else {
+		/* not a sensitive header */
+		return;
+	}
+
+	strbuf_setlen(header, p - header->buf);
+	strbuf_addstr(header, " <redacted>");
+}
+
+static void redact_sensitive_header(CURL *handle, struct strbuf *header)
+{
+	const char *url;
+	int ret;
+
+	ret = curl_easy_getinfo(handle, CURLINFO_EFFECTIVE_URL, &url);
+	if (!ret && url) {
+		if (starts_with(url, "http")) {
+			redact_http_header(header);
+			return;
+		}
+		if (starts_with(url, "imap")) {
+			redact_imap_header(header);
+			return;
+		}
+	}
+
+	/*
+	 * We weren't able to figure out the protocol. Err on the side of
+	 * redacting too much.
+	 */
+	redact_http_header(header);
+	redact_imap_header(header);
+}
+
+static void curl_dump_header(CURL *handle, const char *text,
+			     unsigned char *ptr, size_t size,
+			     int hide_sensitive_header)
 {
 	struct strbuf out = STRBUF_INIT;
 	struct strbuf **headers, **header;
@@ -591,7 +644,7 @@ static void curl_dump_header(const char *text, unsigned char *ptr, size_t size,
 
 	for (header = headers; *header; header++) {
 		if (hide_sensitive_header)
-			redact_sensitive_header(*header);
+			redact_sensitive_header(handle, *header);
 		strbuf_insert((*header), 0, text, strlen(text));
 		strbuf_insert((*header), strlen(text), ": ", 2);
 		strbuf_rtrim((*header));
@@ -641,7 +694,7 @@ static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size,
 		break;
 	case CURLINFO_HEADER_OUT:
 		text = "=> Send header";
-		curl_dump_header(text, (unsigned char *)data, size, DO_FILTER);
+		curl_dump_header(handle, text, (unsigned char *)data, size, DO_FILTER);
 		break;
 	case CURLINFO_DATA_OUT:
 		text = "=> Send data";
@@ -653,7 +706,7 @@ static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size,
 		break;
 	case CURLINFO_HEADER_IN:
 		text = "<= Recv header";
-		curl_dump_header(text, (unsigned char *)data, size, NO_FILTER);
+		curl_dump_header(handle, text, (unsigned char *)data, size, NO_FILTER);
 		break;
 	case CURLINFO_DATA_IN:
 		text = "<= Recv data";
