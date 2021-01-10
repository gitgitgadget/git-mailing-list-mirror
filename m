Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBE3C433E0
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 03:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C2D520882
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 03:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbhAJDXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 22:23:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:51270 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbhAJDXv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 22:23:51 -0500
Received: (qmail 11451 invoked by uid 109); 10 Jan 2021 03:23:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 10 Jan 2021 03:23:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16731 invoked by uid 111); 10 Jan 2021 03:23:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 09 Jan 2021 22:23:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 9 Jan 2021 22:23:09 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Is t5516 somehow flakey only on macOS?
Message-ID: <X/pzHU917VpQOjfL@coredump.intra.peff.net>
References: <xmqq35zbgd2a.fsf@gitster.c.googlers.com>
 <CAPig+cQ3U4s0qmzoLL=ZBeSyCZm=QqjWz2P36ZUxMzNAyYn-WQ@mail.gmail.com>
 <X/mGnY3wR1fGoxcf@coredump.intra.peff.net>
 <X/mJ6gHrKVxQqPX4@coredump.intra.peff.net>
 <20210109173336.GS8396@szeder.dev>
 <xmqqo8hxenpr.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo8hxenpr.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 09, 2021 at 02:42:56PM -0800, Junio C Hamano wrote:

> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> >> Commit 014ade7484 (upload-pack: send ERR packet for non-tip objects,
> >> 2019-04-13) added a test that greps the output of a failed fetch to make
> >> sure that upload-pack sent us the ERR packet we expected. But checking
> >> this is racy; despite the argument in that commit, the client may still
> >> be sending a "done" line when the server exits, causing it to die() on a
> >
> > Nit: I think using the word "after" would make the problematic
> > sequence of events a tad clearer, i.e. "... after the server has
> > exited, ...".
> 
> Thanks everybody for helping with extra clarity.  I do find it
> easier to follow with "after the server has exited" to picture
> the sequence of events in my mind.

Agreed. Here's the same patch with the commit message updated to use
"after", plus Eric's typofix.

-- >8 --
Subject: [PATCH] t5516: loosen "not our ref" error check

Commit 014ade7484 (upload-pack: send ERR packet for non-tip objects,
2019-04-13) added a test that greps the output of a failed fetch to make
sure that upload-pack sent us the ERR packet we expected. But checking
this is racy; despite the argument in that commit, the client may still
be sending a "done" line after the server exits, causing it to die() on
a failed write() and never see the ERR packet at all.

This fails quite rarely on Linux, but more often on macOS. However, it
can be triggered reliably with:

	diff --git a/fetch-pack.c b/fetch-pack.c
	index 876f90c759..cf40de9092 100644
	--- a/fetch-pack.c
	+++ b/fetch-pack.c
	@@ -489,6 +489,7 @@ static int find_common(struct fetch_negotiator *negotiator,
	 done:
	 	trace2_region_leave("fetch-pack", "negotiation_v0_v1", the_repository);
	 	if (!got_ready || !no_done) {
	+		sleep(1);
	 		packet_buf_write(&req_buf, "done\n");
	 		send_request(args, fd[1], &req_buf);
	 	}

This is a real user-visible race that it would be nice to fix, but it's
tricky to do so: the client would have to speculatively try to read an
ERR packet after hitting a write() error. And at least for this error,
it's specific to v0 (since v2 does not enforce reachability at all).

So let's loosen the test to avoid annoying racy failures. If we
eventually do the read-after-failed-write thing, we can tighten it. And
if not, v0 will grow increasingly obsolete as servers support v2, so the
utility of this test will decrease over time anyway.

Note that we can still check stderr to make sure upload-pack bailed for
the reason we expected. It writes a similar message to stderr, and
because the server side is just another process connected by pipes,
we'll reliably see it. This would not be the case for git://, or for
ssh servers that do not relay stderr (e.g., GitHub's custom endpoint
does not).

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5516-fetch-push.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 01004ff680..3ed121d0ce 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1260,7 +1260,9 @@ do
 			git cat-file commit $SHA1_2 &&
 			test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 \
 				git fetch ../testrepo/.git $SHA1_3 2>err &&
-			test_i18ngrep "remote error:.*not our ref.*$SHA1_3\$" err
+			# ideally we would insist this be on a "remote error:"
+			# line, but it is racy; see the commit message
+			test_i18ngrep "not our ref.*$SHA1_3\$" err
 		)
 	'
 done
-- 
2.30.0.455.g8a2dc96235

