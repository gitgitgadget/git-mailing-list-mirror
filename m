From: Jeff King <peff@peff.net>
Subject: Re: libreoffice merge issue ...
Date: Fri, 29 Apr 2011 08:55:05 -0400
Message-ID: <20110429125505.GA4540@sigill.intra.peff.net>
References: <1297699635.31477.253.camel@lenovo-w500>
 <20110215094546.GA25530@sigill.intra.peff.net>
 <7vaahxp250.fsf@alter.siamese.dyndns.org>
 <20110216025726.GC7085@sigill.intra.peff.net>
 <7vfwrnis50.fsf@alter.siamese.dyndns.org>
 <20110421140132.GA6696@brouette>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Damien Wyart <damien.wyart@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 14:55:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFnE7-0007wk-Ov
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 14:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756133Ab1D2MzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 08:55:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38757
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755472Ab1D2MzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 08:55:09 -0400
Received: (qmail 12626 invoked by uid 107); 29 Apr 2011 12:56:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Apr 2011 08:56:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2011 08:55:05 -0400
Content-Disposition: inline
In-Reply-To: <20110421140132.GA6696@brouette>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172451>

On Thu, Apr 21, 2011 at 04:01:32PM +0200, Damien Wyart wrote:

> * Junio C Hamano <gitster@pobox.com> [2011-02-16 13:30]:
> > Yeah, the reverted 83c9031 (unpack_trees(): skip trees that are the
> > same in all input, 2010-12-22) also seems to have seriously broken
> > intermediate merge merge-recursive makes. I actually recall scratching
> > my head when I made 00e6ee7 (Merge branch 'maint', 2011-02-11) that
> > was causing add/add conflict when it shouldn't. It turns out that
> > quite a lot of entries were missing in contrib/ area from the virtual
> > common ancestry tree synthesized by merge-recursive that called into
> > the botched unpack_trees()---it of course would result in add/add
> > conflict if a merge is done using such a tree as the common.
> 
> > No, I haven't had a chance nor energy to dig further than what
> > I reported above.
> 
> Out of curiosity, I would like to know if digging further into this
> issue is still on your TODO list. I feel understanding exactly what was
> wrong in 83c9031 would be interesting ; having just the revert is a bit
> frustrating.
> 
> The initial optimization in 83c9031 seemed right at first glance, so
> I would be interesting in having a more final answer to this.

I didn't dig further, but looking at 83c9031 with a fresh set of eyes, I
think that merge-recursive falls under the "exceptions" that Junio
listed in the commit message. That is, he indicates correctly that we
cannot use this optimization for "reset --hard" or for checking out for
the first time.

Similarly, merge-recursive is going to do many 3-way merges between
trees into an empty index (when merging virtual ancestors), and we need
to unpack those subtrees even if they are all the same.  But given the
conditions added by 83c9031 in unpack-trees.c:fast_forward_merge, I
don't see anything preventing the optimization in how merge-recursive
calls into unpack-trees.

We do a discard_cache() right before doing the 3-way merge for virtual
ancestors. So we will see that there are no entries in our current index
for that directory. That may be a clue that the optimization should not
be used.

-Peff
