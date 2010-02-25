From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [RFC,PATCH] git-amend -- darcs like amend-record for git
Date: Thu, 25 Feb 2010 17:16:05 +0300
Message-ID: <1267107365-2973-1-git-send-email-kirr@mns.spb.ru>
Cc: Kirill Smelkov <kirr@mns.spb.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 15:18:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkeYH-000606-MH
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 15:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694Ab0BYOSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 09:18:48 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:40009 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932680Ab0BYOSr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 09:18:47 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1NkeY9-0006Hu-Qz; Thu, 25 Feb 2010 17:18:45 +0300
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1NkeVf-0000mU-H6; Thu, 25 Feb 2010 17:16:11 +0300
X-Mailer: git-send-email 1.7.0.91.g9803
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141049>

Ever wanted to type `git commit --amend HEAD~3` ? But had to fall back to commit
and interactive rebase with fixup? And was tired by a lot of typing? And also
rebase works only on clean worktree, so stash save and stash pop have to be
used...

Forget it.

Now one can just do `git add ...` to prepare index, and then
`git amend <commit>` to merge that changes from index into <commit>.

Yes, it uses rebase behind the scenes (or better sequencer, when it is
available), but the end result is less typing and much better usability for
humans. And it even tries to work in dirty worktree...

So operations like amending HEAD~3 take not significanltly more time, than
just amending HEAD with already available `git commit --amend`.

It's only a prototype, without documentation and tests, just an RFC.

If you find the idea useful, please let me know. In case people want something
like this, I'll try to polish it for inclusion into git.

Thanks,
Kirill
---
 contrib/git-amend.sh |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)
 create mode 100755 contrib/git-amend.sh

diff --git a/contrib/git-amend.sh b/contrib/git-amend.sh
new file mode 100755
index 0000000..1778594
--- /dev/null
+++ b/contrib/git-amend.sh
@@ -0,0 +1,53 @@
+#!/bin/sh -e
+# git-amend: darcs like amend-record for git
+# FIXME error handling
+
+USAGE="<commit>"
+. git-sh-setup
+
+test "$#" = 1 || usage
+
+commit=$1
+
+# let's see if $commit is a valid one, and also transform it to sha1 for it not
+# to be dependant on current HEAD
+commit=$(git rev-parse "$commit")
+
+# look out merges!
+test -z "$(git log --merges ${commit}~..HEAD)" || \
+	die "E: can't amend commits behind merges"
+
+# commit index, allowing empty commit just for being able to amend patch
+# description
+git commit --allow-empty -m "amend for $commit"
+
+# save worktree/index state
+work=$(git stash create)
+test -n "$work" && git update-ref HEAD.amend-backup $work
+
+# reset to clean work/index before going into rebase
+git reset --hard HEAD
+
+fixup_cmd=$(mktemp -t git-amend-fixupcmd.XXXXXX)
+rest_cmd=$(mktemp -t git-amend-restcmd.XXXXXX)
+trap 'rm -f "$fixup_cmd" "$rest_cmd"' 0
+{
+echo -ne "pick\t";  git log --pretty=oneline -1 ${commit}
+echo -ne "fixup\t"; git log --pretty=oneline -1 ${HEAD}
+} > "$fixup_cmd"
+
+git log --pretty=oneline --reverse ${commit}..HEAD~ | awk '{print "pick\t" $0;}' \
+	> "$rest_cmd"
+
+# now let's apply fixup part to commit
+GIT_EDITOR="cat $fixup_cmd >" git rebase -i ${commit}~
+
+# reword it
+git commit -v --amend
+
+# and apply rest
+GIT_EDITOR="cat $rest_cmd >" git rebase -i HEAD
+
+
+# restore worktree/index state
+test -n "$work" && git stash apply --index $work
-- 
1.7.0.91.g9803
