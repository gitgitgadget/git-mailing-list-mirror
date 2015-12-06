From: Jeff King <peff@peff.net>
Subject: Re: Multiple fetches when unshallowing a shallow clone
Date: Sun, 6 Dec 2015 01:37:19 -0500
Message-ID: <20151206063718.GA549@sigill.intra.peff.net>
References: <CACs8u9STLLHr3c3O9kQKGEN52DLfJ2LatjWkeaeeLA-xP=gC5Q@mail.gmail.com>
 <CAGZ79ka=RxVZ49D0wkqTRqspKb=Ce5Ay01muBt_Gk6_rDbH6KA@mail.gmail.com>
 <20151204212712.GA22493@sigill.intra.peff.net>
 <CACs8u9Qvqn4KDMKo+RHsQaf+dw+CGtWrOpoUJzaZAqD1rFRiuw@mail.gmail.com>
 <20151204215158.GA27987@sigill.intra.peff.net>
 <xmqqh9jxrfy5.fsf@gitster.mtv.corp.google.com>
 <CACsJy8BSNm6=E6Mo6etv_Lvdd2kpqQ7EEMBAoP-AQraYy3xU8w@mail.gmail.com>
 <xmqqmvtons4j.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jason Paller-Rzepka <jasonpr@google.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 07:38:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5SxL-0005Bo-TZ
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 07:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbbLFGhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 01:37:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:37860 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750905AbbLFGhX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 01:37:23 -0500
Received: (qmail 5283 invoked by uid 102); 6 Dec 2015 06:37:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 06 Dec 2015 00:37:23 -0600
Received: (qmail 7958 invoked by uid 107); 6 Dec 2015 06:37:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 06 Dec 2015 01:37:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Dec 2015 01:37:19 -0500
Content-Disposition: inline
In-Reply-To: <xmqqmvtons4j.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282042>

On Sat, Dec 05, 2015 at 08:00:28PM -0800, Junio C Hamano wrote:

> > I suppose followtags feature has been around long enough that we can
> > simply trust that and skip the second fetch?
> 
> Hmmmm, I wonder why the code needs the backfill fetch while talking
> to a server that has the include-tag capability, then?

The logic in find_non_local_tags makes no sense to me.

After we do the first fetch, we call this function to find out if there
are any tags we need to pick up. We iterate through the list of refs
given to us by the remote (including peeled lines), and do:

        if (ends_with(ref->name, "^{}")) {
                if (item && !has_sha1_file(ref->old_sha1) &&
                    !will_fetch(head, ref->old_sha1) &&
                    !has_sha1_file(item->util) &&
                    !will_fetch(head, item->util))
                        item->util = NULL;
                ...
        }

where "ref" is the peeled line (i.e., the pointed-to commit), and "item"
is the preceding line (i.e., the tag itself) with util set to its sha1.
Any such item whose util survives as non-NULL is fetched in the backfill
step.

So I'd think the logic for backfilling a given tag should be:

  1. We have the peeled object, and...

  2. We don't currently have the tag pointing to it, and...

  3. We are not already going to fetch it.

You could write that as:

  if (has_sha1_file(ref->old_sha1) &&
      !has_sha1_file(item->util) &&
      !will_fetch(head, item->util))

Of course the conditional in the code is "should we skip the backfill",
the negation. So using De Morgan's laws, we'd write:

  if (!has_sha1_file(ref->old_sha1) ||
      has_sha1_file(item->util) ||
      will_fetch(head, item->util))

Which is quite a bit different than what is there. I'm not sure at all
what the "will_fetch(head, ref->old_sha1)" is doing. In fact, for the
backfill step, it looks like we feed an empty "head" list, so the
!will_fetch() is always true.

And indeed, replacing the logic with what I wrote does make the backfill
go away in my test case. But it's so far from what is there that I feel
like I must be missing something.

-Peff
