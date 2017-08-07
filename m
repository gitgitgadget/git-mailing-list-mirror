Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C07B42047F
	for <e@80x24.org>; Mon,  7 Aug 2017 14:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbdHGOEF (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 10:04:05 -0400
Received: from 1.mo176.mail-out.ovh.net ([178.33.254.253]:46587 "EHLO
        1.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbdHGOEE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 10:04:04 -0400
X-Greylist: delayed 67529 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Aug 2017 10:04:04 EDT
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id 0282E6A774
        for <git@vger.kernel.org>; Mon,  7 Aug 2017 16:04:02 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 7 Aug
 2017 16:04:01 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [PATCH 3/4] imap_send: setup_curl: use server_conf parameter instead
 of the global variable
To:     <git@vger.kernel.org>
References: <c74c8c386f2c2d8b6cebd4addf925d0121986067.1502114584.git.nicolas@morey-chaisemartin.com>
Message-ID: <4a1f931c-9813-36a5-9c37-63b8abc4fecd@morey-chaisemartin.com>
Date:   Mon, 7 Aug 2017 16:04:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101
 Thunderbird/55.0
MIME-Version: 1.0
In-Reply-To: <c74c8c386f2c2d8b6cebd4addf925d0121986067.1502114584.git.nicolas@morey-chaisemartin.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.136.234]
X-ClientProxiedBy: EX3.indiv2.local (172.16.2.3) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 8309704264868882397
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelkedrkedugdejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 imap-send.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 682a06551..90b8683ed 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1415,37 +1415,37 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
 	if (!curl)
 		die("curl_easy_init failed");
 
-	server_fill_credential(&server);
-	curl_easy_setopt(curl, CURLOPT_USERNAME, server.user);
-	curl_easy_setopt(curl, CURLOPT_PASSWORD, server.pass);
+	server_fill_credential(srvc);
+	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
+	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
 
-	strbuf_addstr(&path, server.use_ssl ? "imaps://" : "imap://");
-	strbuf_addstr(&path, server.host);
+	strbuf_addstr(&path, srvc->use_ssl ? "imaps://" : "imap://");
+	strbuf_addstr(&path, srvc->host);
 	if (!path.len || path.buf[path.len - 1] != '/')
 		strbuf_addch(&path, '/');
-	strbuf_addstr(&path, server.folder);
+	strbuf_addstr(&path, srvc->folder);
 
 	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
 	strbuf_release(&path);
-	curl_easy_setopt(curl, CURLOPT_PORT, server.port);
+	curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
 
-	if (server.auth_method) {
+	if (srvc->auth_method) {
 #if LIBCURL_VERSION_NUM < 0x072200
 		warning("No LOGIN_OPTIONS support in this cURL version");
 #else
 		struct strbuf auth = STRBUF_INIT;
 		strbuf_addstr(&auth, "AUTH=");
-		strbuf_addstr(&auth, server.auth_method);
+		strbuf_addstr(&auth, srvc->auth_method);
 		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
 		strbuf_release(&auth);
 #endif
 	}
 
-	if (!server.use_ssl)
+	if (!srvc->use_ssl)
 		curl_easy_setopt(curl, CURLOPT_USE_SSL, (long)CURLUSESSL_TRY);
 
-	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, server.ssl_verify);
-	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, server.ssl_verify);
+	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, srvc->ssl_verify);
+	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, srvc->ssl_verify);
 
 	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
 
-- 
2.14.0.rc1.16.g87fcec1e8


