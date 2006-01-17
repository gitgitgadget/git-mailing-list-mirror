From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: RFC: Subprojects
Date: Tue, 17 Jan 2006 12:41:39 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601171150050.25300@iabervon.org>
References: <43C52B1F.8020706@hogyros.de> <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
 <7vek3ah8f9.fsf@assigned-by-dhcp.cox.net> <200601161144.48245.Josef.Weidendorfer@gmx.de>
 <7vek37rj83.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0601170001130.25300@iabervon.org>
 <7vfynnfkc8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 18:39:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyuoD-00082w-V6
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 18:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWAQRjt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 12:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWAQRjs
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 12:39:48 -0500
Received: from iabervon.org ([66.92.72.58]:4876 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932248AbWAQRjr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2006 12:39:47 -0500
Received: (qmail 19549 invoked by uid 1000); 17 Jan 2006 12:41:39 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Jan 2006 12:41:39 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfynnfkc8.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14801>

On Mon, 16 Jan 2006, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > So why not use the "bind" approach for the "index vs working tree" part, 
> > but write out "gitlink"-style tree objects?
> 
> I said "index vs working tree" as a mere example, and never said
> "gitlink" is easier (or at least as easy as "bind") for "tree
> object vs index" or "tree object vs working tree through index".
> In fact I suspect those parts also need to be changed fairly
> heavily, and to be honest, I am not very much looking forward to
> investigating the details.

I suspect that it's just as easy, except that you get confronted 
immediately with the issues that you haven't dealt with in the bind 
approach (mentioned below). If you had parse_tree_buffer() just ignore 
them, and had write-tree take a list of bind lines, that would match the 
status of your "bind" implementation, I think (except for the part you say 
is cheating).

Incidentally, I don't think we'd want "gitlink" objects with the "gitlink" 
approach; we'd want trees to contain commit objects for subprojects. The 
"gitlink" thing that corresponds to ".git/HEAD" isn't an object, it's a 
tree entry, which, like ".git/HEAD" (or, more appropriately, 
".git/refs/heads/something") maps a name to the hash of a commit object.

> > In any case, I think it would be good to track where the subprojects are 
> > in some core state, and probably the right solution is to have special 
> > index entries for them, in addition to having their contents in the index. 
> 
> Actually, the "special entry" was what I found out to be quite a
> pain, if you mean to have "linux-2.6/" in the index and have it
> used in some meaningful way.  Further hacking and prototyping
> _might_ convince me otherwise, but I am not so optimistic at
> this moment.

Hmm... maybe libification should go ahead of subprojects. If access to the 
index weren't so often open-coded, it would just be a matter of having 
these entries in the data structure, but not actually returned by any 
current call, and it would be just like they were in some other structure. 

Actually, it should be easy to have them in the index file but not in the 
main index data structure, by skipping over them in the for loop near the 
end of read_cache(). Put them in a separate structure, and write them back 
to the file in write_cache(), and have a different method entirely for 
changing them, and they shouldn't affect the normal use of the index.

> > I'm not seeing a clear way to get from commit objects with "bind" lines to 
> > an index with the appropriate things read and back otherwise.
> 
> Here again I am thinking aloud, remembering the earlier example
> of an embedded linux project that ships with linux-2.6 and
> gcc-4.0, along with its own README and Makefile at the toplevel
> and src/ for its own sources.  The tools at the tip of "pu"
> should be able to let you do the following:
> 
> 	$ git cat-file commit $such_toplevel_commit
> 	tree $tree
>         parent $parent
>         bind $primarysub /
>         bind $linuxsub linux-2.6/
>         bind $gccsub gcc-4.0/
> 	author A U Thor <author@example.com> 1137392543 -0800
> 	commmitter A U Thor <author@example.com> 1137392543 -0800
> 
>         An example.
> 
> where $tree is the object name of the whole tree (no "gitlink"
> object), $primarysub and $linuxsub are the object names of
> commit objects for the primary subproject (which sits at the
> rootlevel) and another subproject (which sits at linux-2.6/
> subdirectory).
> 
> To make sure there is no misunderstanding:
> 
> 	* "git-ls-tree $tree" would show the object name of
>           $linuxsub^{tree} at path "linux-2.6/" because
>           "tree" line of a commit describes the whole tree,
>           including subprojects.
> 
> 	* "git-ls-tree $primarysub" would show README,
>           Makefile and src/ directories but not linux-2.6/ nor
>           gcc-4.0/.
> 
> 	* "git-ls-tree $linuxsub" would show COPYING, Makefile
>           etc., not linux-2.6/COPYING.

Side issue here: this implies that the kernel objects are in the 
superproject's repository, or at least accessible from it. So prune has to 
not remove them. So, if you've committed changes to a subproject but not 
yet committed the fact that you want to use the changed subproject into 
the superproject, fsck-objects has to find them somewhere.

> Reading such a commit is easy:
> 
> 	$ git-read-tree $tree ;# ;-)
> 
> But that is cheating.  

This is for backwards compatibility, I assume?

> Constructing such an index can be done by:
>
> 	$ git-read-tree $primarysub
>         $ git-read-tree --prefix=linux-2.6/ $linuxsub
>         $ git-read-tree --prefix=gcc-4.0/ $gccsub
> 
> When you have such an index, writing out various trees are:
> 
> 	$ git-write-tree ;# $tree
> 	$ git-write-tree --prefix=linux-2.6/ ;# $linuxsub^{tree}
> 	$ git-write-tree --prefix=gcc-4.0/ ;# $gccsub^{tree}
> 	$ git-write-tree \
>           --bound=linux-2.6/ --bound=gcc-4.0/ ;# $primarysub^{tree}
> 
> The decision to use what --prefix and --bound and what tree(s)
> to write out must come from somewhere, and as you say it would
> be nice if we _could_ stick them in the index as "special
> entries", but for the purpose of prototyping I am assuming I
> keep that somewhere in $GIT_DIR/ (the "mtab" in the previous
> message.  Maybe "$GIT_DIR/bind" is a good name?).

The hard thing here is getting the commits for the trees. The bind lines 
need commits, which means either identifying that we already have the 
correct commit object, because we didn't change anything in the 
subproject, or generating a new commit object with some message and the 
right parent. And we want to use commit objects, not tree objects, in the 
bind lines, so that, once we track a problem to the change of which commit 
is bound, we can treat the subproject as a project and debug it with 
bisect, rather than just having one tree that works and one that doesn't.

	-Daniel
*This .sig left intentionally blank*
