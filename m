From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] filter-branch: fix dirty way to provide the helpers to commit
 filters
Date: Wed, 28 Nov 2007 15:50:38 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711281549550.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 28 16:51:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxPBs-0003eN-B0
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 16:51:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757607AbXK1Pus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 10:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757548AbXK1Pur
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 10:50:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:50126 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757202AbXK1Pur (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 10:50:47 -0500
Received: (qmail invoked by alias); 28 Nov 2007 15:50:44 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp007) with SMTP; 28 Nov 2007 16:50:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jxL1lQ3ljhOpxT8ELu/VB3Pc4lI2X7DQLAIoo3p
	s7EAd/jsrGk87U
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66360>


The helper functions 'map' and 'skip_commit' were provided to commit
filters by sourcing filter-branch itself.  This was done with a certain
environment variable set to indicate that only the functions should be
defined, and the script should return then.

This was really hacky, and it did not work all that well, since the
full path to git-filter-branch was not known at all times.

Avoid that by putting the functions into a variable, and eval'ing
that variable.  The commit filter gets these functions by prepending
the variable to the specified commands.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Frankly, I have no idea why this worked, but it did.  However,
	we had to replace the spawnvpe() function in msysGit with a
	custom version (thanks Hannes!) to avoid cmd windows popping up
	all over the place, and the method to source the first part of
	the script back in commit filters failed.

	Independently, I think that this version is nicer.

 git-filter-branch.sh |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index c9f515d..19cab5a 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -8,6 +8,9 @@
 # a new branch. You can specify a number of filters to modify the commits,
 # files and trees.
 
+# The following functions will also be available in the commit filter:
+
+functions=$(cat << \EOF
 warn () {
         echo "$*" >&2
 }
@@ -46,6 +49,10 @@ die()
 	echo "$*" >&2
 	exit 1
 }
+EOF
+)
+
+eval "$functions"
 
 # When piped a commit, output a script to set the ident of either
 # "author" or "committer
@@ -80,11 +87,6 @@ set_ident () {
 	echo "[ -n \"\$GIT_${uid}_NAME\" ] || export GIT_${uid}_NAME=\"\${GIT_${uid}_EMAIL%%@*}\""
 }
 
-# This script can be sourced by the commit filter to get the functions
-test "a$SOURCE_FUNCTIONS" = a1 && return
-this_script="$(cd "$(dirname "$0")"; pwd)"/$(basename "$0")
-export this_script
-
 USAGE="[--env-filter <command>] [--tree-filter <command>] \
 [--index-filter <command>] [--parent-filter <command>] \
 [--msg-filter <command>] [--commit-filter <command>] \
@@ -156,7 +158,7 @@ do
 		filter_msg="$OPTARG"
 		;;
 	--commit-filter)
-		filter_commit='SOURCE_FUNCTIONS=1 . "$this_script";'" $OPTARG"
+		filter_commit="$functions; $OPTARG"
 		;;
 	--tag-name-filter)
 		filter_tag_name="$OPTARG"
-- 
1.5.3.6.2065.gd47ac
