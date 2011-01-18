From: Jeff King <peff@peff.net>
Subject: Re: gitk "find commit adding/removing string"/possible pickaxe bug?
Date: Tue, 18 Jan 2011 15:50:40 -0500
Message-ID: <20110118205040.GA20970@sigill.intra.peff.net>
References: <514EB3AA-CD31-4BDB-B777-B7AAEEDF5663@sebastianhahn.net>
 <201101181744.18139.trast@student.ethz.ch>
 <20110118185027.GA10562@sigill.intra.peff.net>
 <201101182139.28808.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sebastian Hahn <mail@sebastianhahn.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 18 21:51:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfIW7-0004A0-Im
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 21:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab1ARUuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 15:50:44 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54306 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753388Ab1ARUun (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 15:50:43 -0500
Received: (qmail 31996 invoked by uid 111); 18 Jan 2011 20:50:42 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 18 Jan 2011 20:50:42 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Jan 2011 15:50:40 -0500
Content-Disposition: inline
In-Reply-To: <201101182139.28808.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165216>

On Tue, Jan 18, 2011 at 09:39:28PM +0100, Thomas Rast wrote:

> So indeed
> 
>   git log -Squux -c -p
> 
> gives a combined diff.  But OTOH
> 
>   git log -Sbar -c -p
> 
> doesn't; it only gives a diff for the commit that introduced 'bar'.  I
> guess this makes sense: -S notices that the number of 'bar's is
> actually the same as in *one* merge parent, hence the merge cannot be
> all that interesting.  OTOH it still shows the merge commit in the
> history, which is a bit strange.  --pickaxe-all does not make a
> difference either;

Hrm. What I expected[1] to happen would be for the diff machinery to
look at each filepair individually, one of them to trigger -S, which
shows the commit, and then to fail to produce a combined diff because we
threw away the other uninteresting filepair. But in that case,
--pickaxe-all _should_ show something, as its point is to keep all of
the filepairs.  And that's clearly not happening.

So now I don't know what's going on. I'll try to trace through the diff
machinery and see if that gives a clue.

-Peff

[1] That's what I expect, but not necessarily what I want. I think what
I would want is for it to do a token count of the merge commit, and if
it fails to match _every_ parent, then it it interesting. Otherwise, the
content presumably came from that parent.
