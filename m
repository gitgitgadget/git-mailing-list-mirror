Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3D301F404
	for <e@80x24.org>; Mon, 26 Feb 2018 01:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeBZBiZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 20:38:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:36728 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751929AbeBZBiY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 20:38:24 -0500
Received: (qmail 12460 invoked by uid 109); 26 Feb 2018 01:38:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Feb 2018 01:38:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8650 invoked by uid 111); 26 Feb 2018 01:39:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 25 Feb 2018 20:39:12 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Feb 2018 20:38:22 -0500
Date:   Sun, 25 Feb 2018 20:38:22 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] revision.c: reduce object database queries
Message-ID: <20180226013822.GA9385@sigill.intra.peff.net>
References: <1519522496-73090-1-git-send-email-dstolee@microsoft.com>
 <20180226013048.GA8677@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180226013048.GA8677@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 25, 2018 at 08:30:48PM -0500, Jeff King wrote:

> > diff --git a/revision.c b/revision.c
> > index 5ce9b93..bc7def5 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -113,7 +113,8 @@ void mark_parents_uninteresting(struct commit *commit)
> >  			 * it is popped next time around, we won't be trying
> >  			 * to parse it and get an error.
> >  			 */
> > -			if (!has_object_file(&commit->object.oid))
> > +			if (!commit->object.parsed &&
> > +			    !has_object_file(&commit->object.oid))
> >  				commit->object.parsed = 1;
> 
> We don't actually need the object contents at all right here. This is
> just faking the "parsed" flag for later so that calls to parse_object()
> don't barf.
> 
> This code comes originally form 454fbbcde3 (git-rev-list: allow missing
> objects when the parent is marked UNINTERESTING, 2005-07-10). But later,
> in aeeae1b771 (revision traversal: allow UNINTERESTING objects to be
> missing, 2009-01-27), we marked dealt with calling parse_object() on the
> parents more directly.
> 
> So what I wonder is whether this code is simply redundant and can go
> away entirely. That would save the has_object_file() call in all cases.

There's a similar case for trees. In mark_tree_contents_uninteresting()
we do:

   if (!has_object_file(&obj->oid))
	return;
   if (parse_tree(tree) < 0)
	die("bad tree %s", oid_to_hex(&obj->oid));

which seems wasteful. Probably this could be:

  if (parse_tree_gently(tree, 1) < 0)
	return; /* missing uninteresting trees ok */

though technically the existing code allows _missing_ trees, but
not on corrupt ones.

I guess this is perhaps less interesting, because we only mark trees
directly fed from the pending array, not every tree of commits that we
traverse. Though if you had a really gigantic tree, it might be
measurable.

-Peff
