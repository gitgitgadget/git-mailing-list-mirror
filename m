From: Jeff King <peff@peff.net>
Subject: Re: jk/tag-contains (Re: What's cooking in git.git (Jul 2010, #05;
 Wed, 28))
Date: Thu, 5 Aug 2010 15:35:45 -0400
Message-ID: <20100805193545.GA10630@sigill>
References: <7vvd7zuecv.fsf@alter.siamese.dyndns.org>
 <20100730183709.GC18544@coredump.intra.peff.net>
 <20100731060703.GA21207@burratino>
 <20100731123328.GA5273@coredump.intra.peff.net>
 <7vocdlpsmw.fsf@alter.siamese.dyndns.org>
 <20100805175640.GB15760@sigill>
 <7vd3twex76.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 21:35:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh6EL-0006Se-Ms
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 21:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933329Ab0HETft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 15:35:49 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:48808 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759186Ab0HETfs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 15:35:48 -0400
Received: (qmail 30319 invoked by uid 111); 5 Aug 2010 19:35:47 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.116)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 05 Aug 2010 19:35:47 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Aug 2010 15:35:45 -0400
Content-Disposition: inline
In-Reply-To: <7vd3twex76.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152707>

On Thu, Aug 05, 2010 at 11:22:37AM -0700, Junio C Hamano wrote:

> > That's basically a finer-grained version of what I implemented. Mine
> > finds the _worst_ skew for the whole graph, and never lets you optimize
> > a traversal cutoff more than that skew. So it is nicely bounded
> > space-wise, as it is always a single integer, but you waste effort on
> > the entire traversal because a couple of commits are skewed. Yours
> > optimizes perfectly, but needs O(skewed commits) storage. Which is
> > probably a better tradeoff when the number of skewed commits is tiny
> > (which is what we expect).
> 
> One thing missing from the above equation is that O(skewed commits)
> approach will need O(number of commits) look-ups in the skew database (be
> it a notes tree or whatever), only to make sure that most of the look-ups
> say "no timestamp tweak required".  So I think the global single integer
> approach you took would probably be better in the overall picture.

I'm not sure it is that bad. Shouldn't it have the same number of
lookups as this scenario:

  # pretend we have some fake timestamps
  for i in 20 40 60; do
    git notes add -m "fake timestamp" HEAD~$i
  done

  # now time it without notes
  time git log --pretty=raw --no-notes >/dev/null

  # and with notes
  time git log --pretty=raw --show-notes >/dev/null

For me, the timing differences are lost in the noise. So perhaps the
lookup isn't all that expensive compared to the actual traversal.

-Peff
