Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A1E71F453
	for <e@80x24.org>; Wed, 31 Oct 2018 20:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeKAF0s (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 01:26:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:34938 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725780AbeKAF0s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 01:26:48 -0400
Received: (qmail 15997 invoked by uid 109); 31 Oct 2018 20:27:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Oct 2018 20:27:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14463 invoked by uid 111); 31 Oct 2018 20:26:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 31 Oct 2018 16:26:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2018 16:27:08 -0400
Date:   Wed, 31 Oct 2018 16:27:08 -0400
From:   Jeff King <peff@peff.net>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH] pretty: Add %(trailer:X) to display single trailer
Message-ID: <20181031202708.GA13021@sigill.intra.peff.net>
References: <20181028125025.30952-1-anders@0x63.nu>
 <20181029141402.GA17668@sigill.intra.peff.net>
 <CADsOX3Cbn7jjqFERptxMm59mn0qYnkf9bmFvJS20VBPedZHwqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADsOX3Cbn7jjqFERptxMm59mn0qYnkf9bmFvJS20VBPedZHwqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 06:05:34PM +0100, Anders Waldenborg wrote:

> I'll start by reworking my patch to handle %(trailers:key=X)  (I'll
> assume keys never contain ')' or ','), and ignore any formatting until
> the way forward there is decided (see below).

IMHO that is probably an acceptable tradeoff. We haven't really made any
rules for quoting arbitrary values in other %() sequences. I think it's
something we may want to have eventually, but as long as the rule for
now is "you can't do that", I think it would be OK to loosen it later.

> > But my second question is whether we want to provide something more
> > flexible than the always-parentheses that "%d" provides. That has been a
> > problem in the past when people want to format the decoration in some
> > other way.
> 
> Maybe just like +/-/space can be used directly after %, a () pair can
> be allowed..   E.g "%d" would just be an alias for "%()D",  and for
> trailers it would be something like "%()(trailers:key=foo)"

Yeah, I was thinking that "(" was taken as a special character, but I
guess immediately followed by ")" it is easy to parse left-to-right with
no ambiguity.

Would it include the leading space, too? It would be nice if it could be
combined with "% " in an orthogonal way. I guess in theory "% ()D" would
work, but it may need some tweaks to the parsing.

> There is another special cased placeholder %f (sanitized subject line,
> suitable for a filename). Which also could be changed to be a format
> specifiier, allowing sanitize any thing, e.g "%!an" for sanitized
> author name.

Yeah, I agree we should be able to sanitize anything. It's not strictly
related to your patch, though, so you may or may not want to go down
this rabbit hole. :)

> Is even the linebreak to commaseparation a generic thing?
> "% ,()(trailers:key=Ticket)"   it starts go look a bit silly.

In theory, yeah. I agree it's getting a bit magical.

> Then there are the padding modifiers. %<() %<|(). They operate on next
> placeholder. "%<(10)%s" Is that a better syntax?
> "%()%(trailers:key=Ticket,comma)"
> 
> I can also imagine moving all these modifiers into a generic modifier
> syntax in brackets (and keeping old for backwards compat)
> %[lpad=10,ltrunc=10]s ==  %<(10,trunc)%s
> %[nonempty-prefix="%n"]GS ==  %+GS
> %[nonempty-prefix=" (",nonempty-suffix=")"]D ==  %d
> Which would mean something like this for tickets thing:
> %[nonempty-prefix=" (Tickets:",nonempty-suffix=")",commaseparatelines](trailers:key=Ticket,nokey)
> which is kinda verbose.

Yes. I had dreams of eventually stuffing all of those as options into
the placeholders themselves. So "%s" would eventually have a long-form
of "%(subject)", and in that syntax it could be:

  %(subject:lpad=10,filename)

or something. I'm not completely opposed to:

  %[lpad=10,filename]%(subject)

which keeps the "formatting" arguments out of the regular placeholders.
On the other hand, if the rule were not "this affects the next
placeholder" but had a true ending mark, then we could make a real
parse-tree out of it, and format chunks of placeholders. E.g.:

  %(format:lpad=30,filename)%(subject) %(authordate)%(end)

would pad and format the whole string with two placeholders. I know that
going down this road eventually involves reinventing XML, but I think
having an actual tree structure may not be an unreasonable thing to
shoot for.

I dunno. You certainly don't need to solve all of these issues for what
you want to do. My main concern for now is to avoid introducing new
syntax that we'll be stuck with forever, even though it may later become
redundant (or worse, create parsing ambiguities).

> > We have formatting magic for "if this thing is non-empty, then show this
> > prefix" in the for-each-ref formatter, but I'm not sure that we do in
> > the commit pretty-printer beyond "% ". I wonder if we could/should add a
> > a placeholder for "if this thing is non-empty, put in a space and
> > enclose it in parentheses".
> 
> Would there be any interest in consolidating those formatters? Even
> though they are totally separate beasts today. I think having all
> attributes available on long form (e.g "%(authorname)") in addition to
> existing short forms in pretty-formatter would make sense.

Yes, there's great interest. :)

The formats are not mutually incompatible at this point, so we should be
able to come up with a unified language that maintains backwards
compatibility. One of the tricky parts is that some of the formatters
have more information than others (for-each-ref has a ref, which may
resolve to any object type; cat-file has objects only; --pretty has only
commits).

This was the subject of last year's Outreachy work. There's still a ways
to go, but you can find some of the previous discussions and work by
searching for Olga's work in the archive:

  https://public-inbox.org/git/?q=olga+telezhnaya

I've also cc'd her here, as she's still been doing some work since then.

-Peff
