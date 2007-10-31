From: =?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
Subject: [PATCH 1/1] Add --first-parent support to interactive rebase.
Date: Wed, 31 Oct 2007 03:21:49 +0100
Message-ID: <1193797309-1161-1-git-send-email-B.Steinbrink@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Wed Oct 31 03:22:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In3Dv-0000Ot-O4
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 03:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbXJaCVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 22:21:53 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbXJaCVx
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 22:21:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:43144 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752699AbXJaCVw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 22:21:52 -0400
Received: (qmail invoked by alias); 31 Oct 2007 02:21:50 -0000
Received: from i577B89A4.versanet.de (EHLO localhost) [87.123.137.164]
  by mail.gmx.net (mp033) with SMTP; 31 Oct 2007 03:21:50 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19zEvETNdRz7tPm1QLusZxbfpmRu8/+UsryVXIuUb
	RM0GdR7+zUm6G8
X-Mailer: git-send-email 1.5.3.4.456.g072a
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62782>

By default, rebase will take all commits from the branch that is to be
rebased which are missing in upstream. The new --first-parent option
allows to just follow the first parent and thus completely ignore
merges.

Additionally, when used together with --preserve-merges (which is the
more useful use-case) it will no longer rebase the commits from the
merged-in branches, but instead redo the merge with the original
parents.

That means that:
     ---H------I topicB
    /    \      \
    | D---E---F--G topicA
    |/
    A---B---C master

does no longer become:
                -H'--------I'
               /  \         \
              D'---E'---F'---G' topicA
             /
    A---B---C master
     \
      H---I topicB

but instead:
    A---B---C master
     \       \
      \       D'---E'---F'---G' topicA
       \          /         /
        ---------H---------I topicB

Signed-off-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index e4326d3..0b5f4b6 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git-rebase' [-i | --interactive] [-v | --verbose] [-m | --merge]
 	[-C<n>] [ --whitespace=3D<option>] [-p | --preserve-merges]
-	[--onto <newbase>] <upstream> [<branch>]
+	[--first-parent] [--onto <newbase>] <upstream> [<branch>]
 'git-rebase' --continue | --skip | --abort
=20
 DESCRIPTION
@@ -166,6 +166,52 @@ This is useful if F and G were flawed in some way,=
 or should not be
 part of topicA.  Note that the argument to --onto and the <upstream>
 parameter can be any valid commit-ish.
=20
+If you have a branch that contains merges which you want to preserve, =
you
+can use the --preserve-merges option. By default, this will duplicate =
all
+merged commits on top of <upstream> (or <newbase>) and try to redo the
+merges using the new commits. Given this situation:
+
+------------
+     ---H------I topicB
+    /    \      \
+    | D---E---F--G topicA
+    |/
+    A---B---C master
+------------
+
+then the command
+
+    git rebase -i --preserve-merges master topicA
+
+would result in
+
+------------
+                -H'--------I'
+               /  \         \
+              D'---E'---F'---G' topicA
+             /
+    A---B---C master
+     \
+      H---I topicB
+------------
+
+If you pass --first-parent in addition to --preserve-merges, the commi=
ts
+from the merged-in branches won't be duplicated.
+
+So the command
+
+    git rebase -i --preserve-merges --first-parent master topicA
+
+would instead result in
+
+------------
+    A---B---C master
+     \       \
+      \       D'---E'---F'---G' topicA
+       \          /         /
+        ---------H---------I topicB
+------------
+
 In case of conflict, git-rebase will stop at the first problematic com=
mit
 and leave conflict markers in the tree.  You can use git diff to locat=
e
 the markers (<<<<<<) and make edits to resolve the conflict.  For each
@@ -246,6 +292,13 @@ OPTIONS
 	Instead of ignoring merges, try to recreate them.  This option
 	only works in interactive mode.
=20
+\--first-parent::
+	Only follow the first parent commits in merge commits when looking
+	for the commits that are to be rebased. This is most useful with -p
+	as it will cause rebase to recreate the merges against the original
+	branches instead of rebasing those branches as well. This option
+	only works in interactive mode.
+
 include::merge-strategies.txt[]
=20
 NOTES
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e63e1c9..38b070e 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -22,6 +22,7 @@ DONE=3D"$DOTEST"/done
 MSG=3D"$DOTEST"/message
 SQUASH_MSG=3D"$DOTEST"/message-squash
 REWRITTEN=3D"$DOTEST"/rewritten
+FIRST_PARENT=3D
 PRESERVE_MERGES=3D
 STRATEGY=3D
 VERBOSE=3D
@@ -143,14 +144,20 @@ pick_one_preserving_merges () {
 			preserve=3Df
 			new_p=3D$(cat "$REWRITTEN"/$p)
 			test $p !=3D $new_p && fast_forward=3Df
-			case "$new_parents" in
-			*$new_p*)
-				;; # do nothing; that parent is already there
-			*)
-				new_parents=3D"$new_parents $new_p"
-				;;
-			esac
+		elif test t =3D "$FIRST_PARENT"
+		then
+			new_p=3D$p
+		else
+			continue
 		fi
+
+		case "$new_parents" in
+		*$new_p*)
+			;; # do nothing; that parent is already there
+		*)
+			new_parents=3D"$new_parents $new_p"
+			;;
+		esac
 	done
 	case $fast_forward in
 	t)
@@ -412,6 +419,9 @@ do
 	-p|--preserve-merges)
 		PRESERVE_MERGES=3Dt
 		;;
+	--first-parent)
+		FIRST_PARENT=3Dt
+		;;
 	-i|--interactive)
 		# yeah, we know
 		;;
@@ -481,6 +491,10 @@ do
 		else
 			MERGES_OPTION=3D--no-merges
 		fi
+		if test t =3D "$FIRST_PARENT"
+		then
+			MERGES_OPTION=3D"--first-parent $MERGES_OPTION"
+		fi
=20
 		SHORTUPSTREAM=3D$(git rev-parse --short $UPSTREAM)
 		SHORTHEAD=3D$(git rev-parse --short $HEAD)
--=20
1.5.3.4.456.g072a
