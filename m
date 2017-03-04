Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3E7620279
	for <e@80x24.org>; Sat,  4 Mar 2017 01:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbdCDBfI (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 20:35:08 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:42998 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751083AbdCDBfI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 20:35:08 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id CC30B20133;
        Sat,  4 Mar 2017 01:35:04 +0000 (UTC)
Date:   Sat, 4 Mar 2017 01:35:04 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Jann Horn <jannh@google.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: [PATCH] http: inform about alternates-as-redirects behavior
Message-ID: <20170304013504.GA27183@untitled>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is disconcerting for users to not notice the behavior
change in handling alternates from commit cb4d2d35c4622ec2
("http: treat http-alternates like redirects")

Give the user a hint about the config option so they can
see the URL and decide whether or not they want to enable
http.followRedirects in their config.

Signed-off-by: Eric Wong <e@80x24.org>
---
 http-walker.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index b34b6ace7..626badfe6 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -168,6 +168,12 @@ static int is_alternate_allowed(const char *url)
 	};
 	int i;
 
+	if (http_follow_config != HTTP_FOLLOW_ALWAYS) {
+		warning("alternate disabled by http.followRedirects!=true: %s",
+			url);
+		return 0;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(protocols); i++) {
 		const char *end;
 		if (skip_prefix(url, protocols[i], &end) &&
@@ -331,9 +337,6 @@ static void fetch_alternates(struct walker *walker, const char *base)
 	struct alternates_request alt_req;
 	struct walker_data *cdata = walker->data;
 
-	if (http_follow_config != HTTP_FOLLOW_ALWAYS)
-		return;
-
 	/*
 	 * If another request has already started fetching alternates,
 	 * wait for them to arrive and return to processing this request's
-- 
EW
