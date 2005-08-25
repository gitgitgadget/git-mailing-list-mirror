From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merges without bases
Date: Thu, 25 Aug 2005 15:26:36 -0700
Message-ID: <7vvf1tps9v.fsf@assigned-by-dhcp.cox.net>
References: <1125004228.4110.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 01:11:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8QBb-0004y5-P1
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 00:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbVHYW0j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 18:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbVHYW0i
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 18:26:38 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:4554 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964971AbVHYW0i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 18:26:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050825222638.TSDQ19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 Aug 2005 18:26:38 -0400
To: Darrin Thompson <darrint@progeny.com>
In-Reply-To: <1125004228.4110.20.camel@localhost.localdomain> (Darrin
	Thompson's message of "Thu, 25 Aug 2005 16:10:28 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7773>

Darrin Thompson <darrint@progeny.com> writes:

> I have a weird situation I want to support. I want to be able to merge a
> foreign-tree repeatedly.
>
> What makes the foreign tree foreign is that it may not yet share any
> history with this branch.

I believe that's exactly what Linus did when he merged gitk into
git.  As you discovered, the initial one could easily be
scripted, if you wanted to, with something like this:

        #!/bin/sh
        #
        # git-merge-projects-script
        #
        . git-sh-setup-script || die "Not a git archive."

        foreign_project="$1"
        head=`git-rev-parse --verify HEAD` &&
        foreign=`git-rev-parse --verify $foreign_project^0` || exit

        rm -f .no-such-file
        empty=`GIT_INDEX_FILE=.no-such-file git-write-tree`
        git-read-tree -m -u $empty $head $foreign ||
        git-merge-cache -o git-merge-one-file-script -a || exit

        tree=`git-write-tree` &&
        echo Merge $foreign_project in. |
                git-commit-tree $tree -p $head -p $foreign \
                >"$GIT_DIR/HEAD" &&
	git show-branch --more=10 HEAD $foreign_project

Unlike my other "scripts written in e-mail buffer", I
actually tested this one ;-).

	$ cd /var/tmp && rm -fr junk && mkdir junk
	$ cd /var/tmp/junk
	$ git init-db
        $ cat >./git-merge-projects-script
        : type the above and end with ^D
	$ chmod +x git-merge-projects-script
        $ git add git-merge-projects-script
	$ git commit -m 'My Project'
	$ git fetch http://www.kernel.org/pub/scm/git/git.git master:git
	$ ./git-merge-projects-script git
	$ git diff git..HEAD

The "weird" situation to cause "git resolve" barf happens only
for the first time and once they are merged you can repeatedly
pull from that subset foreign branch without any "weirdo"
support.  Since even the oddball initial case can easily be
scripted like above, and that initial case should happen very
very rarely anyway, I do not think this deserves any core-level
change, such as changes to read-tree you suggest.

The above merge-projects-script _may_ deserve a "contrib"
status to be in the source tree, though.

One thing that makes me reluctant to recommend this "merging
unrelated projects" business is that I suspect that it makes
things _much_ harder for the upstream project that is being
merged, and should not be done without prior arrangement; Linus
merged gitk after talking with paulus, so that was OK.

Suppose the above "My Project" is published, people send patches
for core GIT part to it, and you as the maintainer of that "My
Project" accept those patches.  The users of "My Project" would
be happy with the new features and wouldn't care less where
their core GIT tools come from.  But how would _I_ pull from
that "My Project", if I did not want to pull unrelated stuff in?

In this particular example, it only has git-merge-projects
script which _is_ related to core GIT so this objection would
not apply, but if I were paulus (gitk maintainer whose project
has only one file, the great gitk script) and if the git.git
repository had a lot of changes to gitk, I would like to pick up
updates from there without pulling the rest of core GIT.  That
is not something the current set of tools support, and offhand I
do not think of a good way to implement it cleanly.  That is the
reason why I never pick up any patch for gitk myself --- I
always slurp changes to gitk via paulus tree, or feed patches
to him and then slurp the changes from him.

What I think _might_ deserve a bit more support would be a merge
of a foreign project as a subdirectory of a project.  Linus
could have made gitk/ subdirectory in the core git project, and
made that subtree in sync with the toplevel of paulus gitk
project.  But even this could be done without the core-level
change.  You would run ls-tree of the main project to figure out
the tree object name of that subdirectory, and 3-way merge that
with the top of the paulus project tree, and replace the tree
entry with the resulting tree.

Once that kind of "merging an unrelated project as a
subdirectory of a superproject" workflow is established, pulling
from a subdirectory that corresponds to my project after my
project gets merged this way into the superproject would become
easier to manage and would even become a useful workflow
element.
