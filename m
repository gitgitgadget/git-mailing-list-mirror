From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 4/8] cogito: Integrate cg-Xnormid into cg-object-id
Date: Mon, 19 Sep 2005 22:18:51 -0400
Message-ID: <1127182731.31115.25.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 20 04:19:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHXij-0005kK-6v
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 04:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbVITCSy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 22:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVITCSy
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 22:18:54 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:58027 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964840AbVITCSy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 22:18:54 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EHXie-0006FB-US
	for git@vger.kernel.org; Mon, 19 Sep 2005 22:18:53 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EHXid-0001hv-PZ
	for git@vger.kernel.org; Mon, 19 Sep 2005 22:18:51 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8956>

Integrate cg-Xnormid into cg-object-id.

Convert it to a function normalize_id().  Change it to return at most
one ID.  Use the first parent if parent is requested.  "cg-object-id -p"
now uses separate code to return more than one parent ID.

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -16,11 +16,11 @@ SCRIPT=	cg-object-id cg-add cg-admin-lso
 	cg-branch-add cg-branch-ls cg-reset cg-clone cg-commit cg-diff \
 	cg-export cg-help cg-init cg-log cg-merge cg-mkpatch cg-patch \
 	cg-fetch cg-restore cg-rm cg-seek cg-status cg-tag cg-tag-ls cg-update \
 	cg cg-admin-ls cg-upload cg-branch-chg cg-admin-cat cg-clean
 
-LIB_SCRIPT=cg-Xlib cg-Xmergefile cg-Xnormid
+LIB_SCRIPT=cg-Xlib cg-Xmergefile
 
 GEN_SCRIPT= cg-version
 
 VERSION= VERSION
 
diff --git a/cg-Xnormid b/cg-Xnormid
deleted file mode 100755
--- a/cg-Xnormid
+++ /dev/null
@@ -1,75 +0,0 @@
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
-. ${COGITO_LIB}cg-Xlib || exit 1
-
-id="$1"
-
-if [ "${id:(-1):1}" = "^" ]; then
-	# find parent
-	id=$(cg-object-id "${id%^}") || exit 1
-	git-cat-file commit "$id" | awk '/^parent/{print $2};/^$/{exit}' || exit 1
-	exit
-fi
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
-elif [[ "$id" == [0-9a-f][0-9a-f][0-9a-f][0-9a-f]* ]]; then
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
-		echo "${idmatch[@]}" >&2
-		exit 1
-	fi
-fi
-
-valid=; [ ${#id} -eq 40 ] && [ "$(git-rev-parse --revs-only "$id")" ] && valid=1
-if ([ "$id" ] && [ "$id" != " " ]) && [ ! "$valid" ]; then
-	reqsecs=$(date --date="$id" +'%s' 2>/dev/null)
-
-	if [ "$reqsecs" ]; then
-		id=$(git-rev-list --min-age=$reqsecs --max-count=1 HEAD)
-		valid=; [ ${#id} -eq 40 ] && [ "$(git-rev-parse --revs-only "$id")" ] && valid=1
-	fi
-fi
-
-# If we don't have a 40-char ID by now, it's an error
-if [ ! "$valid" ]; then
-	echo "Invalid id: $id" >&2
-	exit 1
-fi
-
-type="$(git-cat-file -t "$id")"
-if [ "$type" = "tag" ]; then
-	id=$(git-cat-file tag "$id" | head -n 1)
-	id="${id#object }"
-	type=
-fi
-
-echo "$id $type"
diff --git a/cg-object-id b/cg-object-id
--- a/cg-object-id
+++ b/cg-object-id
@@ -1,10 +1,11 @@
 #!/usr/bin/env bash
 #
 # Get SHA1 ID of commit or tree associated with given ID or HEAD.
 # Copyright (c) Petr Baudis, 2005
-# Copyright (c) Pavel Roskin 2005
+# Copyright (c) Pavel Roskin, 2005
+# Copyright (c) Philip Pokorny, 2005
 #
 # If the ID is not provided, HEAD is used.  The default behavior is to
 # show the commit ID.
 #
 # OPTIONS
@@ -22,10 +23,80 @@
 
 USAGE="cg-object-id [-p] [-t] [OBJECT_ID]"
 
 . ${COGITO_LIB}cg-Xlib
 
+
+# Normalize argument.  The normalized SHA1 ID is put to $normid,
+# type is put to $type.
+normalize_id()
+{
+	local id="$1"
+
+	if [ "${id:(-1):1}" = "^" ]; then
+		# find first parent
+		id=$(cg-object-id "${id%^}") || exit 1
+		normid=$(git-cat-file commit "$id" | \
+			 awk '/^parent/{print $2; exit};/^$/{exit}') || exit 1
+		type="commit"
+		return
+	fi
+
+	if [ ! "$id" ] || [ "$id" = "this" ] || [ "$id" = "HEAD" ]; then
+		read id < "$_git/HEAD"
+
+	elif [ -r "$_git/refs/tags/$id" ]; then
+		read id < "$_git/refs/tags/$id"
+
+	elif [ -r "$_git/refs/heads/$id" ]; then
+		read id < "$_git/refs/heads/$id"
+
+	# Short id's must be lower case and at least 4 digits.
+	elif [[ "$id" == [0-9a-f][0-9a-f][0-9a-f][0-9a-f]* ]]; then
+		idpref=${id:0:2}
+		idpost=${id:2}
+
+		# Assign array elements to matching names
+		idmatch=($_git_objects/$idpref/$idpost*)
+
+		if [ ${#idmatch[*]} -eq 1 ] && [ -r "$idmatch" ]; then
+			id=$idpref${idmatch#$_git_objects/$idpref/}
+		elif [ ${#idmatch[*]} -gt 1 ]; then
+			echo "Ambiguous id: $id" >&2
+			echo "${idmatch[@]}" >&2
+			exit 1
+		fi
+	fi
+
+	valid=; [ ${#id} -eq 40 ] && [ "$(git-rev-parse --revs-only "$id")" ] && valid=1
+	if ([ "$id" ] && [ "$id" != " " ]) && [ ! "$valid" ]; then
+		reqsecs=$(date --date="$id" +'%s' 2>/dev/null)
+
+		if [ "$reqsecs" ]; then
+			id=$(git-rev-list --min-age=$reqsecs --max-count=1 HEAD)
+			valid=; [ ${#id} -eq 40 ] && [ "$(git-rev-parse --revs-only "$id")" ] && valid=1
+		fi
+	fi
+
+	# If we don't have a 40-char ID by now, it's an error
+	if [ ! "$valid" ]; then
+		echo "Invalid id: $id" >&2
+		exit 1
+	fi
+
+	type="$(git-cat-file -t "$id")"
+	if [ "$type" = "tag" ]; then
+		id=$(git-cat-file tag "$id" | head -n 1)
+		id="${id#object }"
+		type=
+	fi
+
+	normid="$id"
+}
+
+
+
 show_parent=
 show_tree=
 while optparse; do
 	if optparse -p; then
 		show_parent=1
@@ -46,23 +117,17 @@ if [ "$show_parent" -a "$show_tree" ]; t
 	echo "Cannot show parent and tree ID at the same time." >&2
 	exit 1
 fi
 
 id="${ARGS[0]}"
-if [ "$show_parent" ]; then
-	id="$id"^
-fi
-
-normid=$(. ${COGITO_LIB}cg-Xnormid "$id") || exit 1
+normalize_id "$id"
 
 if [ "$show_parent" ]; then
-	echo "${normid% *}"
+	git-cat-file commit "$normid" | awk '/^parent/{print $2};/^$/{exit}'
 	exit 0
 fi
 
-type=${normid#* }
-normid=${normid% *}
 [ "$type" ] || type=$(git-cat-file -t "$normid")
 if [ "$show_tree" ]; then
 	if [ "$type" = "commit" ]; then
 		normid=$(git-cat-file commit "$normid" | sed -e 's/tree //;q')
 		type=$(git-cat-file -t "$normid")


-- 
Regards,
Pavel Roskin
