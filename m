From: Chris Torek <chris.torek@gmail.com>
Subject: git stash doesn't always save work dir as-is: bug?
Date: Sat, 07 Sep 2013 18:40:25 -0600
Message-ID: <201309080040.r880ePlr094459@elf.torek.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 02:48:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VITAt-0002Co-Rq
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 02:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094Ab3IHAsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 20:48:21 -0400
Received: from 50-73-42-1-utah.hfc.comcastbusiness.net ([50.73.42.1]:19924
	"EHLO elf.torek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab3IHAsT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 20:48:19 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Sep 2013 20:48:19 EDT
Received: from elf.torek.net (localhost [127.0.0.1])
	by elf.torek.net (8.14.5/8.14.5) with ESMTP id r880ePlr094459
	for <git@vger.kernel.org>; Sat, 7 Sep 2013 18:40:25 -0600 (MDT)
	(envelope-from chris.torek@gmail.com)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (elf.torek.net [127.0.0.1]); Sat, 07 Sep 2013 18:40:25 -0600 (MDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234153>

When "git stash" does its work, if the index and the work
directory are out of sync, but the work directory is in sync with
the HEAD commit, the work directory commit does not contain the
file in its work-directory state, but rather in its index-state.

This seems wrong.  For instance, "git stash branch recover"
gets you the wrong work-directory state in the new branch.

Here's a simple test-case, its output (before and after ?fix?),
and a possible fix, although I'm not at all sure this doesn't
break other cases; I don't properly understand the code here.
(I did not touch the "$patch_mode" logic either as it's entirely
different, and looks correct at first blush.)

(Also, not that I have a patch for this, the man page DISCUSSION
section needs to add that there's a third parent holding unstaged
files when doing "git stash save -u".)

Chris

----snip---- test-stash.sh
#! /bin/sh

fatal()
{
	echo "$@" >&2
	exit 1
}

cd /tmp || fatal "can't cd to /tmp"
rm -rf test_stash || fatal "can't remove old test_stash"
mkdir test_stash &&
cd test_stash &&
git init -q || fatal "can't make test_stash"

echo base > basefile &&
git add basefile &&
git commit -q -m initial || fatal "can't create initial commit"

echo add to basefile >> basefile &&
git add basefile &&
sed -i .bak -e '2d' basefile || fatal "can't set up the problem"
rm -f basefile.bak

echo "status before stash:"
git status --short

git stash save || fatal "stash failed"

echo "stash created"
echo "in the index, basefile contains:"
git show stash^2:basefile | cat -n
echo
echo "in the WIP, basefile contains:"
git show stash:basefile | cat -n
echo
echo "in the actual basefile:"
cat -n basefile
----snip---- ./test-stash.sh (with original stash script)
status before stash:
MM basefile
Saved working directory and index state WIP on master: c334d9e initial
HEAD is now at c334d9e initial
stash created
in the index, basefile contains:
     1	base
     2	add to basefile

in the WIP, basefile contains:
     1	base
     2	add to basefile

in the actual basefile:
     1	base
----snip---- ./test-stash.sh (after ?fix?)
status before stash:
MM basefile
Saved working directory and index state WIP on master: 3097b8b initial
HEAD is now at 3097b8b initial
stash created
in the index, basefile contains:
     1	base
     2	add to basefile

in the WIP, basefile contains:
     1	base

in the actual basefile:
     1	base
----snip---- possible fix
commit 5288ca30b9425a8c3fd1eb179706275cda3eb717
Author: Chris Torek <chris.torek@gmail.com>
Date:   Sat Sep 7 18:13:31 2013 -0600

    stash: diff work dir against index
    
    When saving a full stash, compare the work directory against the
    already-saved index tree, rather than the HEAD commit, in case
    the work tree reverts things back to the HEAD.

diff --git a/git-stash.sh b/git-stash.sh
index 1e541a2..02818ae 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -115,7 +115,7 @@ create_stash () {
 			git read-tree --index-output="$TMPindex" -m $i_tree &&
 			GIT_INDEX_FILE="$TMPindex" &&
 			export GIT_INDEX_FILE &&
-			git diff --name-only -z HEAD -- >"$TMP-stagenames" &&
+			git diff --name-only -z $i_tree -- >"$TMP-stagenames" &&
 			git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
 			git write-tree &&
 			rm -f "$TMPindex"
