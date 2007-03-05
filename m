From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 3/3] git-checkout: add --track and --no-track options
Date: Mon, 05 Mar 2007 09:57:31 +0100
Message-ID: <esgm1r$33f$3@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 10:05:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO98L-00028D-No
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 10:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbXCEJFP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 04:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752757AbXCEJFP
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 04:05:15 -0500
Received: from main.gmane.org ([80.91.229.2]:40568 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752756AbXCEJFM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 04:05:12 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HO97v-00080w-NH
	for git@vger.kernel.org; Mon, 05 Mar 2007 10:05:03 +0100
Received: from usilu-ge.ti-edu.ch ([195.176.176.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Mar 2007 10:05:03 +0100
Received: from bonzini by usilu-ge.ti-edu.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Mar 2007 10:05:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: usilu-ge.ti-edu.ch
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41429>

This patch adds  --track and --no-track options to "git checkout".  In order to
do so, it modifies the script to use "git branch" to create the branch, and
passes the two options to "git branch".  The two new options are only
allowed when -b is given on the command-line, and they are only effective
when the branch is created off a remote branch.

The defaults for remote branch tracking are as for "git branch": it is off by
default, but it can be enabled with the configuration variable
"remote.REMOTENAME.trackintolocalbranches".
---
 Documentation/git-checkout.txt |   15 +++++++++++++--
 git-checkout.sh                |   17 +++++++++++------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 1ae77be..f5b2d50 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -8,7 +8,7 @@ git-checkout - Checkout and switch to a branch
 SYNOPSIS
 --------
 [verse]
-'git-checkout' [-q] [-f] [-b <new_branch> [-l]] [-m] [<branch>]
+'git-checkout' [-q] [-f] [-b [--track | --no-track] <new_branch> [-l]] [-m] [<branch>]
 'git-checkout' [<tree-ish>] <paths>...
 
 DESCRIPTION
@@ -18,7 +18,8 @@ When <paths> are not given, this command switches branches by
 updating the index and working tree to reflect the specified
 branch, <branch>, and updating HEAD to be <branch> or, if
 specified, <new_branch>.  Using -b will cause <new_branch> to
-be created.
+be created; in this case you can use the --track or --no-track
+options, which will be passed to `git branch`.
 
 When <paths> are given, this command does *not* switch
 branches.  It updates the named paths in the working tree from
@@ -45,6 +46,16 @@ OPTIONS
 	by gitlink:git-check-ref-format[1].  Some of these checks
 	may restrict the characters allowed in a branch name.
 
+--track::
+	When -b is given and a branch is created off a remote branch,
+	setup so that git-pull will automatically retrieve data from
+	the remote branch.
+
+--no-track::
+	When -b is given and a branch is created off a remote branch,
+	don't setup so that git-pull will not retrieve data from the
+	remote branch independent of the configuration settings.
+
 -l::
 	Create the new branch's ref log.  This activates recording of
 	all changes to made the branch ref, enabling use of date
diff --git a/git-checkout.sh b/git-checkout.sh
index 14835a4..6caa9fd 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -12,6 +12,7 @@ new=
 new_name=
 force=
 branch=
+track=
 newbranch=
 newbranch_log=
 merge=
@@ -33,7 +34,10 @@ while [ "$#" != "0" ]; do
 			die "git checkout: we do not like '$newbranch' as a branch name."
 		;;
 	"-l")
-		newbranch_log=1
+		newbranch_log=-l
+		;;
+	"--track"|"--no-track")
+		track="$arg"
 		;;
 	"-f")
 		force=1
@@ -85,6 +89,11 @@ while [ "$#" != "0" ]; do
     esac
 done
 
+case "$new_branch,$track" in
+,--*)
+	die "git checkout: --track and --no-track require -b"
+esac
+
 case "$force$merge" in
 11)
 	die "git checkout: -f and -m are incompatible"
@@ -235,11 +244,7 @@ fi
 #
 if [ "$?" -eq 0 ]; then
 	if [ "$newbranch" ]; then
-		if [ "$newbranch_log" ]; then
-			mkdir -p $(dirname "$GIT_DIR/logs/refs/heads/$newbranch")
-			touch "$GIT_DIR/logs/refs/heads/$newbranch"
-		fi
-		git-update-ref -m "checkout: Created from $new_name" "refs/heads/$newbranch" $new || exit
+		git-branch $track $newbranch_log "$newbranch" "$new_name" || exit
 		branch="$newbranch"
 	fi
 	if test -n "$branch"
-- 
1.4.4.2
