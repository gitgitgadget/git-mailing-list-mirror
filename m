Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA3521F404
	for <e@80x24.org>; Tue, 20 Mar 2018 04:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbeCTEEO (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 00:04:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:35384 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751521AbeCTEEN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 00:04:13 -0400
Received: (qmail 28410 invoked by uid 109); 20 Mar 2018 04:04:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Mar 2018 04:04:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28802 invoked by uid 111); 20 Mar 2018 04:05:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Mar 2018 00:05:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Mar 2018 00:04:11 -0400
Date:   Tue, 20 Mar 2018 00:04:11 -0400
From:   Jeff King <peff@peff.net>
To:     Dakota Hawkins <dakota@dakotahawkins.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: .gitattributes override behavior (possible bug, or documentation
 bug)
Message-ID: <20180320040411.GB12938@sigill.intra.peff.net>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net>
 <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 11:10:26PM -0400, Dakota Hawkins wrote:

> > As you noted below, that second line does not match your path, because
> > attributes on a directory aren't applied recursively. And it has nothing
> > to do with overriding. If you remove the png line entirely, you can see
> > that we still do not match it. You need to use "*" to match the paths.
> 
> Ah, yes, I see that. Inconsistent with .gitignore (more below), right?

Yes, it is.

> > I could not find anything useful in gitattributes(5). There's some old
> > discussion here:
> >
> >   https://public-inbox.org/git/slrnkldd3g.1l4.jan@majutsushi.net/
> 
> If I follow that correctly: There's some initial speculation that it
> would be OK to apply the attributes recursively, which is then shot
> down because it wasn't designed to be recursive (though I don't see a
> different, technical reason for that), followed by finding a (this
> same?) solution/workaround for the original problem. Is that about
> right?

Right. The technical reason is mostly "that is not how it was designed,
and it would possibly break some corner cases if we switched it now".

> > I think just "/.readme-docs/**" should be sufficient for your case. You
> > could also probably write "*" inside ".readme-docs/.gitattributes",
> > which may be simpler (you don't need "**" there because patterns without
> > a slash are just matched directly against the basename).
> 
> Wouldn't that make the "*" inside ".readme-docs/.gitattributes",
> technically recursive when "*" matches a directory?

Sort of. The pattern is applied recursively to each basename, but the
pattern itself does not match recursively. That's probably splitting
hairs, though. :)

> It's always seemed to me that both were necessary to explicitly match
> things in a directory and its subdirectories (example, IIRC: "git
> ls-files -- .gitattributes" vs "git ls-files -- .gitattributes
> **/.gitattributes"). Maybe that example is peculiar in that its a
> dotfile and can't have a wildcard before the dot?

Those are pathspecs, which are not quite the same as gitattributes. They
don't do the magic basename matching.

For pathspecs a "*" matches across slashes, which is what allows "git
log -- '*.h'" to work (but not a suffix wildcard like 'foo*').

> I guess my takeaway is that it would be _good_ if the gitattributes
> documentation contained the caveat about not matching directories
> recursively, but _great_ if gitattributes and gitignore (and whatever
> else there is) were consistent.

I agree it would be nice if they were consistent (and pathspecs, too).
But unfortunately at this point there's a maze of backwards
compatibility to deal with.

-Peff
