Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11BF01F954
	for <e@80x24.org>; Thu, 23 Aug 2018 00:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbeHWEKG (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 00:10:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:52476 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725924AbeHWEKG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 00:10:06 -0400
Received: (qmail 11836 invoked by uid 109); 23 Aug 2018 00:43:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Aug 2018 00:43:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6087 invoked by uid 111); 23 Aug 2018 00:43:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 20:43:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 20:43:01 -0400
Date:   Wed, 22 Aug 2018 20:43:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: [PATCH 0/9] trailer-parsing false positives
Message-ID: <20180823004300.GA1355@sigill.intra.peff.net>
References: <20180821184140.GA24165@sigill.intra.peff.net>
 <20180821190705.GF30764@sigill.intra.peff.net>
 <xmqqin438pze.fsf@gitster-ct.c.googlers.com>
 <xmqqbm9v8pou.fsf@gitster-ct.c.googlers.com>
 <20180821200747.GA21955@sigill.intra.peff.net>
 <xmqq36v78ml8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq36v78ml8.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 21, 2018 at 01:57:07PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Ah, yeah, I think you're right. We call find_patch_start(), which thinks
> > the "---" line is the end of the commit message. That makes sense when
> > parsing trailers out of "format-patch" output, but not when we know we
> > have just the commit message.
> 
> Yes, but that does not explain what we are seeing.  If the code
> mistakenly thinks that the log message ends before that table, then
> it should have inserted the S-o-b: _before_ that table, but that is
> not happening.
> 
> So there are three issues; (1) find-patch-start uses too weak a
> logic to find the beginning of a patch section (2) even if it found
> the right place, its caller does not tell "commit --amend -s" where
> the log message ends correctly and (3) some callchains that get
> there know they only have a log message but there is no way to take
> advantage of that information and skip the call to find-patch-start.

So this turned into a bit of a rabbit hole. Here's what I have so far
(which I think is not quite ready, but I wanted to start discussing).

Issues (2) and (3) are actually the same issue. The caller that does the
bogus appending for (2) is always append_signoff(). But it always has
just a commit message (modulo some complications, which I'll get to in a
minute), and so fixing it with respect to (3) magically solves (2).
I.e., the code was simply not prepared for the case of "end of string is
not end of trailers". But since that case cannot exist, we do not have
to deal with it. :)

Now here's the tricky part. I think patches 1-8 are mostly sensible. But
while doing 7/8, I noticed some weirdness around the ignore_footer
parameter. It seems git-commit strips some cruft off the end of the
buffer, including "#" comments, before looking for the trailers. But
that doesn't make any sense. We should just handle the cleaned-up commit
message. Worse, the stripping does not take into account options like
--cleanup=verbatim, where "#" comments are _not_ cruft anymore. Double
worse, it uses the current notion of core.commentChar, but we might be
operating on historical data (i.e., something created with a different
comment char). Triple-worse, this same cleanup is used in the trailer
parsing code!

So:

  git interpret-trailers --parse <<-\EOF
  subject

  body

  Signed-off-by: me

  # is this a comment or not?
  EOF

will find that s-o-b. Should that "#" thing be a comment? I'd say no. We
are not dealing with a commit message template at all. And even in
git-commit, I think we aren't (or at least ought not to be) passing the
template around to the signoff code.

So I think there may be further opportunities for cleanup here. I'm not
sure if we'd need to retain this behavior for git-interpret-trailers.
AFAICT it is not documented, and I suspect is mostly historical
accident, and not anything anybody ever wanted.

If we do keep it by default, then the "--no-divider" option I added in
patch 4 should probably get a more generic name and cover this.
Something like "--verbatim-input".

I'm going to sleep on it and see how I feel tomorrow.

  [1/9]: trailer: use size_t for string offsets
  [2/9]: trailer: use size_t for iterating trailer list
  [3/9]: trailer: pass process_trailer_opts to trailer_info_get()
  [4/9]: interpret-trailers: tighten check for "---" patch boundary
  [5/9]: interpret-trailers: allow suppressing "---" divider
  [6/9]: pretty, ref-filter: format %(trailers) with no_divider option
  [7/9]: sequencer: ignore "---" divider when parsing trailers
  [8/9]: append_signoff: use size_t for string offsets
  [9/9]: sequencer: handle ignore_footer when parsing trailers

 Documentation/git-interpret-trailers.txt | 10 +++-
 builtin/interpret-trailers.c             |  1 +
 commit.c                                 |  6 +--
 commit.h                                 |  2 +-
 pretty.c                                 |  3 ++
 ref-filter.c                             |  2 +
 sequencer.c                              | 20 ++++++--
 sequencer.h                              |  9 +++-
 t/t4205-log-pretty-formats.sh            | 23 +++++++++
 t/t6300-for-each-ref.sh                  | 23 +++++++++
 t/t7501-commit.sh                        | 16 ++++++
 t/t7513-interpret-trailers.sh            | 42 ++++++++++++++++
 trailer.c                                | 62 +++++++++++++-----------
 trailer.h                                |  4 +-
 14 files changed, 184 insertions(+), 39 deletions(-)

-Peff
