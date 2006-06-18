From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] rebase: Allow merge strategies to be used when rebasing
Date: Sat, 17 Jun 2006 20:02:15 -0700
Message-ID: <1150599735483-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jun 18 05:02:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrnYL-0004S4-OZ
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 05:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWFRDCS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 23:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWFRDCS
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 23:02:18 -0400
Received: from hand.yhbt.net ([66.150.188.102]:27264 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932074AbWFRDCS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 23:02:18 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 5E2DD7DC020;
	Sat, 17 Jun 2006 20:02:16 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 17 Jun 2006 20:02:15 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0.ge24c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22048>

This solves the problem of rebasing local commits against an
upstream that has renamed files.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-rebase.txt |   20 +++++
 git-rebase.sh                |  176 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 186 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 08ee4aa..c339c45 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -7,7 +7,7 @@ git-rebase - Rebase local commits to a n
 
 SYNOPSIS
 --------
-'git-rebase' [--onto <newbase>] <upstream> [<branch>]
+'git-rebase' [--merge] [--onto <newbase>] <upstream> [<branch>]
 
 'git-rebase' --continue | --skip | --abort
 
@@ -106,6 +106,24 @@ OPTIONS
 --abort::
 	Restore the original branch and abort the rebase operation.
 
+--skip::
+	Restart the rebasing process by skipping the current patch.
+	This does not work with the --merge option.
+
+--merge::
+	Use merging strategies to rebase.  When the recursive (default) merge
+	strategy is used, this allows rebase to be aware of renames on the
+	upstream side.
+
+-s <strategy>, \--strategy=<strategy>::
+	Use the given merge strategy; can be supplied more than
+	once to specify them in the order they should be tried.
+	If there is no `-s` option, a built-in list of strategies
+	is used instead (`git-merge-recursive` when merging a single
+	head, `git-merge-octopus` otherwise).  This implies --merge.
+
+include::merge-strategies.txt[]
+
 NOTES
 -----
 When you rebase a branch, you are changing its history in a way that
diff --git a/git-rebase.sh b/git-rebase.sh
index e6b57b8..68bddfb 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -34,7 +34,81 @@ When you have resolved this problem run 
 If you would prefer to skip this patch, instead run \"git rebase --skip\".
 To restore the original branch and stop rebasing run \"git rebase --abort\".
 "
+
+MRESOLVEMSG="
+When you have resolved this problem run \"git rebase --continue\".
+To restore the original branch and stop rebasing run \"git rebase --abort\".
+"
 unset newbase
+strategy_args=
+do_merge=
+dotest=$GIT_DIR/.dotest-merge
+prec=4
+
+continue_merge () {
+	test -n "$prev_head" || die "prev_head must be defined"
+	test -d "$dotest" || die "$dotest directory does not exist"
+
+	unmerged=$(git-ls-files -u)
+	if test -n "$unmerged"
+	then
+		echo "You still have unmerged paths in your index"
+		echo "did you forget update-index?"
+		die "$MRESOLVEMSG"
+	fi
+
+	mh="$GIT_DIR/MERGE_HEAD"
+	mm="$GIT_DIR/MERGE_MSG"
+	if test -f "$mh" && test -f "$mm"
+	then
+		git-commit -F "$mm" || die "commit failed: $MRESOLVEMSG"
+	else
+		echo "Previous merge succeeded automatically"
+	fi
+
+	prev_head=`git-rev-parse HEAD^0`
+
+	# save the resulting commit so we can read-tree on it later
+	echo "$prev_head" > "$dotest/`printf %0${prec}d $msgnum`.result"
+	echo "$prev_head" > "$dotest/prev_head"
+
+	# onto the next patch:
+	msgnum=$(($msgnum + 1))
+	printf "%0${prec}d" "$msgnum" > "$dotest/msgnum"
+}
+
+call_merge () {
+	cmt="$(cat $dotest/`printf %0${prec}d $1`)"
+	echo "$cmt" > "$dotest/current"
+	git-merge $strategy_args "rebase-merge: $cmt" HEAD "$cmt" \
+			|| die "$MRESOLVEMSG"
+}
+
+finish_rb_merge () {
+	set -e
+
+	msgnum=1
+	echo "Finalizing rebased commits..."
+	git-reset --hard "`cat $dotest/upstream`"
+	end="`cat $dotest/end`"
+	while test "$msgnum" -le "$end"
+	do
+		msgnum=`printf "%0${prec}d" "$msgnum"`
+		printf "%0${prec}d" "$msgnum" > "$dotest/msgnum"
+
+		git-read-tree `cat "$dotest/$msgnum.result"`
+		git-checkout-index -q -f -u -a
+		git-commit -C "`cat $dotest/$msgnum`"
+
+		echo "Committed $msgnum"
+		echo '    '`git-rev-list --pretty=oneline -1 HEAD | \
+					sed 's/^[a-f0-9]\+ //'`
+		msgnum=$(($msgnum + 1))
+	done
+	rm -r "$dotest"
+	echo "All done."
+}
+
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
@@ -46,17 +120,42 @@ do
 			exit 1
 			;;
 		esac
+		if test -d "$dotest"
+		then
+			prev_head="`cat $dotest/prev_head`"
+			end="`cat $dotest/end`"
+			msgnum="`cat $dotest/msgnum`"
+			continue_merge
+			while test "$msgnum" -le "$end"
+			do
+				call_merge "$msgnum"
+				continue_merge
+			done
+			finish_rb_merge
+			exit
+		fi
 		git am --resolved --3way --resolvemsg="$RESOLVEMSG"
 		exit
 		;;
 	--skip)
+		if test -d "$dotest"
+		then
+			die "--skip is not supported when using --merge"
+		fi
 		git am -3 --skip --resolvemsg="$RESOLVEMSG"
 		exit
 		;;
 	--abort)
-		[ -d .dotest ] || die "No rebase in progress?"
+		if test -d "$dotest"
+		then
+			rm -r "$dotest"
+		elif test -d .dotest
+		then
+			rm -r .dotest
+		else
+			die "No rebase in progress?"
+		fi
 		git reset --hard ORIG_HEAD
-		rm -r .dotest
 		exit
 		;;
 	--onto)
@@ -64,6 +163,24 @@ do
 		newbase="$2"
 		shift
 		;;
+	-M|-m|--m|--me|--mer|--merg|--merge)
+		do_merge=t
+		;;
+	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
+		--strateg=*|--strategy=*|\
+	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
+		case "$#,$1" in
+		*,*=*)
+			strategy=`expr "$1" : '-[^=]*=\(.*\)'` ;;
+		1,*)
+			usage ;;
+		*)
+			strategy="$2"
+			shift ;;
+		esac
+		do_merge=t
+		strategy_args="${strategy_args}-s $strategy "
+		;;
 	-*)
 		usage
 		;;
@@ -75,16 +192,25 @@ do
 done
 
 # Make sure we do not have .dotest
-if mkdir .dotest
+if test -z "$do_merge"
 then
-	rmdir .dotest
-else
-	echo >&2 '
+	if mkdir .dotest
+	then
+		rmdir .dotest
+	else
+		echo >&2 '
 It seems that I cannot create a .dotest directory, and I wonder if you
 are in the middle of patch application or another rebase.  If that is not
 the case, please rm -fr .dotest and run me again.  I am stopping in case
 you still have something valuable there.'
-	exit 1
+		exit 1
+	fi
+else
+	if test -d "$dotest"
+	then
+		die "previous dotest directory $dotest still exists." \
+			'try git-rebase < --continue | --abort >'
+	fi
 fi
 
 # The tree must be really really clean.
@@ -152,6 +278,38 @@ then
 	exit 0
 fi
 
-git-format-patch -k --stdout --full-index "$upstream"..ORIG_HEAD |
-git am --binary -3 -k --resolvemsg="$RESOLVEMSG"
+if test -z "$do_merge"
+then
+	git-format-patch -k --stdout --full-index "$upstream"..ORIG_HEAD |
+	git am --binary -3 -k --resolvemsg="$RESOLVEMSG"
+	exit 0
+fi
+
+# start doing a rebase with git-merge
+# this is rename-aware if the recursive (default) strategy is used
+
+mkdir -p "$dotest"
+echo "$upstream" > "$dotest/upstream"
+prev_head=`git-rev-parse HEAD^0`
+echo "$prev_head" > "$dotest/prev_head"
+
+msgnum=0
+for cmt in `git-rev-list "$upstream"..ORIG_HEAD | tac`
+do
+	msgnum=$(($msgnum + 1))
+	echo "$cmt" > "$dotest/`printf "%0${prec}d" $msgnum`"
+done
+
+printf "%0${prec}d" 1 > "$dotest/msgnum"
+printf "%0${prec}d" "$msgnum" > "$dotest/end"
+
+end=$msgnum
+msgnum=1
+
+while test "$msgnum" -le "$end"
+do
+	call_merge "$msgnum"
+	continue_merge
+done
 
+finish_rb_merge
-- 
1.4.0.ge24c
