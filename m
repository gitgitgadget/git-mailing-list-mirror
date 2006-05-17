From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] Implement a --dry-run option to git-quiltimport
Date: Wed, 17 May 2006 14:10:25 -0600
Message-ID: <m1r72s2z0u.fsf_-_@ebiederm.dsl.xmission.com>
References: <m1k68l6hga.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0605161001190.3866@g5.osdl.org>
	<m1bqtx6el6.fsf@ebiederm.dsl.xmission.com>
	<7vbqtxaj5k.fsf@assigned-by-dhcp.cox.net>
	<m13bf95ixo.fsf@ebiederm.dsl.xmission.com>
	<7v1wut2p5z.fsf@assigned-by-dhcp.cox.net>
	<m1bqtw4hk7.fsf_-_@ebiederm.dsl.xmission.com>
	<7vsln8cwn6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 22:11:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgSMN-000526-Kg
	for gcvg-git@gmane.org; Wed, 17 May 2006 22:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWEQULE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 16:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWEQULE
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 16:11:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29331 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751071AbWEQULD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 16:11:03 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4HKAQmU020576;
	Wed, 17 May 2006 14:10:26 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4HKAQlj020575;
	Wed, 17 May 2006 14:10:26 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsln8cwn6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Wed, 17 May 2006 11:51:41 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20238>


Since large quilt trees like -mm can easily have patches
without clear authorship information, add a --dry-run
option to make the problem patches easy to find.

---

This patch should make it easy to communicate to Andrew
and others exactly which patches there are problems
with, and should make it possible to easily edit
those patches before they are imported.

 Documentation/git-quiltimport.txt |    8 +++++++-
 git-quiltimport.sh                |   24 ++++++++++++++++++------
 2 files changed, 25 insertions(+), 7 deletions(-)

cb0ff8090e1492f177a521b01cf987c16b125d81
diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
index e694537..97f4071 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -9,7 +9,7 @@ git-quiltimport - Applies a quilt patchs
 SYNOPSIS
 --------
 [verse]
-'git-quiltimport' [--author <author>] [--patches <dir>]
+'git-quiltimport' [--dry-run] [--author <author>] [--patches <dir>]
 
 
 DESCRIPTION
@@ -29,6 +29,12 @@ preserved as the 1 line subject in the g
 
 OPTIONS
 -------
+--dry-run::
+	Walk through the patches in the series and warn
+	if we cannot find all of the necessary information to commit
+	a patch.  At the time of this writing only missing author
+	information is warned about.
+
 --author Author Name <Author Email>::
 	The author name and email address to use when no author
 	information can be found in the patch description.
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index be43f9d..476e078 100644
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -1,8 +1,9 @@
 #!/bin/sh
-USAGE='--author <author> --patches </path/to/quilt/patch/directory>'
+USAGE='--dry-run --author <author> --patches </path/to/quilt/patch/directory>'
 SUBDIRECTORY_ON=Yes
 . git-sh-setup
 
+dry_run=""
 quilt_author=""
 while case "$#" in 0) break;; esac
 do
@@ -19,6 +20,11 @@ do
 		shift
 		;;
 
+	--dry-run)
+		shift
+		dry_run=1
+		;;
+
 	--pa=*|--pat=*|--patc=*|--patch=*|--patche=*|--patches=*)
 		QUILT_PATCHES=$(expr "$1" : '-[^=]*\(.*\)')
 		shift
@@ -75,8 +81,12 @@ for patch_name in $(cat "$QUILT_PATCHES/
 		if [ -n "$quilt_author" ] ; then
 			GIT_AUTHOR_NAME="$quilt_author_name";
 			GIT_AUTHOR_EMAIL="$quilt_author_email";
+	    	elif [ -n "$dry_run" ]; then
+			echo "No author found in $patch_name" >&2;
+			GIT_AUTHOR_NAME="dry-run-not-found";
+			GIT_AUTHOR_EMAIL="dry-run-not-found";
 		else
-			echo "No author found in $patch_name";
+			echo "No author found in $patch_name" >&2;
 			echo "---"
 			cat $tmp_msg
 			echo -n "Author: ";
@@ -98,9 +108,11 @@ for patch_name in $(cat "$QUILT_PATCHES/
 		SUBJECT=$(echo $patch_name | sed -e 's/.patch$//')
 	fi
 
-	git-apply --index -C1 "$tmp_patch" &&
-	tree=$(git-write-tree) &&
-	commit=$((echo "$SUBJECT"; echo; cat "$tmp_msg") | git-commit-tree $tree -p $commit) &&
-	git-update-ref HEAD $commit || exit 4
+	if [ -z "$dry_run" ] ; then
+		git-apply --index -C1 "$tmp_patch" &&
+		tree=$(git-write-tree) &&
+		commit=$((echo "$SUBJECT"; echo; cat "$tmp_msg") | git-commit-tree $tree -p $commit) &&
+		git-update-ref HEAD $commit || exit 4
+	fi	
 done
 rm -rf $tmp_dir || exit 5
-- 
1.3.2.g5041c-dirty
