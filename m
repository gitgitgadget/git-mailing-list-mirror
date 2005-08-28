From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Comments in read-tree about #nALT
Date: Sat, 27 Aug 2005 20:16:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508271941090.23242@iabervon.org>
References: <Pine.LNX.4.63.0508270151590.23242@iabervon.org>
 <7vwtm726xq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0508271709530.23242@iabervon.org>
 <Pine.LNX.4.63.0508271855100.23242@iabervon.org> <Pine.LNX.4.58.0508271621210.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 02:14:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9AnD-0001o6-QB
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 02:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbVH1AM5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Aug 2005 20:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbVH1AM5
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Aug 2005 20:12:57 -0400
Received: from iabervon.org ([66.92.72.58]:37136 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750895AbVH1AM4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Aug 2005 20:12:56 -0400
Received: (qmail 5751 invoked by uid 1000); 27 Aug 2005 20:16:35 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Aug 2005 20:16:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508271621210.3317@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7858>

On Sat, 27 Aug 2005, Linus Torvalds wrote:

> On Sat, 27 Aug 2005, Daniel Barkalow wrote:
> >
> > What I missed was that the effect of causes_df_conflict is to give "no
> > merge" for the entry, rather than giving an error overall. So I do need an
> > equivalent.
>
> Daniel,
>  I'm not 100% sure what you're trying to do, but one thing that might work
> out is to just having multiple "stage 3" entries with the same pathname.
>
> We current use 4 stages:
>  - stage 0 is "resolved"
>  - stage 1 is "original"
>  - stage 2 is "one branch"
>  - stage 3 is "another branch"
>
> But if we allowed duplicate entries per stage, I think we could easily
> just fold stage 2/3 into one stage, and just have <n> entries in stage 2.
> That would immediately mean that a three-way merge could be <n> way.
>
> The only rule would be that when you add a entry to stage 2, you must
> always add it after any previous entry that is already in stage 2. That
> should be easy.

It looks like stage 2 is currently special as the stage that's similar to
the index/HEAD/working tree. However, I don't see any problem with <n>
entries in stage 3, except that, if you have a non-maximal number of them
for some reason, it'll be impossible to determine which came from which
tree.

> In fact, this extension might even allow us to solve the "multiple merge
> base" problem: we could allow multiple entries in "stage 1" too, ie one
> entry per merge base (and just collapse identical entries - there's no
> ordering involved in stage 1 entries).

That's actually the problem I was working on.

> So you could merge "n" trees with "m" bases, and all without really
> changing the current logic much at all.
>
> Maybe I'm missing something (like what you're trying to do in the first
> place), but this _seems_ doable.

I'd be afraid of confusing everything by removing the uniqueness
invariant, although I guess not too much does anything with entries in
stages other than 0. I probably just don't find the index as intuitive as
you do and as the struct tree representation.

I'm working on arranging the code to look at each path in sequence, with
the input trees as the inner loop, rather than with the loops in the other
order; using parse_tree to parse the objects instead of read_tree; and
doing trivial merges before putting things in the cache, rather than
after. I'd been thinking that this would avoid a limit on the number of
stages, since I hadn't considered whether multiple entries for the same
path and stage could be allowed.

I still think that my order is likely to be easier to understand and
involve read-tree relying less on tricky properties of the data
structures, but I'll have to get it done before I can say that for sure.

	-Daniel
*This .sig left intentionally blank*
