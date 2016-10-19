Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F327920986
	for <e@80x24.org>; Wed, 19 Oct 2016 20:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S943576AbcJSUf6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 16:35:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:59639 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941928AbcJSUft (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 16:35:49 -0400
Received: (qmail 16627 invoked by uid 109); 19 Oct 2016 20:35:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 20:35:49 +0000
Received: (qmail 17364 invoked by uid 111); 19 Oct 2016 20:36:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 16:36:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2016 16:35:46 -0400
Date:   Wed, 19 Oct 2016 16:35:46 -0400
From:   Jeff King <peff@peff.net>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: [PATCH 1/2] ref-filter: split ref_kind_from_filter
Message-ID: <20161019203546.dfqmi2czcxopgj6w@sigill.intra.peff.net>
References: <20161019203520.zevkb75at2nrogdm@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161019203520.zevkb75at2nrogdm@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function does two things: if we know we are filtering
only a certain kind of ref, then we can immediately know
that we have that kind. If not, then we compute the kind
from the fully-qualified refname. The latter half is useful
for other callers; let's split it out.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index cfbcd73..77ec9de 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1329,7 +1329,7 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 	return ref;
 }
 
-static int filter_ref_kind(struct ref_filter *filter, const char *refname)
+static int ref_kind_from_refname(const char *refname)
 {
 	unsigned int i;
 
@@ -1342,11 +1342,7 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 		{ "refs/tags/", FILTER_REFS_TAGS}
 	};
 
-	if (filter->kind == FILTER_REFS_BRANCHES ||
-	    filter->kind == FILTER_REFS_REMOTES ||
-	    filter->kind == FILTER_REFS_TAGS)
-		return filter->kind;
-	else if (!strcmp(refname, "HEAD"))
+	if (!strcmp(refname, "HEAD"))
 		return FILTER_REFS_DETACHED_HEAD;
 
 	for (i = 0; i < ARRAY_SIZE(ref_kind); i++) {
@@ -1357,6 +1353,15 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 	return FILTER_REFS_OTHERS;
 }
 
+static int filter_ref_kind(struct ref_filter *filter, const char *refname)
+{
+	if (filter->kind == FILTER_REFS_BRANCHES ||
+	    filter->kind == FILTER_REFS_REMOTES ||
+	    filter->kind == FILTER_REFS_TAGS)
+		return filter->kind;
+	return ref_kind_from_refname(refname);
+}
+
 /*
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
-- 
2.10.1.619.g16351a7

