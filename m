From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] commit: use a priority queue in merge base functions
Date: Thu, 30 Aug 2012 09:03:27 -0400
Message-ID: <20120830130327.GB5687@sigill.intra.peff.net>
References: <20120829110812.GA14069@sigill.intra.peff.net>
 <20120829111147.GB14734@sigill.intra.peff.net>
 <7vtxvlwt7o.fsf@alter.siamese.dyndns.org>
 <20120829205332.GA16064@sigill.intra.peff.net>
 <20120829205525.GA28696@sigill.intra.peff.net>
 <20120829210032.GA29179@sigill.intra.peff.net>
 <20120829210540.GA31756@sigill.intra.peff.net>
 <20120830125421.GA5687@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 15:03:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T74PJ-00067r-PE
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 15:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781Ab2H3NDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 09:03:31 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48128 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327Ab2H3NDa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 09:03:30 -0400
Received: (qmail 9038 invoked by uid 107); 30 Aug 2012 13:03:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 30 Aug 2012 09:03:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2012 09:03:27 -0400
Content-Disposition: inline
In-Reply-To: <20120830125421.GA5687@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204535>

On Thu, Aug 30, 2012 at 08:54:21AM -0400, Jeff King wrote:

> On Wed, Aug 29, 2012 at 05:05:40PM -0400, Jeff King wrote:
> 
> > You would want this on top:
> > [...]
> > but t6024 still fails (it clearly is finding a different merge base than
> > the test expects).  I'll trace through it, but it will have to be later
> > tonight.
> 
> The problem in t6024 is caused by the fact that the commit timestamps
> for every commit are identical.

So I was able to have my queue behave just like commit_list by fixing
the stability issue. But I still have no clue what is going on in t6024.
It does this for each commit it makes:

  [...]
  GIT_AUTHOR_DATE="2006-12-12 23:00:00" git commit -m 1 a1 &&
  [...]
  GIT_AUTHOR_DATE="2006-12-12 23:00:01" git commit -m A a1 &&
  [...]

which is just bizarre. At first I thought it was buggy, and that it
really wanted to be setting COMMITTER_DATE (in which case it should
really just be using test_tick, anyway). But if you do that, the test
fails (even using a regular commit_list)!

So is the test buggy? Or are the identical commit timestamps part of the
intended effect? I can't see how that would be, since:

  1. You would need to set COMMITTER_DATE for that anyway, as you are
     otherwise creating a race condition.

  2. Why would you set AUTHOR_DATE? It's not used by the merge code at
     all.

The script originally comes from here:

  http://thread.gmane.org/gmane.comp.version-control.git/33566/focus=33852

and the discussion implies that the AUTHOR_DATEs were added to avoid a
race condition with the timestamps. But why would that ever have worked?

Confused...

-Peff
