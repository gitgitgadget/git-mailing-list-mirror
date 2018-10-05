Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5FAC1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 20:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeJFD17 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 23:27:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:43848 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728170AbeJFD16 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 23:27:58 -0400
Received: (qmail 27524 invoked by uid 109); 5 Oct 2018 20:27:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Oct 2018 20:27:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16180 invoked by uid 111); 5 Oct 2018 20:26:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Oct 2018 16:26:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Oct 2018 16:27:37 -0400
Date:   Fri, 5 Oct 2018 16:27:37 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 2/5] fetch-pack: load tip_oids eagerly iff needed
Message-ID: <20181005202737.GA22460@sigill.intra.peff.net>
References: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
 <14e57ec8-b8a2-10bd-688d-1cb926e77675@web.de>
 <9f51ac28-73e9-2855-c650-7d695945e286@web.de>
 <20181004220711.GA28287@sigill.intra.peff.net>
 <c75fa650-d2b4-9979-a1f2-25d75c6f447b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c75fa650-d2b4-9979-a1f2-25d75c6f447b@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 05, 2018 at 10:13:34PM +0200, René Scharfe wrote:

> >> -{
> >> -	/*
> >> -	 * Note that this only looks at the ref lists the first time it's
> >> -	 * called. This works out in filter_refs() because even though it may
> >> -	 * add to "newlist" between calls, the additions will always be for
> >> -	 * oids that are already in the set.
> >> -	 */
> > 
> > I don't think the subtle point this comment is making goes away. We're
> > still growing the list in the loop that calls tip_oids_contain() (and
> > which now calls just oidset_contains). That's OK for the reasons given
> > here, but I think that would need to be moved down to this code:
> > 
> >> +	if (strict) {
> >> +		for (i = 0; i < nr_sought; i++) {
> >> +			ref = sought[i];
> >> +			if (!is_unmatched_ref(ref))
> >> +				continue;
> >> +
> >> +			add_refs_to_oidset(&tip_oids, unmatched);
> >> +			add_refs_to_oidset(&tip_oids, newlist);
> >> +			break;
> >> +		}
> >> +	}
> > 
> > I.e., we need to say here why it's OK to summarize newlist in the
> > oidset, even though we're adding to it later.
> 
> There is already this comment:
> 
> 	/* Append unmatched requests to the list */
> 
> And that's enough in my eyes.  The refs loop at the top splits the list
> into matched ("the list") and unmatched, and the loop below said comment
> adds a few more.  I see no subtlety left -- what do I miss?

It looks like tip_oids is meant as a fast lookup into what's in
unmatched and newlist. But in the second loop we continue appending to
newlist. Why is it OK that we do not update tip_oids when we do so?

I.e., something like this explains it:

diff --git a/fetch-pack.c b/fetch-pack.c
index 53914563b5..c0a1b80f4c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -606,6 +606,12 @@ static void filter_refs(struct fetch_pack_args *args,
 			ref->match_status = REF_MATCHED;
 			*newtail = copy_ref(ref);
 			newtail = &(*newtail)->next;
+			/*
+			 * No need to update tip_oids with ref->old_oid; we got
+			 * here because either it was already there, or we are
+			 * in !strict mode, in which case we do not use
+			 * tip_oids at all.
+			 */
 		} else {
 			ref->match_status = REF_UNADVERTISED_NOT_ALLOWED;
 		}
