From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] guilt(1): reimplement push_patch, using a subshell to avoid locals.
Date: Thu, 14 Jun 2007 14:50:59 +0200
Message-ID: <11818254623497-git-send-email-madcoder@debian.org>
References: <11818254621527-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Josef Jeff Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Jun 14 14:51:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyonT-0003Jt-1p
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 14:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbXFNMvM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 08:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbXFNMvM
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 08:51:12 -0400
Received: from pan.madism.org ([88.191.52.104]:60895 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbXFNMvE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 08:51:04 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3B032DA64;
	Thu, 14 Jun 2007 14:51:03 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 77DA692950; Thu, 14 Jun 2007 14:51:02 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11818254621527-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50194>

  this is a bit ugly, but makes the code really shorter, and more readable
anyway. We still need the old bail variable, named __push_patch_bail to
avoid spurious collisions (we are not recursing into ourselves, so it's
safe).

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 guilt |  133 ++++++++++++++++++++++++-----------------------------------------
 1 files changed, 49 insertions(+), 84 deletions(-)

diff --git a/guilt b/guilt
index 44273f3..f77c050 100755
--- a/guilt
+++ b/guilt
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2006, 2007
 #
@@ -341,106 +341,71 @@ update_stack_tags()
 # usage: push_patch patchname [bail_action]
 push_patch()
 {
-	local p="$GUILT_DIR/$branch/$1"
-	local pname="$1"
-	local bail_action="$2"
+	__push_patch_bail=0
 
-	local bail=0
-	local reject="--reject"
-
-	assert_head_check
-
-	cd "$TOP_DIR"
+	(
+		p="$GUILT_DIR/$branch/$1"
+		pname="$1"
+		bail_action="$2"
+		reject="--reject"
 
-	# apply the patch if and only if there is something to apply
-	if [ `git-apply --numstat "$p" | wc -l` -gt 0 ]; then
-		if [ "$bail_action" = abort ]; then
-		    reject=""
-		fi
-		git-apply -C$guilt_push_diff_context \
-			$reject "$p" > /dev/null 2> /tmp/guilt.log.$$
-		bail=$?
+		assert_head_check
+		cd "$TOP_DIR"
 
-		if [ $bail -ne 0 ]; then
-			cat /tmp/guilt.log.$$ >&2
+		# apply the patch if and only if there is something to apply
+		if [ `git-apply --numstat "$p" | wc -l` -gt 0 ]; then
 			if [ "$bail_action" = abort ]; then
-				return $bail
+				reject=""
+			fi
+			git-apply -C$guilt_push_diff_context \
+				$reject "$p" > /dev/null 2> /tmp/guilt.log.$$
+			__push_patch_bail=$?
+
+			if [ $__push_patch_bail -ne 0 ]; then
+				cat /tmp/guilt.log.$$ >&2
+				if [ "$bail_action" = "abort" ]; then
+					rm -f /tmp/guilt.log.$$ /tmp/guilt.msg.$$
+					return $__push_patch_bail
+				fi
 			fi
-		fi
-
-		# FIXME: Path munging is being done, we need to convince
-		# git-apply to just give us list of files with \0 as a
-		# delimiter, and pass -z to git-update-index
-		git-apply --numstat "$p" | cut -f 3- | git-update-index --add --remove --stdin
-	fi
 
-	# grab a commit message out of the patch
-	do_get_header "$p" > /tmp/guilt.msg.$$
+			# FIXME: Path munging is being done, we need to convince
+			# git-apply to just give us list of files with \0 as a
+			# delimiter, and pass -z to git-update-index
+			git-apply --numstat "$p" | cut -f 3- | git-update-index --add --remove --stdin
+		fi
 
-	# make a default commit message if patch doesn't contain one
-	[ ! -s /tmp/guilt.msg.$$ ] && echo "patch $pname" > /tmp/guilt.msg.$$
+		# grab a commit message out of the patch
+		do_get_header "$p" > /tmp/guilt.msg.$$
 
-	# extract a From line from the patch header, and set
-	# GIT_AUTHOR_{NAME,EMAIL}
-	local author_str=`cat "$p" | grep -e '^From: ' | sed -e 's/^From: //'`
-	if [ ! -z "$author_str" ]; then
-		local backup_author_name="$GIT_AUTHOR_NAME"
-		local backup_author_email="$GIT_AUTHOR_EMAIL"
-		GIT_AUTHOR_NAME=`echo $author_str | sed -e 's/ *<.*$//'`
-		GIT_AUTHOR_EMAIL=`echo $author_str | sed -e 's/[^<]*//'`
+		# make a default commit message if patch doesn't contain one
+		[ ! -s /tmp/guilt.msg.$$ ] && echo "patch $pname" > /tmp/guilt.msg.$$
 
-		if [ -z "$GIT_AUTHOR_NAME" ]; then
-			GIT_AUTHOR_NAME=" "
+		# extract a From line from the patch header, and set
+		# GIT_AUTHOR_{NAME,EMAIL}
+		author_str=`sed -n -e '/^From:/ { s/^From: //; p; q }' "$p"`
+		if [ ! -z "$author_str" ]; then
+			GIT_AUTHOR_NAME=`echo $author_str | sed -e 's/ *<.*$//'`
+			export GIT_AUTHOR_NAME="${GIT_AUTHOR_NAME:-" "}"
+                        export GIT_AUTHOR_EMAIL="`echo $author_str | sed -e 's/[^<]*//'`"
 		fi
+		export GIT_AUTHOR_DATE="`stat -c %y "$p"`"
+		export GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
 
-		export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
-	fi
-	local backup_author_date="$GIT_AUTHOR_DATE"
-	local backup_committer_date="$GIT_COMMITTER_DATE"
-	export GIT_AUTHOR_DATE=`stat -c %y "$p"`
-	export GIT_COMMITTER_DATE=$GIT_AUTHOR_DATE
-
-	# commit
-	local treeish=`git-write-tree`
-	local commitish=`git-commit-tree $treeish -p HEAD < /tmp/guilt.msg.$$`
-	echo $commitish > $GIT_DIR/`git-symbolic-ref HEAD`
+		# commit
+		treeish=`git-write-tree`
+		commitish=`git-commit-tree $treeish -p HEAD < /tmp/guilt.msg.$$`
+		echo $commitish > $GIT_DIR/`git-symbolic-ref HEAD`
 
-	# mark patch as applied
-	echo "$commitish:$pname" >> $applied
-
-	cd - 2>&1 >/dev/null
+		# mark patch as applied
+		echo "$commitish:$pname" >> $applied
+	)
 
 	# update references to top, bottom, and base of the stack
 	update_stack_tags
 
-	# restore original GIT_AUTHOR_{NAME,EMAIL}
-	if [ ! -z "$author_str" ]; then
-		if [ ! -z "$backup_author_name" ]; then
-			export GIT_AUTHOR_NAME="$backup_author_name"
-		else
-			unset GIT_AUTHOR_NAME
-		fi
-
-		if [ ! -z "$backup_author_name" ]; then
-			export GIT_AUTHOR_EMAIL="$backup_author_email"
-		else
-			unset GIT_AUTHOR_EMAIL
-		fi
-	fi
-	if [ ! -z "$backup_author_date" ]; then
-		export GIT_AUTHOR_DATE="$backup_author_date"
-	else
-		unset GIT_AUTHOR_DATE
-	fi
-		if [ ! -z "$backup_committer_date" ]; then
-		export GIT_COMMITTER_DATE="$backup_committer_date"
-	else
-		unset GIT_COMMITTER_DATE
-	fi
-
 	rm -f /tmp/guilt.msg.$$ /tmp/guilt.log.$$
-
-	return $bail
+	return $__push_patch_bail
 }
 
 # usage: must_commit_first
-- 
1.5.2.1
