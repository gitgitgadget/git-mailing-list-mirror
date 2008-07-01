From: Stephan Beyer <s-beyer@gmx.net>
Subject: [RFC/PATCH 4/4] Migrate git-am to use git-sequencer
Date: Tue,  1 Jul 2008 04:38:34 +0200
Message-ID: <1214879914-17866-5-git-send-email-s-beyer@gmx.net>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net>
 <1214879914-17866-2-git-send-email-s-beyer@gmx.net>
 <1214879914-17866-3-git-send-email-s-beyer@gmx.net>
 <1214879914-17866-4-git-send-email-s-beyer@gmx.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 04:40:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDVml-0005AW-23
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 04:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756256AbYGACis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 22:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756043AbYGACis
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 22:38:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:44192 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754853AbYGACik (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 22:38:40 -0400
Received: (qmail invoked by alias); 01 Jul 2008 02:38:38 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp043) with SMTP; 01 Jul 2008 04:38:38 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/Cgvxg5eLC8p94NXviuZzq3Jt13WSWv4+vMes6un
	Z/QYPD9gCSKjK9
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KDVlK-0004em-9O; Tue, 01 Jul 2008 04:38:34 +0200
X-Mailer: git-send-email 1.5.6.1.130.ga8860.dirty
In-Reply-To: <1214879914-17866-4-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86987>

This patch also adds --abort to git-am, which is just a
trivial implication of using git-sequencer.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
Hm, what to say here?

I have to admit that interactive mode is purely tested.
Well, I've used sequencer-based git-am for a while, but never really
used the interactive mode (except for first manual test cases).

 Documentation/git-am.txt |    5 +-
 git-am.sh                |  552 +++++++++++++---------------------------------
 git-rebase.sh            |    7 +-
 t/t3407-rebase-abort.sh  |   10 +-
 t/t4150-am.sh            |   21 ++-
 5 files changed, 178 insertions(+), 417 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 46544a0..b714106 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -13,7 +13,7 @@ SYNOPSIS
          [--3way] [--interactive] [--binary]
          [--whitespace=<option>] [-C<n>] [-p<n>]
          <mbox>|<Maildir>...
-'git-am' [--skip | --resolved]
+'git-am' (--abort | --skip | --resolved)
 
 DESCRIPTION
 -----------
@@ -79,6 +79,9 @@ default.   You could use `--no-utf8` to override this.
 --interactive::
 	Run interactively.
 
+--abort::
+	Abort applying and rewind applied patches.
+
 --skip::
 	Skip the current patch.  This is only meaningful when
 	restarting an aborted patch.
diff --git a/git-am.sh b/git-am.sh
index 2c517ed..dd19dd7 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -6,9 +6,11 @@ SUBDIRECTORY_OK=Yes
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
 git-am [options] <mbox>|<Maildir>...
+git-am [options] --abort
 git-am [options] --resolved
 git-am [options] --skip
 --
+abort           abort patching and reset done patches
 d,dotest=       (removed -- do not use)
 i,interactive   run interactively
 b,binary        pass --allow-binary-replacement to git-apply
@@ -30,104 +32,101 @@ set_reflog_action am
 require_work_tree
 cd_to_toplevel
 
-git var GIT_COMMITTER_IDENT >/dev/null || exit
+git var GIT_COMMITTER_IDENT >/dev/null ||
+	die "You need to set your committer info first"
 
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
-    cmdline=$(basename $0)
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
+	author_script="$GIT_DIR/sequencer/author-script"
+	# we rely on sequencer here
+
+	test -t 0 ||
+		die "cannot be interactive without stdin connected to a terminal."
+	action=$(cat "$dotest/interactive")
+	while test "$action" = again
+	do
+		echo "Commit Body is:"
+		echo "--------------------------"
+		cat "$msg"
+		echo "--------------------------"
+		printf "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
 
-cannot_fallback () {
-	echo "$1"
-	echo "Cannot fall back to three-way merge."
-	exit 1
+		read reply
+		case "$reply" in
+		[yY]*)
+			run_sequencer --continue
+			;;
+		[nN]*)
+			git reset --hard HEAD^
+			run_sequencer --continue
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
+			run_sequencer --continue
+			;;
+		*)
+			:
+			;;
+		esac
+	done
+	test "$action" = accept &&
+		run_sequencer --continue
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
-
-    # This is not so wrong.  Depending on which base we picked,
-    # orig_tree may be wildly different from ours, but his_tree
-    # has the same set of wildly different changes in parts the
-    # patch did not touch, so recursive ends up canceling them,
-    # saying that we reverted all those changes.
 
-    eval GITHEAD_$his_tree='"$FIRSTLINE"'
-    export GITHEAD_$his_tree
-    git-merge-recursive $orig_tree -- HEAD $his_tree || {
-	    git rerere
-	    echo Failed to merge in the changes.
-	    exit 1
-    }
-    unset GITHEAD_$his_tree
+run_sequencer () {
+	git sequencer --caller='git am|--abort|--resolved|--skip' "$@"
+	case "$?" in
+	0)
+		cleanup
+		exit 0
+		;;
+	2)
+		test -n "$interactive" && be_interactive
+		echo 'git-sequencer needs continuation (by edit).'
+		exit 0
+		;;
+	3)
+		die 'git-sequencer needs continuation (by conflict).'
+		;;
+	*)
+		die_abort 'git-sequencer died.'
+		;;
+	esac
 }
 
 prec=4
 dotest=".dotest"
+todofile="$dotest/todo"
 sign= utf8=t keep= skip= interactive= resolved= binary= rebasing=
-resolvemsg= resume=
-git_apply_opt=
+resolvemsg=
+opts=
 
 while test $# != 0
 do
 	case "$1" in
 	-i|--interactive)
-		interactive=t ;;
+		interactive=-q ;;
+	--abort)
+		abort=t ;;
 	-b|--binary)
 		binary=t ;;
 	-3|--3way)
@@ -152,9 +151,9 @@ do
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
@@ -163,347 +162,92 @@ do
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
-	case "$#,$skip$resolved" in
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
-	die "previous dotest directory $dotest still exists but mbox given."
-	resume=yes
-else
-	# Make sure we are not given --skip nor --resolved
-	test ",$skip,$resolved," = ,,, ||
-		die "Resolve operation not in progress, we are not resuming."
+	test "$#" != 0 &&
+		die "previous dotest directory $dotest still exists but mbox given."
+
+	test -f "$dotest/interactive" &&
+		interactive=-q action=$(cat "$dotest/interactive")
 
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
+	test -n "$abort" && run_sequencer --abort
+	test -n "$resolved" && run_sequencer --continue
+	test -n "$skip" && run_sequencer --skip
 
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
+# Make sure we are not given --skip nor --resolved nor --abort
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
-then
-	SIGNOFF=`git-var GIT_COMMITTER_IDENT | sed -e '
-			s/>.*/>/
-			s/^/Signed-off-by: /'
-		`
-else
-	SIGNOFF=
-fi
+# Start afresh.
+mkdir -p "$dotest" ||
+	die "Could not create $dotest directory."
 
-last=`cat "$dotest/last"`
-this=`cat "$dotest/next"`
-if test "$skip" = t
+if test -n "$prefix" && test $# != 0
 then
-	git rerere clear
-	this=`expr "$this" + 1`
-	resume=
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
 
-if test "$this" -gt "$last"
-then
-	echo Nothing to do.
-	rm -fr "$dotest"
-	exit
+files=$(git diff-index --cached --name-only HEAD --) || exit
+if [ "$files" ]; then
+	echo "Dirty index: cannot apply patches (dirty: $files)" >&2
+	exit 1
 fi
 
-while test "$this" -le "$last"
-do
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
+test -n "$interactive" && echo 'again' >"$dotest/interactive"
 
-		# skip pine's internal folder data
-		grep '^Author: Mail System Internal Data$' \
-			<"$dotest"/info >/dev/null &&
-			go_next && continue
+# converting our options to git-sequencer file insn options
+test -n "$binary" && opts="$opts --binary"
+test -n "$utf8" || opts="$opts -n"
+test -n "$keep" && opts="$opts -k"
+test -n "$sign" && opts="$opts --signoff"
+test -n "$threeway" && opts="$opts -3"
 
-		test -s $dotest/patch || {
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
+# create todofile
+: > "$todofile" ||
+	die_abort "Cannot create $todofile"
+while test "$this" -le "$last"
+do
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
 
-	printf 'Applying %s\n' "$FIRSTLINE"
-
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
+	printf 'patch%s "%s" #%s\n' \
+		"$opts" "$dotest/$msgnum" \
+		"$(sed -n '1,/^Subject:/s/Subject://p' "$dotest/$msgnum")" >> "$todofile"
+	test -n "$interactive" && echo 'pause' >>"$todofile"
 done
 
-git gc --auto
-
-rm -fr "$dotest"
+run_sequencer $interactive "$todofile"
diff --git a/git-rebase.sh b/git-rebase.sh
index e2d85ee..b0d4c7d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -216,12 +216,11 @@ do
 		if test -d "$dotest"
 		then
 			move_to_original_branch
+			git reset --hard $(cat "$dotest/orig-head")
+			rm -r "$dotest"
 		else
-			dotest=.dotest
-			move_to_original_branch
+			git am --abort
 		fi
-		git reset --hard $(cat "$dotest/orig-head")
-		rm -r "$dotest"
 		exit
 		;;
 	--onto)
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 1777ffe..f6bbd51 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -39,9 +39,11 @@ testrebase() {
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type master &&
 		test -d "$dotest" &&
+		#test -d ".git/sequencer" &&
 		git rebase --abort &&
 		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
-		test ! -d "$dotest"
+		test ! -d "$dotest" &&
+		test ! -d ".git/sequencer"
 	'
 
 	test_expect_success "rebase$type --abort after --skip" '
@@ -54,7 +56,8 @@ testrebase() {
 		test $(git rev-parse HEAD) = $(git rev-parse master) &&
 		git-rebase --abort &&
 		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
-		test ! -d "$dotest"
+		test ! -d "$dotest" &&
+		test ! -d ".git/sequencer"
 	'
 
 	test_expect_success "rebase$type --abort after --continue" '
@@ -70,7 +73,8 @@ testrebase() {
 		test $(git rev-parse HEAD) != $(git rev-parse master) &&
 		git rebase --abort &&
 		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
-		test ! -d "$dotest"
+		test ! -d "$dotest" &&
+		test ! -d ".git/sequencer"
 	'
 }
 
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index bc98260..a9ee55e 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -83,6 +83,10 @@ test_expect_success setup '
 	git commit -m third &&
 	git format-patch --stdout first >patch2	&&
 	git checkout -b lorem &&
+	echo new >another &&
+	git add another &&
+	test_tick &&
+	git commit -m "added another file" &&
 	sed -n -e "11,\$p" msg >file &&
 	head -n 9 msg >>file &&
 	test_tick &&
@@ -181,7 +185,7 @@ test_expect_success 'am -3 falls back to 3-way merge' '
 '
 
 test_expect_success 'am pauses on conflict' '
-	git checkout lorem2^^ &&
+	git checkout lorem2~3 &&
 	! git am lorem-move.patch &&
 	test -d .dotest
 '
@@ -193,8 +197,17 @@ test_expect_success 'am --skip works' '
 	test goodbye = "$(cat another)"
 '
 
+test_expect_success 'am --abort works' '
+	git checkout lorem2~3 &&
+	! git am lorem-move.patch &&
+	test -d .dotest &&
+	git am --abort &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse lorem2~3)" &&
+	! test -f another
+'
+
 test_expect_success 'am --resolved works' '
-	git checkout lorem2^^ &&
+	git checkout lorem2~3 &&
 	! git am lorem-move.patch &&
 	test -d .dotest &&
 	echo resolved >>file &&
@@ -212,14 +225,12 @@ test_expect_success 'am takes patches from a Pine mailbox' '
 '
 
 test_expect_success 'am fails on mail without patch' '
-	! git am <failmail &&
-	rm -r .dotest/
+	! git am <failmail
 '
 
 test_expect_success 'am fails on empty patch' '
 	echo "---" >>failmail &&
 	! git am <failmail &&
-	git am --skip &&
 	! test -d .dotest
 '
 
-- 
1.5.6.334.gdaf0
