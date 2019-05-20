Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 459ED1F461
	for <e@80x24.org>; Mon, 20 May 2019 12:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390282AbfETMbN (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 08:31:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:33848 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2389618AbfETMbM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 08:31:12 -0400
Received: (qmail 23929 invoked by uid 109); 20 May 2019 12:31:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 May 2019 12:31:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3762 invoked by uid 111); 20 May 2019 12:31:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 20 May 2019 08:31:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 May 2019 08:31:10 -0400
Date:   Mon, 20 May 2019 08:31:10 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] clone: auto-enable git-credential-store when
 necessary
Message-ID: <20190520123110.GE11212@sigill.intra.peff.net>
References: <20190519050724.GA26179@sigill.intra.peff.net>
 <20190519051604.GC19434@sigill.intra.peff.net>
 <CAPig+cTkjJjuyrDOUh92B16an+wy9OnZgyKY0-bihWnzyWsoKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTkjJjuyrDOUh92B16an+wy9OnZgyKY0-bihWnzyWsoKg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 20, 2019 at 07:28:08AM -0400, Eric Sunshine wrote:

> > The biggest downside is that it's a bit magical from the user's
> > perspective, because now the password is off in some other file (usually
> > ~/.git-credentials, but sometimes in $XDG_CONFIG_HOME). Which
> > complicates things if they want to purge the repo and password, for
> > example, because now they can't just delete the repository directory.
> >
> > The file location is documented, though, and we point people to the
> > documentation. So perhaps it will be enough (and better still, may lead
> > to them configuring a more secure helper).
> 
> I'm trying to decide how I feel about this based upon my own
> experience recently of having my password magically stored by Git for
> Windows without warning or consent on a computer which was not my own
> but on which I needed to access a private GitHub repository. Although
> the situation is not perfectly analogous, the concern of having one's
> password magically squirreled-away _somewhere_ unexpectedly is the
> same. Being unfamiliar with Git for Windows's credential helper or
> Windows credential management in general, I experienced more than a
> few minutes of consternation and alarm before finally figuring out
> where Git for Windows had stored my password and how to remove it. The
> sense of alarm and discomfort likely would have not arisen had the
> credential helper given me the opportunity to approve or deny the
> action.

Thanks, that's a good elaboration of the uneasiness I was feeling. This
patch is better than the status quo in that your password was already
being squirreled away in plaintext, and now it's at least locked down
with filesystem permissions. But it's clearly not as far as we could go.
I was mostly just afraid to break existing workflows, but maybe we
should be more opinionated.

Or maybe we just need to give more specific details about how to back
out the change.

> > +"Note that the password is still stored in plaintext in the filesystem;\n"
> > +"consider configuring a more secure helper. See \"git help gitcredentials\"\n"
> > +"and \"git help git-credential-store\" for details.\n"
> >  );
> 
> Give the above experience, one way to mitigate such feelings of alarm
> might, at a minimum, be for this message to say where the password is
> being stored (and, possibly, how to remove it) so the user can do so
> immediately if desired. Prompting the user to approve or deny the
> action might also go a long way toward making this more palatable
> (assuming the session is interactive).

I actually thought about pointing to the file, but it's non-trivial to
do so (there's a bunch of internal logic in credential-store to decide
between $HOME and XDG locations).

I think what we really need are better commands to manage credentials
independent of helpers, and then we could recommend a simple command to
clear a credential that you don't want to have stored. Right now I think
the best you can do is:

  echo url=https://example.com | git credential reject

but:

  - "reject" is a funny term; this comes from the C code, which thinks
    of it in terms of the server approving/rejecting (and that makes
    sense for scripts calling this command). But at the helper level,
    the operations are really store/erase. We probably ought to support
    those names, too.

  - piping the credential protocol is slightly awkward; we probably
    ought to allow a url on the command line, and avoid reading stdin if
    we get one.

That would give us:

  git credential erase https://example.com

which is really quite readable. :)

Likewise, if we choose not to auto-enable the store helper, we'd
probably want to give advice on seeding your password. Right now that
is:

  echo url=https://example.com | git credential fill | git credential approve

which is...not intuitive. It would make sense to me to have a "seed"
operation which does a fill/approve together. Maybe that should just be
what "store" does, which would allow:

  $ git credential store https://example.com
  Username for 'https://example.com':
  Password for 'https://user@example.com':

(Of course you can also just "git fetch" to get prompted, but it seems
like this shouldn't require a network operation if you don't want it
to).

-Peff
