From: Brian Gerst <bgerst@didntduck.org>
Subject: [PATCH] Cogito: Use git-rev-parse instead of cg-Xnormid.
Date: Sun, 03 Jul 2005 01:59:42 -0400
Message-ID: <42C77ECE.2080903@didntduck.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030204020208070107020200"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 07:59:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoxW7-0002WR-Ln
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 07:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVGCF7i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 01:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVGCF7i
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 01:59:38 -0400
Received: from quark.didntduck.org ([69.55.226.66]:4559 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261349AbVGCF7T
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Jul 2005 01:59:19 -0400
Received: from [192.168.1.2] (24-236-201-214.dhcp.aldl.mi.charter.com [24.236.201.214])
	(authenticated)
	by quark.didntduck.org (8.11.6/8.11.6) with ESMTP id j635wPx11132;
	Sun, 3 Jul 2005 01:58:25 -0400
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
To: pasky@suse.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------030204020208070107020200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Use git-rev-parse instead of cg-Xnormid.  This allows Cogito to work 
properly with packed objects.

Signed off by: Brian Gerst <bgerst@didntduck.org>


--------------030204020208070107020200
Content-Type: text/plain;
 name="cg-rev-parse"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cg-rev-parse"

Use git-rev-parse instead of cg-Xnormid.  This allows Cogito to work properly with packed objects.

Signed off by: Brian Gerst <bgerst@didntduck.org>

---
commit 32c6125190d7d183110790b556a8e1128f29c52d
tree 0e53bc37eb8ad12f093cfb0e903689ef95c54ece
parent 266e27c48ba20c1af33f6a3eb966e8cd0d3c8b65
author Brian Gerst <bgerst@didntduck.org> Sun, 03 Jul 2005 01:53:22 -0400
committer Brian Gerst <bgerst@didntduck.org> Sun, 03 Jul 2005 01:53:22 -0400

 Makefile   |    2 +-
 cg-Xnormid |   63 ------------------------------------------------------------
 commit-id  |   12 +----------
 parent-id  |    4 +---
 tree-id    |    4 ++--
 5 files changed, 5 insertions(+), 80 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -67,7 +67,7 @@ SCRIPT=	commit-id tree-id parent-id cg-a
 	cg-pull cg-restore cg-rm cg-seek cg-status cg-tag cg-tag-ls cg-update \
 	cg cg-admin-ls cg-push cg-branch-chg
 
-LIB_SCRIPT=cg-Xlib cg-Xmergefile cg-Xnormid
+LIB_SCRIPT=cg-Xlib cg-Xmergefile
 
 GEN_SCRIPT= cg-version
 
diff --git a/cg-Xnormid b/cg-Xnormid
deleted file mode 100755
--- a/cg-Xnormid
+++ /dev/null
@@ -1,63 +0,0 @@
-#!/usr/bin/env bash
-#
-# Normalize an ID to an SHA1 hash value.
-# Copyright (c) Petr Baudis, 2005
-# Copyright (c) Philip Pokorny, 2005
-#
-# Strings resolve in this order:
-# 	NULL, this, HEAD  => .git/HEAD
-# 	<tags>
-# 	<heads>
-# 	short SHA1 (4 or more hex digits)
-#
-# Takes the ID to normalize and returns the normalized ID.
-
-. ${COGITO_LIB}cg-Xlib
-
-id="$1"
-
-if [ ! "$id" ] || [ "$id" = "this" ] || [ "$id" = "HEAD" ]; then
-	read id < "$_git/HEAD"
-
-elif [ -r "$_git/refs/tags/$id" ]; then
-	read id < "$_git/refs/tags/$id"
-
-elif [ -r "$_git/refs/heads/$id" ]; then
-	read id < "$_git/refs/heads/$id"
-
-# Short id's must be lower case and at least 4 digits.
-elif [[ "$id" == [0-9a-z][0-9a-z][0-9a-z][0-9a-z]* ]]; then
-	idpref=${id:0:2}
-	idpost=${id:2}
-
-	# Assign array elements to matching names
-	idmatch=($_git_objects/$idpref/$idpost*)
-
-	if [ ${#idmatch[*]} -eq 1 ] && [ -r "$idmatch" ]; then
-		id=$idpref${idmatch#$_git_objects/$idpref/}
-	elif [ ${#idmatch[*]} -gt 1 ]; then
-		echo "Ambiguous id: $id" >&2
-		exit 1
-	fi
-fi
-
-if ([ "$id" ] && [ "$id" != " " ]) && ([ ${#id} -ne 40 ] || [ ! -f .git/objects/${id:0:2}/${id:2} ]); then
-	reqsecs=$(date --date="$id" +'%s' 2>/dev/null)
-
-	if [ "$reqsecs" ]; then
-		id=$(git-rev-list --min-age=$reqsecs --max-count=1 HEAD)
-	fi
-fi
-
-# If we don't have a 40-char ID by now, it's an error
-if [ ${#id} -ne 40 ] || [ ! -f $_git_objects/${id:0:2}/${id:2} ]; then
-	echo "Invalid id: $id" >&2
-	exit 1
-fi
-
-if [ "$(git-cat-file -t "$id")" = "tag" ]; then
-	id=$(git-cat-file tag "$id" | head -n 1)
-	id="${id#object }"
-fi
-
-echo $id
diff --git a/commit-id b/commit-id
--- a/commit-id
+++ b/commit-id
@@ -5,14 +5,4 @@
 #
 # Takes the appropriate ID, defaults to HEAD.
 
-. ${COGITO_LIB}cg-Xlib
-
-id="$1"
-normid=$(${COGITO_LIB}cg-Xnormid "$id") || exit 1
-
-if [ "$(git-cat-file -t "$normid")" != "commit" ]; then
-	echo "Invalid commit id: $id" >&2
-	exit 1
-fi
-
-echo $normid
+git-rev-parse "${1:-HEAD}"
diff --git a/parent-id b/parent-id
--- a/parent-id
+++ b/parent-id
@@ -7,6 +7,4 @@
 #
 # NOTE: Will return multiple SHA1s if ID is a commit with multiple parents.
 
-id=$(commit-id "$1") || exit 1
-
-git-cat-file commit $id | awk '/^parent/{print $2};/^$/{exit}'
+git-rev-parse "${1:-HEAD}^"
diff --git a/tree-id b/tree-id
--- a/tree-id
+++ b/tree-id
@@ -5,8 +5,8 @@
 #
 # Takes ID of the appropriate commit, defaults to HEAD.
 
-id="$1"
-normid=$(${COGITO_LIB}cg-Xnormid "$id") || exit 1
+id="${1:-HEAD}"
+normid=$(git-rev-parse "$id")
 type=$(git-cat-file -t "$normid")
 
 if [ "$type" = "commit" ]; then

--------------030204020208070107020200--
