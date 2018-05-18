Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 850331F51C
	for <e@80x24.org>; Fri, 18 May 2018 22:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbeERWZ5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 18:25:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:46046 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751888AbeERWZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 18:25:56 -0400
Received: (qmail 31177 invoked by uid 109); 18 May 2018 22:25:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 May 2018 22:25:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14999 invoked by uid 111); 18 May 2018 22:26:03 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 18 May 2018 18:26:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2018 15:25:53 -0700
Date:   Fri, 18 May 2018 15:25:53 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] get_main_ref_store: BUG() when outside a repository
Message-ID: <20180518222552.GA9623@sigill.intra.peff.net>
References: <20180518222506.GA9527@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180518222506.GA9527@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we don't have a repository, then we can't initialize the
ref store.  Prior to 64a741619d (refs: store the main ref
store inside the repository struct, 2018-04-11), we'd try to
access get_git_dir(), and outside a repository that would
trigger a BUG(). After that commit, though, we directly use
the_repository->git_dir; if it's NULL we'll just segfault.

Let's catch this case and restore the BUG() behavior.
Obviously we don't ever want to hit this code, but a BUG()
is a lot more helpful than a segfault if we do.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/refs.c b/refs.c
index 64aadd14c9..2e4a42f459 100644
--- a/refs.c
+++ b/refs.c
@@ -1668,6 +1668,9 @@ struct ref_store *get_main_ref_store(struct repository *r)
 	if (r->refs)
 		return r->refs;
 
+	if (!r->gitdir)
+		BUG("attempting to get main_ref_store outside of repository");
+
 	r->refs = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
 	return r->refs;
 }
-- 
2.17.0.1052.g7d69f75dbf

