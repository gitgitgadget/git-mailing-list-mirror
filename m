Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9134AC433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 21:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353883AbhLCV4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:56:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:43312 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236017AbhLCV4N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 16:56:13 -0500
Received: (qmail 25221 invoked by uid 109); 3 Dec 2021 21:52:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Dec 2021 21:52:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5633 invoked by uid 111); 3 Dec 2021 21:52:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Dec 2021 16:52:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Dec 2021 16:52:47 -0500
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Large delays in mailing list delivery?
Message-ID: <YaqRr//Yu8cn+7s7@coredump.intra.peff.net>
References: <CABPp-BF_xsOpQ6GSaWs9u9JcnPQT_OXP-gCsAuxPtMj-X1tgOg@mail.gmail.com>
 <211203.86sfv9qwdm.gmgdl@evledraar.gmail.com>
 <20211203202427.o575sgrx4auqkmjp@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211203202427.o575sgrx4auqkmjp@meerkat.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 03, 2021 at 03:24:27PM -0500, Konstantin Ryabitsev wrote:

> On Fri, Dec 03, 2021 at 09:02:48PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > When I've experienced delays (sometimes of half a day or more) both
> > https://public-inbox.org/git/ and https://lore.kernel.org/git/ have been
> > updated.
> 
> Btw, you can source lore.kernel.org straight into your gmail inbox. :)
> 
>     https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started
>     https://people.kernel.org/monsieuricon/lore-lei-part-2-now-with-imap
> 
> Or, you can read it via nntp://nntp.lore.kernel.org/.

I've been watching the lei stuff, and it's pretty cool. I was already
indexing my local archive with notmuch, so right now I have an "in
between" solution where I pull from lore and deliver into a local
mailbox, like:

-- >8 --
ROOT=$HOME/.cache/lists

test -n "$QUIET" && exec >/dev/null
test $# = 0 && set -- $(cd "$ROOT" && echo *)

for list in "$@"; do
	cd "$ROOT/$list" || exit 1
	git fetch -v ${QUIET:+--quiet} || exit 1
	git rev-list refs/lists/delivered..HEAD |
	git diff-tree --format= --stdin --raw |
	awk '{print $4}' |
	while read blob; do
		test -n "$QUIET" || echo >&2 "Delivering $blob..."
		git cat-file blob "$blob" |
		safecat maildir/tmp maildir/new ||
		exit 1
	done || exit 1
	git update-ref refs/lists/delivered HEAD || exit 1
done
-- >8 --

Some notes:

  - ~/.cache/lists/git is a bare clone of https://lore.kernel.org/git/0;
    I know this will run into problems if we eventually get enough
    messages to start a new epoch, but that's still years away by the
    current counting.

  - maildir in the bare repo is a symlink to the actual maildir I
    deliver to (~/mail/git)

  - I use safecat here to deliver into the maildir, but notmuch-insert
    would probably make more sense.

I think this is less featureful than lei (especially some of the
advanced queries), but it was a drop-in replacement for my existing
queries and workflows. And it has low dependencies.

Of course it doesn't help much if you're using gmail or something. :)
I guess you could replace the safecat delivery with git-imap-send or
similar.

It's polling, of course, but I assume that a noop fetch against the lore
repo is pretty cheap. I think Eric's public-inbox/lei code for doing
updates has an extra HTTP-endpoint check to avoid invoking even the noop
Git (though it results in an extra HTTP request when there _is_
something to fetch).

And of course it's holding two copies of the messages (one in Git, and
then the delivered one). That's OK for my purposes, but I have noticed
that lei is generally much faster to answer queries, because maildirs
have awful cold-cache behavior because of all the inodes (and my
mailserver is still on spinning disks).

So I don't really recommend anybody going down my same path if they
could just jump to using lei. But I thought the script above might help
somebody who wants to just replace one small bit of their
infrastructure/workflow without retraining fingers, etc.

-Peff
