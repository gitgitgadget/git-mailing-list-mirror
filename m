From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] revision: insert unsorted, then sort in
 prepare_revision_walk()
Date: Mon, 2 Apr 2012 16:37:28 -0400
Message-ID: <20120402203728.GB26503@sigill.intra.peff.net>
References: <201203291818.49933.mfick@codeaurora.org>
 <201204021024.49706.mfick@codeaurora.org>
 <CAJo=hJshOBg4pT8nuWZ=eZvj=E9x+4b9M_EANa=02x=NFW2OfQ@mail.gmail.com>
 <201204021049.04901.mfick@codeaurora.org>
 <CAJo=hJsprQtjDChtrSMcne+OCeUx=NVxLHs3k_qnYLzO=aQWuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Shawn Pearce <sop@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 02 22:37:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEo0O-0002CS-7m
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 22:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029Ab2DBUha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 16:37:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43520
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944Ab2DBUha (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 16:37:30 -0400
Received: (qmail 20970 invoked by uid 107); 2 Apr 2012 20:37:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Apr 2012 16:37:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Apr 2012 16:37:28 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJsprQtjDChtrSMcne+OCeUx=NVxLHs3k_qnYLzO=aQWuw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194556>

On Mon, Apr 02, 2012 at 09:51:21AM -0700, Shawn O. Pearce wrote:

> Probably. But we tend to hate caches in Git because they can get stale
> and need to be rebuilt, and are redundant with the base data. The
> mythical "pack v4" work was going to approach this problem by storing
> the commit timestamps uncompressed in a more machine friendly format.
> Unfortunately the work has been stalled for years.

I'd love for packv4 to exist, but even once it does, it comes with its
own complications for network transfer (since we will have to translate
to/from packv2 on the wire).

Has anyone looked seriously at a new index format that stores the
redundant information in a more easily accessible way? It would increase
our disk usage, but for something like linux-2.6, only by 10MB per
32-bit word. On most of my systems I would gladly spare some extra RAM
for the disk cache if it meant I could avoid inflating a bunch of
objects. And this could easily be made optional for systems that don't
want to make the tradeoff (if it's not there, you fall back to the
current procedure; we could even store the data in a separate file to
retain indexv2 compatibility).

So it's sort-of a cache, in that it's redundant with the actual data.
But staleness and writing issues are a lot simpler, since it only gets
updated when we index the pack (and the pack index in general is a
similar concept; we are "caching" the location of the object in the
packfile, rather than doing a linear search to look it up each time).

-Peff
