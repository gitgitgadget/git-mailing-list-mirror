From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Multi-ancestor read-tree notes
Date: Fri, 9 Sep 2005 16:44:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509091337460.23242@iabervon.org>
References: <Pine.LNX.4.63.0509050049030.23242@iabervon.org>
 <7vy866i1zc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 22:41:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDpfq-0004gp-Az
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 22:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbVIIUkf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Sep 2005 16:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbVIIUkf
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Sep 2005 16:40:35 -0400
Received: from iabervon.org ([66.92.72.58]:40716 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030342AbVIIUke (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2005 16:40:34 -0400
Received: (qmail 5984 invoked by uid 1000); 9 Sep 2005 16:44:34 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Sep 2005 16:44:34 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy866i1zc.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8250>

On Fri, 9 Sep 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > In case #16, I'm not sure what I should produce. I think the best thing 
> > might be to not leave anything in stage 1. The desired end effect is that 
> > the user is given a file with a section like:
> >
> >   {
> >     *t = NULL;
> >     *m = 0;
> > <<<<<<<<
> >     return Z_DATA_ERROR;
> > ========
> >     return Z_OK;
> >>>>>>>>>
> >   }
> 
> I was thinking a bit more about this.  Let's rephrase case #16.
> I'll call merge bases O1, O2,... and merge heads A and B, and we
> are interested in one path.
> 
> If O1 and O2, the path has quite different contents.  A has the
> same contents as O1 and B has the same contents as O2. 

There's a bit more subtlety here: since these are common ancestors, A must 
have somehow changed O2's version to O1's version, and B must have changed 
O1's version to O2's version. It's isn't just that each side left the file 
the same, but from different ancestral versions; both of the other 
versions must have gotten rejected somehow. I think the real key is to 
identify what was going on in between.

> We should not just pick one or the other and do two-file merge
> between the version in A and B (we could prototype by massaging
> 'diff A B' output to produce what is common between A and B and
> run (RCS) merge of A and B pretending that the common contents
> is the original to produce something like the above).
> 
> If A has slight changes since O1 but B did not change since O2,
> ideally I think we would want the same thing to happen.  Let's
> call it case #16+.
> 
> What does the current implementation do?  It is not case #16
> because A and O1 does not exactly match.  I suspect the result
> will be skewed because B has an exact match with O2. 

Yes, in this case we miss whatever caused A to reject O2, and we use the 
modified O2, because we don't realize that A's rejection of O2 should also 
apply to the version in B. Unfortunately, this looks just like the 
situation where both sides took O1, and B did a further modification to 
that.

> The situation becomes more interesting if both A and B has slight
> changes since O1 and O2 respectively.  They do not exactly match
> with their bases, but I think ideally we would like something
> very similar to case #16 resolution to happen.

I think the right thing, ideally, is to have the content merge also take 
multiple ancestors and have a #16 case itself when it's deciding which 
version of a block to use. The #16+ case is actually trickier, because we 
have fewer cues.

> One way to solve this would be to try doing things entirely in
> read-tree by doing not just exact matches but also checking the
> amount of changes -- if each heads has similar but different
> base call it case #16 and try two-file merge between the heads
> disregarding the bases.
> 
> But I am a bit reluctant to suggest this.  My gut feeling tells
> me that these 'interesting' cases are easier if scripted outside
> read-tree machinery to later enhance and improve the heuristics.
> 
> Of course, the current case #16 detected by the exact match rule
> should be something we can automatically handle, but to make
> things safer to use I think we should have a way to detect case
> #16+ situlation and avoid mistakenly favoring A over B (or vice
> versa) only because one has slight modification while the other
> does not.

I think #16+ is extra uncommon, because it involves someone making an 
irrelevant modification to a patched version of a file while someone else 
reverts the patch. I'm actually interested in doing a big spiffy program 
to do merges with information drawn as needed from the history, stuff 
happening on a per-hunk level, and support for block moves. It'll take a 
while before it gets anywhere, but I still think it's likely that people 
won't hit #16+ and get unexpected behavior before it's ready.

The main thing I'm unsure of is whether Fredrick's algorithm is actually 
not a better solution: it is possible to understand what happened leading 
up to a merge either by looking at the time after the common ancestors or 
by looking at the time before them. I think that the more recent history 
is a better guide, but the older history is easier to use; the case his 
version isn't good for, I think, is when the common ancestors of the sides 
are even more complicated to merge.

	-Daniel
*This .sig left intentionally blank*
