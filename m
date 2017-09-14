Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65C3B20A21
	for <e@80x24.org>; Thu, 14 Sep 2017 07:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbdINHwM (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 03:52:12 -0400
Received: from 8.mo176.mail-out.ovh.net ([46.105.58.67]:50153 "EHLO
        8.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbdINHwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 03:52:09 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id 5DFBC8CB55
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 09:52:08 +0200 (CEST)
Received: from [10.0.2.127] (86.200.198.152) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 14
 Sep 2017 09:52:07 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [PATCH v4 3/4] imap_send: setup_curl: retreive credentials if not set
 in config file
To:     <git@vger.kernel.org>
References: <828c6333-0ba0-2a01-324e-f910a8042ca1@morey-chaisemartin.com>
Openpgp: preference=signencrypt
Message-ID: <accffa40-3559-5f65-3149-aaa86a2278fc@morey-chaisemartin.com>
Date:   Thu, 14 Sep 2017 09:52:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <828c6333-0ba0-2a01-324e-f910a8042ca1@morey-chaisemartin.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.198.152]
X-ClientProxiedBy: CAS4.indiv2.local (172.16.1.4) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 3830311483866015709
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelledrgeehgdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Up to this point, the curl mode only supported getting the username
and password from the gitconfig file while the legacy mode could also
fetch them using the credential API.

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 imap-send.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 1b8fbbd545..7e39993d95 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1398,7 +1398,7 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 }
 
 #ifdef USE_CURL_FOR_IMAP_SEND
-static CURL *setup_curl(struct imap_server_conf *srvc)
+static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 {
 	CURL *curl;
 	struct strbuf path = STRBUF_INIT;
@@ -1411,6 +1411,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
 	if (!curl)
 		die("curl_easy_init failed");
 
+	server_fill_credential(&server, cred);
 	curl_easy_setopt(curl, CURLOPT_USERNAME, server.user);
 	curl_easy_setopt(curl, CURLOPT_PASSWORD, server.pass);
 
@@ -1460,8 +1461,9 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	struct buffer msgbuf = { STRBUF_INIT, 0 };
 	CURL *curl;
 	CURLcode res = CURLE_OK;
+	struct credential cred = CREDENTIAL_INIT;
 
-	curl = setup_curl(server);
+	curl = setup_curl(server, &cred);
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
 	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
@@ -1496,6 +1498,18 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	curl_easy_cleanup(curl);
 	curl_global_cleanup();
 
+	if (cred.username)
+		if (res == CURLE_OK)
+			credential_approve(&cred);
+#if LIBCURL_VERSION_NUM >= 0x070d01
+		else if (res == CURLE_LOGIN_DENIED)
+#else
+		else
+#endif
+			credential_reject(&cred);
+
+	credential_clear(&cred);
+
 	return res != CURLE_OK;
 }
 #endif
-- 
2.14.1.461.g503560879


