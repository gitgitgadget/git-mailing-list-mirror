From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH UPDATED] cg-commit chokes when given a very large list of files
Date: Mon, 18 Jul 2005 00:37:22 -0400
Message-ID: <20050718043713.22322.21445.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 06:38:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuNNz-0006eo-7n
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 06:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVGREhY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jul 2005 00:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVGREhY
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jul 2005 00:37:24 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:26240 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261331AbVGREhW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2005 00:37:22 -0400
Received: (qmail 21716 invoked from network); 18 Jul 2005 04:37:18 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:Subject;
  b=RpgGCPfdYAD8BnRoz+94Ol6iVw1Z3MSLYhzrTBzqVxB6kyMAU73PbRUnQd6U7q+G0b6T2IvIlc/+TNQ6UZAD8tjAjKosQeGBBUY80hOeVczKGJqyRrI4VGKeenSHGXwFXLYd7fPVeM69jPwKxeRcklHeefzRDleFc02jDRmIx4o=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp017.mail.yahoo.com with SMTP; 18 Jul 2005 04:37:18 -0000
To: bryan.larsen@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

cg-commit currently chokes when passed a very large list of files.  Fix it.

Resent again.  This time we completely avoid messing with IFS, resulting 
in support for filenames with line feeds.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 cg-Xlib   |   18 ++++++++++++++++++
 cg-commit |    6 +++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -49,6 +49,24 @@ mktemp () {
 	$(which mktemp) $dirarg $prefix"$1"
 }
 
+
+# this function is useful when you want to execute a command that's bigger
+# than the system's limit.
+#
+# this is similar to piping output to xargs -0r
+# 
+# example usage:  eval_via_xargs "git-update-cache --add --" "$@"
+eval_via_xargs () {
+    local cmd=$1
+    shift
+    if [ "$1" ] ; then	
+	( for f in "$@" ; do
+	    echo -ne ${f}\\000
+	done ) | xargs -0 $cmd
+    fi
+}
+
+
 stat () {
 	if [ "$1" != "-c" ] || [ "$2" != "%s" ]; then
 		echo "INTERNAL ERROR: Unsupported stat call $@" >&2
diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -289,9 +289,9 @@ precommit_update () {
 		eval "queue$op[\${#queue$op[@]}]=\"\$fname\""
 	done
 	# XXX: Do we even need to do the --add and --remove update-caches?
-	[ "$queueN" ] && { git-update-cache --add ${infoonly} -- "${queueN[@]}" || return 1; }
-	[ "$queueD" ] && { git-update-cache --force-remove -- "${queueD[@]}" || return 1; }
-	[ "$queueM" ] && { git-update-cache ${infoonly} -- "${queueM[@]}" || return 1; }
+	eval_via_xargs "git-update-cache --add ${infoonly} --" "${queueN[@]}" || return 1
+	eval_via_xargs "git-update-cache --force-remove --" "${queueD[@]}" || return 1
+	eval_via_xargs "git-update-cache ${infoonly} --" "${queueM[@]}" || return 1
 	return 0
 }
 
