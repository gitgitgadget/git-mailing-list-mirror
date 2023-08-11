Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4D9EB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 15:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjHKPBR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 11:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjHKPBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 11:01:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B138510FE
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 08:01:15 -0700 (PDT)
Received: (qmail 15834 invoked by uid 109); 11 Aug 2023 15:01:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Aug 2023 15:01:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26285 invoked by uid 111); 11 Aug 2023 15:01:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Aug 2023 11:01:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Aug 2023 11:01:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/4] commit-graph: verify swapped zero/non-zero
 generation cases
Message-ID: <20230811150114.GC2303200@coredump.intra.peff.net>
References: <ZNUiEXF5CP6WMk9A@nand.local>
 <cover.1691699851.git.me@ttaylorr.com>
 <9b9483893c072961c5871bd0bae17a7098d73c06.1691699851.git.me@ttaylorr.com>
 <xmqqleeir35l.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqleeir35l.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2023 at 02:36:06PM -0700, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > diff --git a/commit-graph.c b/commit-graph.c
> > index c68f5c6b3a..acca753ce8 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -2686,9 +2686,12 @@ static int verify_one_commit_graph(struct repository *r,
> >  				graph_report(_("commit-graph has generation number zero for commit %s, but non-zero elsewhere"),
> >  					     oid_to_hex(&cur_oid));
> >  			generation_zero = GENERATION_ZERO_EXISTS;
> > -		} else if (generation_zero == GENERATION_ZERO_EXISTS)
> > -			graph_report(_("commit-graph has non-zero generation number for commit %s, but zero elsewhere"),
> > -				     oid_to_hex(&cur_oid));
> > +		} else {
> > +			if (generation_zero == GENERATION_ZERO_EXISTS)
> > +				graph_report(_("commit-graph has non-zero generation number for commit %s, but zero elsewhere"),
> > +					     oid_to_hex(&cur_oid));
> > +			generation_zero = GENERATION_NUMBER_EXISTS;
> > +		}
> 
> Hmph, doesn't this potentially cause us to emit the two reports
> alternating, if we are unlucky enough to see a commit with 0
> generation first (which will silently set gz to ZERO_EXISTS), then
> another commit with non-zero generation (which will complain we saw
> non-zero for the current one and earlier we saw zero elsewhere, and
> then set gz to NUM_EXISTS), and then another commit with 0
> generation (which will complain the other way, and set gz back again
> to ZERO_EXISTS)?
> 
> I am tempted to say this gz business should be done with two bits
> (seen zero bit and seen non-zero bit), and immediately after we see
> both kinds, we should report once and stop making further reports,
> but ...

Yeah, I think you are right. It might be OK, in the sense that we would
show a different commit each time as we flip-flopped, but it's not clear
to me how valuable that is.

If the actual commit ids are not valuable, then we could just set bits
and then at the end of the loop produce one warning:

  if (seen_zero && seen_non_zero) {
	graph_report("oops, we saw both types");
  }

Certainly that would make the code less confusing to me. :) But I really
don't know if marking the individual commit is useful or not (on the
other hand, it cannot be perfect, since when we see a mismatch we do not
know if it was _this_ commit that is wrong and the previous one is
right, or if the previous one was wrong and this one was right). I guess
we could also save an example of each type and report them (i.e., make
seen_zero and seen_non_zero pointers to commits/oids).

> >  		if (generation_zero == GENERATION_ZERO_EXISTS)
> >  			continue;
> 
> ... as I do not see what this "continue" is doing, I'd stop at
> expressing my puzzlement ;-)

Yeah, I'm not sure on this bit. I had thought at first it was just
trying to avoid the rest of the loop for commits which are 0-generation.
But after Taylor's explanation that this is about whole files with
zero-generations, it makes sense that we would not do the rest of the
loop for any commit (it is already an error to have mixed zero/non-zero
entries, so the file fails verification).

In a "two bits" world, I think this just becomes:

  if (seen_zero)
	continue;

-Peff
