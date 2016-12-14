Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00EF91FF6D
	for <e@80x24.org>; Wed, 14 Dec 2016 22:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935051AbcLNWkZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 17:40:25 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33600 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935042AbcLNWkX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 17:40:23 -0500
Received: by mail-pg0-f51.google.com with SMTP id 3so12529821pgd.0
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 14:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fH1BMc1OZ9SBuYatkD5BN0ekSF7QqQzaiczHW+Gwjhs=;
        b=TUvvDUduGXUrgkhgB4rVShm3ZOyEIcuUWSo+VRgj9ILr7fuHY/KfRlj7UQoRXc8X1h
         HchS6S2Md6IDGcRPDp7QY7Ivu6JQJH6ROdDS9wJtVZcU634nGwFPVEDAlBJ/UOrtVuO4
         FdkYxkqafBEiiDPmiiZMiV5WDyekmoIfOvLehiPayLX1ou0aJFoV9G8FWYqwy7jfRiAe
         ZgHhcZRDweTHKokPLl0bcJWMpgfn2WIFnmf7kLjdKezDEGZ97kFzUnnV485bfveELTcI
         vgGUxsfiB91dA8XHhAoVH7vQH3DE4udZH/jIyQN+nHFPTx1oLuGC2fGeNSz4xne8ydG5
         j35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fH1BMc1OZ9SBuYatkD5BN0ekSF7QqQzaiczHW+Gwjhs=;
        b=fym4JlC4il6KySnXtHIOL3/pwyEzoisdELaUqwyW6Rp1erVVa0wPIebwPqiAZnguUs
         lWN13K91pTf9VEQvtRiZmVoCnvZwzqHdhmvSp7Bs9ESEYxg60TcfLrhdUsewuyRJ3LNk
         nGWX8udAJmKHGFNVij+4Xm4sn4P771cVWJ6+9SsdemfermY6BMczqEYABnAA+2gr92rc
         7KLjN9hmgD8RiFGs8wxcPzK3kQpUt+/TQehChv4tKDqCqQRMqRZ5qWaOac4fyIaJXhwP
         ofb2Gn37kGUJ30sLjStr0ilzpgbXjzkSg8Qz0mEXkBsXP1ASS6hY4WI0raa4gW57+Bsl
         +HlA==
X-Gm-Message-State: AKaTC020+V72M8UShOLiBXN0CARyfN7XDgakL9ze61zs0GH0NR2wL57/e/0Xr1schnjN3X0t
X-Received: by 10.84.218.70 with SMTP id f6mr66756963plm.142.1481755223040;
        Wed, 14 Dec 2016 14:40:23 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id 72sm89600973pfw.37.2016.12.14.14.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Dec 2016 14:40:22 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, gitster@pobox.com, sbeller@google.com,
        bburky@bburky.com, jrnieder@gmail.com
Subject: [PATCH v10 6/6] http: respect protocol.*.allow=user for http-alternates
Date:   Wed, 14 Dec 2016 14:39:55 -0800
Message-Id: <1481755195-174539-7-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481755195-174539-1-git-send-email-bmwill@google.com>
References: <1481679637-133137-1-git-send-email-bmwill@google.com>
 <1481755195-174539-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

The http-walker may fetch the http-alternates (or
alternates) file from a remote in order to find more
objects. This should count as a "not from the user" use of
the protocol. But because we implement the redirection
ourselves and feed the new URL to curl, it will use the
CURLOPT_PROTOCOLS rules, not the more restrictive
CURLOPT_REDIR_PROTOCOLS.

The ideal solution would be for each curl request we make to
know whether or not is directly from the user or part of an
alternates redirect, and then set CURLOPT_PROTOCOLS as
appropriate. However, that would require plumbing that
information through all of the various layers of the http
code.

Instead, let's check the protocol at the source: when we are
parsing the remote http-alternates file. The only downside
is that if there's any mismatch between what protocol we
think it is versus what curl thinks it is, it could violate
the policy.

To address this, we'll make the parsing err on the picky
side, and only allow protocols that it can parse
definitively. So for example, you can't elude the "http"
policy by asking for "HTTP://", even though curl might
handle it; we would reject it as unknown. The only unsafe
case would be if you have a URL that starts with "http://"
but curl interprets as another protocol. That seems like an
unlikely failure mode (and we are still protected by our
base CURLOPT_PROTOCOL setting, so the worst you could do is
trigger one of https, ftp, or ftps).

Signed-off-by: Jeff King <peff@peff.net>
---
 http-walker.c              | 52 ++++++++++++++++++++++++++++++++++++----------
 t/t5550-http-fetch-dumb.sh | 10 +++++++++
 2 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index c2f81cd..b34b6ac 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -3,6 +3,7 @@
 #include "walker.h"
 #include "http.h"
 #include "list.h"
+#include "transport.h"
 
 struct alt_base {
 	char *base;
@@ -160,6 +161,32 @@ static void prefetch(struct walker *walker, unsigned char *sha1)
 #endif
 }
 
+static int is_alternate_allowed(const char *url)
+{
+	const char *protocols[] = {
+		"http", "https", "ftp", "ftps"
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(protocols); i++) {
+		const char *end;
+		if (skip_prefix(url, protocols[i], &end) &&
+		    starts_with(end, "://"))
+			break;
+	}
+
+	if (i >= ARRAY_SIZE(protocols)) {
+		warning("ignoring alternate with unknown protocol: %s", url);
+		return 0;
+	}
+	if (!is_transport_allowed(protocols[i], 0)) {
+		warning("ignoring alternate with restricted protocol: %s", url);
+		return 0;
+	}
+
+	return 1;
+}
+
 static void process_alternates_response(void *callback_data)
 {
 	struct alternates_request *alt_req =
@@ -274,17 +301,20 @@ static void process_alternates_response(void *callback_data)
 				struct strbuf target = STRBUF_INIT;
 				strbuf_add(&target, base, serverlen);
 				strbuf_add(&target, data + i, posn - i - 7);
-				warning("adding alternate object store: %s",
-					target.buf);
-				newalt = xmalloc(sizeof(*newalt));
-				newalt->next = NULL;
-				newalt->base = strbuf_detach(&target, NULL);
-				newalt->got_indices = 0;
-				newalt->packs = NULL;
-
-				while (tail->next != NULL)
-					tail = tail->next;
-				tail->next = newalt;
+
+				if (is_alternate_allowed(target.buf)) {
+					warning("adding alternate object store: %s",
+						target.buf);
+					newalt = xmalloc(sizeof(*newalt));
+					newalt->next = NULL;
+					newalt->base = strbuf_detach(&target, NULL);
+					newalt->got_indices = 0;
+					newalt->packs = NULL;
+
+					while (tail->next != NULL)
+						tail = tail->next;
+					tail->next = newalt;
+				}
 			}
 		}
 		i = posn + 1;
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 22011f0..c0ee29c 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -360,5 +360,15 @@ test_expect_success 'http-alternates cannot point at funny protocols' '
 		clone "$HTTPD_URL/dumb/evil.git" evil-file
 '
 
+test_expect_success 'http-alternates triggers not-from-user protocol check' '
+	echo "$HTTPD_URL/dumb/victim.git/objects" \
+		>"$evil/objects/info/http-alternates" &&
+	test_config_global http.followRedirects true &&
+	test_must_fail git -c protocol.http.allow=user \
+		clone $HTTPD_URL/dumb/evil.git evil-user &&
+	git -c protocol.http.allow=always \
+		clone $HTTPD_URL/dumb/evil.git evil-user
+'
+
 stop_httpd
 test_done
-- 
2.8.0.rc3.226.g39d4020

