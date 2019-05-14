Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 624641F461
	for <e@80x24.org>; Tue, 14 May 2019 12:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfENMFH (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 08:05:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:56824 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726075AbfENMFH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 08:05:07 -0400
Received: (qmail 4217 invoked by uid 109); 14 May 2019 12:05:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 May 2019 12:05:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12269 invoked by uid 111); 14 May 2019 12:05:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 May 2019 08:05:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 May 2019 08:05:05 -0400
Date:   Tue, 14 May 2019 08:05:05 -0400
From:   Jeff King <peff@peff.net>
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     git@vger.kernel.org
Subject: [PATCH 2/2] help_unknown_ref(): check for refname ambiguity
Message-ID: <20190514120505.GB27229@sigill.intra.peff.net>
References: <20190514120220.GA7714@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190514120220.GA7714@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the user asks to merge "foo" and we suggest "origin/foo" instead,
we do so by simply chopping off "refs/remotes/" from the front of the
suggested ref. This is usually fine, but it's possible that the
resulting name is ambiguous (e.g., you have "refs/heads/origin/foo",
too).

Let's use shorten_unambiguous_ref() to do this the right way, which
should usually yield the same "origin/foo", but "remotes/origin/foo" if
necessary.

Note that in this situation there may be other options (e.g., we could
suggest "heads/origin/foo" as well). I'll leave that up for debate; the
focus here is just to avoid giving advice that does not actually do what
we expect.

Signed-off-by: Jeff King <peff@peff.net>
---
 help.c           | 6 +++---
 t/t7600-merge.sh | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/help.c b/help.c
index d3b3f64e3c..5261d83ecf 100644
--- a/help.c
+++ b/help.c
@@ -754,12 +754,12 @@ static int append_similar_ref(const char *refname, const struct object_id *oid,
 {
 	struct similar_ref_cb *cb = (struct similar_ref_cb *)(cb_data);
 	char *branch = strrchr(refname, '/') + 1;
-	const char *remote;
 
 	/* A remote branch of the same name is deemed similar */
-	if (skip_prefix(refname, "refs/remotes/", &remote) &&
+	if (starts_with(refname, "refs/remotes/") &&
 	    !strcmp(branch, cb->base_ref))
-		string_list_append(cb->similar_refs, remote);
+		string_list_append_nodup(cb->similar_refs,
+					 shorten_unambiguous_ref(refname, 1));
 	return 0;
 }
 
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 7551ae3488..2286b0799d 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -881,4 +881,10 @@ test_expect_success 'merge suggests matching remote refname' '
 	grep origin/not-local stderr
 '
 
+test_expect_success 'suggested names are not ambiguous' '
+	git update-ref refs/heads/origin/not-local HEAD &&
+	test_must_fail git merge not-local 2>stderr &&
+	grep remotes/origin/not-local stderr
+'
+
 test_done
-- 
2.21.0.1388.g2b1efd806f
