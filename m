From: Junio C Hamano <gitster@pobox.com>
Subject: Medium term dreams
Date: Mon, 01 Sep 2008 16:19:47 -0700
Message-ID: <7vsksjsbcc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 02 01:20:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaIhd-0002C0-9I
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 01:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351AbYIAXTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 19:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754865AbYIAXTx
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 19:19:53 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35195 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857AbYIAXTw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 19:19:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 20C7A6F8D3;
	Mon,  1 Sep 2008 19:19:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1CFA16F8D2; Mon,  1 Sep 2008 19:19:48 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7A20F5E6-787C-11DD-A6C7-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94628>

Perhaps because it is also Linus's brainchild, git development has not
generally advanced by intelligent design but by organic evolution.  We
have worked without setting any grand, long term visions, but primarily
by gathering the fruits of individual developers' work to scratch their
own itches.  While I do not see that as a problem at all, it sometimes
may help to write down some medium to long term wishes to review what we
haven't done (and we should) in a perspective.

This is such a wishlist, not a grand intelligent design in any way.

1. Pathspecs

There is a longstanding inconsistency in pathspec limiting done by
various families of commands.  We should unify them.

 * The pathspec limiter that originates from "git diff-tree" and shared
   with "git log" is the most limited.  It only allows you to specify
   leading paths and limits by leading substring match (anchored at
   directory boundaries '/'); no globbing is supported.

 * The pathspec limiter used by "git ls-files -- $path" and shared by
   "git checkout [treeish] -- $path" is more flexible.  In addition to
   the leading directory match above, it does allow globbing.

   This unfortunately has at least two different implementations.  The
   one ls-files and checkout uses is in dir.c; grep uses a different
   implementation that is more advanced and better suited for a caller
   that can benefit from being able to skip a whole subdirectory.

   The limiter used by for-each-ref is also of this kind; it has its own
   implementation (I do not think it is worth using the same code with
   other codepaths for this particular one, but I am mentioning it for
   completeness).

My gut feeling is that we should build a superset of these three
implementations, starting from the one used in grep and adding the
feature it lacks from the dir.c one (namely, the ability to mark which
pathspec had actually matched anything, so that the caller can say "you
gave me this pathspec but it did not match any --- typo?"), and make
the existing three pathspec limiter functions thin wrappers to it.

This will change semantics in that "git diff HEAD '*.c'" will now show
differences to all C files, not just the path with three-letter
filename, asterisk-dot-C.  I do not think that deserves to be called
"breaking backward compatibility"; it is 99% pure feature enhancement,
that hurts insane people who have filenames with shell metacharacters in
them.
 
2. Submodules

Eventually, I'd like to remove gitk-git/ and git-gui/ directories, and use
the submodule mechanism to bind them at modules/{gitk,git-gui}.  So far we
have refrained from doing this, primarily because a repository that uses
submodules cannot be cloned by very old versions (before 1.5.2) of git,
and in principle, git.git's repository itself should be conservative
(e.g. I did not use packed refs in public repositories where I can
configure for a long time, since HTTP clients did not understand them).

Because this change (not the change to the software itself, but the
repository that houses the software, i.e. "git.git") would be conceptually
a big jump, the release that has these two directories as submodules might
need to be called 2.0.0.  Now a big release is over, and hopefully in a
year or so, everybody would be using at least 1.6.0.

I've pushed a sample repository that future git.git might look like to:

    http://repo.or.cz/w/git/split-submodule.git/

We may however need to polish the software side of submodule support so
that the development inside such a repository goes smoothly.  I think the
current submodule support is already good enough to get this started.
Namely:

 * I do not think it is a problem at all that many operations such as
   checkout/diff/fetch/push/bisect do not recurse into submodules, at
   least for the purpose of binding gitk/git-gui to git.git.

 * I do think the current design of the submodule system is very well
   suited for git.git's future use of submodules for gitk/git-gui. If
   somebody builds with "make NO_TCLTK", he most likely won't even want
   to "git submodule init/update" these two submodules.

 * I do not think switching branches across that magic commit, commits
   before which have gitk as a subdirectory and commits after which have
   gitk as a submodule, is a huge problem with the current software, even
   though after switching from new to old there will be leftover, unused
   modules/ directory.

However, there still are some issues that the Porcelain level submodule
support could address to make things better.  For example, if we do not
move gitk-git => modules/gitk as I outlined above, switching across the
magic commit would become an issue, especially switching from new to old
would either lose the submodule repository, or refuse to switch because
doing so would lose the submodule repository.

We should support the usage to replace an existing subdirectory (possibly
but not necessarily merged with subtree strategy) with a submodule.  To do
this sanely, one solution we may want to consider is to keep the real
repository for each submodule somewhere in the superproject's $GIT_DIR/,
and use the "gitfile" to point at it from the submodule's working tree,
and "git submodule init" should be updated to use such a layout by
default.  Then checking out 1.6.0 when you have a clean checkout of 2.0.0
tree will not have to lose the submodule repository (we can notice that
gitk-gui is clean, remove the whole subdirectory and check out the copy
from 1.6.0).

I already know about some breakages around use of relative path in
"gitfile" that needs to be addressed to implement above; there may be
some other issues around that code, but that level of detail is outside
the scope of this message.

There may be some other issues I haven't thought about (submodules area
has never been my bailiwick). and my feeling is that I most likely will
not the primary person who would be doing the polishing of submodule
Porcelain.  But I think the release date of 2.0.0 will be at least one
year after we solve these issues, and when everybody is running such a
version.
