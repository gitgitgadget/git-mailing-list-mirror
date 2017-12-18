Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A716E1F424
	for <e@80x24.org>; Mon, 18 Dec 2017 15:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbdLRPKv (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 10:10:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:42186 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752799AbdLRPKu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 10:10:50 -0500
Received: (qmail 7174 invoked by uid 109); 18 Dec 2017 15:10:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Dec 2017 15:10:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26415 invoked by uid 111); 18 Dec 2017 15:11:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 18 Dec 2017 10:11:10 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Dec 2017 10:10:43 -0500
Date:   Mon, 18 Dec 2017 10:10:43 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: introduce prepare_revision_walk_extended()
Message-ID: <20171218151043.GA9449@sigill.intra.peff.net>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 16, 2017 at 01:12:16PM +0100, René Scharfe wrote:

> prepare_revision_walk() allows callers to take ownership of the array of
> pending objects by setting the rev_info flag "leak_pending" and copying
> the object_array "pending".  They use it to clear commit marks after
> setup is done.  This interface is brittle enough that it requires
> extensive comments.
> 
> Provide an easier way by adding a function that can hand over the array
> to a caller-supplied output parameter and converting all users of the
> flag "leak_pending" to call prepare_revision_walk_extended() instead.

I think this is _better_, but it's still kind of a funny interface.

The root of the matter is that the revision-walking code doesn't clean
up after itself. In every case, the caller is just saving these to clean
up commit marks, isn't it?

Could we instead have an interface like:

  revs.clear_commit_marks = 1;
  prepare_revision_walk(&revs);
  ...
  finish_revision_walk(&revs);

where that final function would do any cleanup, including clearing the
commit marks. I suspect there are other small bits that get leaked
because there's not really any "destructor" for a revision walk.

It's not as flexible as this whole "make a copy of the pending tips"
thing, but it keeps all of the details abstracted away from the callers.

Alternatively:

> +`prepare_revision_walk_extended`::
> +
> +	Like prepare_revision_walk(), but allows callers to take ownership
> +	of the array of pending objects by passing an object_array pointer
> +	as the second parameter; passing NULL clears the array.

What if we just got rid of this function and had callers do:

  object_array_copy(&old_pending, &revs);
  prepare_revision_walk(&revs);
  ...
  clear_commit_marks_for_object_array(&old_pending);

That sidesteps all of the memory ownership issues by just creating a
copy. That's less efficient, but I'd be surprised if it matters in
practice (we tend to do one or two revisions per process, there don't
tend to be a lot of pending tips, and we're really just talking about
copying some pointers here).

-Peff
