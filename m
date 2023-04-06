Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBD3C76196
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 03:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbjDFDfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 23:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjDFDfL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 23:35:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C977AA5
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 20:35:09 -0700 (PDT)
Received: (qmail 11960 invoked by uid 109); 6 Apr 2023 03:35:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Apr 2023 03:35:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21760 invoked by uid 111); 6 Apr 2023 03:35:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Apr 2023 23:35:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 Apr 2023 23:35:07 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] global: resolve Perl executable via PATH
Message-ID: <20230406033507.GA2092122@coredump.intra.peff.net>
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
 <ZC2I7CfVzY6Tl7Pk@pobox.com>
 <ZC2LOAwycdaUawxM@ncase>
 <20230405165414.GA497301@coredump.intra.peff.net>
 <ZC2wppC62E7wOcqM@xps>
 <20230405181505.GA517608@coredump.intra.peff.net>
 <CAMP44s2_b0=Bm-NmDQ7ZVBen27ZtK9DpaF0gs965k1wXzzhARQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMP44s2_b0=Bm-NmDQ7ZVBen27ZtK9DpaF0gs965k1wXzzhARQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 05, 2023 at 09:18:20PM -0500, Felipe Contreras wrote:

> On Wed, Apr 5, 2023 at 2:09 PM Jeff King <peff@peff.net> wrote:
> > On Wed, Apr 05, 2023 at 07:32:22PM +0200, Patrick Steinhardt wrote:
> 
> > IMHO we should aim for fixing those inconsistencies, and then letting
> > people set PERL_PATH as appropriate (even to something that will find it
> > via $PATH if they want to).
> 
> We can aim to fix all those inconsistencies *eventually* while in the
> meantime make them runnable for most people *today*.
> 
> It's not a dichotomy.

It is if the proposed patches change the behavior in such a way as to
make things less consistent.

There are three plausible perls to run (whether intentionally or
accidentally):

  1. the one in PERL_PATH

  2. /usr/bin/perl

  3. the first one in $PATH

What the code tries to do now is to consistently use (1). If there are
cases that accidentally use (2), which is what I took Patrick's patch to
mean, then that is a problem for people who set PERL_PATH to something
else, but not for people who leave it as /usr/bin/perl. If we "fix"
those cases by switching them to (3), then now things are less
consistent for such people than when we started.

But I am not clear on what those cases are (if any), and we have not
seen Patrick's follow-up proposed patch.

I did find one case that is accidentally doing (3), and posted a patch
elsewhere in the thread to convert it to (1). If you prefer behavior
(3), you might consider that a regression, but it seems meaningless
given the 99% of other cases that are using (1). If you want (3) to be
the behavior everywhere, then we'd need to completely change our stance
on how we invoke perl, or we need to teach PERL_PATH to handle this case
so that people building Git can choose their own preference (sadly I
don't think "make PERL_PATH='/usr/bin/env perl'" quite works because we
have to shell-quote it in some contexts before evaluating).

-Peff
