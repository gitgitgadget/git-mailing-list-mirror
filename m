From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] gitk: Use GIT_DIR where appropriate.
Date: Thu, 28 Jul 2005 00:28:44 -0700
Message-ID: <7vpst3e6dv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 09:29:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dy2p5-0000dv-4q
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 09:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVG1H2u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 03:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVG1H2u
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 03:28:50 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:8138 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261308AbVG1H2u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 03:28:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050728072840.CDMS1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Jul 2005 03:28:40 -0400
To: Paul Mackerras <paulus@samba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Some places assumed .git is the GIT_DIR, resulting heads and
tags not showing when it was run like "GIT_DIR=. gitk --all".
This is not a contrived example --- I rely on it to verify
my private copy of git.git repository before pushing it out.

Define a single procedure "gitdir" and use it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** Paul, I will not be applying this to the copy Linus pulled
*** into git.git repository, but sending it to you in a patch
*** form.  I believe that would be easier for you to work with
*** than pulling from git.git along with all the other stuff.

 gitk |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

c41a6a0271ea966f5d5cd648b854ec78b90096a6
diff --git a/gitk b/gitk
--- a/gitk
+++ b/gitk
@@ -7,17 +7,22 @@ exec wish "$0" -- "${1+$@}"
 # and distributed under the terms of the GNU General Public Licence,
 # either version 2, or (at your option) any later version.
 
+proc gitdir {} {
+    global env
+    if {[info exists env(GIT_DIR)]} {
+	return $env(GIT_DIR)
+    } else {
+	return ".git"
+    }
+}
+
 proc getcommits {rargs} {
     global commits commfd phase canv mainfont env
     global startmsecs nextupdate
     global ctext maincursor textcursor leftover
 
     # check that we can find a .git directory somewhere...
-    if {[info exists env(GIT_DIR)]} {
-	set gitdir $env(GIT_DIR)
-    } else {
-	set gitdir ".git"
-    }
+    set gitdir [gitdir]
     if {![file isdirectory $gitdir]} {
 	error_popup "Cannot find the git directory \"$gitdir\"."
 	exit 1
@@ -212,7 +217,7 @@ proc parsecommit {id contents listed} {
 
 proc readrefs {} {
     global tagids idtags headids idheads
-    set tags [glob -nocomplain -types f .git/refs/tags/*]
+    set tags [glob -nocomplain -types f [gitdir]/refs/tags/*]
     foreach f $tags {
 	catch {
 	    set fd [open $f r]
@@ -241,7 +246,7 @@ proc readrefs {} {
 	    close $fd
 	}
     }
-    set heads [glob -nocomplain -types f .git/refs/heads/*]
+    set heads [glob -nocomplain -types f [gitdir]/refs/heads/*]
     foreach f $heads {
 	catch {
 	    set fd [open $f r]
@@ -2752,10 +2757,7 @@ proc domktag {} {
 	return
     }
     if {[catch {
-	set dir ".git"
-	if {[info exists env(GIT_DIR)]} {
-	    set dir $env(GIT_DIR)
-	}
+	set dir [gitdir]
 	set fname [file join $dir "refs/tags" $tag]
 	set f [open $fname w]
 	puts $f $id
