Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 399C520899
	for <e@80x24.org>; Wed,  2 Aug 2017 22:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbdHBWZa (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 18:25:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:56274 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751161AbdHBWZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 18:25:29 -0400
Received: (qmail 3496 invoked by uid 109); 2 Aug 2017 22:25:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 22:25:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14111 invoked by uid 111); 2 Aug 2017 22:25:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 18:25:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Aug 2017 18:25:27 -0400
Date:   Wed, 2 Aug 2017 18:25:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] revision: add rev_input_given flag
Message-ID: <20170802222527.mnn7e6hlyevsgk7a@sigill.intra.peff.net>
References: <20170802222425.7xkoxniz2xbjlnku@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170802222425.7xkoxniz2xbjlnku@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Normally a caller that invokes setup_revisions() has to
check rev.pending to see if anything was actually queued for
the traversal. But they can't tell the difference between
two cases:

  1. The user gave us no tip from which to start a
     traversal.

  2. The user tried to give us tips via --glob, --all, etc,
     but their patterns ended up being empty.

Let's set a flag in the rev_info struct that callers can use
to tell the difference.  We can set this from the
init_all_refs_cb() function.  That's a little funny because
it's not exactly about initializing the "cb" struct itself.
But that function is the common setup place for doing
pattern traversals that is used by --glob, --all, etc.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c | 1 +
 revision.h | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/revision.c b/revision.c
index 6603af944..08d5806b8 100644
--- a/revision.c
+++ b/revision.c
@@ -1168,6 +1168,7 @@ static void init_all_refs_cb(struct all_refs_cb *cb, struct rev_info *revs,
 {
 	cb->all_revs = revs;
 	cb->all_flags = flags;
+	revs->rev_input_given = 1;
 }
 
 void clear_ref_exclusion(struct string_list **ref_excludes_p)
diff --git a/revision.h b/revision.h
index f96e7f7f4..c8f4e91f2 100644
--- a/revision.h
+++ b/revision.h
@@ -71,6 +71,13 @@ struct rev_info {
 	const char *def;
 	struct pathspec prune_data;
 
+	/*
+	 * Whether the arguments parsed by setup_revisions() included any
+	 * "input" revisions that might still have yielded an empty pending
+	 * list (e.g., patterns like "--all" or "--glob").
+	 */
+	int rev_input_given;
+
 	/* topo-sort */
 	enum rev_sort_order sort_order;
 
-- 
2.14.0.rc1.586.g00244b0b6

