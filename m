Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74ED3202BB
	for <e@80x24.org>; Sun, 24 Mar 2019 12:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfCXMJs (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 08:09:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:34220 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726090AbfCXMJs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 08:09:48 -0400
Received: (qmail 4565 invoked by uid 109); 24 Mar 2019 12:09:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 24 Mar 2019 12:09:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1557 invoked by uid 111); 24 Mar 2019 12:10:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 24 Mar 2019 08:10:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Mar 2019 08:09:46 -0400
Date:   Sun, 24 Mar 2019 08:09:46 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Wolfgang Denk <wd@denx.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: [PATCH 2/3] http: normalize curl results for dumb loose and
 alternates fetches
Message-ID: <20190324120946.GB312@sigill.intra.peff.net>
References: <20190324120757.GA18684@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190324120757.GA18684@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the dumb-http walker encounters a 404 when fetching a loose object,
it then looks at any http-alternates for the object. The 404 check is
implemented by missing_target(), which checks not only the http code,
but also that we got an http error from the CURLcode.

That broke when we stopped using CURLOPT_FAILONERROR in 17966c0a63
(http: avoid disconnecting on 404s for loose objects, 2016-07-11), since
our CURLcode will now be CURLE_OK. As a result, fetching over dumb-http
from a repository with alternates could result in Git printing "Unable
to find abcd1234..." and aborting.

We could probably fix this just by loosening missing_target(). However,
there's other code which looks at the curl result, and it would have to
be tweaked as well. Instead, let's just normalize the result the same
way the smart-http code does.

There's a similar case in processing the alternates (where we failover
from "info/http-alternates" to "info/alternates"). We'll give it the
same treatment.

After this patch, we should be hitting all code paths that need this
normalization (notably absent here is the http_pack_request path, but it
does not use FAILONERROR, nor missing_target()).

Signed-off-by: Jeff King <peff@peff.net>
---
 http-walker.c              |  8 ++++++++
 t/t5550-http-fetch-dumb.sh | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/http-walker.c b/http-walker.c
index 8ae5d76c6a..745436921d 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -98,6 +98,11 @@ static void process_object_response(void *callback_data)
 	process_http_object_request(obj_req->req);
 	obj_req->state = COMPLETE;
 
+	normalize_curl_result(&obj_req->req->curl_result,
+			      obj_req->req->http_code,
+			      obj_req->req->errorstr,
+			      sizeof(obj_req->req->errorstr));
+
 	/* Use alternates if necessary */
 	if (missing_target(obj_req->req)) {
 		fetch_alternates(walker, alt->base);
@@ -208,6 +213,9 @@ static void process_alternates_response(void *callback_data)
 	char *data;
 	int i = 0;
 
+	normalize_curl_result(&slot->curl_result, slot->http_code,
+			      curl_errorstr, sizeof(curl_errorstr));
+
 	if (alt_req->http_specific) {
 		if (slot->curl_result != CURLE_OK ||
 		    !alt_req->buffer->len) {
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 6d7d88ccc9..694b77c855 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -408,5 +408,21 @@ test_expect_success 'print HTTP error when any intermediate redirect throws erro
 	test_i18ngrep "unable to access.*/redir-to/502" stderr
 '
 
+test_expect_success 'fetching via http alternates works' '
+	parent=$HTTPD_DOCUMENT_ROOT_PATH/alt-parent.git &&
+	git init --bare "$parent" &&
+	git -C "$parent" --work-tree=. commit --allow-empty -m foo &&
+	git -C "$parent" update-server-info &&
+	commit=$(git -C "$parent" rev-parse HEAD) &&
+
+	child=$HTTPD_DOCUMENT_ROOT_PATH/alt-child.git &&
+	git init --bare "$child" &&
+	echo "../../alt-parent.git/objects" >"$child/objects/info/alternates" &&
+	git -C "$child" update-ref HEAD $commit &&
+	git -C "$child" update-server-info &&
+
+	git -c http.followredirects=true clone "$HTTPD_URL/dumb/alt-child.git"
+'
+
 stop_httpd
 test_done
-- 
2.21.0.705.g64cb90f133

