From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 4/5] Migrate git-am to use git-sequencer
Date: Sat, 26 Jul 2008 07:20:43 +0200
Message-ID: <1217049644-8874-5-git-send-email-s-beyer@gmx.net>
References: <1217049644-8874-1-git-send-email-s-beyer@gmx.net>
 <1217049644-8874-2-git-send-email-s-beyer@gmx.net>
 <1217049644-8874-3-git-send-email-s-beyer@gmx.net>
 <1217049644-8874-4-git-send-email-s-beyer@gmx.net>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 07:22:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMcEr-00086m-Dt
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 07:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbYGZFVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 01:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbYGZFVM
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 01:21:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:34077 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751893AbYGZFU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 01:20:56 -0400
Received: (qmail invoked by alias); 26 Jul 2008 05:20:54 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp057) with SMTP; 26 Jul 2008 07:20:54 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/LU71bDTrLy75oM7HJvHLqX2ls4Y7GZQU2ayu+Zh
	QqM3UDdrqZspKI
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KMcCy-0002Jg-Ea; Sat, 26 Jul 2008 07:20:44 +0200
X-Mailer: git-send-email 1.6.0.rc0.49.gd39f
In-Reply-To: <1217049644-8874-4-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90179>

In principle a migration to git-sequencer is straightforward:
Put all the mail from the mbox or Maildir into .git/rebase-apply
and let the "patch" instruction of sequencer do the rest of the
work.

The git am --interactive part is a little more tricky.
To get this working, "pause" instructions are put after every
"patch" instruction and then be_interactive() swoops in,
that allows the user to input his choice.

Also a slight behavior change, that can be seen in the diff of
the test cases, should be mentioned: If git-am has nothing to
do, the user does not have to remove .git/rebase-apply or run
git-am --skip manually. It automatically aborts instead, which
seems to be an improvement.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 git-am.sh     |  632 ++++++++++++++++++++-------------------------------------
 git-rebase.sh |    7 +-
 t/t4150-am.sh |    4 +-
 3 files changed, 220 insertions(+), 423 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index f4abd9d..ba93f02 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -34,103 +34,148 @@ cd_to_toplevel
 git var GIT_COMMITTER_IDENT >/dev/null ||
 	die "You need to set your committer info first"
 
-stop_here () {
-    echo "$1" >"$dotest/next"
-    exit 1
+cleanup () {
+	git gc --auto
+	rm -fr "$dotest"
 }
 
-stop_here_user_resolve () {
-    if [ -n "$resolvemsg" ]; then
-	    printf '%s\n' "$resolvemsg"
-	    stop_here $1
-    fi
-    cmdline="git am"
-    if test '' != "$interactive"
-    then
-        cmdline="$cmdline -i"
-    fi
-    if test '' != "$threeway"
-    then
-        cmdline="$cmdline -3"
-    fi
-    echo "When you have resolved this problem run \"$cmdline --resolved\"."
-    echo "If you would prefer to skip this patch, instead run \"$cmdline --skip\"."
-    echo "To restore the original branch and stop patching run \"$cmdline --abort\"."
-
-    stop_here $1
+die_abort () {
+	cleanup
+	die "$1"
 }
 
-go_next () {
-	rm -f "$dotest/$msgnum" "$dotest/msg" "$dotest/msg-clean" \
-		"$dotest/patch" "$dotest/info"
-	echo "$next" >"$dotest/next"
-	this=$next
-}
+be_interactive () {
+	msg="$GIT_DIR/sequencer/message"
+	patch="$GIT_DIR/sequencer/patch"
+	# we rely on sequencer here
+
+	test -t 0 ||
+		die "cannot be interactive without stdin connected to a terminal."
+	action=$(cat "$dotest/interactive")
+	while test "$action" = again
+	do
+		echo
+		echo "Commit Body is:"
+		echo "--------------------------"
+		cat "$msg"
+		echo "--------------------------"
+		if test -z "$1"
+		then
+			printf "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
+		else
+			echo 'Patch does not apply cleanly!'
+			printf "Apply+fix? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
+		fi
 
-cannot_fallback () {
-	echo "$1"
-	echo "Cannot fall back to three-way merge."
-	exit 1
+		read reply
+		case "$reply" in
+		[yY]*)
+			return 0
+			;;
+		[nN]*)
+			# pretend we never tried to apply
+			to=HEAD
+			test conflict = "$1" ||
+				to=HEAD^
+			git read-tree -m -u HEAD $to
+			git reset -q $to >/dev/null
+			return 1
+			;;
+		[eE]*)
+			git_editor "$msg"
+			git commit --amend --file="$msg" --no-verify >/dev/null
+			;;
+		[vV]*)
+			LESS=-S ${PAGER:-less} "$patch"
+			;;
+		[aA]*)
+			echo 'accept' >"$dotest/interactive"
+			return 0
+			;;
+		*)
+			:
+			;;
+		esac
+	done
+	test "$action" = accept &&
+		sed -n -e '1s/^/Applying &/p' <"$msg"
+	return 0
 }
 
-fall_back_3way () {
-    O_OBJECT=`cd "$GIT_OBJECT_DIRECTORY" && pwd`
-
-    rm -fr "$dotest"/patch-merge-*
-    mkdir "$dotest/patch-merge-tmp-dir"
-
-    # First see if the patch records the index info that we can use.
-    git apply --build-fake-ancestor "$dotest/patch-merge-tmp-index" \
-	"$dotest/patch" &&
-    GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
-    git write-tree >"$dotest/patch-merge-base+" ||
-    cannot_fallback "Repository lacks necessary blobs to fall back on 3-way merge."
-
-    echo Using index info to reconstruct a base tree...
-    if GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
-	git apply $binary --cached <"$dotest/patch"
-    then
-	mv "$dotest/patch-merge-base+" "$dotest/patch-merge-base"
-	mv "$dotest/patch-merge-tmp-index" "$dotest/patch-merge-index"
-    else
-        cannot_fallback "Did you hand edit your patch?
-It does not apply to blobs recorded in its index."
-    fi
-
-    test -f "$dotest/patch-merge-index" &&
-    his_tree=$(GIT_INDEX_FILE="$dotest/patch-merge-index" git write-tree) &&
-    orig_tree=$(cat "$dotest/patch-merge-base") &&
-    rm -fr "$dotest"/patch-merge-* || exit 1
-
-    echo Falling back to patching base and 3-way merge...
+print_continue_info () {
+	echo 'When you have resolved this problem run "git am --resolved".'
+	echo 'If you would prefer to skip this patch, instead run "git am --skip".'
+	echo 'To restore the original branch and stop patching run "git am --abort".'
+}
 
-    # This is not so wrong.  Depending on which base we picked,
-    # orig_tree may be wildly different from ours, but his_tree
-    # has the same set of wildly different changes in parts the
-    # patch did not touch, so recursive ends up canceling them,
-    # saying that we reverted all those changes.
+run_sequencer () {
+	git sequencer $seqopts --caller='git am|--abort|--resolved|--skip' "$@"
+	case "$?" in
+	0)
+		cleanup
+		exit 0
+		;;
+	2|3)
+		ret=$?
+		print_continue_info
+		exit $(($ret-2))
+		;;
+	*)
+		die_abort 'git-sequencer died unexpected. Aborting.'
+		;;
+	esac
+}
 
-    eval GITHEAD_$his_tree='"$FIRSTLINE"'
-    export GITHEAD_$his_tree
-    git-merge-recursive $orig_tree -- HEAD $his_tree || {
-	    git rerere
-	    echo Failed to merge in the changes.
-	    exit 1
-    }
-    unset GITHEAD_$his_tree
+run_sequencer_i () {
+	command="$1"
+	while true
+	do
+		output=$(git sequencer $seqopts \
+			--caller='git am -i|--abort|--resolved|--skip' \
+			$command 2>&1)
+		case "$?" in
+		0)
+			cleanup
+			exit 0
+			;;
+		2)
+			if test -f "$dotest/conflict"
+			then
+				rm "$dotest/conflict"
+			else
+				be_interactive
+			fi
+			;;
+		3)
+			: >"$dotest/conflict"
+			be_interactive conflict
+			if test $? -eq 0
+			then
+				printf '%s\n' "$output" 1>&2
+				print_continue_info
+				exit 1
+			fi
+			;;
+		*)
+			die_abort "$output"
+			;;
+		esac
+		seqopts=
+		command=--continue
+	done
 }
 
 prec=4
 dotest="$GIT_DIR/rebase-apply"
+todofile="$dotest/todo"
 sign= utf8=t keep= skip= interactive= resolved= binary= rebasing= abort=
-resolvemsg= resume=
-git_apply_opt=
+opts=
 
 while test $# != 0
 do
 	case "$1" in
 	-i|--interactive)
-		interactive=t ;;
+		interactive=_i ;;
 	-b|--binary)
 		binary=t ;;
 	-3|--3way)
@@ -157,9 +202,9 @@ do
 	--resolvemsg)
 		shift; resolvemsg=$1 ;;
 	--whitespace)
-		git_apply_opt="$git_apply_opt $1=$2"; shift ;;
+		opts="$opts $1=$2"; shift ;;
 	-C|-p)
-		git_apply_opt="$git_apply_opt $1$2"; shift ;;
+		opts="$opts $1$2"; shift ;;
 	--)
 		shift; break ;;
 	*)
@@ -168,363 +213,118 @@ do
 	shift
 done
 
-# If the dotest directory exists, but we have finished applying all the
-# patches in them, clear it out.
-if test -d "$dotest" &&
-   last=$(cat "$dotest/last") &&
-   next=$(cat "$dotest/next") &&
-   test $# != 0 &&
-   test "$next" -gt "$last"
-then
-   rm -fr "$dotest"
-fi
-
 if test -d "$dotest"
 then
-	case "$#,$skip$resolved$abort" in
-	0,*t*)
-		# Explicit resume command and we do not have file, so
-		# we are happy.
-		: ;;
-	0,)
-		# No file input but without resume parameters; catch
-		# user error to feed us a patch from standard input
-		# when there is already $dotest.  This is somewhat
-		# unreliable -- stdin could be /dev/null for example
-		# and the caller did not intend to feed us a patch but
-		# wanted to continue unattended.
-		tty -s
-		;;
-	*)
-		false
-		;;
-	esac ||
-	die "previous rebase directory $dotest still exists but mbox given."
-	resume=yes
+	test "$#" != 0 &&
+		die "previous rebase directory $dotest still exists but mbox given."
 
-	case "$skip,$abort" in
-	t,)
-		git rerere clear
-		git read-tree --reset -u HEAD HEAD
-		orig_head=$(cat "$GIT_DIR/ORIG_HEAD")
-		git reset HEAD
-		git update-ref ORIG_HEAD $orig_head
-		;;
-	,t)
-		git rerere clear
-		git read-tree --reset -u HEAD ORIG_HEAD
-		git reset ORIG_HEAD
-		rm -fr "$dotest"
-		exit ;;
-	esac
-else
-	# Make sure we are not given --skip, --resolved, nor --abort
-	test "$skip$resolved$abort" = "" ||
-		die "Resolve operation not in progress, we are not resuming."
+	test -f "$dotest/interactive" &&
+		interactive=_i action=$(cat "$dotest/interactive")
 
-	# Start afresh.
-	mkdir -p "$dotest" || exit
+	# No file input but without resume parameters; catch
+	# user error to feed us a patch from standard input
+	# when there is already $dotest.  This is somewhat
+	# unreliable -- stdin could be /dev/null for example
+	# and the caller did not intend to feed us a patch but
+	# wanted to continue unattended.
+	test -z "$abort$resolved$skip" && tty -s
 
-	if test -n "$prefix" && test $# != 0
-	then
-		first=t
-		for arg
-		do
-			test -n "$first" && {
-				set x
-				first=
-			}
-			case "$arg" in
-			/*)
-				set "$@" "$arg" ;;
-			*)
-				set "$@" "$prefix$arg" ;;
-			esac
-		done
-		shift
-	fi
-	git mailsplit -d"$prec" -o"$dotest" -b -- "$@" > "$dotest/last" ||  {
-		rm -fr "$dotest"
-		exit 1
-	}
+	test -n "$abort" && run_sequencer$interactive --abort
+	test -n "$resolved" && run_sequencer$interactive --continue
+	test -n "$skip" && run_sequencer$interactive --skip
 
-	# -b, -s, -u, -k and --whitespace flags are kept for the
-	# resuming session after a patch failure.
-	# -3 and -i can and must be given when resuming.
-	echo "$binary" >"$dotest/binary"
-	echo " $ws" >"$dotest/whitespace"
-	echo "$sign" >"$dotest/sign"
-	echo "$utf8" >"$dotest/utf8"
-	echo "$keep" >"$dotest/keep"
-	echo 1 >"$dotest/next"
-	if test -n "$rebasing"
-	then
-		: >"$dotest/rebasing"
-	else
-		: >"$dotest/applying"
-		git update-ref ORIG_HEAD HEAD
-	fi
+	die "$dotest still exists. Use git am --abort/--skip/--resolved."
 fi
 
-case "$resolved" in
-'')
-	files=$(git diff-index --cached --name-only HEAD --) || exit
-	if [ "$files" ]; then
-	   echo "Dirty index: cannot apply patches (dirty: $files)" >&2
-	   exit 1
-	fi
-esac
+# Make sure we are not given --skip, --resolved, nor --abort
+test -z "$abort$resolved$skip" ||
+	die 'git-am is not in progress. You cannot use --abort/--skip/--resolved then.'
 
-if test "$(cat "$dotest/binary")" = t
-then
-	binary=--allow-binary-replacement
-fi
-if test "$(cat "$dotest/utf8")" = t
-then
-	utf8=-u
-else
-	utf8=-n
-fi
-if test "$(cat "$dotest/keep")" = t
-then
-	keep=-k
-fi
-ws=`cat "$dotest/whitespace"`
-if test "$(cat "$dotest/sign")" = t
+# sequencer running?
+git sequencer --status >/dev/null 2>&1 &&
+	die "Sequencer already started. Cannot run git-am."
+
+# Start afresh.
+mkdir -p "$dotest" ||
+	die "Could not create $dotest directory."
+
+if test -n "$prefix" && test $# != 0
 then
-	SIGNOFF=`git-var GIT_COMMITTER_IDENT | sed -e '
-			s/>.*/>/
-			s/^/Signed-off-by: /'
-		`
-else
-	SIGNOFF=
+	first=t
+	for arg
+	do
+		test -n "$first" && {
+			set x
+			first=
+		}
+		case "$arg" in
+		/*)
+			set "$@" "$arg" ;;
+		*)
+			set "$@" "$prefix$arg" ;;
+		esac
+	done
+	shift
 fi
+last=$(git mailsplit -d"$prec" -o"$dotest" -b -- "$@") ||  {
+	cleanup
+	exit 1
+}
+this=1
 
-last=`cat "$dotest/last"`
-this=`cat "$dotest/next"`
-if test "$skip" = t
-then
-	this=`expr "$this" + 1`
-	resume=
+files=$(git diff-index --cached --name-only HEAD --) || exit
+if [ "$files" ]; then
+	echo "Dirty index: cannot apply patches (dirty: $files)" >&2
+	exit 1
 fi
 
-if test "$this" -gt "$last"
+test -n "$interactive" && echo 'again' >"$dotest/interactive"
+
+# converting our options to git-sequencer file insn options
+test -n "$binary" && opts="$opts --binary"
+test -n "$utf8" || opts="$opts -n"
+test -n "$keep" && opts="$opts -k"
+test -n "$sign" && opts="$opts --signoff"
+test -n "$threeway" && opts="$opts -3"
+
+# these files are created for tab completion scripts
+if test -n "$rebasing"
 then
-	echo Nothing to do.
-	rm -fr "$dotest"
-	exit
+	: >"$dotest/rebasing"
+else
+	: >"$dotest/applying"
+	git update-ref ORIG_HEAD HEAD
 fi
 
+# create todofile
+: > "$todofile" ||
+	die_abort "Cannot create $todofile"
 while test "$this" -le "$last"
 do
-	msgnum=`printf "%0${prec}d" $this`
-	next=`expr "$this" + 1`
-	test -f "$dotest/$msgnum" || {
-		resume=
-		go_next
-		continue
-	}
-
-	# If we are not resuming, parse and extract the patch information
-	# into separate files:
-	#  - info records the authorship and title
-	#  - msg is the rest of commit log message
-	#  - patch is the patch body.
-	#
-	# When we are resuming, these files are either already prepared
-	# by the user, or the user can tell us to do so by --resolved flag.
-	case "$resume" in
-	'')
-		git mailinfo $keep $utf8 "$dotest/msg" "$dotest/patch" \
-			<"$dotest/$msgnum" >"$dotest/info" ||
-			stop_here $this
-
-		# skip pine's internal folder data
-		grep '^Author: Mail System Internal Data$' \
-			<"$dotest"/info >/dev/null &&
-			go_next && continue
-
-		test -s "$dotest/patch" || {
-			echo "Patch is empty.  Was it split wrong?"
-			stop_here $this
-		}
-		if test -f "$dotest/rebasing" &&
-			commit=$(sed -e 's/^From \([0-9a-f]*\) .*/\1/' \
-				-e q "$dotest/$msgnum") &&
-			test "$(git cat-file -t "$commit")" = commit
-		then
-			git cat-file commit "$commit" |
-			sed -e '1,/^$/d' >"$dotest/msg-clean"
-		else
-			SUBJECT="$(sed -n '/^Subject/ s/Subject: //p' "$dotest/info")"
-			case "$keep_subject" in -k)  SUBJECT="[PATCH] $SUBJECT" ;; esac
-
-			(printf '%s\n\n' "$SUBJECT"; cat "$dotest/msg") |
-				git stripspace > "$dotest/msg-clean"
-		fi
-		;;
-	esac
-
-	GIT_AUTHOR_NAME="$(sed -n '/^Author/ s/Author: //p' "$dotest/info")"
-	GIT_AUTHOR_EMAIL="$(sed -n '/^Email/ s/Email: //p' "$dotest/info")"
-	GIT_AUTHOR_DATE="$(sed -n '/^Date/ s/Date: //p' "$dotest/info")"
-
-	if test -z "$GIT_AUTHOR_EMAIL"
-	then
-		echo "Patch does not have a valid e-mail address."
-		stop_here $this
-	fi
-
-	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
-
-	case "$resume" in
-	'')
-	    if test '' != "$SIGNOFF"
-	    then
-		LAST_SIGNED_OFF_BY=`
-		    sed -ne '/^Signed-off-by: /p' \
-		    "$dotest/msg-clean" |
-		    sed -ne '$p'
-		`
-		ADD_SIGNOFF=`
-		    test "$LAST_SIGNED_OFF_BY" = "$SIGNOFF" || {
-		    test '' = "$LAST_SIGNED_OFF_BY" && echo
-		    echo "$SIGNOFF"
-		}`
-	    else
-		ADD_SIGNOFF=
-	    fi
-	    {
-		if test -s "$dotest/msg-clean"
-		then
-			cat "$dotest/msg-clean"
-		fi
-		if test '' != "$ADD_SIGNOFF"
-		then
-			echo "$ADD_SIGNOFF"
-		fi
-	    } >"$dotest/final-commit"
-	    ;;
-	*)
-		case "$resolved$interactive" in
-		tt)
-			# This is used only for interactive view option.
-			git diff-index -p --cached HEAD -- >"$dotest/patch"
-			;;
-		esac
-	esac
-
-	resume=
-	if test "$interactive" = t
-	then
-	    test -t 0 ||
-	    die "cannot be interactive without stdin connected to a terminal."
-	    action=again
-	    while test "$action" = again
-	    do
-		echo "Commit Body is:"
-		echo "--------------------------"
-		cat "$dotest/final-commit"
-		echo "--------------------------"
-		printf "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
-		read reply
-		case "$reply" in
-		[yY]*) action=yes ;;
-		[aA]*) action=yes interactive= ;;
-		[nN]*) action=skip ;;
-		[eE]*) git_editor "$dotest/final-commit"
-		       action=again ;;
-		[vV]*) action=again
-		       LESS=-S ${PAGER:-less} "$dotest/patch" ;;
-		*)     action=again ;;
-		esac
-	    done
-	else
-	    action=yes
-	fi
-	FIRSTLINE=$(sed 1q "$dotest/final-commit")
+	msgnum=$(printf "%0${prec}d" $this)
+	this=$(($this+1))
 
-	if test $action = skip
-	then
-		go_next
+	# This ignores every mail that does not contain a patch.
+	grep '^diff' "$dotest/$msgnum" >/dev/null ||
 		continue
-	fi
-
-	if test -x "$GIT_DIR"/hooks/applypatch-msg
-	then
-		"$GIT_DIR"/hooks/applypatch-msg "$dotest/final-commit" ||
-		stop_here $this
-	fi
-
-	printf 'Applying: %s\n' "$FIRSTLINE"
 
-	case "$resolved" in
-	'')
-		git apply $git_apply_opt $binary --index "$dotest/patch"
-		apply_status=$?
-		;;
-	t)
-		# Resolved means the user did all the hard work, and
-		# we do not have to do any patch application.  Just
-		# trust what the user has in the index file and the
-		# working tree.
-		resolved=
-		git diff-index --quiet --cached HEAD -- && {
-			echo "No changes - did you forget to use 'git add'?"
-			stop_here_user_resolve $this
-		}
-		unmerged=$(git ls-files -u)
-		if test -n "$unmerged"
-		then
-			echo "You still have unmerged paths in your index"
-			echo "did you forget to use 'git add'?"
-			stop_here_user_resolve $this
-		fi
-		apply_status=0
-		git rerere
-		;;
-	esac
-
-	if test $apply_status = 1 && test "$threeway" = t
-	then
-		if (fall_back_3way)
-		then
-		    # Applying the patch to an earlier tree and merging the
-		    # result may have produced the same tree as ours.
-		    git diff-index --quiet --cached HEAD -- && {
-			echo No changes -- Patch already applied.
-			go_next
-			continue
-		    }
-		    # clear apply_status -- we have successfully merged.
-		    apply_status=0
-		fi
-	fi
-	if test $apply_status != 0
-	then
-		echo Patch failed at $msgnum.
-		stop_here_user_resolve $this
-	fi
-
-	if test -x "$GIT_DIR"/hooks/pre-applypatch
-	then
-		"$GIT_DIR"/hooks/pre-applypatch || stop_here $this
-	fi
-
-	tree=$(git write-tree) &&
-	parent=$(git rev-parse --verify HEAD) &&
-	commit=$(git commit-tree $tree -p $parent <"$dotest/final-commit") &&
-	git update-ref -m "$GIT_REFLOG_ACTION: $FIRSTLINE" HEAD $commit $parent ||
-	stop_here $this
-
-	if test -x "$GIT_DIR"/hooks/post-applypatch
-	then
-		"$GIT_DIR"/hooks/post-applypatch
-	fi
-
-	go_next
+	extra=
+	test -n "$rebasing" &&
+		commit=$(sed -e 's/^From \([0-9a-f]*\) .*/\1/' \
+			-e q "$dotest/$msgnum") &&
+		test "$(git cat-file -t "$commit")" = commit &&
+		extra=" -C $commit"
+
+	subject=$(sed -n '1,/^Subject:/s/Subject: *\(\[.*\]\)\{0,1\} *//p' \
+		<"$dotest/$msgnum")
+	test -n "$interactive" ||
+		printf 'run -- printf '\''Applying: %%s\\n'\'' '\''%s'\''\n' \
+			"$(printf '%s\n' "$subject" |
+				sed "s/'/'\\\\''/g")" >>"$todofile"
+	printf 'patch%s%s "%s" # %s\n' "$opts" "$extra" "$dotest/$msgnum" \
+		"$subject" >>"$todofile"
+	test -z "$interactive" || echo 'pause' >>"$todofile"
 done
 
-git gc --auto
-
-rm -fr "$dotest"
+seqopts="--no-advice --allow-dirty"
+run_sequencer$interactive "$todofile"
diff --git a/git-rebase.sh b/git-rebase.sh
index 412e135..67c1868 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -216,12 +216,11 @@ do
 		if test -d "$dotest"
 		then
 			move_to_original_branch
+			git reset --hard $(cat "$dotest/orig-head")
+			rm -r "$dotest"
 		else
-			dotest="$GIT_DIR"/rebase-apply
-			move_to_original_branch
+			git am --abort
 		fi
-		git reset --hard $(cat "$dotest/orig-head")
-		rm -r "$dotest"
 		exit
 		;;
 	--onto)
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 6e6aaf5..d49c69d 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -212,14 +212,12 @@ test_expect_success 'am takes patches from a Pine mailbox' '
 '
 
 test_expect_success 'am fails on mail without patch' '
-	test_must_fail git am <failmail &&
-	rm -r .git/rebase-apply/
+	test_must_fail git am <failmail
 '
 
 test_expect_success 'am fails on empty patch' '
 	echo "---" >>failmail &&
 	test_must_fail git am <failmail &&
-	git am --skip &&
 	! test -d .git/rebase-apply
 '
 
-- 
1.6.0.rc0.49.gd39f
