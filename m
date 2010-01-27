From: "Yann Dirson" <ydirson@altern.org>
Subject: show/diff --check clarification needed
Date: Wed, 27 Jan 2010 11:41:28 +0100
Message-ID: <d26982ce92a061ee24d04aba6e314fa4.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 11:41:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na5Ky-0005eL-Ru
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 11:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab0A0KlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 05:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753745Ab0A0KlV
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 05:41:21 -0500
Received: from alderaan.linagora.com ([84.14.148.74]:46978 "EHLO
	alderaan.linagora.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab0A0KlU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 05:41:20 -0500
Received: from 10.0.0.2 (unknown [10.75.192.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alderaan.linagora.com (Postfix) with ESMTPSA id 4FE11429F07
	for <git@vger.kernel.org>; Wed, 27 Jan 2010 11:41:17 +0100 (CET)
Received: from 10.0.0.1 (proxying for 194.206.158.221)
        (SquirrelMail authenticated user ydirson)
        by intranet.linagora.com with HTTP;
        Wed, 27 Jan 2010 11:41:28 +0100
User-Agent: SquirrelMail/1.4.18
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138126>

I am experiencing an unexpected behaviour, related to whitespace
(non-)checking.

In a my local repository I have a pre-commit hook checking for "git
diff-index --check --cached" (borrowed from the sample template), and
the server I push to does a "git diff-tree --check" on each pushed
commit to make sure someone who forgot the pre-commit hook does not
push a whitespace-unclean commit by error.

Now I had to import some 3rd-party stuff (an eclipse deltapack if you
wonder) which includes CRLF line-endings, but must not get modified
because of checksums.  So I added the following .gitattributes to the
tree where I import this stuff:

$ cat deltapack/.gitattributes
* binary
.gitattributes -binary

That is just fine for the pre-commit hook, and "git show --check" on
it in my local repository reports no problems.

Now when I attempt to push, the update hook refuses my commit; and if
I run the same "git show --check" on the server (in the bare repo
where the ref has not been updated by the push, but where the pushed
commit has not been pruned yet), I get the complaints which I have
intended the .gitattributes to silent.

What happens is apparently that --check does not know which repository
revision to take .gitattributes from, and takes them from working
tree.  Indeed, removing deltapack/.gitattributes from my worktree and
rerunning "show --check" on that unmodified commit does trigger the errors.

While having "diff-tree --check" defaulting to looking at working tree
by default may make sense, it would seem more natural for "show" to
use by default those of the commit we're looking at - and one could
argue that "diff-tree" could use the positive treeish for that matter
as well.  But defaulting is one matter, it would be really useful to
be able to specify from where the attributes should be taken for any
given operation.  Did not look at the code - anyone knows how easy
that would be ?


Unless I missed something, I suggest the following plan:

- document in maint that --check only takes worktree into account when
  looking for .gitattributes, and more globally add a note to the
  gitattributes manpage to explicitely say that too.

- add a global flag to allow something like
  "git --attributes-tree=<treeish> <command>"

- adjust defaults to agreed-upon values

- add any config entries that would be meaningful


It may just be me having badly written the update hook - here is the
relevant part for reference.  Under the "refs/heads/*,commit)" case of
the sample update hook, I have something like:

                # checks to be done in all commits

                # exclude all commits previously-reachable by any ref
                exclude_oldrevs=$( git for-each-ref --format='^%(refname)' )

                for rev in $(git rev-list $exclude_oldrevs $newrev); do
		    	[...]
                        # special case for root commits
                        if git rev-parse HEAD^ >/dev/null 2>&1; then
                                ref=""
                        else
                                # use an empty tree to compare against
                                ref=4b825dc642cb6eb9a060e54bf8d69288fbee4904
                        fi
                        # checks for whitespace
                        if ! git diff-tree --check $ref $rev >/dev/null; then
                                echo "*** Whitespace problems in $rev" >&2
                                fails_whitespace=1
                        fi
			[...]
		done
