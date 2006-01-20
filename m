From: Michal Ostrowski <mostrows@watson.ibm.com>
Subject: [PATCH] git-{fetch,peek-remote} handling of --upload-pack
Date: Fri, 20 Jan 2006 13:38:16 -0500
Message-ID: <E1F019M-0003Cf-Ln@heater.watson.ibm.com>
Cc: mostrows@watson.ibm.com
X-From: git-owner@vger.kernel.org Fri Jan 20 19:33:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F014M-0003Rw-RE
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 19:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWATSdD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 13:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWATSdD
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 13:33:03 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:34458 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1751142AbWATSdB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 13:33:01 -0500
Received: from sp1n293en1.watson.ibm.com (sp1n293en1.watson.ibm.com [129.34.20.41])
	by igw2.watson.ibm.com (8.12.11/8.13.1/8.13.1-2005-04-25 igw) with ESMTP id k0KIX0bq005505
	for <git@vger.kernel.org>; Fri, 20 Jan 2006 13:33:00 -0500
Received: from sp1n293en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with ESMTP id k0KIWx5331058
	for <git@vger.kernel.org>; Fri, 20 Jan 2006 13:32:59 -0500
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with ESMTP id k0KIWwo331056
	for <git@vger.kernel.org>; Fri, 20 Jan 2006 13:32:59 -0500
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id k0KJWVds022171
	for <git@vger.kernel.org>; Fri, 20 Jan 2006 14:32:31 -0500
Received: from heater.watson.ibm.com (heater.watson.ibm.com [9.2.222.55])
	by kitch0.watson.ibm.com (AIX5.1/8.11.6p2/8.11.0/03-06-2002) with ESMTP id k0KIWvm34738;
	Fri, 20 Jan 2006 13:32:58 -0500
Received: from mostrows by heater.watson.ibm.com with local (Exim 4.51)
	id 1F019M-0003Cf-Ln; Fri, 20 Jan 2006 13:38:16 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14974>

git-peek-remote needs to handle a -u|--upload-pack parameter just like
git-fetch (and git-fetch has to pass it on to git-peek-remote).

(This is actually a follow-up to my previous git-fetch patch.)

Signed-off-by: Michal Ostrowski <mostrows@heater.watson.ibm.com>

---

 git-fetch.sh     |    6 ++++--
 git-ls-remote.sh |   13 ++++++++++---
 2 files changed, 14 insertions(+), 5 deletions(-)

86e69492820679894278a20dd9d9768a07f78f96
diff --git a/git-fetch.sh b/git-fetch.sh
index d1659e2..6b02098 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -18,6 +18,7 @@ force=
 verbose=
 update_head_ok=
 exec=
+upload_pack=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
@@ -28,6 +29,7 @@ do
 	--upload-pac|--upload-pack)
 		shift
 		exec="--exec=$1" 
+		upload_pack="-u $1"
 		;;
 	-f|--f|--fo|--for|--forc|--force)
 		force=t
@@ -202,7 +204,7 @@ reflist=$(get_remote_refs_for_fetch "$@"
 if test "$tags"
 then
 	taglist=$(IFS="	" &&
-		  git-ls-remote --tags "$remote" |
+		  git-ls-remote $upload_pack --tags "$remote" |
 	          while read sha1 name
 		  do
 			case "$name" in
@@ -367,7 +369,7 @@ fetch_main "$reflist"
 case "$no_tags$tags" in
 '')
 	taglist=$(IFS=" " &&
-    	git-ls-remote --tags "$remote" |
+    	git-ls-remote $upload_pack --tags "$remote" |
 	sed -ne 's|^\([0-9a-f]*\)[ 	]\(refs/tags/.*\)^{}$|\1 \2|p' |
 	while read sha1 name
 	do
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index f699268..64f37af 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -2,7 +2,8 @@
 #
 
 usage () {
-    echo >&2 "usage: $0 [--heads] [--tags] <repository> <refs>..."
+    echo >&2 "usage: $0 [--heads] [--tags] [-u|--upload-pack <upload-pack>]"
+    echo >&2 "          <repository> <refs>..."
     exit 1;
 }
 
@@ -11,6 +12,7 @@ die () {
     exit 1
 }
 
+exec=
 while case "$#" in 0) break;; esac
 do
   case "$1" in
@@ -18,6 +20,11 @@ do
   heads=heads; shift ;;
   -t|--t|--ta|--tag|--tags)
   tags=tags; shift ;;
+  -u|--u|--up|--upl|--uploa|--upload|--upload-|--upload-p|--upload-pa|\
+  --upload-pac|--upload-pack)
+	shift
+	exec="--exec=$1" 
+	shift;;
   --)
   shift; break ;;
   -*)
@@ -34,7 +41,7 @@ case ",$heads,$tags," in
 esac
 
 . git-parse-remote
-peek_repo="$(get_remote_url "$@")"
+peek_repo="$(get_remote_url $*)"
 shift
 
 tmp=.ls-remote-$$
@@ -66,7 +73,7 @@ rsync://* )
 	;;
 
 * )
-	git-peek-remote "$peek_repo" ||
+	git-peek-remote $exec "$peek_repo" ||
 		echo "failed	slurping"
 	;;
 esac |
-- 
1.1.4.g0b63-dirty
