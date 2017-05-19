Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37BAA2021E
	for <e@80x24.org>; Fri, 19 May 2017 12:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755671AbdESMsy (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 08:48:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:54790 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754449AbdESMss (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 08:48:48 -0400
Received: (qmail 2215 invoked by uid 109); 19 May 2017 12:48:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 12:48:48 +0000
Received: (qmail 27678 invoked by uid 111); 19 May 2017 12:49:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 08:49:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 May 2017 08:48:46 -0400
Date:   Fri, 19 May 2017 08:48:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 02/15] handle_revision_arg: simplify commit reference lookups
Message-ID: <20170519124846.svasfmiukrm3r7dj@sigill.intra.peff.net>
References: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "dotdot" range parser avoids calling
lookup_commit_reference() if we are directly fed two
commits. But its casts are unnecessarily complex; that
function will just return a commit we pass into it.

Just calling the function all the time is much simpler, and
doesn't do any significant extra work (the object is already
parsed, and deref_tag() on a non-tag is a noop; we do incur
one extra lookup_object() call, but that's fairly trivial).

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index 014bf52e3..b6031fb35 100644
--- a/revision.c
+++ b/revision.c
@@ -1500,12 +1500,8 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 				struct commit *a, *b;
 				struct commit_list *exclude;
 
-				a = (a_obj->type == OBJ_COMMIT
-				     ? (struct commit *)a_obj
-				     : lookup_commit_reference(a_obj->oid.hash));
-				b = (b_obj->type == OBJ_COMMIT
-				     ? (struct commit *)b_obj
-				     : lookup_commit_reference(b_obj->oid.hash));
+				a = lookup_commit_reference(a_obj->oid.hash);
+				b = lookup_commit_reference(b_obj->oid.hash);
 				if (!a || !b)
 					goto missing;
 				exclude = get_merge_bases(a, b);
-- 
2.13.0.219.g63f6bc368

