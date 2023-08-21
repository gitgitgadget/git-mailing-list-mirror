Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615BEEE49A0
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 22:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjHUWYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 18:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjHUWYC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 18:24:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F36DB
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 15:24:00 -0700 (PDT)
Received: (qmail 18682 invoked by uid 109); 21 Aug 2023 22:24:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Aug 2023 22:24:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21635 invoked by uid 111); 21 Aug 2023 22:24:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Aug 2023 18:24:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Aug 2023 18:23:59 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 5/5] diff: the -w option breaks --exit-code for --raw
 and other output modes
Message-ID: <20230821222359.GA1813553@coredump.intra.peff.net>
References: <20230817222949.3835424-1-gitster@pobox.com>
 <20230818235932.3253552-1-gitster@pobox.com>
 <20230818235932.3253552-6-gitster@pobox.com>
 <20230821210058.GD1800481@coredump.intra.peff.net>
 <20230821210804.GA1809621@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821210804.GA1809621@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2023 at 05:08:05PM -0400, Jeff King wrote:

> On Mon, Aug 21, 2023 at 05:00:58PM -0400, Jeff King wrote:
> 
> > Alternatively, we could put it in the caller, like so:
> > 
> > diff --git a/diff.c b/diff.c
> > index 78f4e7518f..e7281e75eb 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -6528,6 +6528,7 @@ void diff_flush(struct diff_options *options)
> >  			if (check_pair_status(p))
> >  				flush_one_pair(p, options);
> >  		}
> > +		options->found_changes = !!q->nr;
> >  		separator++;
> >  	}
> >  
> > 
> > which matches the diffstat technique (I almost thought we could share
> > the code, but for the diffstat we are counting what ends up in the
> > diffstat struct; it does not clean out the original diff_queue when it
> > sees a noop pair).
> > 
> > I don't see a real reason to prefer one over the other.
> 
> Actually, on second look these are not quite the same. Yours only
> triggers if check_pair_status() is true. So something like
> --diff-filter should affect both output and exit code. Yours gets that
> right, and mine does not. Sorry for the noise. :)

Sorry, I'm dumb again. That is not where diff-filter is handled (it is
handled by diffcore, duh). check_pair_status() is only checking for
DIFF_STATUS_UNKNOWN. I'm not sure when that would ever be set, but it
seems like we should be matching the "if it is output" logic, which is
what you get by calling flush_one_pair(). So yours is definitely
preferable, even if I don't understand the possible differences. ;)

-Peff
