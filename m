Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1F6E20323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753407AbdCVWlb (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:41:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:49851 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752760AbdCVWl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:41:29 -0400
Received: (qmail 32005 invoked by uid 109); 22 Mar 2017 22:41:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 22:41:29 +0000
Received: (qmail 967 invoked by uid 111); 22 Mar 2017 22:41:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 18:41:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Mar 2017 18:41:24 -0400
Date:   Wed, 22 Mar 2017 18:41:24 -0400
From:   Jeff King <peff@peff.net>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH 3/3] t7004, t7030: fix here-doc syntax errors
Message-ID: <20170322224124.u3eax4ui3y4saxks@sigill.intra.peff.net>
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
 <20170322200805.23837-1-gitster@pobox.com>
 <20170322200805.23837-4-gitster@pobox.com>
 <20170322211003.b52cql3iwig2xqcd@sigill.intra.peff.net>
 <xmqq8tnxhssv.fsf@gitster.mtv.corp.google.com>
 <20170322221556.j7uj4vvgbcubcr3b@LykOS.localdomain>
 <20170322222230.yqqv6x4gokvb4jbz@sigill.intra.peff.net>
 <20170322223441.w32y464jqbnxnzna@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170322223441.w32y464jqbnxnzna@LykOS.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 06:34:43PM -0400, Santiago Torres wrote:

> > I worked up the patch to do that (see below), but I got stumped trying
> > to write the commit message. Perhaps that is what the test intended, but
> > I don't think tag's --format understands "%G" codes at all. So you
> > cannot tell from the output if a tag was valid or not; you have to check
> > the exit code separately.
> > 
> > And if you do something like:
> > 
> >   git tag -v --format='%(tag)' foo bar |
> >   while read tag
> >   do
> >      ...
> >   done
> > 
> > you cannot tell at all which ones are bogus. Whereas with the current
> > behavior, the bogus ones are quietly omitted. Which can also be
> > confusing, but I'd think would generally err on the side of caution.
> 
> In that case, something like this would be closer to the desired
> behavior?

Yes, though you can spell:

  cat >expect <<-\EOF
  EOF

as just:

  >expect

> I'm also unsure on what would be the right thing to put on the commit
> message.

I think the argument is:

  1. It's safer not to expound on tags that have failed verification (so
     that the caller cannot accidentally use them). Especially since the
     --format cannot tell anything about the GPG status.

     That means that

       tag=$(git verify-tag --format='%(tag)' foo)

     can use a non-blank $tag without having to wonder whether it is
     valid or not.

and

  2. That's what we've done since the feature was released.

The only thing that would give me pause is if were to later add
%G-like formatters, and then:

  xargs git verify-tag --format='%(gpg:status) %(tag)' |
  while read status tag
  do
     ...
  done

would become useful, but we'd be tied to the behavior that we omit the
tag when the gpg verification failed (for backwards compatibility).
OTOH, we could perhaps make the rule "ignored unless %(gpg) formatters
are used". Which would be backwards-compatible and safe for old formats,
and work correctly for new ones.

-Peff
