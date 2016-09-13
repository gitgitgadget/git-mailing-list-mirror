Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C127520996
	for <e@80x24.org>; Tue, 13 Sep 2016 00:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbcIMA0G (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 20:26:06 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55834 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750975AbcIMA0E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 20:26:04 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id EA38320994;
        Tue, 13 Sep 2016 00:25:57 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC 2/3] http: consolidate #ifdefs for curl_multi_remove_handle
Date:   Tue, 13 Sep 2016 00:25:56 +0000
Message-Id: <20160913002557.10671-3-e@80x24.org>
In-Reply-To: <20160913002557.10671-1-e@80x24.org>
References: <20160913002557.10671-1-e@80x24.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I find #ifdefs makes code difficult-to-follow.

An early version of this patch had error checking for
curl_multi_remove_handle calls, but caused some tests (e.g.
t5541) to fail under curl 7.26.0 on old Debian wheezy.

Signed-off-by: Eric Wong <e@80x24.org>
---
 http.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/http.c b/http.c
index cac5db9..a7eaf7b 100644
--- a/http.c
+++ b/http.c
@@ -201,6 +201,13 @@ static void finish_active_slot(struct active_request_slot *slot)
 		slot->callback_func(slot->callback_data);
 }
 
+static void xmulti_remove_handle(struct active_request_slot *slot)
+{
+#ifdef USE_CURL_MULTI
+	curl_multi_remove_handle(curlm, slot->curl);
+#endif
+}
+
 #ifdef USE_CURL_MULTI
 static void process_curl_messages(void)
 {
@@ -216,7 +223,7 @@ static void process_curl_messages(void)
 			       slot->curl != curl_message->easy_handle)
 				slot = slot->next;
 			if (slot != NULL) {
-				curl_multi_remove_handle(curlm, slot->curl);
+				xmulti_remove_handle(slot);
 				slot->curl_result = curl_result;
 				finish_active_slot(slot);
 			} else {
@@ -881,9 +888,7 @@ void http_cleanup(void)
 	while (slot != NULL) {
 		struct active_request_slot *next = slot->next;
 		if (slot->curl != NULL) {
-#ifdef USE_CURL_MULTI
-			curl_multi_remove_handle(curlm, slot->curl);
-#endif
+			xmulti_remove_handle(slot);
 			curl_easy_cleanup(slot->curl);
 		}
 		free(slot);
@@ -1164,9 +1169,7 @@ static void release_active_slot(struct active_request_slot *slot)
 {
 	closedown_active_slot(slot);
 	if (slot->curl && curl_session_count > min_curl_sessions) {
-#ifdef USE_CURL_MULTI
-		curl_multi_remove_handle(curlm, slot->curl);
-#endif
+		xmulti_remove_handle(slot);
 		curl_easy_cleanup(slot->curl);
 		slot->curl = NULL;
 		curl_session_count--;
-- 
EW

