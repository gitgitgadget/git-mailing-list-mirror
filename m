From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] fetch: optionally store the current remote information
 in the config
Date: Sun, 30 Apr 2006 15:24:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604301524080.2646@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Apr 30 15:24:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaBui-0002oO-5u
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 15:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWD3NYY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 09:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWD3NYY
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 09:24:24 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:5546 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751117AbWD3NYX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 09:24:23 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 48C661CA0
	for <git@vger.kernel.org>; Sun, 30 Apr 2006 15:24:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 3D29E1BA6
	for <git@vger.kernel.org>; Sun, 30 Apr 2006 15:24:22 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 214CD17E8
	for <git@vger.kernel.org>; Sun, 30 Apr 2006 15:24:22 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19337>


Instead of editing files, you can now say

	git pull --store junio \
		git://git.kernel.org/pub/scm/git/git.git next:next

and next time, just

	git pull junio

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	This is what the patch series is all about.

	If there is no interest in a feature like this, let's just forget
	about the whole "remote info in config" thing.

	If there is interest, I could add the same functionality to
	builtin-push.

 Documentation/fetch-options.txt |    6 ++++++
 git-fetch.sh                    |   19 +++++++++++++++++++
 git-pull.sh                     |    8 ++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

6bd937b0de211465e9664f8dc890fc5066617b73
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 13f34d3..caf98de 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -16,6 +16,12 @@
 	fetches is a descendant of `<lbranch>`.  This option
 	overrides that check.
 
+-S, \--store <nick>::
+	Store the URL and the refnames in the config file so that
+	`git fetch <nick>` repeats the exercise.
+	If the nick exists already, edit the URL, but append the
+	refnames.
+
 \--no-tags::
 	By default, `git-fetch` fetches tags that point at
 	objects that are downloaded from the remote repository
diff --git a/git-fetch.sh b/git-fetch.sh
index 280f62e..ac122da 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -15,8 +15,10 @@ no_tags=
 tags=
 append=
 force=
+keep=
 verbose=
 update_head_ok=
+store=
 exec=
 upload_pack=
 while case "$#" in 0) break ;; esac
@@ -34,6 +36,10 @@ do
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
@@ -235,6 +241,12 @@ then
 	fi
 fi
 
+if test "$store"
+then
+    git-repo-config remote."$store".url $remote ||
+	die "Could not store into $store"
+fi
+
 fetch_main () {
   reflist="$1"
   refs=
@@ -243,6 +255,11 @@ fetch_main () {
   do
       refs="$refs$LF$ref"
 
+      if test "$store"
+      then
+	  git-repo-config remote."$store".pull "$ref" '^$'
+      fi
+
       # These are relative path from $GIT_DIR, typically starting at refs/
       # but may be HEAD
       if expr "z$ref" : 'z\.' >/dev/null
@@ -381,6 +398,8 @@ fetch_main () {
 
 fetch_main "$reflist"
 
+store=
+
 # automated tag following
 case "$no_tags$tags" in
 '')
diff --git a/git-pull.sh b/git-pull.sh
index 4611ae6..ab0fba3 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -8,7 +8,7 @@ USAGE='[-n | --no-summary] [--no-commit]
 LONG_USAGE='Fetch one or more remote refs and merge it/them into the current HEAD.'
 . git-sh-setup
 
-strategy_args= no_summary= no_commit=
+strategy_args= no_summary= no_commit= store=
 while case "$#,$1" in 0) break ;; *,-*) ;; *) break ;; esac
 do
 	case "$1" in
@@ -31,6 +31,10 @@ do
 		esac
 		strategy_args="${strategy_args}-s $strategy "
 		;;
+	-S|--store)
+		store="-S $2"
+		shift
+		;;
 	-h|--h|--he|--hel|--help)
 		usage
 		;;
@@ -43,7 +47,7 @@ do
 done
 
 orig_head=$(git-rev-parse --verify HEAD) || die "Pulling into a black hole?"
-git-fetch --update-head-ok "$@" || exit 1
+git-fetch --update-head-ok $store "$@" || exit 1
 
 curr_head=$(git-rev-parse --verify HEAD)
 if test "$curr_head" != "$orig_head"
-- 
1.3.1.g38c00-dirty
