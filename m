Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 747091F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 19:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbeJMCnS (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 22:43:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:39168 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725851AbeJMCnS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 22:43:18 -0400
Received: (qmail 32398 invoked by uid 109); 12 Oct 2018 19:09:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 12 Oct 2018 19:09:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13522 invoked by uid 111); 12 Oct 2018 19:08:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Oct 2018 15:08:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Oct 2018 15:09:20 -0400
Date:   Fri, 12 Oct 2018 15:09:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] ref-filter: free item->value and item->value->s
Message-ID: <20181012190920.GD4917@sigill.intra.peff.net>
References: <0102016657e7cfee-f1343b1e-9a85-4cae-990a-cc7177ea8487-000000@eu-west-1.amazonses.com>
 <0102016657e7d087-be1f65a3-be3e-4b15-95f1-7570d258c70d-000000@eu-west-1.amazonses.com>
 <xmqqzhvli8kl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhvli8kl.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 10:19:22AM +0900, Junio C Hamano wrote:

> > @@ -1373,36 +1379,31 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
> >  		}
> >  	} else if (atom->u.remote_ref.option == RR_TRACKSHORT) {
> >  		if (stat_tracking_info(branch, &num_ours, &num_theirs,
> > -				       NULL, AHEAD_BEHIND_FULL) < 0)
> > +				       NULL, AHEAD_BEHIND_FULL) < 0) {
> > +			*s = xstrdup("");
> >  			return;
> 
> It is a bit sad that we need to sprinkle xstrdup() all over the
> place, but I do not offhand think of a better alternative to ensure
> that it is safe to blindly free the .s field.

I think the root of the problem is that the current code needs
_something_ in the "s" field to know that the value has already been
filled in.

If there were a separate flag for "filled", then this could just be
NULL (and the later code that builds the output would have to realize
to replace that with an empty string).

I think in the long run, we'd ideally have one of two code structures:

  - a single pass, without iterating over the used atoms list
    repeatedly. E.g., the way oid_object_info() takes a struct
    representing the set of items that the caller is interested in, and
    then fills it in as it digs for information.

  - individual atoms could write directly to an output strbuf, avoiding
    the extra allocation and copy altogether (that would help these
    cases that are just copying an empty string, but also the ones that
    really are allocating a piece of data and end up copying it.

I'm OK with this approach in the meantime, though. There's a fair bit of
refactoring to get to either of those end-states, and this clears up the
confusing memory ownership issues. And I don't think for-each-ref is
_too_ sensitive to a few extra mallocs (as compared to say, cat-file's
formatter, which is often run once per object).

I didn't dig into the valgrind errors you saw, but I'd guess they are
the result of this patch missing one of these cases (if not a string
literal like "", perhaps a const pointer into another heap string).

-Peff
