From: Michal Ostrowski <mostrows@watson.ibm.com>
Subject: [PATCH] --upload-pack for git-fetch
Date: Fri, 20 Jan 2006 13:05:24 -0500
Message-ID: <E1F00dY-0002XH-Nw@heater.watson.ibm.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 19:00:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F00Yc-0004Ee-Go
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 19:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWATSAP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 13:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWATSAO
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 13:00:14 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:11152 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1751126AbWATSAN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 13:00:13 -0500
Received: from sp1n294en1.watson.ibm.com (sp1n294en1.watson.ibm.com [129.34.20.40])
	by igw2.watson.ibm.com (8.12.11/8.13.1/8.13.1-2005-04-25 igw) with ESMTP id k0KI0Awi030110
	for <git@vger.kernel.org>; Fri, 20 Jan 2006 13:00:10 -0500
Received: from sp1n294en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with ESMTP id k0KI09v336002
	for <git@vger.kernel.org>; Fri, 20 Jan 2006 13:00:09 -0500
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with ESMTP id k0KI09s153610
	for <git@vger.kernel.org>; Fri, 20 Jan 2006 13:00:09 -0500
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id k0KIxdUL022060
	for <git@vger.kernel.org>; Fri, 20 Jan 2006 13:59:39 -0500
Received: from heater.watson.ibm.com (heater.watson.ibm.com [9.2.222.55])
	by kitch0.watson.ibm.com (AIX5.1/8.11.6p2/8.11.0/03-06-2002) with ESMTP id k0KI05m18652
	for <git@vger.kernel.org>; Fri, 20 Jan 2006 13:00:06 -0500
Received: from mostrows by heater.watson.ibm.com with local (Exim 4.51)
	id 1F00dY-0002XH-Nw
	for git@vger.kernel.org; Fri, 20 Jan 2006 13:05:24 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14971>

Implement  "git-clone"'s "--upload-pack" parameter in git-fetch, making
it available for git-pull.  Without this, there is no way to specify a
remote executable when invoking git-pull/git-fetch as there is for
git-clone.

Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>

---

 Documentation/fetch-options.txt |    7 +++++++
 git-fetch.sh                    |    8 +++++++-
 2 files changed, 14 insertions(+), 1 deletions(-)

0b6314bc51945c2ce1e4c8627a00779c23bef3e1
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index e624d3d..8323756 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -3,6 +3,13 @@
 	existing contents of `.git/FETCH_HEAD`.  Without this
 	option old data in `.git/FETCH_HEAD` will be overwritten.
 
+--upload-pack <upload-pack>::
+-u <upload-pack>::
+        When given, and the repository to fetch from is handled
+        by 'git-fetch-pack', '--exec=<upload-pack>' is passed to
+        the command to specify non-default path for the command
+        run on the other end.
+
 -f, \--force::
 	When `git-fetch` is used with `<rbranch>:<lbranch>`
 	refspec, it refuses to update the local branch
diff --git a/git-fetch.sh b/git-fetch.sh
index 4a0cb32..d1659e2 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -17,12 +17,18 @@ append=
 force=
 verbose=
 update_head_ok=
+exec=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
 	-a|--a|--ap|--app|--appe|--appen|--append)
 		append=t
 		;;
+	-u|--u|--up|--upl|--uploa|--upload|--upload-|--upload-p|--upload-pa|\
+	--upload-pac|--upload-pack)
+		shift
+		exec="--exec=$1" 
+		;;
 	-f|--f|--fo|--for|--forc|--force)
 		force=t
 		;;
@@ -312,7 +318,7 @@ fetch_main () {
     ( : subshell because we muck with IFS
       IFS=" 	$LF"
       (
-	  git-fetch-pack $keep "$remote" $rref || echo failed "$remote"
+	  git-fetch-pack $exec $keep "$remote" $rref || echo failed "$remote"
       ) |
       while read sha1 remote_name
       do
-- 
1.1.4.ge755-dirty
