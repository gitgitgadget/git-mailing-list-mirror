Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52AFD1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 15:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751158AbdHVP4b (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 11:56:31 -0400
Received: from 1.mo176.mail-out.ovh.net ([178.33.254.253]:52934 "EHLO
        1.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdHVP4a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 11:56:30 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id 565E880FAB;
        Tue, 22 Aug 2017 17:56:29 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 22
 Aug 2017 17:56:28 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [PATCH v3 3/4] imap_send: setup_curl: retreive credentials if not set
 in config file
To:     <git@vger.kernel.org>
CC:     <peff@peff.net>
References: <087f5907-6558-ce32-2f5c-2e418522c030@morey-chaisemartin.com>
Openpgp: preference=signencrypt
Message-ID: <60becdb6-6b08-e3db-a217-62933f924eae@morey-chaisemartin.com>
Date:   Tue, 22 Aug 2017 17:56:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <087f5907-6558-ce32-2f5c-2e418522c030@morey-chaisemartin.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.136.234]
X-ClientProxiedBy: CAS1.indiv2.local (172.16.1.1) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 6065504274079803383
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelledrtddtgdejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
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
index 448a4a0b3..a74d011a9 100644
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
 	return res == CURLE_OK;
 }
 #endif
-- 
2.14.0.1.gd9597ce13


