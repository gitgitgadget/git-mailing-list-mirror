From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-tag-script updates.
Date: Mon, 25 Jul 2005 16:02:58 -0700
Message-ID: <7vek9mh4kd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jul 26 01:07:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxC2O-0000Ne-Fh
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 01:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVGYXDx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 19:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVGYXDn
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 19:03:43 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:49328 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261162AbVGYXDC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2005 19:03:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050725230252.SSYE8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 25 Jul 2005 19:02:52 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds -a (annotate only but not sign) option "A Large Angry
SCM" <gitzilla@gmail.com> sent to the list, after fixing up the
whitespace corruption in the patch, with some of my own fixes.

Namely, changes are:

 * A new flag '-a' can be used to create an unsigned tag
   object;

 * The '-f' flag logic did not do the right thing;

 * When creating a signed tag, we did not check for GPG failure
   as we should;

 * Try to use the key for the tagger identity when signing the
   tag.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-tag-script |   32 ++++++++++++++++++++++++++------
 1 files changed, 26 insertions(+), 6 deletions(-)

0fad0fdd4beadb2ff06af8d5a16d509cd8796ee4
diff --git a/git-tag-script b/git-tag-script
--- a/git-tag-script
+++ b/git-tag-script
@@ -3,17 +3,30 @@
 
 . git-sh-setup-script || die "Not a git archive"
 
+usage () {
+    echo >&2 "Usage: git-tag-script [-a | -s] [-f] tagname"
+    exit 1
+}
+
+annotate=
 signed=
 force=
 while case "$#" in 0) break ;; esac
 do
     case "$1" in
+    -a)
+	annotate=1
+	;;
     -s)
+	annotate=1
 	signed=1
 	;;
     -f)
 	force=1
 	;;
+    -*)
+        usage
+	;;
     *)
 	break
 	;;
@@ -22,16 +35,19 @@ do
 done
 
 name="$1"
-[ "$name" ] || die "I need a tag-name"
-[ -e "$GIT_DIR/refs/tags/$name" ] &&
-	[ "$force" ] || die "tag '$name' already exists"
+[ "$name" ] || usage
+if [ -e "$GIT_DIR/refs/tags/$name" -a -z "$force" ]; then
+    die "tag '$name' already exists"
+fi
 shift
 
 object=$(git-rev-parse --verify --revs-only --default HEAD "$@") || exit 1
 type=$(git-cat-file -t $object) || exit 1
 tagger=$(git-var GIT_COMMITTER_IDENT) || exit 1
 
-if [ "$signed" ]; then
+trap 'rm -f .tmp-tag* .tagmsg .editmsg' 0
+
+if [ "$annotate" ]; then
     ( echo "#"
       echo "# Write a tag message"
       echo "#" ) > .editmsg
@@ -43,9 +59,13 @@ if [ "$signed" ]; then
 
     ( echo -e "object $object\ntype $type\ntag $name\ntagger $tagger\n"; cat .tagmsg ) > .tmp-tag
     rm -f .tmp-tag.asc .tagmsg
-    gpg -bsa .tmp-tag && cat .tmp-tag.asc >> .tmp-tag
+    if [ "$signed" ]; then
+	me=$(expr "$tagger" : '\(.*>\)') &&
+	gpg -bsa -u "$me" .tmp-tag &&
+	cat .tmp-tag.asc >>.tmp-tag ||
+	die "failed to sign the tag with GPG."
+    fi
     object=$(git-mktag < .tmp-tag)
-    rm -f .tmp-tag .tmp-tag.sig
 fi
 
 mkdir -p "$GIT_DIR/refs/tags"
