From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: add "--dense" flag
Date: Sat, 22 Oct 2005 13:37:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510221251330.10477@g5.osdl.org>
References: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org>
 <20051022003733.GA8351@pasky.or.cz> <Pine.LNX.4.64.0510211814050.10477@g5.osdl.org>
 <7voe5iqk82.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 22 22:39:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETQ8A-0004B6-9F
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 22:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVJVUhy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Oct 2005 16:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVJVUhy
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Oct 2005 16:37:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9618 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750802AbVJVUhy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Oct 2005 16:37:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9MKbhFC028379
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 22 Oct 2005 13:37:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9MKbg9m027185;
	Sat, 22 Oct 2005 13:37:42 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe5iqk82.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10474>



On Fri, 21 Oct 2005, Junio C Hamano wrote:
> 
> If rev-list can optionally be told to detect renames internally
> (it has necessary bits after all), it could adjust the set of
> paths to follow when it sees something got renamed, either by
> replacing the original path given from the command line with its
> previous name, or adding its previous name to the set of path
> limitters (to cover the copy case as well).

The problem with renames isn't the straight-line case. 

The problem with renames is the merge case. And quite frankly, I don't 
know how to handle that sanely.

If everything was straight-line (CVS), renames would be trivial. But 
git-rev-list very fundamentally works on something that isn't. So let's 
look at the _fundamental_ problem:

 - git-rev-list traverses one commit at a time, and it doesn't even _know_ 
   whether it has seem all the parents of that commit during the first 
   phase.

   The first phase is the "limit_list()" thing, which is when we decide 
   which commits are reachable, uninteresting, and which merges to follow.

   Now, think about this: since we don't even know that we've seen all 
   parents, that pretty much by definition means that we can't know what 
   has been renamed if we were to track it.

 - in the second phase (which is where I do the densification), we do 
   actually have the full tree and that makes a lot of things a lot easier 
   to do. When it comes to dense, for example, it means that I know all 
   the UNINTERESTING logic has already been done, and that all merges have 
   been simplified.

   But in the second phase, we couldn't do rename detection either, since 
   by then, we've already fixed the list of names as far as merges are 
   concerned.

And note that this fundamental issue is true _whether_ we have some 
explicit rename information in a commit or not. 

Git-rev-list has a few additional issues that make it even more 
interesting:

 - git-rev-list fundamentally is designed for multiple heads. There is no 
   one special "origin" head. We might not have _one_ end-point, we might 
   have twenty-five different heads we're looking at at the same time. Try

	gitk --all --dense -d -- git-fetch.c

   on the current git archive, and be impressed by how well it works (and 
   yes, you'll see a funny artifact: "--dense" never removes a line of 
   development entirely, so you'll see a single dot for the two 
   "unrelated" lines: "gitk" and "to-do" do not share a root with the rest 
   of them. You'll get a single dot for that root, even if it 
   obviously doesn't actually change "git-fetch.c").

   You'll also very clearly see the "Big tool rename" which created that 
   name: it will be the first commit after the root that is visible that 
   way.

 - path limiters are fundamentally designed to take a list of paths and 
   directories. Personally, I find that to be a lot more important than a 
   single file. That's very efficient the way we do it, but if you were to 
   _change_ the list of paths, you'd basically have to track those changes 
   over history.

   (This actually happens even with a single path - imagine a merge, and a 
   rename down one line of the merge. You'll have to keep track of 
   different files for the different lines of development, and then when 
   they join together, and the rename only happened in one of them, you'll 
   have to make an executive decision, or just continue to track _both_)

So what do I propose? I propose that you realize that "git-rev-list" is 
just the _building_ block. It does one thing, and one thing only: it 
creates revision list.

A user basically _never_ uses git-rev-list directly: it just doesn't make 
sense. It's not what git-rev-list is there for. git-rev-list is meant to 
be used as a base for doing the real work. And that's how you can use it 
for renaming too.

If you think of "git-rev-list --dense -- name" as a fast way to get a set 
of commits that affect "name", suddenly it all makes sense. You suddenly 
realize that that's a nice building block for figuring out renames. It's 
not _all_ of it, but it's a big portion.

To go back to "gitk", let's see what the path limitation shows us. Right 
now, doing a

	gitk --all --dense -d -- git-fetch.sh

only shows that particular name, and that's by design. Maybe that's what 
the user wants? You have to realize that especially if you remember an 
_old_ name that may not even exist any more, that's REALLY what you want. 
Something that works more like "annotate" is useless, because something 
that works like annotate would just say "I don't have that file, I can't 
follow renames" and exit.

So the first lesson to learn is that following just pure path-names is 
actually meaningful ON ITS OWN! Sometimes you do NOT want to follow 
renames.

For example, let's say that you used to work on git 4 months ago, but gave 
up, since it was too rough for you. But you played around with it, and now 
you're back, and you have an old patch that you want to re-apply, but it 
doesn't talk about "git-fetch.sh", it talks about "git-fetch-script". So 
you do

	gitk --dense -- git-fetch-script

and voila, it does the right thing, and top of the thing is "Big tool 
rename", which tells you _exactly_ what happened to that PATHNAME. 

See? Static pathnames are important! 

Now, this does show that when you _do_ care about renames, "gitk" right 
now doesn't help you very much (no offense to gitk - how could it know 
that git-rev-list would give it pathname detection one day?). Let's 
go back to the original example, and see what we could do to make gitk 
more useful..

	gitk --all --dense -d -- git-fetch.sh

Go and select that "Big tool rename" thing, and start looking for the 
rename..

You won't find it. Why? You'll see all-new files, no renames. It turns out 
that "gitk" follows the "parent" thing a bit _too_ slavishly, which is 
correct on one level, but in this case with "--dense" it turns out that 
what you want to do is see only what _that_ commit does, not what that 
commit did relative to its parent (which was the initial revision).

So while "--dense" made gitk work even without any changes, it's clear 
that the new capability means that gitk might want to have a new button: 
"show diff against 'fake parent'" and "show diff against 'real parent'".

If you want the global view, the default gitk behaviour is correct (it 
will show a "valid" diff - you'll see everything that changed between the 
points it shows). But in a rename-centric world, you want the _local_ 
change to that commit, and right now gitk can't show you that.

So for trackign renames, we probably want that as a helper to gitk.

Also, gitk has a "re-read references" button, but if you track renames, 
you probably want to do more than re-read them: you want to re-DO them 
with the "Big rename" as the new head (forget the old references 
entirely), and with the name list changed. New functionality (possibly 
you'd like to havea "New wiew" button, which actually starts a new gitk 
so that you can see both of them). Right now you'd have to do it by hand:

	gitk --dense 215a7ad1ef790467a4cd3f0dcffbd6e5f04c38f7 -- git-fetch-script 

(where 215a.. is the thing you get when you select the "Big tool rename")

You'd also probably like to have some way to limit the names shown for the 
git-diff-tree in gitk. 

In short, the new "gitk --dense -- filename" doesn't help you nearly as 
much as it _could_. But when you squint a bit, I think you'll see how it's 
quite possible to do...

		Linus
