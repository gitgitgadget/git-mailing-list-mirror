Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FBCC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 13:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBINJC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 08:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBINJC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 08:09:02 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BF75EA28
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 05:09:00 -0800 (PST)
Received: (qmail 605 invoked by uid 109); 9 Feb 2023 13:09:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Feb 2023 13:09:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12836 invoked by uid 111); 9 Feb 2023 13:08:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Feb 2023 08:08:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Feb 2023 08:08:59 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew John Cheetham <mjcheetham@outlook.com>
Cc:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v7 12/12] credential: add WWW-Authenticate header to cred
 requests
Message-ID: <Y+Twa22Gw2nzV8sG@coredump.intra.peff.net>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <09164f77d56e8efd1450091cf1b12af2bc6cf2f5.1674252531.git.gitgitgadget@gmail.com>
 <Y9JjRfhl1H4Julv3@coredump.intra.peff.net>
 <DB9PR03MB9831A708EA98E198591F6632C0DA9@DB9PR03MB9831.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DB9PR03MB9831A708EA98E198591F6632C0DA9@DB9PR03MB9831.eurprd03.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 06, 2023 at 11:18:03AM -0800, Matthew John Cheetham wrote:

> > could be normalized as:
> > 
> >   www-auth-challenge=Basic realm="foo"
> >   www-auth-challenge=OtherAuth realm="bar"
> >   www-auth-challenge=YetAnotherScheme some-token
> > 
> > which saves each helper from having to do the same work. Likewise, we
> > can do a _little_ more parsing to get:
> > 
> >   www-auth-basic=realm="foo"
> >   www-auth-otherauth=realm="bar"
> >   www-auth-yetanotherscheme=some-token
> > 
> > I don't think we can go beyond there, though, without understanding the
> > syntax of individual schemes. Which is a shame, as one of the goals of
> > the credential format was to let the helpers do as little as possible
> > (so they can't get it wrong!). But helpers are stuck doing things like
> > handling backslashed double-quotes, soaking up extra whitespace, etc.
> 
> This key format wouldn't make it obviously easier for simple helpers to
> understand. Now they no longer have well-known keys but a key prefix.

Yes, though I don't think that's particularly complicated to parse.
Either way we're just flattening a tuple of (a, b, c) from "a=b c" to
"a-b=c". The value is in normalizing the syntax, so that helpers don't
have to deal with both "a=b c d e" and ("a=b c", "a=d e") themselves.

Another way to do that normalization would be to have Git convert:

  WWW-Authenticate: Basic realm="foo" OtherAuth realm="bar"

into:

 WWW-Authenticate: Basic realm="foo"
 WWW-Authenticate: OtherAuth realm="bar"

which then becomes (at the credential level):

  www-auth[]=Basic realm="foo"
  www-auth[]=OtherAuth realm="bar"

And likewise to normalize whitespace, etc, so each individual helper
doesn't have to (or risk getting confused/exploited). That said...

> My overall goal here is to have Git know less about auth, so it treats
> all values as totally opaque. The only logic added is around reconstructing
> folded headers, which is just HTTP and not auth specific.

Yeah, in general I agree with the notion that Git is mostly just passing
around opaque tokens. We do have to understand some syntax (like
folding!) at the HTTP level, so I think some syntactic normalization /
simplification is reasonable.

BUT. I think you are right that embedding it into the schema of the
helper protocol is probably bad. If the point is that the two forms of
my Basic / OtherAuth example are semantically equivalent, then we can
always decide later to convert between one and the other as a favor to
helpers. Whereas baking it into the schema is a promise for Git to
always parse and understand the headers.

So let me retract my suggestion, and we can leave "maybe normalize
headers to save helpers some work" as a possible topic for later (if
indeed it ever even becomes a problem in practice).

> >   realm=foo
> >   while read line; do
> >     case "$line" in
> >     www-auth-basic=)
> >         value=${line#*=}
> > 	# oops, we're just assuming it's realm= here, and we're
> > 	# not handling quotes at all. I think it could technically be
> > 	# realm=foo or realm="foo"
> > 	realm=${value#realm=}
> > 	;;
> >     esac
> >   done
> >   echo password=$(pass "pats-by-realm/$realm")
> > 
> > which could be made a lot easier if we did more parsing (e.g.,
> > www-auth-basic-realm or something). I dunno. Maybe that is just opening
> > up a can of worms, as we're stuffing structured data into a linearized
> > key-value list. The nice thing about your proposal is that Git does not
> > even have to know anything about these schemes; it's all the problem of
> > the helper. My biggest fear is just that we'll want to shift that later,
> > and we'll be stuck with this microformat forever.
> 
> I'm not sure there's such a continuous scale between simple and 'complex'
> helpers that would mean there'd be a simple shell script generating
> OAuth or DPoP credentials instead of a helper written in a higher-level
> language where parsing the headers is one of the simpler challenges faced.

For the most part, yeah. I tried to form the above example as something
that was really just relying on "basic", but taking in more information
/ context than we currently provide (and that your patch would provide).
I admit it's a stretch, though. Are there any servers which actually use
a Basic realm to distinguish between two credential's you'd want to
provide? I don't think I've seen one.

(Not to mention that people scripting helpers like this is probably
pretty rare; I do, but you can probably consider me a special case. And
if things got more complicated I'd just turn to Perl anyway. ;) ).

> I had considered another model whereby we forgo the key=value line model,
> and hide another format behind the 'final' terminating new-line. However
> I thought this would be even more distuptive.

Yeah, if we can shoe-horn this into the existing key/value model, that's
much better. The original intent with the final newline is that you
could read multiple credentials in a list, though in the end I don't
recall that we ever used that feature anyway.

-Peff
