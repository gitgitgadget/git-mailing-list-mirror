Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 955E71F991
	for <e@80x24.org>; Tue,  8 Aug 2017 07:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbdHHH4M (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 03:56:12 -0400
Received: from 6.mo64.mail-out.ovh.net ([46.105.48.16]:39491 "EHLO
        6.mo64.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751868AbdHHH4L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 03:56:11 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo64.mail-out.ovh.net (Postfix) with ESMTPS id 38ED3712EE
        for <git@vger.kernel.org>; Tue,  8 Aug 2017 09:48:20 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 8 Aug
 2017 09:48:20 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [PATCHv2 2/4] imap-send: add wrapper to get server credentials if
 needed
To:     <git@vger.kernel.org>
References: <3637fd31-3120-eca0-b7ee-8e6e324b6b58@morey-chaisemartin.com>
Message-ID: <19196543-f4ac-0584-6916-fd414c377eb1@morey-chaisemartin.com>
Date:   Tue, 8 Aug 2017 09:48:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101
 Thunderbird/55.0
MIME-Version: 1.0
In-Reply-To: <3637fd31-3120-eca0-b7ee-8e6e324b6b58@morey-chaisemartin.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.136.234]
X-ClientProxiedBy: EX4.indiv2.local (172.16.2.4) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 7837389254444115933
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelkedrkedvgddufedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 imap-send.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 09f29ea95..448a4a0b3 100644
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
2.14.0.rc1.16.gcc208c97c


