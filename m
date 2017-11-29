Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D14E320C13
	for <e@80x24.org>; Wed, 29 Nov 2017 03:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbdK2D0g (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 22:26:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:43132 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751501AbdK2D0f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 22:26:35 -0500
Received: (qmail 29417 invoked by uid 109); 29 Nov 2017 03:26:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Nov 2017 03:26:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16373 invoked by uid 111); 29 Nov 2017 03:26:53 -0000
Received: from rrcs-98-101-163-98.midsouth.biz.rr.com (HELO sigill.intra.peff.net) (98.101.163.98)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 28 Nov 2017 22:26:53 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Nov 2017 22:26:33 -0500
Date:   Tue, 28 Nov 2017 22:26:33 -0500
From:   Jeff King <peff@peff.net>
To:     Max Kirillov <max@max630.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] t5560-http-backend-noserver.sh: add
 CONTENT_LENGTH cases
Message-ID: <20171129032632.GC32345@sigill.intra.peff.net>
References: <20171126193813.12531-1-max@max630.net>
 <20171126193813.12531-3-max@max630.net>
 <CAPig+cROFS+3Yon2CFr-aPUGzDY4WVbU8kHbBx68O3M8k5eeug@mail.gmail.com>
 <20171126224051.GF26158@jessie.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171126224051.GF26158@jessie.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 27, 2017 at 12:40:51AM +0200, Max Kirillov wrote:

> > Rather than introducing a new 'test' program, would it be possible to
> > get by with just using 'printf' from the shell?
> > 
> >     % printf "%zu\n" -20
> >     18446744073709551596
> 
> I thought about it, of course. But, I am not sure I can
> exclude cases when the shell's printf uses 64-bit size_t and
> git 32-bit one, or vise-versa. Same way, I cannot say it for
> sure for any other software which I might use here instead
> of the shell's printf. The only somewhat sure way would be
> to use the same compiler, with same settings, which is used
> for the production code.
> 
> I do not exclude possibility that my reasoning above is
> wrong, either in general of specifically for git case. If
> there are some examples where it is already used and the
> risk of type size mismatch is prevented I could do it
> similarly.

That's definitely something to worry about, and I have a vague
recollection that build differences between the shell environment and
git have bitten us in the past.

That said, we already have some precedent in "git version
--build-options" to report sizes there. Can we do something like the
patch below instead of adding a new test helper?

diff --git a/help.c b/help.c
index 88a3aeaeb9..9590eaba28 100644
--- a/help.c
+++ b/help.c
@@ -413,6 +413,7 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 
 	if (build_options) {
 		printf("sizeof-long: %d\n", (int)sizeof(long));
+		printf("sizeof-size_t: %d\n", (int)sizeof(size_t));
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
 	}
 	return 0;

That does still require you to compute size_t based on the byte-size in
the test script, that should be do-able.

-Peff
