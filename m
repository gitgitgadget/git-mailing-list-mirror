Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79167C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 22:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529B660F46
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 22:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhHPWac (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 18:30:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:49244 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232471AbhHPWab (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 18:30:31 -0400
Received: (qmail 26148 invoked by uid 109); 16 Aug 2021 22:29:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Aug 2021 22:29:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19741 invoked by uid 111); 16 Aug 2021 22:29:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Aug 2021 18:29:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Aug 2021 18:29:58 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.33.0-rc2 (Build/Test Report)
Message-ID: <YRrm5odz3WhcUQS9@coredump.intra.peff.net>
References: <009101d7904e$a3703e50$ea50baf0$@nexbridge.com>
 <YRaYnDR6RlgJRr/P@coredump.intra.peff.net>
 <01b501d792cc$f4071ed0$dc155c70$@nexbridge.com>
 <YRqwIAL/JgJp+RyI@coredump.intra.peff.net>
 <01c501d792df$5fcb24b0$1f616e10$@nexbridge.com>
 <YRrSXhbaZMLMq+1/@coredump.intra.peff.net>
 <01d001d792e9$55f45470$01dcfd50$@nexbridge.com>
 <YRrlQwLENaWs8zWm@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRrlQwLENaWs8zWm@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 06:22:59PM -0400, Jeff King wrote:

> Yeah, I think we are better to get a consistent exit code from perl.
> There are a few options here:

So concretely, the patch below works for me (my tests are not failing,
but with some instrumenting, I see that the case in question is exiting
with code 25 before this patch, and 255 after. So it really is just that
my errno values are lower than yours).

It's ugly, and I kind of wonder if we'd want to do it for every script
to get consistent exit codes. But it does work.

diff --git a/git-send-email.perl b/git-send-email.perl
index e65d969d0b..c82336c2e8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -35,8 +35,15 @@ sub readline {
 	my $self = shift;
 	die "Cannot use readline on FakeTerm: $$self";
 }
+
 package main;
 
+$SIG{__DIE__} = sub {
+	CORE::die @_ if $^S; # in an eval; use regular die
+	CORE::die @_ if !defined $^S; # in perl's parser
+	print STDERR "fatal: @_\n";
+	exit 255;
+};
 
 sub usage {
 	print <<EOT;

-Peff
