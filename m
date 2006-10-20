From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Thu, 19 Oct 2006 20:20:32 -0400
Message-ID: <20061020002032.GA7162@delft.aura.cs.cmu.edu>
References: <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org> <20061018214143.GF19194@spearce.org> <7vwt6xxofi.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610181542160.3962@g5.osdl.org> <Pine.LNX.4.64.0610181910440.1971@xanadu.home> <Pine.LNX.4.64.0610181655430.3962@g5.osdl.org> <7vac3tx900.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610190747060.3962@g5.osdl.org> <20061019160750.GS17794@delft.aura.cs.cmu.edu> <Pine.LNX.4.64.0610190936440.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 02:20:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gai7t-00008B-JQ
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 02:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946749AbWJTAUg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 20:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946751AbWJTAUg
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 20:20:36 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:55000 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S1946749AbWJTAUf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 20:20:35 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 4.63)
	(envelope-from <jaharkes@cs.cmu.edu>)
	id 1Gai7k-00071N-5Y; Thu, 19 Oct 2006 20:20:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610190936440.3962@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29391>

On Thu, Oct 19, 2006 at 09:48:29AM -0700, Linus Torvalds wrote:
> On Thu, 19 Oct 2006, Jan Harkes wrote:
> > 
> > If we find a delta against a base that is not found in our repository we
> > can keep it as a delta, the base should show up later on in the
> > thin-pack. Whenever we find a delta against a base that we haven't seen
> > in the received part of the thin pack, but is available from the
> > repository we should expand it because there is a chance we may not see
> > this base in the remainder of the thin-pack.
> 
> Yes, indeed. We can also have another heuristic: if we find a delta, and 
> we haven't seen the object it deltas against, we can still keep it as a 
> delta IF WE ALSO DON'T ALREADY HAVE THE BASE OBJECT. Because then we know 
> that the base object has to be there later in the pack (or we have a 
> dangling delta, which we'll just consider an error).
> 
> So yeah, maybe my patch-series is something we can still save.

It looks like you were really close. When we cannot resolve a delta, we
just write it to the packfile and we don't queue it. If it can be
resolved we write it as a full object.

The only thing that cannot be reliably tracked is the pack index
information. The offsets are trivial, but we cannot calculate the SHA1
for a delta without applying it to it's base, if the base comes later
the existing code could do it, but if it has already been written to the
pack we can't easily track back.

And why add all the extra complexity. Running git-index-pack after
git-update-objects --repack not only generates the correct index without
a problem, it also serves as an extra consistency check and we keep this
code isolated from any possible future changes to the index file format.

I'll try to follow this up with 2 patches, one is an almost trivial
change to your code that makes it write out a pack with all full objects
and resolvable deltas converted to full objects, any unresolved deltas
are expected to be relative to some other object in the same pack.

The rewritten pack is indexed correctly even when I run git-update-index
in a repository that does not contain any of the objects in the thin-pack.
Ofcourse it also works when the objects are available, but the resulting
full pack is considerably bigger since we can find a suitable base for
every delta.

> However, the thing that makes me suspect that it is _not_ saveable, is 
> this:
...
> The answer is: no. It's not trivial. Or rather, it _is_ trivial, but you 
> have to _remember_ all of the actual data for A, B, C and D all the way to 
> the end, because only if you have that data in memory can you actually 
> _recreate_ B, C and D even enough to get their SHA1's (which you need, 
> just in order to know that the pack is complete, must less to be able to 
> create a non-delta version in case it hadn't been).

Only if you want to build the index at the same time, we don't need to
know the SHA1 values for unresolved deltas.

> Anyway, I just pushed the "rewrite-pack" branch to my git repo on 
> kernel.org, so once it mirrors out, if you really want to try to fix up 
> the mess I left behind, there it is:

I think I still left quite a bit of the mess unfixed.

Jan
