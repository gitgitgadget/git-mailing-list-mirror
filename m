From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC] git-fetch: Optionally store fetch information under a nick
Date: Fri, 16 Dec 2005 15:16:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512161514490.8170@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Dec 16 15:18:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnGNj-0006gR-00
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 15:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVLPOQT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 09:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVLPOQT
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 09:16:19 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:7590 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932150AbVLPOQT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 09:16:19 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 214BE13FB64; Fri, 16 Dec 2005 15:16:18 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0AEFF9DEFE; Fri, 16 Dec 2005 15:16:18 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id EB6999DE45; Fri, 16 Dec 2005 15:16:17 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BD2FB13FB64; Fri, 16 Dec 2005 15:16:17 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13735>


This is on top of my .git/remotes/* -> .git/config patch. With this, you
can do:

	git pull -S junio git://git.kernel.org/pub/scm/git/git.git \
		master:junio todo:todo +pu:pu

once, and after that,

	git pull junio

will have the same effect.

Signed-off-by: Johannes "always off by one" Schindelin <Johannes.Schindelin@gmx.de>

---

	This was what git-repo-config was all about, but I backed off a
	little when I felt not much enthusiasm for remote information in
	the config.

	However, when I tried to get a CVS user to work *with* (as opposed
	to *on*) git, he told me that he was sick of editing files, and
	if there would be a more user friendly way to store the remote
	information. So, I whipped this up.

 Documentation/fetch-options.txt |    6 ++++++
 git-fetch.sh                    |   16 ++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

2bbb9ef0fc8601a91f0b36ad27a7e2be09cc6e46
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 200c9b2..a1d9210 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -10,6 +10,12 @@
 	fetches is a descendant of `<lbranch>`.  This option
 	overrides that check.
 
+-S, \--store <nick>::
+	Store the URL and the refnames in the config file so that
+	`git fetch <nick>` repeats the exercise.
+	If the nick exists already, edit the URL, but append the
+	refnames.
+
 -t, \--tags::
 	By default, the git core utilities will not fetch and store
 	tags under the same name as the remote repository;  ask it
diff --git a/git-fetch.sh b/git-fetch.sh
index 0a4fc98..f3f6146 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -16,6 +16,7 @@ append=
 force=
 verbose=
 update_head_ok=
+store=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
@@ -25,6 +26,10 @@ do
 	-f|--f|--fo|--for|--forc|--force)
 		force=t
 		;;
+	-S|--s|--st|--sto|--stor|--store)
+		store="$2"
+		shift
+		;;
 	-t|--t|--ta|--tag|--tags)
 		tags=t
 		;;
@@ -204,10 +209,21 @@ then
 	fi
 fi
 
+if test "$store"
+then
+    git-repo-config remote."$store".url $remote ||
+	die "Could not store into $store"
+fi
+
 for ref in $reflist
 do
     refs="$refs$LF$ref"
 
+    if test "$store"
+    then
+	git-repo-config remote."$store".pull "$ref" '^$'
+    fi
+
     # These are relative path from $GIT_DIR, typically starting at refs/
     # but may be HEAD
     if expr "$ref" : '\.' >/dev/null
-- 
0.99.9.GIT
