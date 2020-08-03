Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A79C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 20:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF302207DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 20:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgHCUpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:45:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:46812 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgHCUpE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 16:45:04 -0400
Received: (qmail 29296 invoked by uid 109); 3 Aug 2020 20:45:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Aug 2020 20:45:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4430 invoked by uid 111); 3 Aug 2020 20:45:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Aug 2020 16:45:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Aug 2020 16:45:03 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
Subject: Re: Renaming the "master" branch without breaking existing clones
Message-ID: <20200803204503.GB2715275@coredump.intra.peff.net>
References: <ec960483f5008e9948271c678d51876920ab62c9.camel@mattmccutchen.net>
 <20200803160051.GA50799@syl.lan>
 <20200803194006.GA2715275@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200803194006.GA2715275@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 03, 2020 at 03:40:06PM -0400, Jeff King wrote:

> On Mon, Aug 03, 2020 at 12:00:51PM -0400, Taylor Blau wrote:
> 
> > This is more-or-less what I was proposing in the message that I linked
> > above. Maybe a more solidified proposal might look something as follows:
> > 
> >   - We could introduce a mechanism to mark certain refs as aliases to
> >     other refs. For example, a remote might publish its
> >     'refs/heads/master' as an alias to 'refs/heads/main', so that any
> >     reads or writes to the former get applied to the latter
> >     transparently.
> 
> I think symrefs do this already. Try this:

Looks like Junio already mentioned symrefs. I guess I should have read
the whole thread. :)

As he noted, they don't work if you want to free up the original name.
But I think in the master/main renaming case that most people wouldn't
care that much about doing so.

> >   - A ref alias can be annotated to say "I am a transition ref alias",
> >     i.e., that clients should be taught to rename their copy of 'master'
> >     to 'main' (and update remote-tracking refs accordingly).
> 
> It's not specifically marked as a transition, but a client could act on
> the symref advertisement above.

Something like this script could be run on the clients:

  remote=origin
  git ls-remote --symref $remote |
  grep ^ref: |
  while read junk to from; do
    if test "$from" = HEAD; then
      old=$(git symbolic-ref refs/remotes/$remote/HEAD)
      echo "Upstream switched their HEAD:"
      echo "  old: $old"
      echo "  new: $to"
      echo "Update to match?"
      read r </dev/tty
      if test "$r" = yes; then
        git symbolic-ref refs/remotes/$remote/HEAD $to
      fi
    else
      # do we even have the old branch?
      git rev-parse --verify $from >/dev/null 2>&1 || continue
      echo "Upstream is redirecting a branch:"
      echo "     branch: $from"
      echo "  points to: $to"
      echo "And you have a local $from; should we rename it?"
      read r </dev/tty
      if test "$r" = yes; then
        git branch -m ${from#refs/heads/} ${to#refs/heads/}
      fi
    fi
  done

There are probably some rough edges that could be smoothed (only looking
in refs/heads/ and using branch names instead of fully qualified refs,
handling the case that $to already exists more gracefully, better
prompting). But something like that might be useful for projects that
are transitioning.

Note that it only works with protocol v2, though, because we don't
report non-HEAD symrefs in v0.

-Peff
