From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-mergetool to run an appropriate merge conflict resolution program
Date: Wed, 28 Mar 2007 20:58:49 -0700
Message-ID: <7vabxwbszq.fsf@assigned-by-dhcp.cox.net>
References: <E1HORtY-0000zK-8B@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 29 05:59:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWln3-0006N2-Eq
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 05:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbXC2D6v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 23:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbXC2D6v
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 23:58:51 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:39382 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194AbXC2D6u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 23:58:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070329035849.JHSF792.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 28 Mar 2007 23:58:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id gTyo1W00R1kojtg0000000; Wed, 28 Mar 2007 23:58:49 -0400
In-Reply-To: <E1HORtY-0000zK-8B@candygram.thunk.org> (Theodore Ts'o's message
	of "Tue, 06 Mar 2007 00:07:28 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43401>

I had a chance to use git-mergetool in real life for the first
time today, when I merged 'maint' into 'master'.  It has a
symlink vs symlink conflict, so I got something like this:

================================================================
Merging the files: RelNotes

Symlink merge conflict for RelNotes:
    'RelNotes' is a symlink containing 'Documentation/RelNotes-1.5.1.txt' in the local branch
    'RelNotes' is a symlink containing 'Documentation/RelNotes-1.5.0.6.txt' in the remote branch
Use (r)emote or (l)ocal, or (a)bort?
================================================================

A few observations.

(1) Saying "a" <Return> does not let me exit.  It keeps asking
    the same question.

(2) The word "symlink" might be less geekish if worded "symbolic
    link".

(3) The message look very long, and repeats the same information.

(4) The status info gives local and then remote, but the choice
    is between remote and local.

The attached is a minimum fix for the above issues, but not for
immediate application, as I am sure the rewording would make
messages inconsistent with other cases.  The updated output
would look like this:

================================================================
Merging the files: RelNotes

Symbolic link merge conflict for 'RelNotes':
  local: a symbolic link -> 'Documentation/RelNotes-1.5.1.txt'
  remote: a symbolic link -> 'Documentation/RelNotes-1.5.0.6.txt'
Use (l)ocal or (r)emote, or (a)bort? l
================================================================

---
 git-mergetool.sh |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 7942fd0..0b30133 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -44,27 +44,24 @@ function describe_file () {
     branch="$2"
     file="$3"
 
-    echo -n "    "
+    echo -n "  ${branch}: "
     if test -z "$mode"; then
-	echo -n "'$path' was deleted"
+	echo "deleted"
     elif is_symlink "$mode" ; then
-	echo -n "'$path' is a symlink containing '"
-	cat "$file"
-	echo -n "'"
+	echo "a symbolic link -> '$(cat "$file")'"
     else
 	if base_present; then
-	    echo -n "'$path' was created"
+	    echo "created"
 	else
-	    echo -n "'$path' was modified"
+	    echo "modified"
 	fi
     fi
-    echo " in the $branch branch"
 }
 
 
 resolve_symlink_merge () {
     while /bin/true; do
-	echo -n "Use (r)emote or (l)ocal, or (a)bort? "
+	echo -n "Use (l)ocal or (r)emote, or (a)bort? "
 	read ans
 	case "$ans" in
 	    [lL]*)
@@ -79,7 +76,7 @@ resolve_symlink_merge () {
 		cleanup_temp_files --save-backup
 		return
 		;;
-	    [qQ]*)
+	    [aAqQ]*)
 		exit 1
 		;;
 	    esac
@@ -147,7 +144,7 @@ merge_file () {
     fi
 
     if is_symlink "$local_mode" || is_symlink "$remote_mode"; then
-	echo "Symlink merge conflict for $path:"
+	echo "Symbolic link conflict for '$path':"
 	describe_file "$local_mode" "local" "$LOCAL"
 	describe_file "$remote_mode" "remote" "$REMOTE"
 	resolve_symlink_merge
