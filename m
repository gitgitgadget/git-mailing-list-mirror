From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Notes on Subproject Support
Date: Sun, 22 Jan 2006 22:50:32 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601222104120.25300@iabervon.org>
References: <7v3bjfafql.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 23 04:48:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0shF-0000aC-Jh
	for gcvg-git@gmane.org; Mon, 23 Jan 2006 04:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWAWDsb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 22:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWAWDsb
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 22:48:31 -0500
Received: from iabervon.org ([66.92.72.58]:64268 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751398AbWAWDsa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jan 2006 22:48:30 -0500
Received: (qmail 14037 invoked by uid 1000); 22 Jan 2006 22:50:32 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Jan 2006 22:50:32 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bjfafql.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15074>

On Sun, 22 Jan 2006, Junio C Hamano wrote:

> Also note that in this round of proposal, there is no separate
> branches that keep track of heads of subprojects.

Interesting; I think it may become useful to allow for such heads, but we 
can deal with that when it arises. (e.g., maybe you want to use topic 
branches in the kernel development you do in the linux-2.6/ subdirectory 
of your superproject working tree; so long as the core isn't using refs 
for its own purposes, this is up to the user to keep straight and we can 
help later when we have usage notes)

> ============
> 
> Let's not forget to add the `Makefile`, and check the whole
> thing out from the index file.
> ------------
> $ git add Makefile

Maybe bind-projects should be "add-projects", to match "add", which has a 
similar effect at the user level?

> $ git checkout-index -f -u -q -a
> ------------
> 
> Now our directory should be identical with the `current`
> directory.  After making sure of that, we should be able to
> commit the whole thing:
> 
> ------------
> $ diff -x .git -r ../current ../combined
> $ git commit -m 'Initial toplevel project commit'
> ------------
> 
> Which should create a new commit object that records what is in
> the index file as its tree, with `bind` lines to record which
> subproject commit objects are bound at what subdirectory, and
> updates the `$GIT_DIR/refs/heads/master`.  Such a commit object
> might look like this:
> ------------
> tree 04803b09c300c8325258ccf2744115acc4c57067

Does this tree include trees for the bound projects?

> bind 5b2bcc7b2d546c636f79490655b3347acc91d17f linux-2.6/
> bind 0bdd79af62e8621359af08f0afca0ce977348ac7 appliance/
> author Junio C Hamano <junio@kernel.org> 1137965565 -0800
> committer Junio C Hamano <junio@kernel.org> 1137965565 -0800
> 
> Initial toplevel project commit
> ------------
> 
> 
> Making further commits
> ----------------------
> 
> The easiest case is when you updated the Makefile without
> changing anything in the subprojects.  In such a case, we just
> need to create a new commmit object that records the new tree
> with the current `HEAD` as its parent, and with the same set of
> `bind` lines.
> 
> When we have changes to the subproject part, we would make a
> separate commit to the subproject part and then record the whole
> thing by making a commit to the toplevel project.  The user
> interaction might go this way:
> ------------
> $ git commit
> error: you have changes to the subproject bound at linux-2.6/.
> $ git commit --subproject linux-2.6/
> $ git commit
> ------------

I think "cd linux-2.6 && git commit" should work for the subproject, too, 
but that can be a later enhancement.

> With the new `--subproject` option, the directory structure
> rooted at `linux-2.6/` part is written out as a tree, and a new
> commit object that records that tree object with the commit
> bound to that portion of the tree (`5b2bcc7b` in the above
> example) as its parent is created.

And the commit is written to the index, in the special slot for the 
subproject, replacing its parent, I assume.

> Switching branches
> ------------------
> 
> Along with the traditional two-way merge by `read-tree -m -u`,
> we would need to look at:
> 
> . `bind` lines in the current `HEAD` commit.
> 
> . `bind` lines in the commit we are switching to.
> 
> . subproject binding information in the index file.
> 
> to make sure we do sensible things.

This is one place I think storing the bindings in the commit is awkward. 
read-tree deals in trees (hence the name), but will need information from 
the commit.

I think it should be possible to hide the existance of subtrees in an 
add-on to the struct tree API such that code that doesn't handle it 
specifically doesn't see a difference, similarly to how the index file can 
be handled. (parse_tree would fill out the structure as if the subproject 
were a tree instead of a commit, assuming that the structure it's 
pretending to be is the full tree, but there would be an additional 
field for the commit if it's a subproject, until we've gone through 
everything to make it work with subprojects).

I'm hoping to kill off the other tree object parser, which is only used by 
ls-tree and diff-index at this point, but my workstation's home directory 
hard drive seems to have gotten weirdly messed up at the hardware level 
(and seems to have lost a lot of the contents of unused storage, or 
something), so this may take a little while. At that point, whatever 
special things we do in tree objects can be handled automatically with 
changes only to a single location.

	-Daniel
*This .sig left intentionally blank*
