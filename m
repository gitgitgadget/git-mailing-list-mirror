Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C1F820985
	for <e@80x24.org>; Wed, 21 Sep 2016 21:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756347AbcIUVqZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 17:46:25 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45876 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756249AbcIUVqY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 17:46:24 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5EE1B1F935;
        Wed, 21 Sep 2016 21:46:23 +0000 (UTC)
Date:   Wed, 21 Sep 2016 21:46:23 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Yaroslav Halchenko <yoh@onerussian.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: [PATCH 4/3] http: check curl_multi_remove_handle error code
Message-ID: <20160921214623.GA1919@whir>
References: <20160913002557.10671-1-e@80x24.org>
 <xmqqr38nv8ul.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr38nv8ul.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> > The key patch here is 3/3 which seems like an obvious fix to
> > adding the problem of adding a curl easy handle to a curl multi
> > handle repeatedly.
> 
> Yeah, sounds like the right thing to do and 2/3 makes it really easy
> to read the resulting code.
> 
> > I will investigate those failures in a week or two when I regain
> > regular computer access.
> 
> Thanks. Will tentatively queue on 'pu' and wait for updates.

I'm comfortable with the original 3 patch series in 'next'
and being merged to 'master' and 'maint', soon.

I don't think the following 4/3 is strictly necessary now, so
I'd be more comfortable with it being tested in 'pu' or 'next'
for a longer period.

(online today, but not much tomorrow or another few days after)

-----------8<-----------
Subject: [PATCH] http: check curl_multi_remove_handle error code

This should help detect bugs in future changes.  While we're at
it, fix a (probably innocuous) bug in our http_cleanup function
for users of older curl.

curl_multi_remove_handle was not idempotent until curl 7.33.0
with commit 84f3b3dd448399f9548468676e1bd1475dba8de5
("curl_multi_remove_handle: allow multiple removes"),
so we track the "curlm" membership of the curl easy handle
ourselves with a new "in_multi" flag.

Tested with curl 7.26.0 and 7.38.0 on Debian 7.x (wheezy) and
Debian 8.x (jessie) respectively.

Signed-off-by: Eric Wong <e@80x24.org>
---
 http.c | 12 ++++++++++--
 http.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 82ed542..9f97749 100644
--- a/http.c
+++ b/http.c
@@ -204,7 +204,12 @@ static void finish_active_slot(struct active_request_slot *slot)
 static void xmulti_remove_handle(struct active_request_slot *slot)
 {
 #ifdef USE_CURL_MULTI
-	curl_multi_remove_handle(curlm, slot->curl);
+	CURLMcode code = curl_multi_remove_handle(curlm, slot->curl);
+
+	if (code != CURLM_OK)
+		die("curl_multi_remove_handle failed (%p): %s",
+			slot->curl, curl_multi_strerror(code));
+	slot->in_multi = 0;
 #endif
 }
 
@@ -888,7 +893,8 @@ void http_cleanup(void)
 	while (slot != NULL) {
 		struct active_request_slot *next = slot->next;
 		if (slot->curl != NULL) {
-			xmulti_remove_handle(slot);
+			if (slot->in_multi)
+				xmulti_remove_handle(slot);
 			curl_easy_cleanup(slot->curl);
 		}
 		free(slot);
@@ -965,6 +971,7 @@ struct active_request_slot *get_active_slot(void)
 		newslot = xmalloc(sizeof(*newslot));
 		newslot->curl = NULL;
 		newslot->in_use = 0;
+		newslot->in_multi = 0;
 		newslot->next = NULL;
 
 		slot = active_queue_head;
@@ -1033,6 +1040,7 @@ int start_active_slot(struct active_request_slot *slot)
 		slot->in_use = 0;
 		return 0;
 	}
+	slot->in_multi = 1;
 
 	/*
 	 * We know there must be something to do, since we just added
diff --git a/http.h b/http.h
index 5ab9d9c..3339d70 100644
--- a/http.h
+++ b/http.h
@@ -60,6 +60,7 @@ struct slot_results {
 struct active_request_slot {
 	CURL *curl;
 	int in_use;
+	int in_multi;
 	CURLcode curl_result;
 	long http_code;
 	int *finished;
-- 
EW

