Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC3841FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 09:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754309AbdDKJV1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 05:21:27 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36180 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753367AbdDKJVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 05:21:25 -0400
Received: by mail-lf0-f65.google.com with SMTP id 75so5194010lfs.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 02:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qGhtEzhBOuEDtKMqxxlVeWlKnn6VsfJjokGjyZBXZMo=;
        b=YThp2p2/Eejira/gX37VDwuAsUuaEEfd6p6rhCTWyolMDbUNkxkkkVIowXSxbAOaXU
         goPgBMvKcfpvfItPGsDkNYxM/k+PQ9Ec/X+2/4YpAZuiB8KW+sY5OxESC2s3o7LlFUbZ
         xIYErT2JnCTNYU+W8ACDAboThl7n7w8mYjXW1bTTmSvs239E1cwtvKCy2+Y2qbEKx6jz
         TvE85DpVihZyoA93BoTSqMJaE7fKvMkyI6Zobjkv4V+MNHzKbzrfM+6xJMn1kKLxtb/x
         TYUa7l9/qfoLOXxbvPXtbzMzVDnICQih+79fL2WH5p2miQwLAREP1V7W9E9t7j6dEqAw
         n53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qGhtEzhBOuEDtKMqxxlVeWlKnn6VsfJjokGjyZBXZMo=;
        b=QG7KJ6vFaVB8gX2oNPryabWTnMWvRpTTLxyCvq0F9s9uzGqBb3FpNKqLqhR7pdo8+R
         3GJEzRCr0l7DgzD0KR4jB/aaCKSZfr+4UkkOPpNmKnzJfy+IwrhO0cg4nxQsM/jH2u+D
         OkBy+KO3lRVEFVt0ZOfodfsPUUbSw+tid8T6ulKjRf4qLcbbk4zAQC56DkiOtnTPDYh9
         3LY+4raMjg4Z8rZa/yQsG5kU7fqG0OUnIlJlwBQCAgvx3Nhc5jmnS/jMuP/CdN8ewFFl
         e7t4QFzOvzHNCiS4+LKRVAcbMkKLzSFzM2izcPq0csXs581PZ2WznoiRSJdNGe/knkvw
         aP8g==
X-Gm-Message-State: AFeK/H0auyT5KyQR2swWSJBinWu7a9HQZVww8LOqgjjOcrIS/zxusolFaQLmxvVRV92oGQ==
X-Received: by 10.46.1.98 with SMTP id 95mr16433104ljb.8.1491902483374;
        Tue, 11 Apr 2017 02:21:23 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id y17sm3333455lja.61.2017.04.11.02.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 02:21:22 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] http: honnor empty http.proxy option to bypass proxy
Date:   Tue, 11 Apr 2017 12:20:50 +0300
Message-Id: <20170411092050.15867-1-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Curl distinguish between empty proxy address and NULL proxy address. In
the first case it completly disable proxy usage, but if proxy address
option is NULL then curl attempt to determine proxy address from
http_proxy environment variable.

According to documentation, if http.proxy configured to empty string
then git should bypass proxy and connects to the server directly:

    export http_proxy=http://network-proxy/
    cd ~/foobar-project
    git config remote.origin.proxy ""
    git fetch

Previously, proxy host was configured by one line:

    curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);

Commit 372370f (http: use credential API to handle proxy auth...) parses
proxy option, extracts proxy host address and additionaly updates curl
configuration, which makes previous call a noop:

    credential_from_url(&proxy_auth, curl_http_proxy);
    curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);

But if proxy option is empty then proxy host field become NULL this
force curl to fallback to proxy configuration detection from
environment. This caused empty http.proxy option not working any more.

Fix this issue by explicitly handling empty http.proxy option. This also
makes code a bit more clear and should help us avoid such regressions in
the future.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---

Changes since v1:
 - explicitly handle this case instead of mangling the common code

 http.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 96d84bb..8be75b2 100644
--- a/http.c
+++ b/http.c
@@ -836,8 +836,14 @@ static CURL *get_curl_handle(void)
 		}
 	}
 
-	if (curl_http_proxy) {
-		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+	if (curl_http_proxy && curl_http_proxy[0] == '\0') {
+		/*
+		 * Handle case with the empty http.proxy value here to keep
+		 * common code clean.
+		 * NB: empty option disables proxying at all.
+		 */
+		curl_easy_setopt(result, CURLOPT_PROXY, "");
+	} else if (curl_http_proxy) {
 #if LIBCURL_VERSION_NUM >= 0x071800
 		if (starts_with(curl_http_proxy, "socks5h"))
 			curl_easy_setopt(result,
-- 
2.10.2

