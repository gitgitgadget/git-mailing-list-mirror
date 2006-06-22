From: Yann Dirson <ydirson@altern.org>
Subject: stgit: bunch of bugreports/wishes
Date: Fri, 23 Jun 2006 00:14:25 +0200
Message-ID: <20060622221425.GA7851@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 23 00:14:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtXRQ-0005QS-3P
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 00:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161357AbWFVWOR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 18:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161362AbWFVWOR
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 18:14:17 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:28619 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161357AbWFVWOQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 18:14:16 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id B02125498C;
	Fri, 23 Jun 2006 00:14:15 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FtXRT-00024T-6m; Fri, 23 Jun 2006 00:14:27 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22379>

Here are a number of problems I encountered while playing with
uncommit with 0.10:

- uncommit ignores grafts.  This causes "uncommit -n" to through
"graft merges" without asking, and surely gives unexpected result
when a graft is used to change an ancestor rather than adding one.

- the previous behaviour causes strange interactions with merge
commits (eg. "stg show" cannot show the diff)

- uncommit could allow to go through a merge (indeed ignoring grafts
as it did was a gain of time for me, since it was in a couple of cases
precisely what I wanted to do ;).  One possible interface to such a
feature would be to allow this if HEAD is the merge, and the branch to
follow is explicitely specified.  The issue mentionned above seems to
indicate that when uncommitting a merge, a new commit for the
newly-uncommitted patch has to be created right away, to ensure it has
a single parent.

- uncommit could be more flexible to help with mass-uncommitting,
eg. with something like "--to <commit>" (to avoid counting manually),
or "--to-merge" to cleanly stop on first merge instead of failing
there.  This may have an impact on how uncommits are numbered.

- uncommit synopsis is incomplete (lacks " | -n <n> <basename>")

- after mass-uncommitting, more help to look at the stack would be
needed.  Eg. a "stg series" flag to print more commit info (author,
files), or to limit the listing to a given author (like "stg patches"
limits for a file).


Additionally, a couple of non-uncommit-related thing:

- when a push is not committed because of a conflict, looking at the
previous diff for the patch would help.  Maybe something like "stg
show --old" ?

- the help string for push should say "patches", and possibly document
more precisely the syntax, something like:

--- a/stgit/commands/push.py
+++ b/stgit/commands/push.py
@@ -24,8 +24,8 @@ from stgit.utils import *
 from stgit import stack, git
 
 
-help = 'push a patch on top of the series'
-usage = """%prog [options] [<patch1> [<patch2>...]]
+help = 'push patches on top of the series'
+usage = """%prog [options] [<patch1> [<patch2>...] | -n <n> <patchroot>]
 
 Push a patch (defaulting to the first unapplied one) or range of
 patches to the stack. The 'push' operation allows patch reordering by


- "push --undo" is not robust.  On the occasion reproduced below, I
had to rollback the push myself by hand-modifying the stgit data,
which took me some effort.  I'll have to gather precise info, but the
issue occurs on patch reordering, on a genuine conflict, and seems to
be involve a change to a non-existent file, when that file would have
been added by a non-applied patch originally below the one I attempted
to apply.

I do agree there is a conflict, but "push --undo" should definitely be
able to rollback in any case.

Here is the log:

========
Now at patch "patch9"
Pushing patch "patch10"...The merge failed during "push". Use "refresh"
after fixing the conflicts
stg push: GIT index merging failed (possible conflicts)

stg push: local changes in the tree. Use "refresh" to commit them
stg push: local changes in the tree. Use "refresh" to commit them
stg push: local changes in the tree. Use "refresh" to commit them
stg push: local changes in the tree. Use "refresh" to commit them
stg push: local changes in the tree. Use "refresh" to commit them
stg push: local changes in the tree. Use "refresh" to commit them
stg push: local changes in the tree. Use "refresh" to commit them
stg push: local changes in the tree. Use "refresh" to commit them
stg push: local changes in the tree. Use "refresh" to commit them
stg push: local changes in the tree. Use "refresh" to commit them
stg push: local changes in the tree. Use "refresh" to commit them
stg push: local changes in the tree. Use "refresh" to commit them
stg push: local changes in the tree. Use "refresh" to commit them
stg push: local changes in the tree. Use "refresh" to commit them
stg push: local changes in the tree. Use "refresh" to commit them
stg push: local changes in the tree. Use "refresh" to commit them
stg push: local changes in the tree. Use "refresh" to commit them
stg push: local changes in the tree. Use "refresh" to commit them

ydirson$ stg push --undo
Undoing the "patch10" push...stg push: ['git-diff-index', 'HEAD', 'path/to/the/file.java'] failed (fatal: ambiguous argument
'path/to/the/file.java': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions)
========

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
