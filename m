Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AD65203EA
	for <e@80x24.org>; Sat, 10 Dec 2016 08:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbcLJIvs (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 03:51:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:54567 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752814AbcLJIvr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 03:51:47 -0500
Received: (qmail 1132 invoked by uid 109); 10 Dec 2016 08:51:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Dec 2016 08:51:36 +0000
Received: (qmail 25089 invoked by uid 111); 10 Dec 2016 08:52:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Dec 2016 03:52:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2016 03:51:34 -0500
Date:   Sat, 10 Dec 2016 03:51:34 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Klaus Ethgen <Klaus@Ethgen.ch>,
        git@vger.kernel.org
Subject: Re: [BUG] Colon in remote urls
Message-ID: <20161210085133.2pnkz6eqlxoxdckg@sigill.intra.peff.net>
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch>
 <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net>
 <xmqqwpf8rkeq.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwpf8rkeq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 09, 2016 at 11:07:25AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > (One other option is to just declare that the quarantine feature doesn't
> > work with colons in the pathname, but stop turning it on by default. I'm
> > not sure I like that, though).
> 
> I think we long time ago in 2005 have declared that a colon in a
> directory name would not work for Git repositories because of things
> like GIT_CEILING_DIRECTORIES, GIT_ALTERNATE_OBJECT_DIRECTORIES; so I
> do not think we terribly mind that direction.

I don't mind declaring the feature incompatible. But I'm not sure
whether I like not having it on by default, if only because it means we
have two distinct code paths to care about. They're sufficiently
different that I'd worry about a bug creeping into one and not the
other.

> > Here's a rough idea of what the quoting solution could look like. It
> > should make your case work, but I'm not sure what we want to do about
> > backwards-compatibility, if anything.
> 
> Yes, obviously it robs from those with backslash in their pathnames
> to please those with colons; we've never catered to the latter, so I
> am not sure if the trade-off is worth it.
> 
> I can see how adding a new environment variable could work, though.
> A naive way would be to add GIT_ALT_OBJ_DIRS that uses your quoting
> when splitting its elements, give it precedence over the existing
> one (or allow to use both and take union as the set of alternate
> object stores) and make sure that the codepaths we use internally
> uses the new variable.

Yeah, a new variable solves the backwards-compatibility issue, though if
we continue to use backslash as an escape, then people on Windows will
annoying _have_ to backslash-escape "C:\\" (worse, AIUI the conversion
from "/unix/path" to "C:\unix\path" happens transparently via msys
magic, and it would not know that we need to quote).

I think the least-gross alternative would be to make newline the new
delimiter. It's already the delimiter (and not quotable) in the
objects/info/alternates file, and I have a lot less trouble telling
people with newline in their filenames that they're Doing It Wrong.

> But if the quarantine codepath will stay to
> be the only user of this mechanism (and I strongly suspect that will
> be the case), the new environment could just be pointing at a single
> directory, i.e. GIT_OBJECT_QUARANTINE_DIRECTORY, whose value is
> added without splitting to the list of alternate object stores, and
> the quarantine codepath can export that instead.

Yes, I also considered that approach. The big downside is that it does
not help other users of GIT_ALTERNATE_OBJECT_DIRECTORIES. I doubt that
matters much in practice, though.

My other question is whether we care about compatibility between Git
versions here. If receive-pack sets the variable, we can assume that
index-pack will be run from the same version. But we also run hooks with
the quarantine variables set. The nice thing about the existing scheme
is that older versions of Git (or alternate implementations of Git) will
just work, because it builds on a mechanism that has existed for ages.

And that's the one thing that a quoting scheme has going for it: it only
impacts the variable when there is something to be quoted. So if your
repo path has a colon in it (or semi-colon on Windows) _and_ you are
calling something like jgit from your hook, then you might see a
failure. But either of those by itself is not a problem.

Side note: It makes me wonder if all implementations even support
GIT_ALTERNATE_OBJECT_DIRECTORIES. JGit seems to, looks like libgit2 does
not. The most backwards-compatible thing is not enabling quarantine by
default, and then there's no chance of regression, and you are
responsible for making sure you have a compatible setup before turning
the feature on. But like I said, I'd love to avoid that if we can.

So here's the array of options, as I see it:

  1. Disable quarantine by default; only turn it on if you don't have
     any of the funny corner cases.

  2. Introduce an extra single-item environment variable that gets
     appended to the list of alternates, and side-steps quoting issues.

  3. Introduce a new variable that can hold an alternate list, and
     either teach it reasonable quoting semantics, or give it a
     less-common separator.

  4. Introduce quoting to the existing variable, but make the quoting
     character sufficiently obscure that nobody cares about the lack of
     backwards compatibility.

I actually think (4) is reasonably elegant, except that the resulting
quoting scheme would be vaguely insane to look at. E.g., if we pick
newline as the quote character (not the separator), then you end up
with:

  $ repo=foo:bar.git
  $ GIT_ALTERNATE_OBJECT_DIRECTORIES=$(echo $repo | perl -pe 's/:/\n$&/')
  $ echo "$GIT_ALTERNATE_OBJECT_DIRECTORIES"
  foo
  :bar.git

It's pleasant for machines, but not for humans.

So I dunno. Opinions on those 4 options are welcome.

-Peff
