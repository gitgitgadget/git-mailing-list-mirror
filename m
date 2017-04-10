Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5007520966
	for <e@80x24.org>; Mon, 10 Apr 2017 15:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753710AbdDJPQK (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 11:16:10 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35038 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753665AbdDJPQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 11:16:09 -0400
Received: by mail-lf0-f68.google.com with SMTP id i3so5082117lfh.2
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 08:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=ElQWv0fwFUx7LzppsYJDa9b/QRP3TenLc6KxMwn3qlY=;
        b=dz8vmJ4/viGaVXCgFaNd5jQsQhZZ+A9L4skcbAnMoQKPMWyS7p4HGzxfq/9OugURGP
         TXDy0AnSos6zLAkaEhuqi4Ll488dI4wIKnm3Dx9TGRsriuZgY5DmvY7y/uhvgB5VFBvy
         KX/gd4LAMUhdqcNFSPYNkt+JqMGz4kqIRLlxR09TBXqUCxwxbTx4GZhi6BWHM2PLIxpt
         cTW9CgUpZ7FgvZezBInZyERhlwqHAno0E6TCgHJFFWhtOBIbjunKWabm8EFqqzmfY6Wm
         BvvcpYWM+PICpYRucuQI5OL1y2ahR8+B8wat8QPB9mi0h8DAcuhysN/medhyQ7yX/bvK
         hv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=ElQWv0fwFUx7LzppsYJDa9b/QRP3TenLc6KxMwn3qlY=;
        b=ucHBBSCV9O9EHe0VZX0bxgDYl5Se5BEXMQR45QGygf8+Xi2hYCIwaUr8Bhhe2XFrD+
         7jKhYGFrtSeO3WrFnrkie+e8arlE7SsSejOiLpI0EeOdsyYpDl4XZ5t5q71JvGTYZ6nP
         S+9M7KzTm5x66xTqqXG+d6BVReS1Xr2UqSxi+4HLsG/TBR3y5QCJzbZrPTMtYMaHiHZW
         Emy3onXcHrM5stX47EbQQBd0XF04g5jAkUZSUcJCACGyV1FvICi1pqGRxtcJ4lc/mAbP
         g7yjsFakupfjTowGj9x9Pv5/wqn7jG8TxLzZV28sr3hO4RlnEXqD+u7Y5wd2r4NdPf+7
         Sxtw==
X-Gm-Message-State: AFeK/H3llOb4H4fhgrAvV2XH+dXxspt6hcb8TdjBbzLjfgvKoGNXjLq92ZFpoFpAxmXaCA==
X-Received: by 10.46.0.96 with SMTP id 93mr16441480lja.134.1491837367467;
        Mon, 10 Apr 2017 08:16:07 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id p8sm2913302lfp.21.2017.04.10.08.16.06
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 08:16:06 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] http: honnor empty http.proxy option to bypass proxy
Date:   Mon, 10 Apr 2017 18:15:56 +0300
Message-Id: <20170410151556.10054-1-ryazanov.s.a@gmail.com>
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
configuration:

    credential_from_url(&proxy_auth, curl_http_proxy);
    curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);

But if proxy option is empty then proxy host field become NULL this
force curl to fallback to proxy configuration detection from
environment. This caused empty http.proxy option not working any more.

Avoid setting NULL CURLOPT_PROXY from proxy_auth.host to fix this issue.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 http.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 96d84bb..bf0e709 100644
--- a/http.c
+++ b/http.c
@@ -861,7 +861,12 @@ static CURL *get_curl_handle(void)
 			strbuf_release(&url);
 		}
 
-		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
+		/*
+		 * Avoid setting CURLOPT_PROXY to NULL if empty http.proxy
+		 * option configured.
+		 */
+		if (proxy_auth.host)
+			curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
 #if LIBCURL_VERSION_NUM >= 0x071304
 		var_override(&curl_no_proxy, getenv("NO_PROXY"));
 		var_override(&curl_no_proxy, getenv("no_proxy"));
-- 
2.10.2

