From: Jeff King <peff@peff.net>
Subject: Re: Extremely slow progress during 'git reflog expire --all'
Date: Tue, 6 Apr 2010 02:02:17 -0400
Message-ID: <20100406060217.GF3901@coredump.intra.peff.net>
References: <201004022154.14793.elendil@planet.nl>
 <201004022350.20999.elendil@planet.nl>
 <20100402224100.GA997@coredump.intra.peff.net>
 <201004031629.01970.elendil@planet.nl>
 <20100403203507.GA12262@coredump.intra.peff.net>
 <7vy6h36pt1.fsf@alter.siamese.dyndns.org>
 <20100405062621.GA30934@coredump.intra.peff.net>
 <7v1vetpw63.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Frans Pop <elendil@planet.nl>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 08:02:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz1s0-0007iW-4d
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 08:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443Ab0DFGCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 02:02:36 -0400
Received: from peff.net ([208.65.91.99]:47869 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751926Ab0DFGCe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 02:02:34 -0400
Received: (qmail 3321 invoked by uid 107); 6 Apr 2010 06:03:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 06 Apr 2010 02:03:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Apr 2010 02:02:17 -0400
Content-Disposition: inline
In-Reply-To: <7v1vetpw63.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144101>

On Mon, Apr 05, 2010 at 11:54:28AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Hmm. It looks like mark_reachable() stops traversing when it hits a
> > commit older than expire_total. I imagine that's to avoid going all the
> > way to the roots. But if we hit any unreachable entry, in_merge_bases()
> > is going to have to go all the way to the roots, anyway.
> 
> Yeah, an alternative is to keep the list of commits where the initial
> mark_reachable() run stopped, and instead of doing in_merge_bases(),
> lazily restart the traversal all the way down to root, and then rely
> solely on the REACHABLE bit from then on.

Ah, yeah, that is much more clever. It has the same worst case
performance as what I proposed, but is much more optimistic that we
won't have to do it at all.

> > I wonder if, in addition to your patch, we should remove the
> > double-check in_merge_bases and simply report those old ones as
> > reachable. We may be wrong, but we are erring on the side of keeping
> > entries, and they will eventually expire in the regular cycle (i.e., 90
> > days instead of 30).
> >
> > All of that being said, your patch does drop Frans' case down to about
> > 1s of CPU time, so perhaps it is not worth worrying about beyond that.
> 
> I think a reasonable solution would be along the lines you described, but
> the patch you are responding to does err on the wrong side when a clock
> skew is there.  Does it matter?  Probably not.

True. With the technique you mentioned above, you would reverse your
test and do:

  if (flags & REACHABLE)
    return 0;
  if (expanded_reachable_to_root)
    return 1; /* we know it's not */
  expand_reachable_to_root();
  return !(flags & REACHABLE);

I don't think I care enough to do a patch, though. I don't have a
problem with you applying what you posted earlier.

-Peff
