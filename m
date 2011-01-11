From: Jeff King <peff@peff.net>
Subject: Re: clone breaks replace
Date: Tue, 11 Jan 2011 00:47:35 -0500
Message-ID: <20110111054735.GC10094@sigill.intra.peff.net>
References: <4D262D68.2050804@cfl.rr.com>
 <20110106213338.GA15325@burratino>
 <4D276CD2.60607@cfl.rr.com>
 <20110107205103.GC4629@burratino>
 <4D278930.7010100@cfl.rr.com>
 <20110107214907.GA9194@burratino>
 <20110107220942.GB10343@sigill.intra.peff.net>
 <4D27B33C.2020907@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 06:47:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcX58-00012X-GB
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 06:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469Ab1AKFrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 00:47:40 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55920 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135Ab1AKFri (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 00:47:38 -0500
Received: (qmail 11381 invoked by uid 111); 11 Jan 2011 05:47:37 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 11 Jan 2011 05:47:37 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jan 2011 00:47:35 -0500
Content-Disposition: inline
In-Reply-To: <4D27B33C.2020907@cfl.rr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164910>

On Fri, Jan 07, 2011 at 07:43:40PM -0500, Phillip Susi wrote:

> >Based on previous discussions, I think the answer to the first is no.
> >The resulting repo violates a fundamental assumption of git. Yes,
> >because of the replacement object, many things will still work. But many
> >parts of git intentionally do not respect replacement, and they will be
> >broken.
> 
> What parts do not respect replacement?  More importantly, what parts
> will be broken?  The man page seems to indicate that about the only
> thing that does not by default is reachability testing, which to me
> means fsck and prune.  It seems to be the purpose of replace to
> /prevent/ breakage and be respected by default, unless doing so would
> cause harm, which is why fsck and prune do not.

Off the top of my head, I don't know. I suspect it would take somebody
writing a patch to create such an incomplete repository (or making one
manually) and seeing how badly things broke. Maybe nothing would, and I
am being overly conservative. It just makes me nervous to start
violating what has always been a fundamental assumption about the object
database (though as I pointed out, we did start violating it with
shallow clones, so maybe it is not so bad).

> >Instead, I think of replacements as a specific view into history, not a
> >fundamental history-changing operation itself. Which means you can never
> >save bandwidth or space by truncating history with replacements. You can
> >only give somebody the full history, and share with them your view. If
> >you want to truncate, you must rewrite history[1].
> 
> Right, but if you only care about that view, then there is no need to
> waste bandwidth fetching the original one.  It goes without saying
> that people pulling from the repository mainly care about the view
> upstream chooses to publish.  Upstream can choose to rewrite, which
> will cause breakage and is a sort of sneaky way to hide the original
> history, or they can use replace, which avoids the breakage and gives
> the client the choice of which view to use.

Once you have fetched with that view, how locked into that view are you?
Certainly you can never push to or be the fetch remote for another
repository that does not want to respect that view, because you simply
don't have the objects to complete the history for them.

But what about deepening your own repo? In your proposal, I contact the
server and ask for the replacement refs along with the branch refs. For
the history of the branches, it gives me the truncated version with the
replacement objects, right? Now how do I go back later and say "I'm
interested in getting the rest of history, give me the real one"?

I guess you can get the parent pointer from the real, "non-replaced"
object and ask for it. But you can't ask for a specific commit, so for
every such truncation, the parent needs to publish an extra ref (but
_not_ make it one of the ones fetched by default, or it would nullify
your original shallow fetch), and we need to contact them and find that
ref.

So I guess it's do-able, but there are a few interesting corners. I
think somebody would need to whip up a proof of concept patch to explore
those corners.

-Peff
