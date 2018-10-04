Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5B431F453
	for <e@80x24.org>; Thu,  4 Oct 2018 22:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeJEFJe (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 01:09:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:41946 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726179AbeJEFJe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 01:09:34 -0400
Received: (qmail 5282 invoked by uid 109); 4 Oct 2018 22:14:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Oct 2018 22:14:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31114 invoked by uid 111); 4 Oct 2018 22:13:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Oct 2018 18:13:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2018 18:14:06 -0400
Date:   Thu, 4 Oct 2018 18:14:06 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     l.s.r@web.de, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 2/5] fetch-pack: load tip_oids eagerly iff needed
Message-ID: <20181004221406.GB28287@sigill.intra.peff.net>
References: <9f51ac28-73e9-2855-c650-7d695945e286@web.de>
 <20181004213813.158688-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181004213813.158688-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 04, 2018 at 02:38:13PM -0700, Jonathan Tan wrote:

> > -		if ((allow_unadvertised_object_request &
> > -		     (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1)) ||
> > -		    tip_oids_contain(&tip_oids, unmatched, newlist,
> > -				     &ref->old_oid)) {
> > +		if (!strict || oidset_contains(&tip_oids, &ref->old_oid)) {
> >  			ref->match_status = REF_MATCHED;
> >  			*newtail = copy_ref(ref);
> >  			newtail = &(*newtail)->next;
> 
> I don't think the concerns are truly separated - the first loop quoted
> needs to know that in the second loop, tip_oids is accessed only if
> there is at least one unmatched ref. Would it be better to expose the
> size of the oidset and then use it in place of
> "tip_oids->map.map.tablesize"? Checking for initialization (using
> "tablesize") is conceptually different from checking the size, but in
> this code, both initialization and the first increase in size occur upon
> the first oidset_insert(), so we should still get the same result.

Yes, I agree with you that the loops are still entwined. They're at
least now in a single function, though, which IMHO is a slight
improvement.

I agree with you that just checking:

  if (oidset_count() != 0)

would be fine, too. Or I am even OK with leaving the existing tablesize
check. It is a little intimate with the implementation details, but I
suspect that if oidset were to change (e.g., to initialize the buckets
immediately), the problem would be pretty apparent in the tests.

And in fact, we can test by just changing the conditional in
tip_oid_contains to if(0), which quite clearly fails t5500.60 (along
with others).

So I don't think it's the end of the world to leave it (but I also am
not opposed to the other options discussed).

-Peff
