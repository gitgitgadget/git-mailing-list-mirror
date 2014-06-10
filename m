From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/15] do not create "struct commit" with xcalloc
Date: Tue, 10 Jun 2014 17:49:11 -0400
Message-ID: <20140610214911.GB19107@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
 <20140609181008.GC20315@sigill.intra.peff.net>
 <xmqqbnu08n2j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 23:49:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuTuu-0003ti-Tk
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbaFJVtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 17:49:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:41467 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753168AbaFJVtM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:49:12 -0400
Received: (qmail 20409 invoked by uid 102); 10 Jun 2014 21:49:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 16:49:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 17:49:11 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbnu08n2j.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251265>

On Tue, Jun 10, 2014 at 02:35:48PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > In both blame and merge-recursive, we sometimes create a
> > "fake" commit struct for convenience (e.g., to represent the
> > HEAD state as if we would commit it). By allocating
> > ourselves rather than using alloc_commit_node, we do not
> > properly set the "index" field of the commit. This can
> > produce subtle bugs if we then use commit-slab on the
> > resulting commit, as we will share the "0" index with
> > another commit.
> 
> The change I see here is all good, but I wonder if it is too late to
> start the real index from 1 and catch anything that has 0 index with
> a BUG("do not hand-allocate a commit").

Yeah, I had a similar thought while writing the series. I do not think
it is too late at all. It would just waste one commit's worth of memory
in the slab, but that is not a big deal. Other than slab_at, no callers
should care.

It would cost an extra conditional in each call to slab_at. That
probably doesn't matter, though the original goal was to make slab_at as
fast as an indirect pointer dereference (it's not quite these days,
though, as we have to do a little division to find the right section of
the slab).

-Peff
