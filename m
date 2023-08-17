Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAD2C2FC22
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 19:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354755AbjHQTtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 15:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354756AbjHQTtO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 15:49:14 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDE9EE
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 12:49:13 -0700 (PDT)
Received: (qmail 29405 invoked by uid 109); 17 Aug 2023 19:49:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Aug 2023 19:49:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 566 invoked by uid 111); 17 Aug 2023 19:49:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Aug 2023 15:49:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Aug 2023 15:49:12 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Paul Watson <pwatson2@wellmed.net>
Subject: Re: [PATCH] diff: tighten interaction between -w and --exit-code
Message-ID: <20230817194912.GB3032779@coredump.intra.peff.net>
References: <MW2PR12MB25558D1886C4AA2A95A5FC618709A@MW2PR12MB2555.namprd12.prod.outlook.com>
 <xmqqbkfh8nu3.fsf@gitster.g>
 <xmqqv8ded018.fsf@gitster.g>
 <20230817051059.GA3006160@coredump.intra.peff.net>
 <xmqqy1i9bqcm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy1i9bqcm.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2023 at 09:12:09AM -0700, Junio C Hamano wrote:

> > diff --git a/diff.c b/diff.c
> > index 38b57b589f..1dbfdaeff0 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -3853,6 +3853,8 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
> >  				&& one->mode == two->mode) {
> >  				free_diffstat_file(file);
> >  				diffstat->nr--;
> > +			} else {
> > +				o->found_changes = 1;
> >  			}
> >  		}
> >  	}
> 
> That is much better.  In all cases where the above diffstat->nr-- is
> not reached and diffstat is kept is where we found changes, so an
> even simpler solution that fundamentally cannot go wrong would be to
> see "diffstat->nr" at the end (i.e. "are we going to show diffstat
> for *any* filepair?").  If it is non-zero, we did find a difference.

Yeah, without having really dug into the problem too far, that does
sound a lot better. I also wonder to what degree you could apply the
same strategy to other formats (I guess it depends on them removing
whitespace-only changes from a structure). From the test I posted
earlier, it does look like many of them have the same blind spots for
mode-only changes (and I suspect addition/removal of empty files is
another corner case to check).

-Peff
