Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 460FD1F404
	for <e@80x24.org>; Sat, 23 Dec 2017 15:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753025AbdLWPCu (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 10:02:50 -0500
Received: from dogben.com ([172.104.80.166]:49506 "EHLO dogben.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752216AbdLWPCt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 10:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dogben.com;
         s=main; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:
        Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3WTFp6MvoMjY9/WORhmQstu/VbWOk59Bpk2GrGqcqsw=; b=RBUWlhbnDcUnd6KjOMiiPEOIdy
        cb2xOiIE8E54Kiw3NxVmqWHbjviLl3ln2yglspwMSGIGxrQVq2T4Cy0xFNvnv+lqn/mRFFPLhXkxT
        6uNHNWfTDeRNKWZhErzZKeLrg5ybKcVBw+BOMNOrdIRgcH8Zt8e6QYRyS/DT+OGY4a2dgQ+tIwUpD
        AK/bcEewzScVpoF9mO3BcWmc4w49wxQ+GBD1Q2AsbuAw/9eA7xJ/En4UwabcdtkIvAOAzRAHWEnh/
        N7Rj5NPBA3LD6BxgxralWV6PQz8R18zm9ODKFqrSXwOgo2SDyUybR2Urzlqvx+aB8e3/Z3/pn8gA6
        t1Wy6LkQ==;
Received: from home.dogben.com ([2400:8902:e001:30:e221:c60b:10c8:13bd])
        by dogben.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_RC4)
        (envelope-from <wsy@dogben.com>)
        id 1eSlK1-0007md-TK; Sat, 23 Dec 2017 15:02:45 +0000
Received: from wsy by home.dogben.com with local (Exim 4.90_RC4)
        (envelope-from <wsy@home.dogben.com>)
        id 1eSlJz-0002Fk-Vp; Sat, 23 Dec 2017 23:02:43 +0800
From:   Wei Shuyu <wsy@dogben.com>
To:     git@vger.kernel.org
Cc:     Wei Shuyu <wsy@dogben.com>, jrnieder@gmail.com, gitster@pobox.com,
        peff@peff.net
Subject: [RFC PATCH v2] http: support CURLPROXY_HTTPS
Date:   Sat, 23 Dec 2017 23:02:15 +0800
Message-Id: <20171223150215.8615-1-wsy@dogben.com>
X-Mailer: git-send-email 2.15.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git has been taught to support an https:// used for http.proxy when
using recent versions of libcurl.

To use https proxy with self-signed certs, we need a way to
unset CURLOPT_PROXY_SSL_VERIFYPEER and CURLOPT_PROXY_SSL_VERIFYHOST
just like direct SSL connection. This is required if we want
use t/lib-httpd to test proxy.

In this patch I reuse http.sslverify to do this, do we need an
independent option like http.sslproxyverify?

To fully support https proxy, we also need ways to set more options
such as CURLOPT_PROXY_SSLCERT. However, I'm not sure if we need to
support them.

Signed-off-by: Wei Shuyu <wsy@dogben.com>
---
 http.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/http.c b/http.c
index 215bebef1..d8a5e48f0 100644
--- a/http.c
+++ b/http.c
@@ -708,6 +708,10 @@ static CURL *get_curl_handle(void)
 	if (!curl_ssl_verify) {
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 0);
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 0);
+#if LIBCURL_VERSION_NUM >= 0x073400
+		curl_easy_setopt(result, CURLOPT_PROXY_SSL_VERIFYPEER, 0);
+		curl_easy_setopt(result, CURLOPT_PROXY_SSL_VERIFYHOST, 0);
+#endif
 	} else {
 		/* Verify authenticity of the peer's certificate */
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 1);
@@ -865,6 +869,11 @@ static CURL *get_curl_handle(void)
 		else if (starts_with(curl_http_proxy, "socks"))
 			curl_easy_setopt(result,
 				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
+#endif
+#if LIBCURL_VERSION_NUM >= 0x073400
+		else if (starts_with(curl_http_proxy, "https"))
+			curl_easy_setopt(result,
+				CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
 #endif
 		if (strstr(curl_http_proxy, "://"))
 			credential_from_url(&proxy_auth, curl_http_proxy);
-- 
2.15.1

