Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD0B51F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 21:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933099AbcI1VVa (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 17:21:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932968AbcI1VV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 17:21:28 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 657FD1265E
        for <git@vger.kernel.org>; Wed, 28 Sep 2016 21:21:22 +0000 (UTC)
Received: from pirat-work.brq.redhat.com (unused-4-182.brq.redhat.com [10.34.4.182])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u8SLLL3H003289;
        Wed, 28 Sep 2016 17:21:21 -0400
From:   Petr Stodulka <pstodulk@redhat.com>
To:     git@vger.kernel.org
Cc:     pstodulk@redhat.com
Subject: [PATCH] Replace deprecated CURLAUTH_GSSNEGOTIATE with CURLAUTH_NEGOTIATE.
Date:   Wed, 28 Sep 2016 23:20:23 +0200
Message-Id: <1475097623-13849-1-git-send-email-pstodulk@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 28 Sep 2016 21:21:22 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Macro CURLAUTH_GSSNEGOTIATE is deprecated since cURL v7.38.0 and
should be used CURLAUTH_NEGOTIATE instead. For compatibility
with older versions of cURL is CURLAUTH_NEGOTIATE set as alias
to CURLAUTH_GSSNEGOTIATE

Signed-off-by: Petr Stodulka <pstodulk@redhat.com>
---
 http.c        | 4 ++--
 http.h        | 7 +++++++
 remote-curl.c | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index 82ed542..7c2d9ef 100644
--- a/http.c
+++ b/http.c
@@ -79,7 +79,7 @@ static struct {
 } proxy_authmethods[] = {
 	{ "basic", CURLAUTH_BASIC },
 	{ "digest", CURLAUTH_DIGEST },
-	{ "negotiate", CURLAUTH_GSSNEGOTIATE },
+	{ "negotiate", CURLAUTH_NEGOTIATE },
 	{ "ntlm", CURLAUTH_NTLM },
 #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 	{ "anyauth", CURLAUTH_ANY },
@@ -1277,7 +1277,7 @@ static int handle_curl_result(struct slot_results *results)
 			return HTTP_NOAUTH;
 		} else {
 #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
-			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
+			http_auth_methods &= ~CURLAUTH_NEGOTIATE;
 #endif
 			return HTTP_REAUTH;
 		}
diff --git a/http.h b/http.h
index 5ab9d9c..bcc7d7d 100644
--- a/http.h
+++ b/http.h
@@ -42,6 +42,13 @@
 #endif
 
 /*
+ * Keep it compatible on system with cURL < 7.38.0
+ * */
+#ifndef CURLAUTH_NEGOTIATE
+#define CURLAUTH_NEGOTIATE CURLAUTH_GSSNEGOTIATE
+#endif
+
+/*
  * CURLOPT_USE_SSL was known as CURLOPT_FTP_SSL up to 7.16.4,
  * and the constants were known as CURLFTPSSL_*
 */
diff --git a/remote-curl.c b/remote-curl.c
index 6b83b77..d4fce63 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -542,7 +542,7 @@ static int post_rpc(struct rpc_state *rpc)
 		if (err != HTTP_OK)
 			return -1;
 
-		if (results.auth_avail & CURLAUTH_GSSNEGOTIATE)
+		if (results.auth_avail & CURLAUTH_NEGOTIATE)
 			needs_100_continue = 1;
 	}
 
-- 
2.5.5

