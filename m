Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B96EE1FF1E
	for <e@80x24.org>; Mon, 30 Jan 2017 23:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752802AbdA3X0F (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 18:26:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:47064 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750910AbdA3X0E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 18:26:04 -0500
Received: (qmail 12341 invoked by uid 109); 30 Jan 2017 23:26:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Jan 2017 23:26:04 +0000
Received: (qmail 30787 invoked by uid 111); 30 Jan 2017 23:26:05 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Jan 2017 18:26:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jan 2017 00:26:00 +0100
Date:   Tue, 31 Jan 2017 00:26:00 +0100
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: difflame
Message-ID: <20170130232559.krdxkt4dq4lfv4rj@sigill.intra.peff.net>
References: <CAOc6etaCk=OEyarMNhorM94MBnYRscCkJBM-K08snv1ecmOaPQ@mail.gmail.com>
 <20170128035321.yrcqwkg2fiwadxj4@sigill.intra.peff.net>
 <xmqqd1f4uug6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1f4uug6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 30, 2017 at 01:08:41PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Jan 17, 2017 at 11:24:02PM -0600, Edmundo Carmona Antoranz wrote:
> >
> >> For a very long time I had wanted to get the output of diff to include
> >> blame information as well (to see when something was added/removed).
> >
> > This is something I've wanted, too. The trickiest part, though, is
> > blaming deletions, because git-blame only tracks the origin of content,
> > not the origin of a change.
> 
> Hmph, this is a comment without looking at what difflame does
> internally, so you can ignore me if I am misunderstood what problem
> you are pointing out, but I am not sure how "tracks the origin of
> content" could be a problem.
> 
> If output from "git show" says this:
> 
> 	--- a/file
> 	+++ b/file
> 	@@ -1,5 +1,6 @@
> 	 a
> 	 b
> 	-c
> 	+C
> 	+D
> 	 d
> 	 e
> 
> in order to annotate lines 'a', 'b', 'd', and 'e' for their origin,
> you would run 'blame' on the commit the above output was taken from
> (or its parent---they are in the context so either would be OK).
> 
> You know where 'C' and 'D' came from already.  It's the commit you
> are feeding "git show".

I think the point (or at least as I understand it) is that the diff is
not "git show" for a particular commit. It could be part of a much
larger diff that covers many commits.

As a non-hypothetical instance, I have a fork of git.git that has
various enhancements. I want to feed those enhancements upstream. I need
to know which commits should be cherry-picked to get those various
enhancements.

Looking at "log origin..fork" tells me too many commits, because it
includes ones which aren't useful anymore. Either because they already
went upstream, or because they were cherry-picked to the fork and their
upstream counterparts merged (or even equivalent commits made upstream
that obsoleted the features).

Looking at "git diff origin fork" tells me what the actual differences
are, but it doesn't show me which commits are responsible for them.

I can "git blame" each individual line of the diff (starting with "fork"
as the tip), but that doesn't work for lines that no longer exist (i.e.,
when the interesting change is a deletion).

> In order to run blame to find where 'c' came from, you need to start
> at the _parent_ of the commit the above output came from, and the
> hunk header shows which line range to find the final 'c'.

So perhaps that explains my comment more. "blame" is not good for
finding which commit took away a line. I've tried using "blame
--reverse", but it shows you the parent of the commit you are looking
for, which is slightly annoying. :)

"git log -S" is probably a better tool for finding that.

-Peff
