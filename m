Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BFAC1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 14:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752354AbcHZODv (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 10:03:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:59203 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751884AbcHZODv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 10:03:51 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MWxtA-1bZy4N39pE-00W0DT; Fri, 26 Aug 2016 15:47:15
 +0200
Date:   Fri, 26 Aug 2016 15:47:14 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 02/14] sequencer: do not die() in do_pick_commit()
In-Reply-To: <cover.1472219214.git.johannes.schindelin@gmx.de>
Message-ID: <00c1114b4717a020ad107a0fcd864bc8eaccbbf9.1472219214.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <cover.1472219214.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WugZad0sXH8VOnAUyVukgTtHt7mbj2VTWLcJNwZyf8OqWxW5UvY
 JD5mLCNFC6HbmA4n2VhF7GgIJaqT/i4g7IVCVKkYzQCV/PBpNJRbiihEEDSz8lnuYBy5WSs
 i0KXYpIhot5yp7XvjXEQo2RQudlC8LmdhzYLrbSJCBQc485fZUI/AOhTq3YsmGd9DDG43X6
 FoDZhze6u7uf8Vl+wC9AA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MZp1la9mvP0=:P6FxKkUYWwP8FuG8W21agz
 sk/ZzyCBZdZqTjEmCSWyzdxnn5VaxnhOubn7PzEhFw85OCfDCiySdyBKipeU6mu069EQFGso4
 MoDnDQIUJCxv9JNnJg8aAxO7k5I4j7cj1PplXWIJ2A1lRiPqcDyRmZp/EhUTFNC5D83i2CNBF
 bFzmFnAuhlcnlIZcazyQa3vtfh3MpKbLnv9SATHS3FYwQB/+6FT3Da7b+8+uCObzdBulcmBNG
 hdLV1LIgidxSOczTHv10ZXsKK/iPuqnMFHOyJ8viyRlcBr287piu+mBIL+c1R1ewnezLggbfC
 OWmrTmk/NjFXKiF2RIPjjZP0ocq7l4yUbv9zoO1wPATinNQGGPdIpB7cE2UacCT8Ur82osTsD
 RZQojNzuzfukMrLZV7ooHaArBRDC4G5TI2l6sxMMujt8qIzgVQ5NYOjP1ENk+0lvwaZnIwOL1
 +H9OckbbwSZV4RjKuNsy76aRE0n3SPrfDpbh1dFq/UnEGdbX7iLkIRNvFI2uB/ehuVc+wvflP
 ujz7yOfLa1q9pfFt/oD09/tbZ+z6xeIy1CrAyKFHBfMI6/r9S0uSrZUGn0m4wDyNg6m4fhdJ/
 rMnVM6N1Nnn0D004ajhIUB8qlUBfCWBhV7BrDdpirlPq1xunUfm/3LIjStk/5ezRhWntZlBN0
 Pj8Vz4HJ11uwAC/1uQyf/RBZMvjaaLEdvKcVwTvEKKZzCJm94g0sWKpHXJl0kqH3zLSOWOSWY
 AQQaniFj591d6iyWq9JPZhi09rEGmHQG9uGrYurkwmopDDzovjSkKprFBIvbWSPIb0BInA6Y9
 X0uMLv3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain
notice the error and handle it (by dying, still).

The eventual caller of do_pick_commit() is sequencer_pick_revisions(),
which already relays a reported error from its helper functions
(including this one), and both of its two callers know how to react to
a negative return correctly.

So this makes do_pick_commit() callable from new callers that want it
not to die, without changing the external behaviour of anything
existing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 76b1c52..baf6b40 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -585,12 +585,14 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	 * However, if the merge did not even start, then we don't want to
 	 * write it at all.
 	 */
-	if (opts->action == REPLAY_PICK && !opts->no_commit && (res == 0 || res == 1))
-		update_ref(NULL, "CHERRY_PICK_HEAD", commit->object.oid.hash, NULL,
-			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
-	if (opts->action == REPLAY_REVERT && ((opts->no_commit && res == 0) || res == 1))
-		update_ref(NULL, "REVERT_HEAD", commit->object.oid.hash, NULL,
-			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
+	if (opts->action == REPLAY_PICK && !opts->no_commit && (res == 0 || res == 1) &&
+	    update_ref(NULL, "CHERRY_PICK_HEAD", commit->object.oid.hash, NULL,
+		       REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
+		res = -1;
+	if (opts->action == REPLAY_REVERT && ((opts->no_commit && res == 0) || res == 1) &&
+	    update_ref(NULL, "REVERT_HEAD", commit->object.oid.hash, NULL,
+		       REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
+		res = -1;
 
 	if (res) {
 		error(opts->action == REPLAY_REVERT
-- 
2.10.0.rc1.99.gcd66998


