Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C66E81F404
	for <e@80x24.org>; Tue, 19 Dec 2017 11:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762400AbdLSLtM (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 06:49:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:43006 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1762392AbdLSLtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 06:49:09 -0500
Received: (qmail 1970 invoked by uid 109); 19 Dec 2017 11:49:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Dec 2017 11:49:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1389 invoked by uid 111); 19 Dec 2017 11:49:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 19 Dec 2017 06:49:34 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Dec 2017 06:49:06 -0500
Date:   Tue, 19 Dec 2017 06:49:06 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: introduce prepare_revision_walk_extended()
Message-ID: <20171219114906.GB24558@sigill.intra.peff.net>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <20171218151043.GA9449@sigill.intra.peff.net>
 <39581cd0-0bfd-c8d1-642b-1245cf425ab4@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39581cd0-0bfd-c8d1-642b-1245cf425ab4@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 18, 2017 at 08:18:19PM +0100, René Scharfe wrote:

> > The root of the matter is that the revision-walking code doesn't clean
> > up after itself. In every case, the caller is just saving these to clean
> > up commit marks, isn't it?
> 
> bundle also checks if the pending objects exists.

Thanks, I missed that one. So just adding a feature to clean up commit
marks wouldn't be sufficient to cover that case.

> > That sidesteps all of the memory ownership issues by just creating a
> > copy. That's less efficient, but I'd be surprised if it matters in
> > practice (we tend to do one or two revisions per process, there don't
> > tend to be a lot of pending tips, and we're really just talking about
> > copying some pointers here).
> [...]
> I don't know if there can be real-world use cases with millions of
> entries (when it would start to hurt).

I've seen repos which have tens of thousands of tags. Something like
"rev-list --all" would have tens of thousands of pending objects.
I think in practice it's limited to the number of objects (though in
practice more like the number of commits).

I'd note also that for most uses we don't need a full object_array. You
really just need a pointer to the "struct object" to wipe its flags.

So there we might waste 8 bytes per object in the worst case. But bear
in mind that the process is wasting a lot more than that per "struct
commit" that we're holding. And versus the existing scheme, it's only
for the moment until prepare_revision_walk() frees the old pending list.

> Why does prepare_revision_walk() clear the list of pending objects at
> all?  Assuming the list is append-only then perhaps remembering the
> last handled index would suffice.

I assume it was mostly to clean up after itself, since there's no
explicit "I'm done with the traversal" function. But as I said earlier,
I'd be surprised of a revision walk doesn't leave some allocated cruft
in rev_info these days (e.g., pathspec cruft). In practice it doesn't
matter much because we don't do arbitrary numbers of traversals in
single process.

-Peff
