Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B96620A21
	for <e@80x24.org>; Thu, 14 Sep 2017 07:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbdINHwH (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 03:52:07 -0400
Received: from 10.mo64.mail-out.ovh.net ([87.98.138.33]:44800 "EHLO
        10.mo64.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdINHwG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 03:52:06 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo64.mail-out.ovh.net (Postfix) with ESMTPS id A5DBA94741
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 09:52:04 +0200 (CEST)
Received: from [10.0.2.127] (86.200.198.152) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 14
 Sep 2017 09:52:03 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [PATCH v4 2/4] imap-send: add wrapper to get server credentials if
 needed
To:     <git@vger.kernel.org>
References: <828c6333-0ba0-2a01-324e-f910a8042ca1@morey-chaisemartin.com>
Openpgp: preference=signencrypt
Message-ID: <3453a8a7-a390-6c93-1460-44d2ac88034e@morey-chaisemartin.com>
Date:   Thu, 14 Sep 2017 09:52:02 +0200
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
X-Ovh-Tracer-Id: 3829185587084519389
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelledrgeehgdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 imap-send.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index b5e332420a..1b8fbbd545 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -926,6 +926,25 @@ static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, const cha
 	return 0;
 }
 
+static void server_fill_credential(struct imap_server_conf *srvc, struct credential *cred)
+{
+	if (srvc->user && srvc->pass)
+		return;
+
+	cred->protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
+	cred->host = xstrdup(srvc->host);
+
+	cred->username = xstrdup_or_null(srvc->user);
+	cred->password = xstrdup_or_null(srvc->pass);
+
+	credential_fill(cred);
+
+	if (!srvc->user)
+		srvc->user = xstrdup(cred->username);
+	if (!srvc->pass)
+		srvc->pass = xstrdup(cred->password);
+}
+
 static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *folder)
 {
 	struct credential cred = CREDENTIAL_INIT;
@@ -1078,20 +1097,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *f
 		}
 #endif
 		imap_info("Logging in...\n");
-		if (!srvc->user || !srvc->pass) {
-			cred.protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
-			cred.host = xstrdup(srvc->host);
-
-			cred.username = xstrdup_or_null(srvc->user);
-			cred.password = xstrdup_or_null(srvc->pass);
-
-			credential_fill(&cred);
-
-			if (!srvc->user)
-				srvc->user = xstrdup(cred.username);
-			if (!srvc->pass)
-				srvc->pass = xstrdup(cred.password);
-		}
+		server_fill_credential(srvc, &cred);
 
 		if (srvc->auth_method) {
 			struct imap_cmd_cb cb;
-- 
2.14.1.461.g503560879


