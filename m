From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/3] Somebody updated my branch tip underneath me.
Date: Sat, 31 Mar 2007 14:39:20 -0700
Message-ID: <7vvegh6qk7.fsf@assigned-by-dhcp.cox.net>
References: <7vslbo4fwx.fsf@assigned-by-dhcp.cox.net>
	<loom.20070329T133700-713@post.gmane.org>
	<7vwt0z3ipb.fsf@assigned-by-dhcp.cox.net>
	<loom.20070331T144714-311@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sergio Callegari <scallegari@arces.unibo.it>
X-From: git-owner@vger.kernel.org Sat Mar 31 23:39:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXlIF-00039s-0T
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 23:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbXCaVjX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 31 Mar 2007 17:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752344AbXCaVjX
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 17:39:23 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:53304 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbXCaVjW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Mar 2007 17:39:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070331213922.NFGT27119.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 31 Mar 2007 17:39:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id hZfL1W00L1kojtg0000000; Sat, 31 Mar 2007 17:39:21 -0400
In-Reply-To: <loom.20070331T144714-311@post.gmane.org> (Sergio Callegari's
	message of "Sat, 31 Mar 2007 12:50:42 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43571>

Sergio Callegari <scallegari@arces.unibo.it> writes:

> Junio C Hamano <junkio <at> cox.net> writes:
>
>>=20
>> Answering that is part of "let's see who are motivated enough"
>> area .  Are you?
>
> Touch=C3=A9! :-)

Having said that...

       If we allowed a commit to be created in such a case, your next
       commit will have B as the parent, with the tree state you wanted
       to have in X.  The graph becomes like this:

                 x---x---B
                /          \
        ---o---A            X (New HEAD)

       The commit essentially reverts what happened in 'x' and 'B',
       which is quite bad.

       What you want to happen in this case is to make a graph like
       this:

                 x---x---B branch tip
                /
        ---o---A-------X (your work is still based on A)

       and then perhaps merge B's work, after making sure B is a
       fast-forward of A and doing other sanity checks:

                 x---x---B
                /         \
        ---o---A-------X---M the final branch tip

I did not code the patch to detach the HEAD at the same time,
because I was not convinced that "What you want to happen" part
is the *only* sane resolution of the situation.

Depending on who created the chain that leads to B, I suspect
the desired outcome to resolve this situation would be
different.  If it was yourself working in another repository
(either working in a separate repository on the same machine,
and then pushed to update the branch tip from there, or working
in a separate working tree that shares the .git/refs with this
repository created with Julian Phillips's workdir script to
directly update the branch tip), then you might want to rebase
the branch tip on top of your commit 'X', resulting in a picture
like this instead:

                         x'--x'--B' branch tip
                        /
        ---o---A-------X (your work is still based on A)

Both of these workflows would require you to detach your HEAD to
A.

But it is conceivable that you might want to do an equivalent of
"switching branches while merging the local changes" (aka "git
checkout -m other-branch") without making a commit, to result
in:

                 x---x---B.......X' (your work is now based on B)
                /        tip
        ---o---A

This is especially true when the chain leading to B is somebody
else's work, which potentially is already published elsewhere.
You do not want to rebase that (although it is perfectly fine to
merge with it, so the solution I suggested in the original
message is Ok).

The difference in the end result is your commit will come after
B, not before it, and in this case you do not need to detach the
HEAD.  For this, you would need to perform the same operation as
"# Match the index to the working tree, and do a three-way" part
of git-checkout.sh:

	git update-index --refresh >/dev/null

	new=3D`git rev-parse --verify HEAD` ;# updated head at B
	old=3D`git update-index --get-base` ;# base of the working tree at A

	# prepare $work tree that represents what you would have
        # committed if you did "git commit -a"
    	git diff-files --name-only | git update-index --remove --stdin &&
	work=3D`git write-tree` &&
	git read-tree --reset -u $new || exit

        # Three-way merge to transplant A..X change on top of B
	eval GITHEAD_$new=3D'${new_name:-${branch:-$new}}' &&
	eval GITHEAD_$work=3Dlocal &&
	export GITHEAD_$new GITHEAD_$work &&
	git merge-recursive $old -- $new $work

	# Do not register the cleanly merged paths in the index yet.
	# this is not a real merge before committing, but just carrying
	# the working tree changes along.
	unmerged=3D`git ls-files -u`
	git read-tree --reset $new	;# index has B's tree now
	case "$unmerged" in
	'')	;;
	*)
		# ... except we carry the conflicted paths along
		(
			z40=3D0000000000000000000000000000000000000000
			echo "$unmerged" |
			sed -e 's/^[0-7]* [0-9a-f]* /'"0 $z40 /"
			echo "$unmerged"
		) | git update-index --index-info
		;;
	esac


Where you should detach your head to (if you choose to do so) is
already recorded in the index and "git update-index --get-base"
would give that to you if you need it, but once we detach the
HEAD, we would not know on which branch we were, and we need to
keep that information while detaching the HEAD.  If there is a
sane resolution that does not require detaching the HEAD (such
as the above example), there is no point to do so, so I left
that policy decision to later steps.
