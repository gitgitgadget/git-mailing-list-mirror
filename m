Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F7EC76196
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 03:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjC2DEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 23:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjC2DEf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 23:04:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA672D75
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 20:04:33 -0700 (PDT)
Received: (qmail 5773 invoked by uid 109); 29 Mar 2023 03:04:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Mar 2023 03:04:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4497 invoked by uid 111); 29 Mar 2023 03:04:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 23:04:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 23:04:32 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 3/4] tests: drop here-doc check from internal chain-linter
Message-ID: <20230329030432.GA1801645@coredump.intra.peff.net>
References: <20230328202043.GA1241391@coredump.intra.peff.net>
 <20230328202819.GC1241631@coredump.intra.peff.net>
 <xmqqzg7wczx7.fsf@gitster.g>
 <20230329023702.GA1793752@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230329023702.GA1793752@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 10:37:02PM -0400, Jeff King wrote:

> I just think chainlint.pl is doing a good enough job of catching it that
> we can rely on it. I'll be curious if Eric has input there on whether it
> can do even better, which would remove all of the caveats from the
> commit message.

So I _think_ it's something like this:

diff --git a/t/chainlint.pl b/t/chainlint.pl
index e966412999a..6b8c1de5208 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -171,6 +171,9 @@ sub swallow_heredocs {
 		my $start = pos($$b);
 		my $indent = $tag =~ s/^\t// ? '\\s*' : '';
 		$$b =~ /(?:\G|\n)$indent\Q$tag\E(?:\n|\z)/gc;
+		if (pos($$b) == $start) {
+			die "oops, we did not find the end of the heredoc";
+		}
 		my $body = substr($$b, $start, pos($$b) - $start);
 		$self->{lineno} += () = $body =~ /\n/sg;
 	}

But I wasn't sure how to surface a clean error from here, since we're in
the Lexer. Maybe we just accumulate a "problems" array here, and then
roll those up via the TestParser? I'm not very familiar with the
arrangement of that part of the script.

And I say "think" because the thing I was worried about is that we'd do
this lexing at too high a level, and accidentally walk past the end of
the test. Which would mean getting fooled by;

  test_expect_success 'this one is broken' '
	cat >foo <<\EOF
	oops, we are missing our here-doc end
  '

  test_expect_success 'this one is ok' '
	cat >foo <<\EOF
	this one is OK, but we would not want to confuse
	its closing tag for the missing one
	EOF
  '

But it looks like Lexer::swallow_heredocs gets to see the individual
test snippets.

-Peff
