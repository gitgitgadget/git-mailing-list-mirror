From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [RFC] git-clone: add --track <headname> support
Date: Thu, 12 Apr 2007 22:08:59 +1200
Message-ID: <1176372539871-git-send-email-martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Apr 12 12:09:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbwEw-0002IP-J0
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 12:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946103AbXDLKJO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 06:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946116AbXDLKJO
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 06:09:14 -0400
Received: from smtp5.clear.net.nz ([203.97.33.68]:34392 "EHLO
	smtp5.clear.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946103AbXDLKJK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 06:09:10 -0400
Received: from localhost.localdomain
 (121-73-4-156.cable.telstraclear.net [121.73.4.156])
 by smtp5.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0JGD00KFNQV85320@smtp5.clear.net.nz> for git@vger.kernel.org;
 Thu, 12 Apr 2007 22:09:08 +1200 (NZST)
X-Mailer: git-send-email 1.5.1.106.ga32037
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44333>

Add support for a simplified workflow where users
want to clone and start working on a head that is
different from the HEAD of the repository.

Calling

   git-clone --track maint <repo>

Is equivalent to

   git-clone <repo> mydir
   cd mydir
   git-checkout --track -b maint origin/maint

--

Not sure if Junio wants this, but if I am going to migrate
away from cogito, I'd like these common operations to be
dead simple. 

This is something cogito supports using the <repo>#branchname
syntax. I am pretty sure git supports it when fetching
but alas, no longer for cloning. 

And if we want it, there are 2 things I'd ask review for

 - The --track parameter handling - I merely copied the 
   handling for other parameters. Clearly shell doesn't
   do this very elegantly, or at least we don't. 

 - The block that defines head_points_at (@360-370) looks 
   very brittle so I didn't want to mess with it. 

---
 git-clone.sh |   39 +++++++++++++++++++++++++++------------
 1 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index e98e064..c7b3e99 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -14,7 +14,7 @@ die() {
 }
 
 usage() {
-	die "Usage: $0 [--template=<template_directory>] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [--depth <n>] [-n] <repo> [<dir>]"
+	die "Usage: $0 [--template=<template_directory>] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [--track <head>] [--depth <n>] [-n] <repo> [<dir>]"
 }
 
 get_repo_base() {
@@ -85,6 +85,7 @@ bare=
 reference=
 origin=
 origin_override=
+track=
 use_separate_remote=t
 depth=
 no_progress=
@@ -105,6 +106,11 @@ while
 		shift; template="--template=$1" ;;
 	*,--template=*)
 	  template="$1" ;;
+	1,--track) usage ;;
+	*,--track)
+		shift; track="$1" ;;
+	*,--track=*)
+	  track="$1" ;;
 	*,-q|*,--quiet) quiet=-q ;;
 	*,--use-separate-remote) ;;
 	*,--no-separate-remote)
@@ -344,17 +350,22 @@ if test -z "$bare" && test -f "$GIT_DIR/REMOTE_HEAD"
 then
 	# a non-bare repository is always in separate-remote layout
 	remote_top="refs/remotes/$origin"
-	head_sha1=`cat "$GIT_DIR/REMOTE_HEAD"`
-	case "$head_sha1" in
-	'ref: refs/'*)
-		# Uh-oh, the remote told us (http transport done against
-		# new style repository with a symref HEAD).
-		# Ideally we should skip the guesswork but for now
-		# opt for minimum change.
-		head_sha1=`expr "z$head_sha1" : 'zref: refs/heads/\(.*\)'`
-		head_sha1=`cat "$GIT_DIR/$remote_top/$head_sha1"`
-		;;
-	esac
+	if test ! -z "$track" && test -f "refs/remotes/$origin/$track"
+	then
+		head_sha1=`cat "refs/remotes/$origin/$track"`
+	else
+		head_sha1=`cat "$GIT_DIR/REMOTE_HEAD"`
+		case "$head_sha1" in
+		'ref: refs/'*)
+			# Uh-oh, the remote told us (http transport done against
+			# new style repository with a symref HEAD).
+			# Ideally we should skip the guesswork but for now
+			# opt for minimum change.
+			head_sha1=`expr "z$head_sha1" : 'zref: refs/heads/\(.*\)'`
+			head_sha1=`cat "$GIT_DIR/$remote_top/$head_sha1"`
+			;;
+		esac
+	fi
 
 	# The name under $remote_top the remote HEAD seems to point at.
 	head_points_at=$(
@@ -376,6 +387,10 @@ then
 		done
 		)
 	)
+	if test -n "$track" && test -f "$GIT_DIR/$remote_top/$track"
+	then
+		head_points_at="$track"
+	fi
 
 	# Write out remote.$origin config, and update our "$head_points_at".
 	case "$head_points_at" in
-- 
1.5.1.106.ga32037
