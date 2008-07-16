From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 1/2] Migrate git-am to use git-sequencer
Date: Wed, 16 Jul 2008 22:45:20 +0200
Message-ID: <5f60ea3acffdb5dfdbe0ea6e81133efadab9f20d.1216233919.git.s-beyer@gmx.net>
References: <cover.1216233918.git.s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 22:47:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJDtw-0004gx-Pj
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 22:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756927AbYGPUpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 16:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756842AbYGPUpj
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 16:45:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:58135 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756477AbYGPUpc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 16:45:32 -0400
Received: (qmail invoked by alias); 16 Jul 2008 20:45:30 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp060) with SMTP; 16 Jul 2008 22:45:30 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+WDHk2UWaWkOTGtPsdKHADoIvf0opaqx0EAHC5yq
	BnPmTe/B6PUJHc
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KJDsI-0005nz-Fu; Wed, 16 Jul 2008 22:45:22 +0200
X-Mailer: git-send-email 1.5.6.3.390.g7b30
In-Reply-To: <cover.1216233918.git.s-beyer@gmx.net> 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88752>

In principle a migration to git-sequencer is straightforward:
Put all the mail from the mbox or Maildir into .git/rebase and
let the "patch" instruction of sequencer do the rest of the
work.

The git am --interactive part is a little more tricky.
To get this working, "pause" instructions are put after every
"patch" instruction and then be_interactive() swoops in,
that allows the user to input his choice.

Also a slight behavior change, that can be seen in the diff of
the test cases, should be mentioned: If git-am has nothing to do,
the user does not have to remove .git/rebase or run git-am --skip
manually. It automatically aborts instead, which seems to be
an improvement.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 git-am.sh     |  612 ++++++++++++++++++++-------------------------------------
 git-rebase.sh |    1 +
 t/t4150-am.sh |    6 +-
 3 files changed, 214 insertions(+), 405 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index cc8787b..e36f22c 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -33,102 +33,143 @@ cd_to_toplevel
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
+			if test -z "$1"
+			then
+				git reset -q --hard HEAD^
+			else
+				git reset -q --hard HEAD
+			fi
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
+}
 
-    # This is not so wrong.  Depending on which base we picked,
-    # orig_tree may be wildly different from ours, but his_tree
-    # has the same set of wildly different changes in parts the
-    # patch did not touch, so recursive ends up canceling them,
-    # saying that we reverted all those changes.
+run_sequencer () {
+	git sequencer $noadvice --caller='git am||--resolved|--skip' "$@"
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
+		output=$(git sequencer $noadvice \
+			--caller='git am -i||--resolved|--skip' \
+			$command 2>&1 >/dev/null)
+		noadvice=
+		case "$?" in
+		0)
+			cleanup
+			exit 0
+			;;
+		2)
+			be_interactive
+			;;
+		3)
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
+		command=--continue
+	done
 }
 
 prec=4
 dotest="$GIT_DIR/rebase"
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
+		interactive=_i ;;
 	-b|--binary)
 		binary=t ;;
 	-3|--3way)
@@ -153,9 +194,9 @@ do
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
@@ -164,348 +205,117 @@ do
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
-	die "previous rebase directory $dotest still exists but mbox given."
-	resume=yes
-else
-	# Make sure we are not given --skip nor --resolved
-	test ",$skip,$resolved," = ,,, ||
-		die "Resolve operation not in progress, we are not resuming."
+	test "$#" != 0 &&
+		die "previous rebase directory $dotest still exists but mbox given."
+
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
+	test -z "$resolved$skip" && tty -s
 
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
+	die "$dotest still exists. Use git am --skip/--resolved."
 fi
 
-case "$resolved" in
-'')
-	files=$(git diff-index --cached --name-only HEAD --) || exit
-	if [ "$files" ]; then
-	   echo "Dirty index: cannot apply patches (dirty: $files)" >&2
-	   exit 1
-	fi
-esac
+# Make sure we are not given --skip nor --resolved
+test -z "$resolved$skip" ||
+	die 'git-am is not in progress. You cannot use --skip/--resolved then.'
 
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
-	git rerere clear
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
+	msgnum=$(printf "%0${prec}d" $this)
+	this=$(($this+1))
 
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
-
-	if test $action = skip
-	then
-		go_next
+	# This ignores every mail that does not contain a patch.
+	grep '^diff' "$dotest/$msgnum" >/dev/null ||
 		continue
-	fi
 
-	if test -x "$GIT_DIR"/hooks/applypatch-msg
-	then
-		"$GIT_DIR"/hooks/applypatch-msg "$dotest/final-commit" ||
-		stop_here $this
-	fi
-
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
+		printf 'run -- printf '\''Applying "%%s"\\n'\'' '\''%s'\''\n' \
+			"$(printf '%s\n' "$subject" |
+				sed "s/'/'\\\\''/g")" >>"$todofile"
+	printf 'patch%s%s "%s" # %s\n' "$opts" "$extra" "$dotest/$msgnum" \
+		"$subject" >>"$todofile"
+	test -z "$interactive" || echo 'pause' >>"$todofile"
 done
 
-git gc --auto
-
-rm -fr "$dotest"
+noadvice=--no-advice
+run_sequencer$interactive "$todofile"
diff --git a/git-rebase.sh b/git-rebase.sh
index 56cf6f0..231c486 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -220,6 +220,7 @@ do
 			dotest="$GIT_DIR"/rebase
 			move_to_original_branch
 		fi
+		rm -rf "$GIT_DIR/sequencer"
 		git reset --hard $(cat "$dotest/orig-head")
 		rm -r "$dotest"
 		exit
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 5cbd5ef..e771806 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -212,14 +212,12 @@ test_expect_success 'am takes patches from a Pine mailbox' '
 '
 
 test_expect_success 'am fails on mail without patch' '
-	! git am <failmail &&
-	rm -r .git/rebase/
+	test_must_fail git am <failmail
 '
 
 test_expect_success 'am fails on empty patch' '
 	echo "---" >>failmail &&
-	! git am <failmail &&
-	git am --skip &&
+	test_must_fail git am <failmail &&
 	! test -d .git/rebase
 '
 
-- 
1.5.6.3.391.ge45b
