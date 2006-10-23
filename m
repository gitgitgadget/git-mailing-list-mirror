From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] git-split: Split the history of a git repository by
 subdirectories and ranges
Date: Mon, 23 Oct 2006 12:50:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610231237080.3962@g5.osdl.org>
References: <451A30E4.50801@freedesktop.org> <7vlko5d3bx.fsf@assigned-by-dhcp.cox.net>
 <453C96C9.4010005@freedesktop.org> <Pine.LNX.4.64.0610230846420.3962@g5.osdl.org>
 <453D17B5.6070203@freedesktop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 21:53:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc5qg-00067Z-8Z
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 21:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWJWTvn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 15:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030185AbWJWTvn
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 15:51:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23736 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030181AbWJWTvl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 15:51:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9NJp1aX002387
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 Oct 2006 12:51:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9NJowmV003654;
	Mon, 23 Oct 2006 12:51:00 -0700
To: Josh Triplett <josh@freedesktop.org>
In-Reply-To: <453D17B5.6070203@freedesktop.org>
X-Spam-Status: No, hits=-0.976 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29869>



On Mon, 23 Oct 2006, Josh Triplett wrote:
>
> > Without the "--full-history", you get a simplified history, but it's 
> > likely to be _too_ simplified for your use, since it will not only 
> > collapse multiple identical parents, it will also totally _remove_ parents 
> > that don't introduce any new content.
> 
> Considering that git-split does exactly that (remove parents that don't
> introduce new content, assuming they changed things outside the
> subtree), that might actually work for us.  I just checked, and the
> output of "git log --parents -- $project" on one of my repositories
> seems to show the same sequence of commits as git log --parents on the
> head commit printed by git-split $project (apart from the rewritten
> sha1s), including elimination of irrelevant merges.

Ok. In that case, you're good to go, and just use the current 
simplification entirely.

Although I think that somebody (Dscho?) also had a patch to remove 
multiple identical parents, which he claimed could happen with 
simplification otherwise. I didn't look any closer at it.

> > So there are multiple levels of history simplification, and right now the 
> > internal git revision parser only gives you two choices: "none" 
> > (--full-history) and "extreme" (which is the default when you give a set 
> > of filenames). 
> 
> I don't think we need any middle ground here; why might we want less
> simplification?

There's really three levels of simplification:

 - none at all ("--full-history"). This is really annoying, but if you 
   want to guarantee that you see all the changes (even duplicate ones) 
   done along all branches, you currently need to do this one.

   Currently "git whatchanged" uses this one (and that ignores merges by
   default, making it quite palatable). So with "git whatchanged", you 
   will get _every_ commit that changed the file, even if there are 
   duplicates alogn different histories.

 - extreme (the current default). This one is really nice, in that it 
   shows the simplest history you can make that explains the end result. 
   But it means that if you had two branches that ended up with the same 
   result, we will pick just one of them. And the other one may have done 
   it differently, and the different way of reaching the same result might 
   be interesting. We'll never know.

   As an exmple: the extreme simplification can also throw away branches 
   that had work reverted on them - the branch ended up the _same_ as the 
   one we chose, but it did so because it had some experimental work that 
   was deemed to be bad. Extreme simplification may or may not remove that 
   experiment, simply depending on which branch it _happened_ to pick.

   Currently, this is what most git users see if they ask for pathname 
   simplification, ie "gitk drivers/char" or "git log -p kernel/sched.c"
   uses this simplification. It's extremely useful, but it definitely 
   culls real history too.

 - The nice one that doesn't throw away potentially interesting 
   duplicate paths to reach the same end result. We don't have this one, 
   so no git commands do this yet.

   The way to do this one would be "--full-history", but then removing all 
   parents that are "redundant". In other words, for any merge that 
   remains (because of the --full-history), check if one parent is a full 
   superset of another one, and if so, remove the "dominated" parent, 
   which simplifies the merge. Continue until nothing can be simplified 
   any more.

   This would _usually_ end up giving the same graph as the "extreme" 
   simplification, but if there were two branches that really _did_ 
   generate the same end result using different commits, they'd remain in 
   the end result.

The problem with the "nice one" is that it's expensive as hell. There may 
be clever tricks to make it less so, though. But I think it's the 
RightThing(tm) to do, at least as an option for when you really want to 
see a reasonable history that still contains everything that is relevant.

			Linus
