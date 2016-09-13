Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33E77207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 00:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752793AbcIMA0M (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 20:26:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55852 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752152AbcIMA0L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 20:26:11 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 4FD0E20995;
        Tue, 13 Sep 2016 00:25:58 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC 3/3] http: always remove curl easy from curlm session on release
Date:   Tue, 13 Sep 2016 00:25:57 +0000
Message-Id: <20160913002557.10671-4-e@80x24.org>
In-Reply-To: <20160913002557.10671-1-e@80x24.org>
References: <20160913002557.10671-1-e@80x24.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We must call curl_multi_remove_handle when releasing the slot to
prevent subsequent calls to curl_multi_add_handle from failing
with CURLM_ADDED_ALREADY (in curl 7.32.1+; older versions
returned CURLM_BAD_EASY_HANDLE)

Signed-off-by: Eric Wong <e@80x24.org>
---
 http.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index a7eaf7b..3c4c3f5 100644
--- a/http.c
+++ b/http.c
@@ -1168,11 +1168,13 @@ void run_active_slot(struct active_request_slot *slot)
 static void release_active_slot(struct active_request_slot *slot)
 {
 	closedown_active_slot(slot);
-	if (slot->curl && curl_session_count > min_curl_sessions) {
+	if (slot->curl) {
 		xmulti_remove_handle(slot);
-		curl_easy_cleanup(slot->curl);
-		slot->curl = NULL;
-		curl_session_count--;
+		if (curl_session_count > min_curl_sessions) {
+			curl_easy_cleanup(slot->curl);
+			slot->curl = NULL;
+			curl_session_count--;
+		}
 	}
 #ifdef USE_CURL_MULTI
 	fill_active_slots();
-- 
EW

