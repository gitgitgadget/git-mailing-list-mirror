From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Fix notes handling in rev-list
Date: Thu, 19 Jul 2012 07:35:35 -0400
Message-ID: <20120719113535.GA29774@sigill.intra.peff.net>
References: <20120325005504.GA27651@sigill.intra.peff.net>
 <1342463409-6919-1-git-send-email-jukka.lehtniemi@gmail.com>
 <20120717034640.GB20945@sigill.intra.peff.net>
 <7vvchnx7tc.fsf@alter.siamese.dyndns.org>
 <20120718072104.GB12942@sigill.intra.peff.net>
 <7vhat4wv6h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jukka Lehtniemi <jukka.lehtniemi@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 13:35:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Srp1J-0005CP-Eh
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 13:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359Ab2GSLfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 07:35:44 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:41669
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701Ab2GSLfm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 07:35:42 -0400
Received: (qmail 28214 invoked by uid 107); 19 Jul 2012 11:35:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jul 2012 07:35:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2012 07:35:35 -0400
Content-Disposition: inline
In-Reply-To: <7vhat4wv6h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201731>

On Wed, Jul 18, 2012 at 03:39:34PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So leaving aside the --graph issues, we would need to decide what to
> > show in the non-graph case. And I think your suggestion is good; there
> > is no real need to dereference the blob (if you want that, you can turn
> > on the pretty-printer).
> >
> > I'm just not sure what the output should be. I guess:
> >
> >   <commit_sha1> <notes sha1s>
> >
> > is probably the most sensible (it's sort of like --parents). And that
> > solves the --graph issue, too, since it continues to take only a single
> > line.
> 
> Surely.  "rev-list --parents --notes" would still be usable that
> way, as a reader that requests such a combination is prepared to
> tell commits (i.e. parents) and blobs (i.e. notes) apart.

I don't think we forbid non-blob values in notes trees, so technically
there could be some ambiguity. I doubt it is a big problem in practice
(especially since I haven't even heard of a good use case yet for "git
rev-list --notes", let alone "git rev-list --notes --parents"). But now
would be the time to avoid a crappy format that we will be stuck with
later.

Unlike elements of the commit object itself, like --parents or
--timestamp, notes do not really gain any efficiency by being printed as
part of the traversal. So modulo the cost of piping the list of commits,
it would not really be any more efficient than "git rev-list | git notes
list --stdin" (except that the latter does not take a --stdin argument,
but could easily do so). And the latter is way more flexible.

So for plumbing, I think this is the wrong direction, anyway. The real
value of this patch is that the pretty-printed code path would work more
like git-log (especially the "%N" format, which lets callers make their
own micro-format for specifying all the bits they are interested in).

Maybe the best thing is to simply disallow --notes when not using a
pretty-printed format.

-Peff
