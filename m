Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E5CC388F9
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 05:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D8D21D41
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 05:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505919AbgJ0Fhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 01:37:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:38200 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505912AbgJ0Fhy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 01:37:54 -0400
Received: (qmail 13415 invoked by uid 109); 27 Oct 2020 05:37:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2020 05:37:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14737 invoked by uid 111); 27 Oct 2020 05:37:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2020 01:37:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Oct 2020 01:37:53 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4] refs: implement reference transaction hook
Message-ID: <20201027053753.GA3005508@coredump.intra.peff.net>
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
 <55c58e9b09691dc11dea911f26424594fb3922c9.1592549570.git.ps@pks.im>
 <20201023010315.GA1542721@coredump.intra.peff.net>
 <xmqqpn59k2xw.fsf@gitster.c.googlers.com>
 <20201026074303.GA972@ncase>
 <X5dhN+dsLXlKfukF@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X5dhN+dsLXlKfukF@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 26, 2020 at 07:52:23PM -0400, Taylor Blau wrote:

> On Mon, Oct 26, 2020 at 08:43:03AM +0100, Patrick Steinhardt wrote:
> > @Taylor, given that you've already dug into the code: do you already
> > have plans to post a patch for this?
> 
> You are likely in a better position to do that than I am. I am
> unfamiliar enough with the refs.c code to feel confident that my change
> is correct, let alone working. The combination of REF_HAVE_OLD, the lock
> OID, the update OID, and so on is very puzzling.
> 
> Ordinarily, I'd be happy to post a patch after familiarizing myself, but
> right now I don't have the time. So, I may come back to this in six
> months, but I certainly won't feel bad if you beat me to it ;-).
> 
> In the meantime, I'd be fine to apply Peff's patch with some fix-ups,
> maybe something like what's below the scissors line.

Thanks for moving this forward. I'm definitely OK with leaving the code
for now and just tightening the test. But there is one curiosity, still.
Your patch tweaks two tests:

> @@ -52,10 +52,10 @@ test_expect_success 'hook gets all queued updates in prepared state' '
> [...]
> @@ -75,10 +75,10 @@ test_expect_success 'hook gets all queued updates in committed state' '

but there's a third one, which checks the hook's view of the "aborted"
state. And there we _do_ pass in an expected state which is not
$PRE_OID. But it's $ZERO_OID, so we can't tell if if the hook is getting
what we passed in, or some sensible value.

If we instead do this:

diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 74f94e293c..a7ed983d3c 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -94,14 +94,15 @@ test_expect_success 'hook gets all queued updates in aborted state' '
 			done >actual
 		fi
 	EOF
+	nonsense_oid=$(echo $ZERO_OID | tr 0 a) &&
 	cat >expect <<-EOF &&
-		$ZERO_OID $POST_OID HEAD
-		$ZERO_OID $POST_OID refs/heads/master
+		$nonsense_oid $POST_OID HEAD
+		$nonsense_oid $POST_OID refs/heads/master
 	EOF
 	git update-ref --stdin <<-EOF &&
 		start
-		update HEAD POST $ZERO_OID
-		update refs/heads/master POST $ZERO_OID
+		update HEAD POST $nonsense_oid
+		update refs/heads/master POST $nonsense_oid
 		abort
 	EOF
 	test_cmp expect actual

Then test still passes, because it's passing along the value we
provided. And I think that's the only sensible thing we can do: show the
hook the proposed update. There's little point in telling it what the
actual ref values were, I would think.

So I think it's worth adding in to the test, but:

  - probably that meaning of old-value needs to be discussed in more
    detail in the hook documentation, because it feels like it differs a
    bit in the "aborted" case versus the "committed" case

  - we'd want to make sure this keeps passing if further changes to the
    code are made to support the case without an expected state
    specified (and not, say, accidentally passing $PRE_OID to the hook)

  - we'd likewise want eventually a test for the case without an
    expected state (which I guess would actually pass $ZERO_OID to the
    hook). Of course we're using a mismatch of the expected value as the
    reason to abort, so we'd have to find another reliable way to make
    the transaction abort. :) Perhaps a refname with illegal characters,
    or trying to create "foo/bar" when "foo" exists (or vice versa).

Most of that can be bumped to later, but I think it's worth squashing
something like the hunk above into the patch you posted.

-Peff
