From: "Bernhard R. Link" <brlink@debian.org>
Subject: equal-tree-merges as way to make rebases fast-forward-able
Date: Mon, 30 Nov 2009 15:43:33 +0100
Message-ID: <cover.1259524136.git.brlink@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 15:43:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF7TY-0006ge-Bi
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 15:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794AbZK3On3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 09:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbZK3On2
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 09:43:28 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:33528
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752557AbZK3On2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 09:43:28 -0500
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NF7TR-0000vu-Rl
	for git@vger.kernel.org; Mon, 30 Nov 2009 15:43:33 +0100
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NF7TR-0000qH-Pr
	for git@vger.kernel.org; Mon, 30 Nov 2009 15:43:33 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134103>

The itch this idea is supposed to scratch is the problem that a rebase
or a amended commit is no longer a fast-forward, so cannot be easily
pulled.
While this is not a problem in most workflows, as one can either merge
or keep everything private and rebase until published, it would be nice
to have a way for cases in between, where both a clean presentable
commit order is to be maintained and people (or yourself from different
repositories) should be able to easily upgrade to newer versions without
an error-prone not-fast-forward.

My idea to solve this is combining both histories, the rebased/revised
history and the actualy history, marking with some "equal-tree-merge"
the point where they have the same result.
The following mails show some patches to implement this by means of
a merge where all parents have the same tree and some special casing
when encountering such a thing. This has the advantage that older git
version will just see strange merges and may present both histories,
but otherwise just work.

Example 1:

Let's assume you maintain such a regularily-rebased branch that you
want to be able to publish (or pull from other repositories for example
on your laptop):

o=m=o=o=master
   \
    a=b=c=d=e=feature

with this patch you can do "git rebase -eqt master" and get:

              a'=b'=c'=d'=e'=feature'=eqt
             /                       /
o=m=o=o=master--------              /
   \                  \            /
    a=b=c=d=e=feature--merge-------

i.e: the new feature branch has both histories:
  - "feature'" where everything is cleanly rebased and in a form where
               format-patch is suitable to send it upstream
  - "merge" which is both a descendant from feature (so one can see what
    changed since that time and can just pull when one had had cloned feature)

Example 2:

Let's assume you have a feature branch like

o=master
   \
    a=b=c=d=e=f

Assume you just commited "f" which fixes a bug introduced by "b".
Now you of course do not want to send it that way upstream (as it will
make reviewing harder, may force people bisecting to skip some versions
every time they hit this region and so on), so you want to
bisect -i and squash "f" into "b".

o=master
   \
    a=b+f=c'=d'=e'

But if you had already cloned at state "d" to your laptop (or made a backup
of that branch at some server, or published it for use of some collegues)
it will not be a fast-forward, so you have to be very carefull to not
accidentially lose a commit that is already there.

So with this patches you can do "git rebase -i --eqt" and squash f into b
and get:

o=master
   \
    a=b=c=d=e=f---
     \            \
      b+f=c'=d'=e'=eqt

which means that you can just pull from your laptop and get the new head
as fast-forward, but still have a proper history ready for submitting.

The only downsize of this approach is that an unpatched/old git of course
does not know about that it can just choose one of both histories but think
it has to look at both, so git-format-patch will return patches multiple times
and git-rebase will also try to apply both branches, which the patched version
no longer does, only showing the 'presentable' in this case.

Those patches are a bit rough and mostly intended to show how it could work
and to allow experimenting with it. I think the biggest thing still missing
(apart from documentation, error handling, better commit messages) is making
git bisect take advantage of this and only looking at the nice branch.

Bernhard R. Link (7):
  add new command git equal-tree-marker
  add option to only visit the first parent of a equal tree merge
  format-patch defaults to --first-equal-tree-only
  support equal tree merges in interactive rebase
  make rebase -m equal tree marker aware
  add support for creating equal tree markers after rebase
  add support for creating equal tree markers to rebase -i

 .gitignore                 |    1 +
 Makefile                   |    1 +
 builtin-log.c              |    1 +
 git-equal-tree-marker.sh   |   50 ++++++++++++++++++++++++++++++++++++++
 git-rebase--interactive.sh |   33 +++++++++++++++++++++++++
 git-rebase.sh              |   35 ++++++++++++++++++++++++--
 revision.c                 |   57 +++++++++++++++++++++++++++++++++++++-------
 revision.h                 |    1 +
 8 files changed, 167 insertions(+), 12 deletions(-)
 create mode 100644 git-equal-tree-marker.sh

Hochachtungsvoll,
	Bernhard R. Link
-- 
"Never contain programs so few bugs, as when no debugging tools are available!"
	Niklaus Wirth
