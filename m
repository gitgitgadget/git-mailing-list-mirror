Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFE1C6FA99
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 13:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjCJNUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 08:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjCJNUl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 08:20:41 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA60ED6AD
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 05:20:38 -0800 (PST)
Received: (qmail 21242 invoked by uid 109); 10 Mar 2023 13:20:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Mar 2023 13:20:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12292 invoked by uid 111); 10 Mar 2023 13:20:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Mar 2023 08:20:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Mar 2023 08:20:36 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] receive-pack: fix stale packfile locks when dying
Message-ID: <ZAsupPsPPiRnEs4h@coredump.intra.peff.net>
References: <e16bd81bf9e251aa6959fbe10a3fbc215a4a1c12.1678367338.git.ps@pks.im>
 <e1ee1d8026a361bc58d16bc741e2b347ada7a53e.1678431076.git.ps@pks.im>
 <ZArvkVPhF4Th424Z@coredump.intra.peff.net>
 <ZAsZMAhgag1iBSK5@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAsZMAhgag1iBSK5@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2023 at 12:49:04PM +0100, Patrick Steinhardt wrote:

> > There's no test here, and I think we _could_ make a reliable one with
> > something like:
> > 
> >   1. Have a proc-receive hook that signals via fifo that it's running,
> >      then pauses indefinitely.
> > 
> >   2. Start a push in the background, then wait on the fifo signal.
> > 
> >   3. Kill receive-pack.
> > 
> > But it's awfully complicated for little gain. I'm fine with not worrying
> > about it (and I did something similar manually to make to sure it works
> > as we expect).
> 
> I actually tried doing exactly what you're proposing here yesterday. It
> caused hangs, lingering processes, you had to play games to not trigger
> the &&-chain linter due to the backgrounding via &, and ultimately it
> somehow just didn't work.
> 
> So at some point I came to the same conclusion as you did, that it's
> just too complicated for little gain.

So I don't think we should apply this, because it's horrific. But
because I like a challenge, here is a test that should be race-free,
doesn't hang, and doesn't leave lingering processes (the blocking hook
waits for its parent to die).

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 3f81f16e133..ca6950ef433 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -300,4 +300,37 @@ test_expect_success 'receive-pack de-dupes .have lines' '
 	test_cmp expect refs
 '
 
+test_expect_success PIPE 'receive-pack cleans up .keep after signal' '
+	git init --bare keep.git &&
+	write_script keep.git/hooks/proc-receive <<-\EOF &&
+	# tell the other side we are in the hook
+	echo running proc-receive >&9
+	# and then wait until our parent receive-pack exits
+	wait "$PPID"
+	EOF
+	git -C keep.git config receive.procReceiveRefs refs/ &&
+
+	mkfifo rpstatus &&
+	(
+		# this will fail because we kill receive-pack while it hangs,
+		# but we will not see its exit code until we "wait" below.
+		git push \
+			--receive-pack="echo \$\$ >&9; exec git-receive-pack" \
+			--all keep.git 9>rpstatus &
+	) &&
+
+	exec 9<rpstatus &&
+	read <&9 rp_pid &&
+	read <&9 ready_signal &&
+	kill -15 "$rp_pid" &&
+	# in theory we get the signal code from receive-pack here,
+	# but we are racing with send-pack to call wait(), so we
+	# might also get "not found" from wait
+	{ wait "$rp_pid"; OUT=$?; } &&
+	{ test_match_signal 15 $OUT || test "$OUT" = 127; } &&
+
+	find keep.git/objects/pack -name "*.keep" >actual &&
+	test_must_be_empty actual
+'
+
 test_done

It fails as expected without your patch (the .keep file is left in
"actual"), and passes with it.

-Peff
