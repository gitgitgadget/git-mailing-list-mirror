Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 018A41F453
	for <e@80x24.org>; Thu, 27 Sep 2018 06:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeI0Mgt (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 08:36:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:33130 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726627AbeI0Mgt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 08:36:49 -0400
Received: (qmail 11723 invoked by uid 109); 27 Sep 2018 06:20:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Sep 2018 06:20:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28090 invoked by uid 111); 27 Sep 2018 06:19:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 27 Sep 2018 02:19:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2018 02:20:12 -0400
Date:   Thu, 27 Sep 2018 02:20:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: On shipping more of our technical docs as manpages
Message-ID: <20180927062011.GA1318@sigill.intra.peff.net>
References: <20180921223558.65055-2-sbeller@google.com>
 <87h8ihk7sl.fsf@evledraar.gmail.com>
 <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
 <20180926041517.GA2140@sigill.intra.peff.net>
 <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
 <87d0t0jghm.fsf@evledraar.gmail.com>
 <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
 <87a7o4je0t.fsf@evledraar.gmail.com>
 <20180926185812.GD30680@sigill.intra.peff.net>
 <878t3oj8em.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878t3oj8em.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 10:44:33PM +0200, Ævar Arnfjörð Bjarmason wrote:

> My bias here is that I've also contributed actively to the perl project
> in the past, and with that project you can get an overview of *all* of
> the docs by typing:
> 
>     man perl
> 
> That includes stuff like perl585delta(1) which we'd stick in
> Documentation/RelNotes, and "Internals and C Language Interface". Most
> of what we'd put in Documentation/technical/api-* & headers is in
> perlapi(1).

I like the perl documentation, too. But I think most of what you're
talking about there is the public API, where you have many readers. But
here we're talking about internal functions (albeit ones we hope to see
reused across the codebase). My concern is mostly: is the work in
maintaining this documentation-formatting system worth the number of
readers it will get?

There are two numbers there, and I'm guessing at both of them. ;)

If you're interested in pulling documentation out of the header files
and generating asciidoc from it, I'm happy to at least try keeping it up
to date. When we started putting this information into header files, we
used "/**" to start the comment, as a special marker to indicate it was
worth pulling out. I don't know how well we've maintained that
convention, but it's a starting point.

> I spent an embarrassingly long time submitting patches to git before
> discovering that Documentation/technical/api-*.txt even existed, I think
> something like 1-2 years ago.

That's another thing that I think is improved by keeping the
documentation and code together. If you find one, you find the other.
You just have to "somehow" find one, which is what you're getting at
below.

> We have very well documented stuff like strbuf.h (mostly thanks to you),
> but how is such documentation supposed to be discovered? Something like:
> 
>     git grep -A20 '^/\*$' -- *.h
>     <hold in page down>
> 
> ?
> 
> In terms of getting an overview it's indistinguishable from
> comments. I.e. there's nothing like an index of:
> 
>     man git-api-strbuf     ==> working with strings
>     man git-api-sha1-array ==> list, iterate and binary lookup SHA1s

I agree that is a problem, especially for contributors less familiar
with the code base. But I think generating an index is a separate (and
much easier) problem than formatting all of the documentation.

We already have the /** convention I mentioned above. Could we have
another micro-format like:

  /** API:strbuf - working with strings */

in each header file? That would make generating such an index pretty
trivial.

> I'm also not in the habit of opening the *.h file for something, I
> usually just start reading the *.c and only later discover there's some
> API docs in the relevant *.h (or not).

Interesting. I'm not totally opposed to putting the documentation
alongside the actual code. It does feel a bit cluttered to me, but I
think you're right that it keeps everything as close together as
possible.

> It means you can't avoid seeing it or updating it when source
> spelunking, and it leaves header files short, which is useful when you'd
> like to get a general API overview without all the docs. Our documented
> headers are quite fat, e.g. strbuf.h is 60% of the size of strbuf.c, but
> less than 20% when you strip the docs.

I don't use folds in my editor, and I guess nobody else in this thread
does, either. But they may be a reasonable tool for "wow, there are
comments, declarations, and definitions all together and I just want to
view one of them". In vim, try "set foldmethod=syntax" and then "zc" to
close the folds.

I kind of hate it myself, but just another option to explore.

> > I'm mildly negative on this, just because it introduces extra work on
> > people writing the documentation. Now it has to follow special
> > formatting rules, and sometimes the source is uglier (e.g., the horrible
> > +-continuation in lists). Are authors now responsible for formatting any
> > changes they make to make sure they look good in asciidoc? Or are people
> > who care about the formatted output going to come along afterwards and
> > submit fixup patches? Either way it seems like make-work.
> 
> This part I'm slightly confused by. If you're just saying "let's
> document stuff in *.h files in free-flowing text", fine. But if we're
> talking about the difference between Documentation/technical/api-*.txt
> and having the same stuff in manpages, then the stuff in api-*.txt *is*
> already asciidoc, and we have a target to format it all up and ship it
> with git, and distros ship that.

Yes, the "free-flowing text" thing is more or less what I'm saying. I
suspect what's in technical/* currently probably has formatting
problems, and people update it (if we're lucky!) without regard to what
the result looks like.

> E.g. on Debian you can "apt install git-doc" and browse stuff like
> file:///usr/share/doc/git-doc/technical/api-argv-array.html which is the
> HTML formatted version, same for all the other api-*.txt docs.

IMHO this is just silly. What am I as an end user going to do with
api-argv-array.html?

> This E-mail is much longer than I intended, sorry about that. I didn't
> just mean to bitch about how we ship docs, but I was wondering if there
> was a desire to move to something like what I've outlined above, or
> whether the status quo was mostly by design and intended.

I think we're actually half-way between status quos. The stuff in
technical/api-* has existed for a long time. We've been slowly moving
stuff over to header files, but there's still a bit of stuff there.

Building those files as asciidoc is one of those things that just
cropped up along the way. I have never thought it was useful myself, but
somebody bothered to write the patches, so OK. The person who did so is
not even somebody who has otherwise worked on the project, AFAICT.

-Peff
