From: Junio C Hamano <junkio@cox.net>
Subject: Re: Expected Behavior?
Date: Mon, 07 Nov 2005 22:00:11 -0800
Message-ID: <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net>
References: <E1EZKOB-0002j5-VY@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 07:00:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZMWq-0008A3-35
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 07:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVKHGAP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 01:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVKHGAP
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 01:00:15 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:38081 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751095AbVKHGAN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 01:00:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051108055911.XEDX24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Nov 2005 00:59:11 -0500
To: Jon Loeliger <jdl@freescale.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11313>

Jon Loeliger <jdl@freescale.com> writes:

> That is, after the merge, file3 appears to have simply kept
> the contents of the current, master branch.  Why wasn't the
> dev branch represented here?
>
> I _almost_ think I get it, and then *poof*...

Automerge completely punted for this path, and at this point, it
is still unmerged:

------------
$ git ls-files --unmerged
100644 c4da0eb.... 2       file3
100644 fbc2aa4.... 3       file3
------------

Three-way "git-read-tree -m -u O A B" (O is for old, A is ours
and B is hers) puts O in stage1, A in stage2 and B in stage3.
This path did not exist in O so we only have them in stage2 and
stage3.  You could compare the stages like this:

------------
$ git diff-stages -p 2 3 file3
diff --git a/file3 b/file3
index c4da0eb..fbc2aa4 100644
--- a/file3
+++ b/file3
@@ -1 +1 @@
-Stuff for a conflict.
+Another file!
------------

When we do a file-level merge (and possibly leave conflicts), we
register _our_ version in the index and leave the merge result
in the working tree.  However, when O is empty like this case,
we leave the conflicting path simply unmerged and do not touch
the working tree.  We say "ERROR: not handling case" when this
happens.

Nobody complained so far about this, probably because two side
adding different versions is rare enough.  And the reasoning
behind the current behaviour is probably because the tool cannot
automerge them sensibly anyway.  Leaving the SHA1 in index file
might probably be easier to clean up by hand (e.g. see ls-files
--unmerged, and cut&paste the desired SHA1 to 'git-cat-file
blob' command line, or something silly like that).  But if we
were to go that route, adding --stage=[123] flag so that the
user can say 'git-checkout-index --stage=3 file3'might have
helped a bit more.

We could instead use the attached patch to get the behaviour you
are expecting.  I have a feeling that the result from this might
be a little more intuitive and easier to resolve by hand than
the current one.  Although we may end up unresolvable mess in
file3 if either side is binary, in that case the user can still
sift through 'diff-tree A B file3' output to find out the
relevant SHA1 to recover the blobs from both sides by hand
anyway.  Does anybody have strong opinion on this?

--
[PATCH] merge with /dev/null as base, instead of not handling O=='' case

Instead of leaving the path unmerged in a case where each side
adds different version of the same path, attempt to merge it
with empty base and leave "our" version in the index file, just
like we do for the case in conflicting merge.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 5419e59..32e17cb 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -56,9 +56,18 @@ case "${1:-.}${2:-.}${3:-.}" in
 #
 # Modified in both, but differently.
 #
-"$1$2$3")
-	echo "Auto-merging $4."
-	orig=`git-unpack-file $1`
+"$1$2$3" | ".$2$3")
+	case "$1" in
+	'')
+		echo "Added $4 in both, but differently."
+		orig=`git-unpack-file $2`
+		: >$orig
+		;;
+	*)
+		echo "Auto-merging $4."
+		orig=`git-unpack-file $1`
+		;;
+	esac
 	src2=`git-unpack-file $3`
 
 	# We reset the index to the first branch, making
@@ -73,6 +82,9 @@ case "${1:-.}${2:-.}${3:-.}" in
 		echo "ERROR: Permissions conflict: $5->$6,$7."
 		ret=1
 	fi
+	if [ "$1" = '' ]; then
+		ret=1
+	fi
 
 	if [ $ret -ne 0 ]; then
 		echo "ERROR: Merge conflict in $4."
