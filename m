Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AEEE1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 19:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932856AbeGITsW (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 15:48:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:52512 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932764AbeGITsV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 15:48:21 -0400
Received: (qmail 2115 invoked by uid 109); 9 Jul 2018 19:48:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Jul 2018 19:48:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15154 invoked by uid 111); 9 Jul 2018 19:48:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 09 Jul 2018 15:48:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jul 2018 15:48:19 -0400
Date:   Mon, 9 Jul 2018 15:48:19 -0400
From:   Jeff King <peff@peff.net>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] sequencer: handle empty-set cases consistently
Message-ID: <20180709194819.GA7980@sigill.intra.peff.net>
References: <20180709194636.GB9852@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180709194636.GB9852@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the user gives us a set that prepare_revision_walk()
takes to be empty, like:

  git cherry-pick base..base

then we report an error. It's nonsense, and there's nothing
to pick.

But if they use revision options that later cull the list,
like:

  git cherry-pick --author=nobody base~2..base

then we quietly create an empty todo list and return
success.

Arguably either behavior is acceptable, but we should
definitely be consistent about it. Reporting an error
seems to match the original intent, which dates all the way
back to 7e2bfd3f99 (revert: allow cherry-picking more than
one commit, 2010-06-02). That in turn was trying to match
the single-commit case that exited before then (and which
continues to issue an error).

Signed-off-by: Jeff King <peff@peff.net>
---
 sequencer.c                     | 6 ++++--
 t/t3510-cherry-pick-sequence.sh | 7 ++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5354d4d51e..f692b2ef44 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1863,8 +1863,6 @@ static int prepare_revs(struct replay_opts *opts)
 	if (prepare_revision_walk(opts->revs))
 		return error(_("revision walk setup failed"));
 
-	if (!opts->revs->commits)
-		return error(_("empty commit set passed"));
 	return 0;
 }
 
@@ -2317,6 +2315,10 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 			short_commit_name(commit), subject_len, subject);
 		unuse_commit_buffer(commit, commit_buffer);
 	}
+
+	if (!todo_list->nr)
+		return error(_("empty commit set passed"));
+
 	return 0;
 }
 
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index b42cd66d3a..3505b6aa14 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -480,11 +480,16 @@ test_expect_success 'malformed instruction sheet 2' '
 	test_expect_code 128 git cherry-pick --continue
 '
 
-test_expect_success 'empty commit set' '
+test_expect_success 'empty commit set (no commits to walk)' '
 	pristine_detach initial &&
 	test_expect_code 128 git cherry-pick base..base
 '
 
+test_expect_success 'empty commit set (culled during walk)' '
+	pristine_detach initial &&
+	test_expect_code 128 git cherry-pick -2 --author=no.such.author base
+'
+
 test_expect_success 'malformed instruction sheet 3' '
 	pristine_detach initial &&
 	test_expect_code 1 git cherry-pick base..anotherpick &&
-- 
2.18.0.400.g702e398724

