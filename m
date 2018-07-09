Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EC2D1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 19:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933118AbeGITtQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 15:49:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:52524 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933100AbeGITtO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 15:49:14 -0400
Received: (qmail 2165 invoked by uid 109); 9 Jul 2018 19:49:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Jul 2018 19:49:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15183 invoked by uid 111); 9 Jul 2018 19:49:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 09 Jul 2018 15:49:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jul 2018 15:49:12 -0400
Date:   Mon, 9 Jul 2018 15:49:12 -0400
From:   Jeff King <peff@peff.net>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] sequencer: don't say BUG on bogus input
Message-ID: <20180709194912.GB7980@sigill.intra.peff.net>
References: <20180709194636.GB9852@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180709194636.GB9852@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cherry-picking a single commit, we go through a special
code path that avoids creating a sequencer todo list at all.
This path expects our revision parsing to turn up exactly
one commit, and dies with a BUG if it doesn't.

But it's actually quite easy to fool. For example:

  $ git cherry-pick --author=no.such.person HEAD
  error: BUG: expected exactly one commit from walk
  fatal: cherry-pick failed

This isn't a bug; it's just bogus input.

Let's drop the "BUG" to make it clear that the input is the
problem. And let's also use the phrase "empty commit set
passed", which matches what we say when we do a real
revision walk and it turns up empty.

This BUG dates back to 7acaaac275 (revert: allow single-pick
in the middle of cherry-pick sequence, 2011-12-10), and
could be triggered in the same way even then. So clearly
this outcome is unexpected. Another approach would be to
make the conditional from 7acaaac275 smarter, and avoid even
entering this single-pick case.  But since the action is
identical either way (we have nothing to pick, so we exit)
there's not much point in trying to distinguish the two.

Signed-off-by: Jeff King <peff@peff.net>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index f692b2ef44..234666b980 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3637,7 +3637,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 			return error(_("revision walk setup failed"));
 		cmit = get_revision(opts->revs);
 		if (!cmit || get_revision(opts->revs))
-			return error("BUG: expected exactly one commit from walk");
+			return error(_("empty commit set passed"));
 		return single_pick(cmit, opts);
 	}
 
-- 
2.18.0.400.g702e398724
