From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Make cg-commit work with accented letters.
Date: Sun, 16 Apr 2006 19:57:00 +0200
Message-ID: <20060416175700.29745.26898.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 19:54:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVBSQ-0004FD-27
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 19:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWDPRyn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 13:54:43 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWDPRyn
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 13:54:43 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:30947 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750778AbWDPRym (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 13:54:42 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 7D8161EACE;
	Sun, 16 Apr 2006 19:54:41 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FVBbf-0003z9-D4; Sun, 16 Apr 2006 20:04:19 +0200
To: Petr Baudis <pasky@suse.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18797>


git-diff-index in default mode has an annoying behaviour wrt filenames
containing non-ascii chars.  As suggested by Pasky, we can use -z
mode, which gives us a much better way of handling all other special
chars.  With associated testcases ensuring it works with simple and
double quotes, backslashes, and spaces as well.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 cg-commit               |   10 ++++----
 t/t9900-specialchars.sh |   59 +++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/cg-commit b/cg-commit
index 8dac57c..9ec8289 100755
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
+	eval "commitfiles=3D($(cat "$filter" | path_xargs git-diff-index -z -=
r -m HEAD -- | \
+		perl -n0e 'if (defined $meta) { s/([\"\\])/\\\1/; print "\"$meta $_\=
"\n"; $meta=3Dundef } else { $meta =3D (split(/\s/))[4] }'))"
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
+		eval "commitfiles=3D($(git-diff-index -z -r -m HEAD | \
+			perl -n0e 'if (defined $meta) { s/([\"\\])/\\\1/; print "\"$meta $_=
\"\n"; $meta=3Dundef } else { $meta =3D (split(/\s/))[4] }'))"
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
