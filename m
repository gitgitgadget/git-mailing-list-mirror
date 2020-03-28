Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B72C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 11:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555AA20723
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 11:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgC1LUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:20:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:54358 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725973AbgC1LUM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 07:20:12 -0400
Received: (qmail 23429 invoked by uid 109); 28 Mar 2020 11:20:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 28 Mar 2020 11:20:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 730 invoked by uid 111); 28 Mar 2020 11:30:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 28 Mar 2020 07:30:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 28 Mar 2020 07:20:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] test-lib-functions: make packetize() more efficient
Message-ID: <20200328112010.GC639140@coredump.intra.peff.net>
References: <20200327080210.GA604725@coredump.intra.peff.net>
 <20200327080300.GA605934@coredump.intra.peff.net>
 <xmqq1rpdhaid.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rpdhaid.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 27, 2020 at 12:18:34PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The packetize() function takes its input on stdin, and requires 4
> > separate sub-processes to format a simple string. We can do much better
> > by getting the length via the shell's "${#packet}" construct. The one
> > caveat is that the shell can't put a NUL into a variable, so we'll have
> > to continue to provide the stdin form for a few calls.
> 
> Yuck.  Binary protocol and shell variables do not mix well.
> 
> Documentation/CodingGuidelines forbids ${#parameter} in the first
> place and we seem to use it only when we know we are using bash.
> 
> Perhaps we should start considering to lift it.  I dunno.

Hmph. I had a vague recollection there but checked beforehand:

 - we do use it in t9010, which is /bin/sh (and have since 2010). I
   thought it might not be run on obscure platforms because it's
   svn-related, but I think it doesn't actually require svn.

 - it's in POSIX, at least as far back as 2004 (I couldn't find an easy
   copy of the 2001 version). That doesn't prove there aren't
   problematic systems, of course, but it at least passes the bar of
   "not even in POSIX".

 - it's not in check-non-portable-shell.pl. :) That doesn't mean
   CodingGuidelines is wrong, but we should probably reconcile them.

Given that the first point means we've had a 10-year weather balloon,
and that the original rule seems to have come from a big list of
rules[1] rather than a specific known problem shell, I think we should
declare it available.

[1] https://lore.kernel.org/git/7vtznzf5jb.fsf@gitster.siamese.dyndns.org/

> >  packetize() {
> > +	if test $# -gt 0
> > +	then
> > +		packet="$*"
> > +		printf '%04x%s' "$((4 + ${#packet}))" "$packet"
> 
> This allows 
> 
> 		packetize "want $hash_head"
> 
> to be written like so:
> 
> 		packetize want "$hash_head"
> 
> which maybe is a handy thing to do.

Yeah. I admit I don't care overly much between that and doing something
else sensible with multiple arguments (like putting each one in its own
packet). I just really didn't want to silently ignore anything after
"$1". This at least behaves like "echo".

> > +	else
> > +		cat >packetize.tmp &&
> > +		len=$(wc -c <packetize.tmp) &&
> > +		printf '%04x' "$(($len + 4))" &&
> > +		cat packetize.tmp &&
> > +		rm -f packetize.tmp
> 
> 	perl -e '
> 		my $data = do { local $?; <STDIN> };
>                 printf "%04x%s", length($data), $data;
> 	'
> 
> That's one process but much heavier than cat/wc/printf/cat, I guess.

Yeah, I was tempted to do that, but ${#packet} is even one process
shorter. :) It might be worth simplifying the stdin path above, but it's
much less important if most of those call-sites go away.

-Peff
