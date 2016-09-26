Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5F0C1F4F8
	for <e@80x24.org>; Mon, 26 Sep 2016 04:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932967AbcIZEer (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 00:34:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:47901 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932496AbcIZEeq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 00:34:46 -0400
Received: (qmail 26046 invoked by uid 109); 26 Sep 2016 04:34:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 04:34:45 +0000
Received: (qmail 2250 invoked by uid 111); 26 Sep 2016 04:34:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 00:34:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 00:34:42 -0400
Date:   Mon, 26 Sep 2016 00:34:42 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Changing the default for "core.abbrev"?
Message-ID: <20160926043442.3pz7ccawdcsn2kzb@sigill.intra.peff.net>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <xmqq37knwcf4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37knwcf4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 25, 2016 at 08:46:39PM -0700, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > I can just keep reminding kernel maintainers and developers to update
> > their git config, but maybe it would be a good idea to just admit that
> > the defaults picked in 2005 weren't necessarily the best ones
> > possible, and those could be bumped up a bit?
> >
> > I think I mentioned this some time ago, and it's not a huge deal, but
> > I thought I'd just mention it again because it came up again today for
> > me..
> 
> I am not quite sure how good any new default would be, though.  Just
> like any timeout is not long enough for somebody, growing projects
> will eventually hit whatever abbreviation length they start with.

I actually think "12" might be sane for a long time. That's 48 bits of
sha1, so we'd expect a 50% change of a _single_ collision at 2^24, or 16
million.  The biggest repository I know about (in number of objects) is
the one holding all of the objects for all of the forks of
torvalds/linux on GitHub. It's at about 15 million objects.

Which _seems_ close, but remember that's the size where we expect to see
a single collision. They don't become common until much later (I didn't
compute an exact number, but Linus's 16x sounds about right). I know
that the growth of the kernel isn't really linear, but I think the need
to bump to "13" might not just be decades, but possibly a century or
more.

So 12 seems reasonable, and the only downside for it (or for "13", for
that matter) is a few extra bytes. I dunno, maybe people will really
hate that, but I have a feeling these are mostly cut-and-pasted anyway.

> I am not opposed to bump the default to 12 or whatever, but I
> suspect any lengthening today may need to be accompanied by a tool
> support that finds the set of objects that are reachable from a
> commit whose names begin with non-unique abbreviations that appear
> in the commit log message. Assuming that it is very hard to refer to
> future objects in the log message you write today, such a tool may
> find a single object that used to be the unique instance of that
> abbreviation back then, and with reachability bitmap support, it may
> not be too expensive to run.

I had a similar thought, but I think it's not just reachability. You
might refer to a short sha1 on an alternate branch that isn't reachable
from you. Or you may even use the short sha1 in an email message or a
bug tracker. So I think the extra context you want is probably a
timestamp: at time t, what was a reasonable guess for this sha1?

That's easy to answer for commits and tags (cull the ones that are too
new), but harder for blobs and trees (you'd want to know the earliest
commit which contains them).

An easier (but less automatic) tool would be to improve our error
message for the ambiguous case, and actually report details of the
candidates. I'm working up a patch now.

-Peff
