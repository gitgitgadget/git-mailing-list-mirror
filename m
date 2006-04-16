From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Make cogito work with accented letters.
Date: Sun, 16 Apr 2006 22:46:23 +0200
Message-ID: <20060416204623.10411.26396.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 22:44:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVE6Q-0001zO-Kl
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 22:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWDPUoF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 16:44:05 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWDPUoF
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 16:44:05 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:63873 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750798AbWDPUoE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 16:44:04 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 3B381548FF;
	Sun, 16 Apr 2006 22:44:03 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FVEFZ-0005E9-Qc; Sun, 16 Apr 2006 22:53:41 +0200
To: Petr Baudis <pasky@suse.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18804>


git-diff-index in default mode has an annoying behaviour wrt filenames
containing non-ascii chars.  As suggested by Pasky, we can use -z
mode, which gives us a much better way of handling all other special
chars.  With associated testcases ensuring it works with simple and
double quotes, backslashes, and spaces as well.

This is an improved version of the previous patch, which fixes other
commands like cg-switch which use tree_timewarp.  A couple of other
commands using git-diff-index still need to be fixed in a similar
manner.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 cg-Xlib                 |    7 ++----
 cg-commit               |   10 ++++----
 t/t9900-specialchars.sh |   59 +++++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
index 38172a0..e594986 100755
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -555,10 +555,9 @@ tree_timewarp()
 		[ "$no_head_update" ] || git-update-ref HEAD "$branch" || :
=20
 		# Kill gone files
-		git-diff-tree -r "$base" "$branch" |
-			# match ":100755 000000 14d43b1abf... 000000000... D"
-			sed -ne 's/^:[^\t]* D\t//p' |
-			xargs rm -f --
+		git-diff-tree -z --name-status -r "$base" "$branch" |
+			perl -n0e 'chomp; if (defined $meta) { print "$_\0" if $meta eq 'D'=
; $meta=3Dundef } else { $meta =3D $_ }' |
+			xargs --null rm -f --
 		git-checkout-index -u -f -a
=20
 		# FIXME: Can produce bogus "contains only garbage" messages.
diff --git a/cg-commit b/cg-commit
index 8dac57c..1d8de92 100755
--- a/cg-commit
+++ b/cg-commit
@@ -274,8 +274,8 @@ if [ "$ARGS" -o "$_git_relpath" ]; then
 		echo "${_git_relpath}$file" >>"$filter"
 	done
=20
-	eval "commitfiles=3D($(cat "$filter" | path_xargs git-diff-index -r -=
m HEAD -- | \
-		sed -e 's/"\|\\/\\&/g' -e 's/^\([^	]*\)\(.\)	\(.*\)\(	.*\)*$/"\2 \3"=
/'))"
+	eval "commitfiles=3D($(cat "$filter" | path_xargs git-diff-index --na=
me-status -z -r -m HEAD -- | \
+		perl -n0e 'chomp; if (defined $meta) { s/([\"\\])/\\\1/; print "\"$m=
eta $_\"\n"; $meta=3Dundef } else { $meta =3D $_ }'))"
 	customfiles=3D1
=20
 	[ "$review" ] && cat "$filter" | path_xargs git-diff-index -r -m -p H=
EAD -- > "$PATCH"
@@ -292,8 +292,8 @@ else
 	if [ ! "$ignorecache" ]; then
 		# \t instead of the tab character itself works only with new
 		# sed versions.
-		eval "commitfiles=3D($(git-diff-index -r -m HEAD | \
-			sed -e 's/"\|\\/\\&/g' -e 's/^\([^	]*\)\(.\)	\(.*\)\(	.*\)*$/"\2 \3=
"/'))"
+		eval "commitfiles=3D($(git-diff-index --name-status -z -r -m HEAD | =
\
+			perl -n0e 'chomp; if (defined $meta) { s/([\"\\])/\\\1/; print "\"$=
meta $_\"\n"; $meta=3Dundef } else { $meta =3D $_ }'))"
=20
 		if [ -s "$_git/commit-ignore" ]; then
 			newcommitfiles=3D()
@@ -439,7 +439,7 @@ __END__
 		exit 1
 	fi
 	if [ ! "$ignorecache" ] && [ ! "$merging" ] && [ ! "$review" ]; then
-		eval "newcommitfiles=3D($(grep ^CG:F "$LOGMSG2" | sed 's/^CG:F *\(.*=
\)$/"\1"/'))"
+		eval "newcommitfiles=3D($(grep ^CG:F "$LOGMSG2" | sed -e 's/\"/\\&/g=
' -e 's/^CG:F *\(.*\)$/"\1"/'))"
 		if [ ! "$force" ] && [ ! "${newcommitfiles[*]}" ]; then
 			rm "$LOGMSG" "$LOGMSG2"
 			[ "$quiet" ] && exit 0 || die 'Nothing to commit'
diff --git a/t/t9900-specialchars.sh b/t/t9900-specialchars.sh
new file mode 100755
index 0000000..a705052
--- /dev/null
+++ b/t/t9900-specialchars.sh
@@ -0,0 +1,59 @@
+#!/usr/bin/env bash
+#
+# Copyright (c) 2006 Yann Dirson
+#
+test_description=3D"Tests various commands with shell-special chars.
+
+Filenames with embedded spaces, quotes, non-ascii letter, you name it.=
"
+
+. ./test-lib.sh
+
+rm -rf .git
+cg-init -m .
+
+touch "a space"
+test_expect_success 'add file with space' 'cg-add "a space"'
+test_expect_success 'commit file with space' 'cg-commit -m . "a space"=
'
+
+touch "a'quote"
+test_expect_success 'add file with quote' "cg-add \"a'quote\""
+test_expect_success 'commit file with quote' "cg-commit -m . \"a'quote=
\""
+
+touch "d\"quote"
+test_expect_success 'add file with accent' 'cg-add "d\"quote"'
+test_expect_success 'commit file with quote' 'cg-commit -m . "d\"quote=
"'
+
+touch "back\\slash"
+test_expect_success 'add file with accent' 'cg-add "back\\slash"'
+test_expect_success 'commit file with quote' 'cg-commit -m . "back\\sl=
ash"'
+
+touch "acc=E9nt"
+test_expect_success 'add file with accent' "cg-add acc=E9nt"
+test_expect_success 'commit file with quote' "cg-commit -m . acc=E9nt"
+
+## same without a file arg to cg-commit
+
+rm -rf * .git
+cg-init -m .
+
+touch "a space"
+test_expect_success 'add file with space' 'cg-add "a space"'
+test_expect_success 'commit file with space' 'cg-commit -m .'
+
+touch "a'quote"
+test_expect_success 'add file with quote' "cg-add \"a'quote\""
+test_expect_success 'commit file with quote' "cg-commit -m ."
+
+touch "d\"quote"
+test_expect_success 'add file with accent' 'cg-add "d\"quote"'
+test_expect_success 'commit file with quote' 'cg-commit -m .'
+
+touch "back\\slash"
+test_expect_success 'add file with accent' 'cg-add "back\\slash"'
+test_expect_success 'commit file with quote' 'cg-commit -m .'
+
+touch "acc=E9nt"
+test_expect_success 'add file with accent' "cg-add acc=E9nt"
+test_expect_success 'commit file with quote' "cg-commit -m ."
+
+test_done
