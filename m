From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Multi-ancestor read-tree notes
Date: Tue, 6 Sep 2005 18:59:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509061819340.23242@iabervon.org>
References: <Pine.LNX.4.63.0509050049030.23242@iabervon.org>
 <7virxeycod.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0509061228090.23242@iabervon.org>
 <7vbr36j75b.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0509061610080.23242@iabervon.org>
 <7vslwhg8xe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 07 00:55:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECmLo-0005vc-NB
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 00:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVIFWze (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 18:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVIFWze
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 18:55:34 -0400
Received: from iabervon.org ([66.92.72.58]:24083 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751097AbVIFWzd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2005 18:55:33 -0400
Received: (qmail 986 invoked by uid 1000); 6 Sep 2005 18:59:29 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Sep 2005 18:59:29 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslwhg8xe.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8153>

On Tue, 6 Sep 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Good. (Although that patch doesn't seem to be directly on top of my 
> > version; I can tell what it's doing anyway)
> 
> That one was against the proposed updates head.  I've updated it
> again to include the patch.
> 
> > I'm happy with the content in "pu"; the issue is just whether you want the 
> > history cleaned up more. In the series I sent, I kept forgetting parts 
> > that belonged in earlier patches.
> 
> Again, that is up to you.  I am not _that_ perfectionist but I
> do not mind reapplying updated ones if you are ;-).

What's there is fine with me.

(I'll work on improving the documentation as a further patch)

> > Could you look over the documentation in
> > Documentation/technical/trivial-merge.txt, and see if it's a
> > suitable replacement for the table in
> > t1000-read-tree-m-3way.sh?
> 
> I do not understand what you meant by '*' and 'index+' in
> one-way merge table.  I take the first row ('*') to mean "If the
> tree is missing a path, that path is removed from the index."

'*' means that that case applies regardless of what's there. 'index+' 
means that it's the index, with the stat information. I forgot to actually 
explain the table before going on to the interesting section.

> I like the second sentence in three-way merge description.  That
> is a very easy-to-understand description of what the index
> requirements are.
> 
> You have 2 2ALTs.  Also 14 and 14ALT look like they are the same
> rule now.

Ah, right. I had originally listed "index" in the table, with separate 
cases for having it match the head and having it match the result, but 
then ditched that when I figured out how that actually works.

> What's "(empty)^" in "ancest"?  All of them must be empty for
> this rule to apply?

The '^' means that all must be like that. 

I have to check, but I think that 8ALT and 10ALT should be '+'.

> I am not quite sure it is 'a suitable replacement' yet; the
> existing table you can see it covers all the cases, but with
> things like "'ancestor+' means one of them matches", I cannot
> really tell the table covers all the cases or some cases fall of
> the end of the chain.

All of the "any ancestor" spots are good for covering things. Case #11 
(which actually needs to be at the bottom) is basically "everything else".

> Also when we have more than one ancestors or one remotes and we
> say "no merge", it is still unspecified (and I have to admit I
> cannot readily say what the result should be for all of them,
> except that I agree #16 will be fine with an empty stage1) what
> are left in which stages.

Presently, except for case #16, only the first ancestor is used in "no 
merge" output. The right thing should be worked out and documented, of 
course.

I'm not at all convinced at this point that we can do much with multiple 
remotes in a single application of the rules; you won't necessarily have 
the same merge base for all pairs, and all sorts of things go wrong if you 
start including ancestors that aren't related to something, or not 
including common ancestors of some pair.

What might work is to have the error for an unmerged index only happen 
when you get to a "no merge" result, so that you can get as many conflicts 
as possible (in different files) resolved by the user at the same time.

> I personally think the exotic cases (i.e. no rule applies, or
> "no merge" result with more than one ancestors/remotes) needs to
> be handled outside read-tree anyway, by the script that drives
> read-tree to attempt trivial merges.

I think case #16 would benefit from doing more stuff, but there aren't any 
holes in the rules, and I think that, for the multiple ancestors in "no 
merge", we just want to use the one with the least conflict. (Or, if we 
write our own merge, do a #16/#13,#14/#11 decision per-hunk in our merge, 
which is the really right thing). I think the common case for multiple 
ancestors will really be that you've got a side branch that split before 
the split you're resolving, and was merged into both sides before now; in 
this case, there's no big problem, and it's not the exotic cross-merge 
case. Of course, we won't see this in projects like the kernel and git, 
which aren't that amorphous.

	-Daniel
*This .sig left intentionally blank*
