From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [cogito PATCH] Add "-c" (colorize) option to cg-diff
Date: Fri, 20 May 2005 15:58:30 +0100
Message-ID: <tnxfywirlk9.fsf@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-From: git-owner@vger.kernel.org Fri May 20 17:02:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ8xg-0005Ok-OT
	for gcvg-git@gmane.org; Fri, 20 May 2005 16:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVETO7l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 10:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVETO7c
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 10:59:32 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:8380 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261430AbVETO6q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 10:58:46 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j4KEwZeS015626
	for <git@vger.kernel.org>; Fri, 20 May 2005 15:58:35 +0100 (BST)
Received: from localhost.localdomain (cmarinas@pc1117.cambridge.arm.com [10.1.69.144])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id PAA00527
	for <git@vger.kernel.org>; Fri, 20 May 2005 15:58:40 +0100 (BST)
To: git@vger.kernel.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--=-=-=

An option I found quite useful in quilt. I just copied the
corresponding code from quilt (released under GPLv2) to cg-diff.

Catalin


--=-=-=
Content-Disposition: inline; filename=patch-color-diff

Add "-c" (colorize) option to cg-diff

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Index: cg-diff
===================================================================
--- ca5fef50fb68a3afbb35e1a48ac622f7a964f021/cg-diff  (mode:100755)
+++ uncommitted/cg-diff  (mode:100755)
@@ -14,6 +14,8 @@
 # -p instead of one ID denotes a parent commit to the specified ID
 # (which must not be a tree, obviously).
 #
+# -c colorizes the diff output
+#
 # Outputs a diff converting the first tree to the second one.
 
 . ${COGITO_LIB}cg-Xlib
@@ -22,7 +24,17 @@
 id1=" "
 id2=" "
 parent=
+opt_color=
 
+setup_colors()
+{
+	local C=diff_hdr=32:diff_add=36:diff_mod=35:diff_rem=35:diff_hunk=33:diff_ctx=35:diff_cctx=33:patch_offs=33:patch_fuzz=35:patch_fail=31:clear=00
+	[ -n "$COGITO_COLORS" ] && C="$C:$COGITO_COLORS"
+
+	C=${C//=/=\'$'\e'[}
+	C=color_${C//:/m\'; color_}m\'
+	eval $C
+}
 
 # FIXME: The commandline parsing is awful.
 
@@ -31,6 +43,12 @@
 	parent=1
 fi
 
+if [ "$1" = "-c" ]; then
+	shift
+	opt_color=1
+	setup_colors
+fi
+
 if [ "$1" = "-r" ]; then
 	shift
 	id1=$(echo "$1": | cut -d : -f 1)
@@ -44,6 +62,32 @@
 	shift
 fi
 
+colorize() {
+	if [ "$opt_color" ]; then
+		/usr/bin/gawk '
+		{ if (/^(Index:|\-\-\-|\+\+\+|\*\*\*) /)
+		    print "'$color_diff_hdr'" $0 "'$color_clear'"
+		  else if (/^\+/)
+		    print "'$color_diff_add'" $0 "'$color_clear'"
+		  else if (/^-/)
+		    print "'$color_diff_rem'" $0 "'$color_clear'"
+		  else if (/^!/)
+		    print "'$color_diff_mod'" $0 "'$color_clear'"
+		  else if (/^@@ \-[0-9]+(,[0-9]+)? \+[0-9]+(,[0-9]+)? @@/)
+		    print gensub(/^(@@[^@]*@@)([ \t]*)(.*)/,
+		         "'$color_diff_hunk'" "\\1" "'$color_clear'" \
+			 "\\2" \
+			 "'$color_diff_ctx'" "\\3" "'$color_clear'", "")
+		  else if (/^\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/)
+		    print "'$color_diff_cctx'" $0 "'$color_clear'"
+		  else
+		    print
+		}'
+	else
+		cat
+	fi
+}
+
 if [ "$parent" ]; then
 	id2="$id1"
 	id1=$(parent-id "$id2" | head -n 1)
@@ -71,7 +115,7 @@
 	# FIXME: Update ret based on what did we match. And take "$@"
 	# to account after all.
 	ret=
-	git-diff-cache -r -z $tree | xargs -0 ${COGITO_LIB}cg-Xdiffdo "$tree" uncommitted "$filter"
+	git-diff-cache -r -z $tree | xargs -0 ${COGITO_LIB}cg-Xdiffdo "$tree" uncommitted "$filter" | colorize
 
 	[ "$filter" ] && rm $filter
 
@@ -85,7 +129,7 @@
 
 [ "$id1" = "$id2" ] && die "trying to diff $id1 against itself"
 
-git-diff-tree -r -z $id1 $id2 | xargs -0 ${COGITO_LIB}cg-Xdiffdo $id1 $id2 "$filter"
+git-diff-tree -r -z $id1 $id2 | xargs -0 ${COGITO_LIB}cg-Xdiffdo $id1 $id2 "$filter" | colorize
 
 [ "$filter" ] && rm $filter
 exit 0
Index: cg-help
===================================================================
--- ca5fef50fb68a3afbb35e1a48ac622f7a964f021/cg-help  (mode:100755)
+++ uncommitted/cg-help  (mode:100755)
@@ -26,7 +26,7 @@
 	cg-cancel
 	cg-clone	[-s] SOURCE_LOC [DESTDIR]
 	cg-commit	[-m"Commit message"]... [-e | -E] [FILE]... < log message
-	cg-diff		[-p] [-r FROM_ID[:TO_ID]] [FILE]...
+	cg-diff		[-p] [-c] [-r FROM_ID[:TO_ID]] [FILE]...
 	cg-export	DEST [TREE_ID]
 	cg-help		[COMMAND]
 	cg-init

--=-=-=--

