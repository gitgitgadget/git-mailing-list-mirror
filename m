From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-am: --resolved.
Date: Wed, 16 Nov 2005 01:26:52 -0800
Message-ID: <7v7jb99c4j.fsf@assigned-by-dhcp.cox.net>
References: <7voe4lfpxm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Nov 16 10:27:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcJZF-0002ed-El
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 10:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbVKPJ05 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 04:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbVKPJ05
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 04:26:57 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:47079 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030258AbVKPJ04 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 04:26:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116092654.FCU25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Nov 2005 04:26:54 -0500
To: git@vger.kernel.org
In-Reply-To: <7voe4lfpxm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 15 Nov 2005 15:32:05 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12015>

Junio C Hamano <junkio@cox.net> writes:

>  - Patch C does not apply.  git-am stops here, with conflicts to
>    be resolved in the working tree.  Yet-to-be-applied D and E
>    are still kept in .dotest/ directory at this point.  What the
>    user does is exactly the same as fixing up unapplicable patch
>    when running git-am:
>
>    - Resolve conflict just like any merge conflicts. 
>
>    - "git diff -p --full-index HEAD >.dotest/patch" to pretend
>      as if you received a perfect, applicable patch.
>
>    - "git reset --hard", to pretend you have not tried to apply
>      that patch yet.
>
>    [Side note] I think the latter two steps can and should be
>    made into a short-hand to tell "git-am" that the conflicting
>    patch is resolved.  "git-am --resolved", perhaps?

It turns out that the above "diff >.dotest/patch && reset --hard"
was unnecessary.  Instead, the above workflow would read:

    - Resolve conflict just like any merge conflicts.

    - Do necessary 'git-update-index' to prepare your index to
      record the result of the patch application.

    - "git am --resolved".

What it does is just record the current index as tree, along
with the commit log message and authorship information taken
from the e-mail.  No diff & patch is involved.  Oh, and you can
do this in a dirty working tree as long as your index is clean
and dirty paths do not interfere with the patch application.

The patch I am posting here is against the tip of the master, if
somebody wants to try it out.  Proposed updates branch has an
equivalent patch on top of the reworked rebase series.

-- >8 --
After failed patch application, you can manually apply the patch
(this includes resolving the conflicted merge after git-am falls
back to 3-way merge) and run git-update-index on necessary paths
to prepare the index file in a shape a successful patch
application should have produced.  Then re-running git-am --resolved
would record the resulting index file along with the commit log
information taken from the patch e-mail.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-am.sh |   65 ++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 53 insertions(+), 12 deletions(-)

applies-to: 1e3fcf60526c196a46433e6947c9104ca236f230
3efc3e216c8a64fae53a15767064162ee431f57e
diff --git a/git-am.sh b/git-am.sh
index 38841d9..98a390a 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -3,16 +3,10 @@
 #
 . git-sh-setup || die "Not a git archive"
 
-files=$(git-diff-index --cached --name-only HEAD) || exit
-if [ "$files" ]; then
-   echo "Dirty index: cannot apply patches (dirty: $files)" >&2
-   exit 1
-fi
-
 usage () {
     echo >&2 "usage: $0 [--signoff] [--dotest=<dir>] [--utf8] [--3way] <mbox>"
     echo >&2 "	or, when resuming"
-    echo >&2 "	$0 [--skip]"
+    echo >&2 "	$0 [--skip | --resolved]"
     exit 1;
 }
 
@@ -104,7 +98,7 @@ fall_back_3way () {
 }
 
 prec=4
-dotest=.dotest sign= utf8= keep= skip= interactive=
+dotest=.dotest sign= utf8= keep= skip= interactive= resolved=
 
 while case "$#" in 0) break;; esac
 do
@@ -128,6 +122,9 @@ do
 	-k|--k|--ke|--kee|--keep)
 	keep=t; shift ;;
 
+	-r|--r|--re|--res|--reso|--resol|--resolv|--resolve|--resolved)
+	resolved=t; shift ;;
+
 	--sk|--ski|--skip)
 	skip=t; shift ;;
 
@@ -140,6 +137,8 @@ do
 	esac
 done
 
+# If the dotest directory exists, but we have finished applying all the
+# patches in them, clear it out.
 if test -d "$dotest" &&
    last=$(cat "$dotest/last") &&
    next=$(cat "$dotest/next") &&
@@ -155,9 +154,9 @@ then
 	die "previous dotest directory $dotest still exists but mbox given."
 	resume=yes
 else
-	# Make sure we are not given --skip
-	test ",$skip," = ,, ||
-	die "we are not resuming."
+	# Make sure we are not given --skip nor --resolved
+	test ",$skip,$resolved," = ,,, ||
+		die "we are not resuming."
 
 	# Start afresh.
 	mkdir -p "$dotest" || exit
@@ -170,12 +169,24 @@ else
 		exit 1
 	}
 
+	# -s, -u and -k flags are kept for the resuming session after
+	# a patch failure.
+	# -3 and -i can and must be given when resuming.
 	echo "$sign" >"$dotest/sign"
 	echo "$utf8" >"$dotest/utf8"
 	echo "$keep" >"$dotest/keep"
 	echo 1 >"$dotest/next"
 fi
 
+case "$resolved" in
+'')
+	files=$(git-diff-index --cached --name-only HEAD) || exit
+	if [ "$files" ]; then
+	   echo "Dirty index: cannot apply patches (dirty: $files)" >&2
+	   exit 1
+	fi
+esac
+
 if test "$(cat "$dotest/utf8")" = t
 then
 	utf8=-u
@@ -216,6 +227,15 @@ do
 		go_next
 		continue
 	}
+
+	# If we are not resuming, parse and extract the patch information
+	# into separate files:
+	#  - info records the authorship and title
+	#  - msg is the rest of commit log message
+	#  - patch is the patch body.
+	#
+	# When we are resuming, these files are either already prepared
+	# by the user, or the user can tell us to do so by --resolved flag.
 	case "$resume" in
 	'')
 		git-mailinfo $keep $utf8 "$dotest/msg" "$dotest/patch" \
@@ -263,6 +283,13 @@ do
 		fi
 	    } >"$dotest/final-commit"
 	    ;;
+	*)
+		case "$resolved,$interactive" in
+		tt)
+			# This is used only for interactive view option.
+			git-diff-index -p --cached HEAD >"$dotest/patch"
+			;;
+		esac
 	esac
 
 	resume=
@@ -310,7 +337,21 @@ do
 	echo "Applying '$SUBJECT'"
 	echo
 
-	git-apply --index "$dotest/patch"; apply_status=$?
+	case "$resolved" in
+	'')
+		git-apply --index "$dotest/patch"
+		apply_status=$?
+		;;
+	t)
+		# Resolved means the user did all the hard work, and
+		# we do not have to do any patch application.  Just
+		# trust what the user has in the index file and the
+		# working tree.
+		resolved=
+		apply_status=0
+		;;
+	esac
+
 	if test $apply_status = 1 && test "$threeway" = t
 	then
 		if (fall_back_3way)
---
0.99.9.GIT
