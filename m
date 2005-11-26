From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Rename git-config-set to git-repo-config
Date: Fri, 25 Nov 2005 21:52:31 -0800
Message-ID: <7v4q609crk.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
	<200511210026.30280.Josef.Weidendorfer@gmx.de>
	<200511221831.03954.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
	<438371E8.2030701@op5.se>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
	<Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
	<43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 06:54:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfszF-0005ag-Dz
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 06:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbVKZFwe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 00:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932726AbVKZFwe
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 00:52:34 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:16549 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932725AbVKZFwd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2005 00:52:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051126055103.FBTZ20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 26 Nov 2005 00:51:03 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12767>

Linus Torvalds <torvalds@osdl.org> writes:

> Please don't. 
>
> We should just make the scripts do it automatically instead.

Don't worry, we are in agreement about that goal.

> "git-rev-parse" already has support for all of this, and you can do
>
> 	GIT_DIR=$(git-rev-parse --git-dir)
> 	GIT_PREFIX=$(git-rev-parse --show-prefix)
>
> where the first one shows the GIT_DIR, and the second one shows where in a 
> git directory we are (empty if we're at the root).

Not in one case -- out-of-tree GIT_DIR.  That is what
GIT_WORKING_TREE is about.

> In fact, I'd prefer if _every_ command just did the right thing inside a 
> subdirectory. 

Of course.

The case your patch does not cover that I am worried about is
where GIT_DIR is totally out of the tree.  Something like
GIT_DIR=/home/torvalds/uemacs.git and working tree at
/tmp/uemacs.  There is currently no way for the tools to figure
out where the working tree toplevel is in such an arrangement,
and that is when GIT_WORKING_TREE becomes useful.

Under normal use pattern, with GIT_DIR not in such a funny place
but immediately under working tree root, you do not need GIT_DIR
nor GIT_WORKING_TREE.  We can figure things ourselves by
chdir()-up and looking for '.git/' directory.

> I sent out this patch a week or two ago - it still applies, and it still 
> mostly does the right thing. It makes at least "gitk" work right inside a 
> subdirectory, and might make things like "git commit" and friends do the 
> same.

I am afraid it needs more work --- as long as a script uses only
C-level that use setup_git_directory(), everything should work,
and in such a case you do not even need sh-setup --- asking
"git-rev-parse --git-dir" is enough, just like you did in
git-add.  If the script does not have to know where GIT_DIR is
(and I do not think gitk needs to know it, although it digs
there by hand), it does not even need to do that.  As you said,
git-log and git-whatchanged works without any funny trick and
are fine examples of that.

> More testing still needed, but I think this is going in the right 
> direction.
>
> Comments? I got none the first time around.

Among the ones I looked at that use git-sh-setup in
Documentation directory of git.git:

 - git-checkout nor git-reset do not work because git-read-tree
   does not use setup_git_directory(), and git-sh-setup does not
   export GIT_DIR.

   And exporting GIT_DIR from git-sh-setup is not a solution.
   To setup_git_directory(), existence of GIT_DIR environment
   currently means you cannot tell where your toplevel is
   anymore.  We could check GIT_DIR against getcwd() and if it
   is a grand*parent directory, do an appropriate thing
   including chdir("$GIT_DIR/..") and returning an adjusted
   prefix, but we don't.  And that would not work if GIT_DIR is
   really out-of-tree anyway.

   That is why I keep saying GIT_WORKING_TREE.  We could export
   both GIT_DIR and GIT_WORKING_TREE from git-sh-setup, and
   teach the C-level commands that need access to working tree
   to look at it, just like we default GIT_OBJECT_DIRECTORY from
   git-sh-setup.  People with out of tree GIT_DIR needs to
   export both GIT_DIR and GIT_WORKING_TREE to override both,
   just like people with object directory in nonstandard place
   need to export GIT_OBJECT_DIRECTORY.

   Maybe GIT_WORKING_TREE can default to "$GIT_DIR/..", just
   like GIT_OBJECT_DIRECTORY defaults to "$GIT_DIR/objects".

   Another obvious approach is to stop supporting out-of-tree
   GIT_DIR, but I suspect that probably means we should ignore
   GIT_DIR environment and always chdir()-up to find .git/
   (which is fine and sane but is probably an uncomfortably big
   change).

 - git-prune does not work because git-fsck-objects does not
   know where GIT_DIR is (again, GIT_DIR not exported).

 - git-tag works.


Here is a list of C-level and their subdirectory-readiness
status.


These do not look at .git at all -- automatically subdirectory
ready ;-):

	check-ref-format get-tar-commit-id git index-pack
	mailinfo mailsplit patch-id shell show-index stripspace
	verify-pack

Uses setup_git_directory() and subdirectory ready:

        cat-file config-set diff-files diff-index diff-stages
        diff-tree ls-files name-rev rev-list rev-parse
        show-branch symbolic-ref update-index update-ref var

Uses enter_repo() to work from the toplevel:

	daemon receive-pack upload-pack

Wants GIT_DIR to know where it is and working tree access is
always toplevel:

	apply checkout-index clone-pack commit-tree
	convert-objects fetch-pack fsck-objects hash-object
	http-fetch http-push init-db local-fetch ls-tree
	merge-base merge-index mktag pack-objects pack-redundant
	peek-remote prune-packed read-tree send-pack ssh-fetch
	ssh-upload tar-tree unpack-file unpack-objects
	update-server-info write-tree
