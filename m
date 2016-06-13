From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] repack --keep-unreachable
Date: Mon, 13 Jun 2016 00:33:14 -0400
Message-ID: <20160613043313.GA29422@sigill.intra.peff.net>
References: <20160612212514.GA4584@gmail.com>
 <20160612213804.GA5428@sigill.intra.peff.net>
 <20160612215436.GB4584@gmail.com>
 <20160612221309.GC5428@sigill.intra.peff.net>
 <C04883EB-2170-47C3-94E7-AE13516FD0C0@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nasser Grainawi <nasser@codeaurora.org>
X-From: git-owner@vger.kernel.org Mon Jun 13 06:33:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCJYv-0006Es-A1
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 06:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbcFMEdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 00:33:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:53584 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753484AbcFMEdR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 00:33:17 -0400
Received: (qmail 23385 invoked by uid 102); 13 Jun 2016 04:33:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 00:33:16 -0400
Received: (qmail 9985 invoked by uid 107); 13 Jun 2016 04:33:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 00:33:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jun 2016 00:33:14 -0400
Content-Disposition: inline
In-Reply-To: <C04883EB-2170-47C3-94E7-AE13516FD0C0@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297149>

On Sun, Jun 12, 2016 at 07:43:27PM -0600, Nasser Grainawi wrote:

> On Jun 12, 2016, at 4:13 PM, Jeff King <peff@peff.net> wrote:
> > 
> >    At GitHub we actually have a patch to `repack` that keeps all
> >    objects, reachable or not, in the pack, and use it for all of our
> >    automated maintenance. Since we don't drop objects at all, we can't
> >    ever have such a race. Aside from some pathological cases, it wastes
> >    much less space than you'd expect. We turn the flag off for special
> >    cases (e.g., somebody has rewound history and wants to expunge a
> >    sensitive object).
> > 
> >    I'm happy to share the "keep everything" patch if you're interested.
> 
> We have the same kind of patch actually (for the same reason), but
> back on the shell implementation of repack. It'd be great if you could
> share your modern version.

Here is a cleaned-up version of what we run at GitHub (so this is a
concept that has been exercised for a few years in production, but I had
to forward port the patches a bit; I _probably_ didn't introduce any
bugs. :) ).

The heavy lifting is done by the existing --keep-unreachable option to
pack-objects, which Junio added a long time ago[1] in support of a safer
"gc --auto". But it doesn't look like we ever documented or exercised
it, and "gc --auto" ended up using the loosen-unreachable strategy
instead. In fact, the rest of that series seems to have been dropped; I
couldn't find any discussion on the list explaining it, or why this one
patch was kept (so I don't think anybody upstream has ever used this
code, but as I said, we have been doing so for a few years, so I feel
confident in it).

  [1/3]: repack: document --unpack-unreachable option
  [2/3]: repack: add --keep-unreachable option
  [3/3]: repack: extend --keep-unreachable to loose objects

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/58413
