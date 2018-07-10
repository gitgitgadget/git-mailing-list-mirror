Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845DD1F85B
	for <e@80x24.org>; Tue, 10 Jul 2018 04:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbeGJEcN (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 00:32:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:53150 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751099AbeGJEcK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 00:32:10 -0400
Received: (qmail 22191 invoked by uid 109); 10 Jul 2018 04:32:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 04:32:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19666 invoked by uid 111); 10 Jul 2018 04:32:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 10 Jul 2018 00:32:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2018 00:32:08 -0400
Date:   Tue, 10 Jul 2018 00:32:08 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 2/2] sequencer: don't say BUG on bogus input
Message-ID: <20180710043207.GB1909@sigill.intra.peff.net>
References: <20180710043120.GA1330@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180710043120.GA1330@sigill.intra.peff.net>
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

The condition to trigger this message actually has two
parts:

  1. We saw no commits. That's the case in the example
     above. Let's drop the "BUG" here to make it clear that
     the input is the problem. And let's also use the phrase
     "empty commit set passed", which matches what we say
     when we do a real revision walk and it turns up empty.

  2. We saw more than one commit. That one _should_ be
     impossible to trigger, since we fed at most one tip and
     provided the no_walk option (and we'll have already
     expanded options like "--branches" that can turn into
     multiple tips). If this ever triggers, it's an
     indication that the conditional added by 7acaaac275
     (revert: allow single-pick in the middle of cherry-pick
     sequence, 2011-12-10) needs to more carefully define
     the single-pick case.

     So this can remain a bug, but we'll upgrade it to use
     the BUG() macro, which would make it easier to detect
     and analyze if it does trigger.

Signed-off-by: Jeff King <peff@peff.net>
---
 sequencer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f692b2ef44..8f0a015160 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3636,8 +3636,10 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 		if (prepare_revision_walk(opts->revs))
 			return error(_("revision walk setup failed"));
 		cmit = get_revision(opts->revs);
-		if (!cmit || get_revision(opts->revs))
-			return error("BUG: expected exactly one commit from walk");
+		if (!cmit)
+			return error(_("empty commit set passed"));
+		if (get_revision(opts->revs))
+			BUG("unexpected extra commit from walk");
 		return single_pick(cmit, opts);
 	}
 
-- 
2.18.0.400.g702e398724
