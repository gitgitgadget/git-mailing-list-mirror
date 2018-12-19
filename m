Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6A9A1F405
	for <e@80x24.org>; Wed, 19 Dec 2018 18:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbeLSSWT (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 13:22:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:45966 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727232AbeLSSWT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 13:22:19 -0500
Received: (qmail 1032 invoked by uid 109); 19 Dec 2018 18:22:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Dec 2018 18:22:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23434 invoked by uid 111); 19 Dec 2018 18:21:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Dec 2018 13:21:51 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2018 13:22:17 -0500
Date:   Wed, 19 Dec 2018 13:22:17 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Referring to commits in commit messages
Message-ID: <20181219182216.GA17309@sigill.intra.peff.net>
References: <20181217165957.GA60293@google.com>
 <877eg5fwd5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877eg5fwd5.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 19, 2018 at 03:02:14PM +0100, Ævar Arnfjörð Bjarmason wrote:

> On Mon, Dec 17 2018, Jonathan Nieder wrote:
> 
> > v2.11.0-rc3~3^2~1 (stripspace: respect repository config, 2016-11-21)
> 
> Minor nit not just on this patch, but your patches in general: I think
> you're the only one using this type of template instead of the `%h
> ("%s", %ad)` format documented in SubmittingPatches.
> 
> I've had at least a couple of cases where I've git log --grep=<abbr sha>
> and missed a commit of yours when you referred to another commit.
> 
> E.g. when composing
> https://public-inbox.org/git/878t0lfwrj.fsf@evledraar.gmail.com/ I
> remembered PERLLIB_EXTRA went back & forth between
> working/breaking/working with your/my/your patch, so:
> 
>     git log --grep=0386dd37b1
> 
> Just found the chain up to my breaking change, but not your 7a7bfc7adc,
> which refers to that commit as v1.9-rc0~88^2.
> 
> Maybe this is really a feature request. I.e. maybe we should have some
> mode where --grep=<commitish> will be combined with some mode where we
> try to find various forms of <commitish> in commit messages, then
> normalize & match them....

That would help when you're using --grep, but not other things that are
trying to parse the commit message. Two instances I've noticed:

  - web interfaces like GitHub won't linkify this type of reference
    (whereas they will for something that looks like a hex object id)

  - my terminal makes it easy to select hex strings, but doesn't
    understand this git-describe output :)

These tools _could_ be taught a regex like /v(\d+.)(-rc\d+)?([~^]+d)*/.
But matching hex strings is a lot simpler, and works across many
projects.

So I agree with you that this git-describe format is less convenient for
readers, but my preferred solution is to use a different format, rather
than try to teach every reading tool to be more clever.

As far as I can tell, the main advantage of using "v2.11.0-rc3~3^2~1"
over its hex id is that it gives a better sense in time of which Git
version we're talking about.  The date in the parentheses does something
similar for wall-clock time, but it's left to the reader to map that to
a Git version if they choose.

Personally, I find the wall-clock time to be enough, since usually what
I want to know is "how ancient is this". And in the rare instance that I
care about the containing version, it's not a big deal to use "git tag
--contains".  If we really want to convey that information in the text,
I think it would be reasonable to say something like:

  In commit 1234abcd (the subject line, 2016-01-01, v2.11.0), we did
  blah blah blah

with a few simple rules:

  - only mention a single version, the oldest one that contains the
    commit[1]. If it's in v2.11.1, we can infer that it's in v2.12.0,
    etc.

  - only mention released commits; for the granularity we're talking
    about here, the distinction between v2.11.0 and v2.11.0-rc3 is not
    important

  - if it hasn't been in a released version, don't include a version at
    all.

That's probably over-engineering, and I'm perfectly fine with the
oid/subject/date format most people use. Just trying to give an option
if people really think the tag name is useful.

-Peff

[1] I usually compute the containing version with:

      $ git help has
      'has' is aliased to '!f() { git tag --contains "$@" | grep ^v | grep -v -- -rc | sort -V | head -1; }; f'

    though I suspect it could be done these days with fewer processes
    using "tag --sort".

