From: Junio C Hamano <junkio@cox.net>
Subject: What's new in git.git master branch
Date: Wed, 30 Nov 2005 14:57:06 -0800
Message-ID: <7vlkz5n3r1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Dec 01 00:01:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehasz-0005B3-Qz
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 23:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVK3W5J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 17:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbVK3W5I
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 17:57:08 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:11762 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751178AbVK3W5I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 17:57:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051130225544.JYKL17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 30 Nov 2005 17:55:44 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13028>

As promised (or warned), most of the things are now graduating
from proposed updates to the master branch.  The plan is to
merge this into "maint" by the weekend after field testing
(sorry, you guys are guinea pigs, but I did human experiments on
myself first ;-)), and label that 1.0rc4.  After that, hopefully
no disrupting feature changes until 1.0 final.

Among the miscellaneous fixes, notable recent changes are:

 - bisect can cut down trials if given pathspec (Linus).

 - merge-one-file leaves unmerged entries in index (Linus,
   linux@horizon.com, me).  The recursive merge strategy has
   been also updated to match this but only in no-renaming
   case.

 - diff-files updated to show diff between a higher stage and
   working tree (Linus).  I reverted most of the butchering I
   suggested last night on the list except one obvious bugfix
   Linus agreed.

 - ls-tree rewrite (Linus).

 - making more things work from subdirectories (me).

 - repository format version futureproofing (Martin Atukunda and
   me).  A fix by Tommi Virtanen for the bug reported by David
   Woodhouse is included here.

 - improved gitk (Paulus, Yann Dirson, Pavel Roskin)

I am still holding back "Disable USE_SYMLINK_HEAD" by Pavel
Roskin in the proposed updates branch.  This makes symref
everywhere, not only on symbolic-challenged platforms, to
represent HEAD link.  As far as I know, Cogito and StGIT are
ready for this change, but this will break gitweb, which
directly reads from $project/HEAD to find out the object name of
the HEAD commit (it needs to do `GIT_DIR=$project git-rev-parse
HEAD` now).  I think we earlier agreed that this patch will go
in sometime after 1.0; correct me if I am wrong.

One interesting change is ls-tree rewrite by Linus.  The command
does _not_ show tree nodes when running with -r flag anymore.
Running "git diff v0.99.9i t/t3100-ls-tree-restrict.sh"
after updating to the master tells you the summary of changes in
the behaviour.

I've looked at gitweb, Cogito and StGIT to see if this breaks
things, and while I think it is safe for these three, authors of
Porcelains including these three are asked to double check.

Particularly interesting one is cg-log, which only uses
"git-ls-tree -r" to show the list of things being committed for
the initial commit, and this change actually fixes a small bug
there (I think with the ls-tree before this change it would end
up listing tree entries).  cg-restore guards itself with a sed
script from ls-tree spitting out entries other than blob, so it
is not affected, but it could lose that guard now.

Another improvement is around git-merge-one-file and
git-diff-files to change how the conflicting path information is
left in the index after a failed automerge.  This change was
prompted by a question from linux@horizon.com (do you have a
real name?).  We leave the failed merge result in the working
tree with conflict markers as before, but unlike the previous
round which registered the HEAD commit version at stage0 in the
index file, we now leave the index entries unmerged.  "git diff"
command can be used to see what the changes from our HEAD commit
is as before, but you can also say "git diff --base" to see the
differences from the merge base, and "git diff --theirs" to see
the differences from the other branch that was merged.
