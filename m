From: Jeff King <peff@peff.net>
Subject: Re: Multiple fetches when unshallowing a shallow clone
Date: Fri, 4 Dec 2015 16:51:58 -0500
Message-ID: <20151204215158.GA27987@sigill.intra.peff.net>
References: <CACs8u9STLLHr3c3O9kQKGEN52DLfJ2LatjWkeaeeLA-xP=gC5Q@mail.gmail.com>
 <CAGZ79ka=RxVZ49D0wkqTRqspKb=Ce5Ay01muBt_Gk6_rDbH6KA@mail.gmail.com>
 <20151204212712.GA22493@sigill.intra.peff.net>
 <CACs8u9Qvqn4KDMKo+RHsQaf+dw+CGtWrOpoUJzaZAqD1rFRiuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jason Paller-Rzepka <jasonpr@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 22:52:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4yGz-0001sY-LN
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 22:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756795AbbLDVwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 16:52:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:37544 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756789AbbLDVwC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 16:52:02 -0500
Received: (qmail 6718 invoked by uid 102); 4 Dec 2015 21:52:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Dec 2015 15:52:01 -0600
Received: (qmail 29041 invoked by uid 107); 4 Dec 2015 21:52:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Dec 2015 16:52:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Dec 2015 16:51:58 -0500
Content-Disposition: inline
In-Reply-To: <CACs8u9Qvqn4KDMKo+RHsQaf+dw+CGtWrOpoUJzaZAqD1rFRiuw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282011>

On Fri, Dec 04, 2015 at 04:38:16PM -0500, Jason Paller-Rzepka wrote:

> It appears that it happens when the shallow history grows to include a
> commit that's pointed to by a previously unseen tag.  For example,
> when I deepen a checkout of git to depth 8, I hit v2.5.2, and a second
> fetch takes place.

Yeah. The code is in builtin/fetch.c:backfill_tags.

> But why would fetching a tag (or set of tags) merit a depth of zero?
> Doesn't depth 1 mean "give me the the objects, and none of their
> descendants"?  Why use 0?

That comes from this line:

  transport_set_option(transport, TRANS_OPT_DEPTH, "0");

That line blame back to b888d61 (Make fetch a builtin, 2007-09-10),
which isn't incredibly helpful.

I think that comes from the original git-fetch.sh, which had:

  ?*)
          # do not deepen a shallow tree when following tags
          shallow_depth=

Which makes sense. I think the code at that point is not aware that we
just "unshallowed" and can therefore drop the depth parameter
altogether. But I admit I am not all that familiar with the shallow
code.

+cc Duy, who can probably say something way more intelligent about this
off the top of his head. :)

-Peff
