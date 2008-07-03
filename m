From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC/PATCH 1/4] Add git-sequencer shell prototype
Date: Thu, 3 Jul 2008 23:09:50 +0200
Message-ID: <20080703210950.GC6677@leksak.fem-net>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807031142540.9925@racer> <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 03 23:11:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEW5A-000734-7k
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 23:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637AbYGCVJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 17:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753536AbYGCVJ5
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 17:09:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:52260 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753417AbYGCVJz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 17:09:55 -0400
Received: (qmail invoked by alias); 03 Jul 2008 21:09:53 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp015) with SMTP; 03 Jul 2008 23:09:53 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX193h0ApNLt359FpJYtdv+hzNOwLTPrC6xyIqgLOh9
	mmJ8jijEGmlksw
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KEW3q-0006mL-Bn; Thu, 03 Jul 2008 23:09:50 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807031142540.9925@racer> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87319>

Hi,

On Thu, Jul 03, 2008 at 12:03:49PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 2 Jul 2008, Junio C Hamano wrote:
> > Stephan Beyer <s-beyer@gmx.net> writes:
> > 
> > > git sequencer is planned as a backend for user scripts
> > > that execute a sequence of git instructions and perhaps
> > > need manual intervention, for example git-rebase or git-am.
> > 
> > ...
> > > +output () {
> > > +	case "$VERBOSE" in
> > > +	0)
> > > +		"$@" >/dev/null
> > > +		;;
> > > +	1)
> > > +		output=$("$@" 2>&1 )
> > > +		status=$?
> > > +		test $status -ne 0 && printf '%s\n' "$output"
> > > +		return $status
> > > +		;;
> > > +	2)
> > > +		"$@"
> > > +		;;
> > > +	esac
> > > +}
> > 
> > Perhaps misnamed?  This feels more like "do" or "perform" or "run".
> 
> My fault.  I like "perform".

Right, the "output" name puts a wrong behavior in mind.
"perform" (or "do" or "run") won't exactly say that this function
"adjusts" the output somehow, but I'm nonetheless fine with taking
"perform".

(I inline-attach patches so that you can incrementally review what I did
with your feedback.)
--- a/git-sequencer.sh
+++ b/git-sequencer.sh
@@ -75,7 +75,7 @@ quit () {
 	exit 0
 }
 
-output () {
+perform () {
 	case "$VERBOSE" in
 	0)
 		"$@" >/dev/null
@@ -165,7 +165,7 @@ restore () {
 		git symbolic-ref HEAD "$HEADNAME"
 		;;
 	esac &&
-	output git reset --hard "$HEAD"
+	perform git reset --hard "$HEAD"
 }
 
 has_action () {
@@ -208,14 +208,14 @@ pick_one () {
 	then
 		test "$(git rev-parse --verify "$1^")" = \
 			"$(git rev-parse --verify HEAD)" &&
-			output git reset --hard "$1" &&
+			perform git reset --hard "$1" &&
 			return
 	fi
 	test "$1" != '--edit' -a "$what" = 'revert' &&
 		what='revert --no-edit'
 	test -n "$SIGNOFF" &&
 		what="$what -s"
-	$use_output git $what "$@"
+	$use_perform git $what "$@"
 }
 
 nth_string () {
@@ -945,15 +945,15 @@ insn_pick () {
 	# Be kind to users and ignore --mainline=1 on non-merge commits
 	test -n "$mainline" -a 2 -gt $(count_parents "$sha1") && mainline=
 
-	use_output=
+	use_perform=
 	test -n "$edit_msg" ||
-		use_output=output
+		use_perform=perform
 
 	pick_one "$op" $edit_msg $mainline $sha1 ||
 		die_with_patch $sha1 "Could not apply $sha1"
 
 	test -n "$EDIT" ||
-		use_output=output
+		use_perform=perform
 
 	get_current_author
 	signoff=
@@ -961,18 +961,18 @@ insn_pick () {
 	if test -n "$AUTHOR" -a -n "$MESSAGE"
 	then
 		# this is just because we only want to do ONE amending commit
-		$use_output git commit --amend $EDIT $signoff --no-verify \
+		$use_perform git commit --amend $EDIT $signoff --no-verify \
 			--author "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" \
 			--message="$MESSAGE"
 	else
 		# correct author if AUTHOR is set
 		test -n "$AUTHOR" &&
-			$use_output git commit --amend $EDIT --no-verify -C HEAD \
+			$use_perform git commit --amend $EDIT --no-verify -C HEAD \
 				--author "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>"
 		# XXX: a git-cherry-pick --author could be nicer here
 		# correct commit message if MESSAGE is set
 		test -n "$MESSAGE" &&
-			$use_output git commit --amend $EDIT $signoff --no-verify \
+			$use_perform git commit --amend $EDIT $signoff --no-verify \
 				-C HEAD --message="$MESSAGE"
 	fi
 
@@ -1128,12 +1128,12 @@ insn_squash () {
 	case "$(peek_next_command)" in
 	squash)
 		edit_commit=
-		use_output=output
+		use_perform=perform
 		cp "$MSG" "$squash_msg"
 		;;
 	*)
 		edit_commit=-e
-		use_output=
+		use_perform=
 		rm -f "$squash_msg" || exit
 		;;
 	esac
@@ -1157,9 +1157,9 @@ insn_squash () {
 	failed=
 	if test -n "$from"
 	then
-		output git reset --soft "$sha1"
+		perform git reset --soft "$sha1"
 	else
-		output git reset --soft HEAD^
+		perform git reset --soft HEAD^
 
 		pick_one cherry-pick -n "$sha1" || failed=t
 	fi
@@ -1169,7 +1169,7 @@ insn_squash () {
 	if test -z "$failed"
 	then
 		# This is like --amend, but with a different message
-		with_author $use_output git commit --no-verify \
+		with_author $use_perform git commit --no-verify \
 			-F "$MSG" $edit_commit || failed=t
 	else
 		cp "$MSG" "$GIT_DIR/MERGE_MSG"
@@ -1320,13 +1320,13 @@ insn_merge () {
 	fi
 
 	mark_action_done
-	if ! with_author output git merge $strategy -m junk $new_parents
+	if ! with_author perform git merge $strategy -m junk $new_parents
 	then
 		git rerere
 		cat "$MSG" >"$GIT_DIR/MERGE_MSG"
 		die_to_continue 'Error merging'
 	fi
-	with_author output git commit --amend -F "$MSG" --no-verify
+	with_author perform git commit --amend -F "$MSG" --no-verify
 	return 0
 }
 
@@ -1352,7 +1352,7 @@ insn_reset () {
 	comment_for_reflog reset
 
 	mark_action_done
-	output git reset --hard "$(mark_to_commit "$1")"
+	perform git reset --hard "$(mark_to_commit "$1")"
 }
 
 
@@ -1375,7 +1375,7 @@ insn_ref () {
 	comment_for_reflog ref
 
 	mark_action_done
-	output git update-ref "$1" HEAD
+	perform git update-ref "$1" HEAD
 }
 
 
@@ -1547,10 +1547,10 @@ do_startup () {
 		then
 			ONTO="refs/heads/${ONTO##*/}"
 			echo "$ONTO" >"$SEQ_DIR/onto"
-			output git checkout "$(git rev-parse "$ONTO")" ||
+			perform git checkout "$(git rev-parse "$ONTO")" ||
 				die_abort "Could not checkout branch $ONTO"
 		else
-			output git checkout "$ONTO" ||
+			perform git checkout "$ONTO" ||
 				die_abort "Could not checkout commit $ONTO"
 			ONTO=
 		fi
@@ -1653,7 +1653,7 @@ Fix with git sequencer --edit or abort with $(print_caller --abort)."
 	comment_for_reflog skip
 	git rerere clear
 
-	output git reset --hard "$(cat "$SEQ_DIR/skiphead")" &&
+	perform git reset --hard "$(cat "$SEQ_DIR/skiphead")" &&
 	rm -f "$WHY_FILE" &&
 	echo '# SKIPPED the last instruction' >>"$DONE" &&
 		execute_rest
###

On Wed, Jul 02, 2008 at 06:45:06PM -0700, Junio C Hamano wrote:
> > +LAST_COUNT=
> > +mark_action_done () {
> > +	sed -e 1q <"$TODO" >>"$DONE"
> > +	sed -e 1d <"$TODO" >"$TODO.new"
> > +	mv -f "$TODO.new" "$TODO"
> > +	if test "$VERBOSE" -gt 0
> > +	then
> > +		count=$(grep -c '^[^#]' <"$DONE")
> > +		total=$(expr "$count" + "$(grep -c '^[^#]' <"$TODO")")
> 
> Here we are not counting lines that are comments as insns (I am not
> complaining; just making a mental note).

Add to your note, that empty lines are also skipped, because at least
one character (which is not #) must be there.
And add to your note, that leading whitespace is not ignored on that
checks, which can lead to wrong numbers, but: (quoting Dscho)
> "count" and "total" are only used for the progress output

(The builtin handles that better because it just does proper parsing
and not such hacks.)

Junio C Hamano wrote:
> > +		if test "$LAST_COUNT" != "$count"
> > +		then
> > +			LAST_COUNT="$count"
> > +			test "$VERBOSE" -lt 1 ||
> > +				printf 'Sequencing (%d/%d)\r' "$count" "$total"
> > +			test "$VERBOSE" -lt 2 || echo
> > +		fi
> > +	fi
> > +}
> > +
> > +# Generate message, patch and author script files
> > +make_patch () {
> > +	parent_sha1=$(git rev-parse --verify "$1"^) ||
> > +		die "Cannot get patch for $1^"
> > +	git diff-tree -p "$parent_sha1..$1" >"$PATCH"
> 
> Could there be a case where we need/want to deal with a root commit
> without parents?

Yes, and this is not handled correctly.

I've taken Jakub's idea:
--- a/git-sequencer.sh
+++ b/git-sequencer.sh
@@ -139,9 +139,9 @@ mark_action_done () {
 
 # Generate message, patch and author script files
 make_patch () {
-	parent_sha1=$(git rev-parse --verify "$1"^) ||
-		die "Cannot get patch for $1^"
-	git diff-tree -p "$parent_sha1..$1" >"$PATCH"
+	parent_sha1=$(git rev-parse --verify "$1^" 2>/dev/null ||
+		echo '--root')
+	git diff-tree -p "$parent_sha1" "$1" >"$PATCH"
 	test -f "$MSG" ||
 		commit_message "$1" >"$MSG"
 	test -f "$AUTHOR_SCRIPT" ||
###

Btw, another root commit problem is btw that it's not possible
to cherry-pick root commits.

Junio C Hamano wrote:
> > +	test -f "$MSG" ||
> > +		commit_message "$1" >"$MSG"
> > +	test -f "$AUTHOR_SCRIPT" ||
> > +		get_author_ident_from_commit "$1" >"$AUTHOR_SCRIPT"
> > +}
> > +
> > +# Generate a patch and die with "conflict" status code
> > +die_with_patch () {
> > +	make_patch "$1"
> > +	git rerere
> > +	die_to_continue "$2"
> > +}
> > +
> > +restore () {
> > +	git rerere clear
> > +
> > +	HEADNAME=$(cat "$SEQ_DIR/head-name")
> > +	HEAD=$(cat "$SEQ_DIR/head")
> 
> Perhaps
> 
> 	read HEADNAME <"$SEQ_DIR/head-name"
> 
> provided if these values are $IFS safe?

They are IFS-safe. I don't really have an opinion if
	read FOO <foo
is better than
	FOO=$(cat foo)
or vice versa, so I have no problem to change this.

--- a/git-sequencer.sh
+++ b/git-sequencer.sh
@@ -158,8 +158,8 @@ die_with_patch () {
 restore () {
 	git rerere clear
 
-	HEADNAME=$(cat "$SEQ_DIR/head-name")
-	HEAD=$(cat "$SEQ_DIR/head")
+	read HEADNAME <"$SEQ_DIR/head-name"
+	read HEAD <"$SEQ_DIR/head"
 	case $HEADNAME in
 	refs/*)
 		git symbolic-ref HEAD "$HEADNAME"
@@ -1496,9 +1496,10 @@ prepare_editable_todo () {
 }
 
 get_saved_options () {
-	VERBOSE=$(cat "$SEQ_DIR/verbose")
-	ONTO=$(cat "$SEQ_DIR/onto")
-	WHY=$(cat "$WHY_FILE" 2>/dev/null)
+	read VERBOSE <"$SEQ_DIR/verbose"
+	read ONTO <"$SEQ_DIR/onto"
+	test -f "$WHY_FILE" &&
+		read WHY <"$WHY_FILE"
 	return 0
 }
 
###

Johannes Schindelin wrote:
> > > +# Usage: pick_one (cherry-pick|revert) [-*|--edit] sha1
> > > +pick_one () {
> > > +	what="$1"
> > > +	# we just assume that this is either cherry-pick or revert
> > > +	shift
> > > +
> > > +	# check for fast-forward if no options are given
> > > +	if expr "x$1" : 'x[^-]' >/dev/null
> > > +	then
> > > +		test "$(git rev-parse --verify "$1^")" = \
> > > +			"$(git rev-parse --verify HEAD)" &&
> > > +			output git reset --hard "$1" &&
> > > +			return
> > > +	fi
> > > +	test "$1" != '--edit' -a "$what" = 'revert' &&
> > > +		what='revert --no-edit'
> > 
> > This looks somewhat wrong.
> > 
> > When the history looks like ---A---B and we are at A, cherry-picking B can
> > be optimized to just advancing to B, but that optimization has a slight
> > difference (or two) in the semantics.
> > 
> >  (1) The committer information would not record the user and time of the
> >      sequencer operation, which actually may be a good thing.
> 
> This is debatable.  But I think you are correct, for all the same reasons 
> why a merge can result in a fast-forward.

Dscho, you mean me by referring to 'you' here, right?
Otherwise I'm a bit confused: "For the same reasons why a merge can result
in a fast-forward we should not do fast forward here" ;-)

I think the ff is more useful than real picking and I think the rebase-i
test suite even has a test case for this.
(Checked: "* FAIL 17: merge redoes merges" if it is removed, so it's
implicitly checked for redone merges.)

> >  (2) When $what is revert, this codepath shouldn't be exercised, should 
> >  it?
> 
> Yes.

I haven't done a check intentionally, but there was a stupid thinko.
So you're right.

But: this will only be a bug if the commit that _comes next in the
original history_ is to be reverted.  This is usually user-nonsense
(I can't imagine a useful application for that), but nonetheless a
user can try it for fun and such a case is not worth a sanity check.
So it's perhaps good to add a test here and just do the revert (and no
ff) as the user requests.

> >  (3) If B is a merge, even if $what is pick, this codepath shouldn't be
> >      exercised, should it?
> 
> I think it should, again for the same reason why a merge can result in a 
> fast-forward.

Right.

Junio C Hamano wrote:
> As to the syntax I tend to prefer
> 
> 	case "$1" in
>         -*)	... do option thing ... ;;
>         *)	... do other thing... ;;
>         esac

Christian has mentioned this, but I didn't listen to him ;)
Because I think, if you put the cases, the do_thing and the ;;
on separate lines,
1. it is just consistent compared to the cases where you
   do several things ... you don't do them on one line and
   you put the ;; on an extra line
2. the diffs will look better on extensions

> So how about...
> 
> 	case "$what,$1" in
>         revert,--edit)
>         	what='revert --no-edit' ;;
>         revert,* | cherry-pick,-* )
>         	;;
>         *)
> 		if ! git rev-parse --verify "$1^2" &&
> 	                test "$(git rev-parse --verify "$1^") = \
>                 	"$(git rev-parse --verify HEAD)"
> 		then
>                 	output git reset --hard "$1"
> 			return
> 		fi
> 		;;
> 	esac

I've done this:
--- a/git-sequencer.sh
+++ b/git-sequencer.sh
@@ -200,19 +200,25 @@ with_author () {
 # Usage: pick_one (cherry-pick|revert) [-*|--edit] sha1
 pick_one () {
 	what="$1"
-	# we just assume that this is either cherry-pick or revert
 	shift
 
-	# check for fast-forward if no options are given
-	if expr "x$1" : 'x[^-]' >/dev/null
-	then
-		test "$(git rev-parse --verify "$1^")" = \
-			"$(git rev-parse --verify HEAD)" &&
-			perform git reset --hard "$1" &&
+	case "$what,$1" in
+	revert,*)
+		test "$1" != '--edit' &&
+			what='revert --no-edit'
+		;;
+	cherry-pick,-*)
+		;;
+	cherry-pick,*)
+		# fast forward
+		if test "$(git rev-parse --verify "$1^")" = \
+			"$(git rev-parse --verify HEAD)"
+		then
+			perform git reset --hard "$1"
 			return
-	fi
-	test "$1" != '--edit' -a "$what" = 'revert' &&
-		what='revert --no-edit'
+		fi
+		;;
+	esac
 	test -n "$SIGNOFF" &&
 		what="$what -s"
 	$use_perform git $what "$@"
###

Johannes Schindelin wrote:
> > > +make_squash_message () {
> > > +	if test -f "$squash_msg"
> > > +	then
> > > +		count=$(($(sed -n -e 's/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p' \
> > > +			<"$squash_msg" | sed -n -e '$p')+1))
> > > +		echo "# This is a combination of $count commits."
> > > +		sed -e '1d' -e '2,/^./{
> > > +			/^$/d
> > > +		}' <"$squash_msg"
> > > +	else
> > > +		count=2
> > > +		echo '# This is a combination of 2 commits.'
> > > +		echo '# The first commit message is:'
> > > +		echo
> > > +		commit_message HEAD
> > > +	fi
> > > +	echo
> > > +	echo "# This is the $(nth_string "$count") commit message:"
> > > +	echo
> > > +	commit_message "$1"
> > > +}
> > > +
> > > +make_squash_message_multiple () {
> > > +	echo '# This is a dummy to get the 0.' >"$squash_msg"
> > > +	for cur_sha1 in $(git rev-list --reverse "$sha1..HEAD")
> > > +	do
> > > +		make_squash_message "$cur_sha1" >"$MSG"
> > > +		cp "$MSG" "$squash_msg"
> > > +	done
> > > +}
> > 
> > Hmm, I know this is how rebase-i is written, but we should be able to do
> > better than writing and flipping temporary times N times, shouldn't we?
> 
> Right, again my fault.

No, not your fault.
I think Junio is referring to make_squash_message_multiple which is for
	squash --from <mark>
and just calls your make_squash_message several times.

When I did this, I knew that this is not most efficient, but I had in
mind: this is just a prototype. The builtin will solve this in a
different way.

Nonetheless, purely tested:
--- a/git-sequencer.sh
+++ b/git-sequencer.sh
@@ -264,11 +264,26 @@ make_squash_message () {
 }
 
 make_squash_message_multiple () {
-	echo '# This is a dummy to get the 0.' >"$squash_msg"
-	for cur_sha1 in $(git rev-list --reverse "$sha1..HEAD")
+	revlist=$(git rev-list --reverse "$sha1..HEAD")
+	count=$(echo "$revlist" | wc -l)
+	squash_i=0
+	echo "# This is a combination of $count commits."
+	for cur_sha1 in $revlist
 	do
-		make_squash_message "$cur_sha1" >"$MSG"
-		cp "$MSG" "$squash_msg"
+		squash_i=$(($squash_i+1))
+		if test -f "$squash_msg"
+		then
+			count=$(($count + $(sed -n -e \
+				's/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p' \
+				<"$squash_msg" | sed -n -e '$p')+1))
+			sed -e '1d' -e '2,/^./{
+				/^$/d
+			}' <"$squash_msg"
+		fi
+		echo
+		echo "# This is the $(nth_string "$squash_i") commit message:"
+		echo
+		commit_message "$cur_sha1"
 	done
 }
 
@@ -1128,7 +1143,7 @@ insn_squash () {
 	else
 		if test -n "$from"
 		then
-			make_squash_message_multiple "$sha1"
+			make_squash_message_multiple "$sha1" >"$MSG"
 		else
 			make_squash_message "$sha1" >"$MSG"
 		fi
###

Johannes Schindelin wrote:
> > > +peek_next_command () {
> > > +	sed -n -e '1s/ .*$//p' <"$TODO"
> > > +}
> > 
> > ... which could respond "the next command is '#' (comment)", so we are
> > actively counting a comment as a step here.  Does this contradict with the
> > mental note we made earlier, and if so, does the discrepancy hurt us
> > somewhere in this program?

Yes it does hurt ;-)

> Yes, this is wrong.  it must be
> 
> 	sed -n -e '/^#/d' -e '1s .*$//p' < "$TODO"

Thanks ;)

--- a/git-sequencer.sh
+++ b/git-sequencer.sh
@@ -273,7 +273,7 @@ make_squash_message_multiple () {
 }
 
 peek_next_command () {
-	sed -n -e '1s/ .*$//p' <"$TODO"
+	sed -n -e '/^#/d' -e '1s/ .*$//p' <"$TODO"
 }
 
 # If $1 is a mark, make a ref from it; otherwise keep it.
###

Junio C Hamano wrote:
> > +# If $1 is a mark, make a ref from it; otherwise keep it
> > +mark_to_ref () {
> > +	arg="$1"
> > +	ref=$(expr "x$arg" : 'x:0*\([0-9][0-9]*\)$')
> 
> You might want to leave comments to describe constraints that led to this
> slightly awkward regexp:
> 
>  * :0 is allowed
>  * :01 is the same as :1

Right.

--- a/git-sequencer.sh
+++ b/git-sequencer.sh
@@ -270,7 +270,10 @@ peek_next_command () {
 	sed -n -e '1s/ .*$//p' <"$TODO"
 }
 
-# If $1 is a mark, make a ref from it; otherwise keep it
+# If $1 is a mark, make a ref from it; otherwise keep it.
+# Note on marks:
+#  * :0 is allowed
+#  * :01 is the same as :1
 mark_to_ref () {
 	arg="$1"
 	ref=$(expr "x$arg" : 'x:0*\([0-9][0-9]*\)$')
###

Junio C Hamano wrote:
> > +strategy_check () {
> > +	case "$1" in
> > +	resolve|recursive|octopus|ours|subtree|theirs)
> > +		return
> > +		;;
> > +	esac
> > +	todo_warn "Strategy '$1' not known."
> > +}
> 
> Hmm.  Do we need to maintain list of available strategies here and then in
> git-merge separately?

No, this is potentially-error-prone at large.
But I want a check for this, so I'd vote for a
	--list-strategies
feature in the builtin-merge.
(Before writing the quoted code, I was looking for such a feature, but
haven't found. But since builtin-merge is in work I didn't want send
patches on git-merge.sh)

Johannes Schindelin wrote:
> I'd not check in sequencer for the strategy.  Especially given that we 
> want to support user-written strategies in the future.

I don't know how this is planned to look like, but perhaps --list-strategies
may make sense here, too.
Also, the shell completion scripts could use that.

Junio C Hamano wrote:
> > +### Author script functions
> > +
> > +clean_author_script () {
> > +	cat "$ORIG_AUTHOR_SCRIPT" >"$AUTHOR_SCRIPT"
> > +}
> > +
> > +# Take "Name <e-mail>" in stdin and outputs author script
> > +make_author_script_from_string () {
> > +	sed -e 's/^\(.*\) <\(.*\)>.*$/GIT_AUTHOR_NAME="\1"\
> > +GIT_AUTHOR_EMAIL="\2"\
> > +GIT_AUTHOR_DATE=/'
> > +}
> 
> If you are going to "."-source or eval the output from this, you would
> need to quote the values a lot more robustly, wouldn't you?  Is this safe
> against shell metacharacters in names, mails and/or space between unixtime
> and the timezone information?

Time is set empty here.
It is not save according to shell metacharacters in name or e-mail and I
knew that when writing.
Of course, a
	First "nick" Sure
author will get problems here. ;-)
And as long as nobody is named $(rm -rf "$HOME")  [1], I thought this is
sufficient for the prototype.

But...
--- a/git-sequencer.sh
+++ b/git-sequencer.sh
@@ -520,7 +520,7 @@ clean_author_script () {
 
 # Take "Name <e-mail>" in stdin and outputs author script
 make_author_script_from_string () {
-	sed -e 's/^\(.*\) <\(.*\)>.*$/GIT_AUTHOR_NAME="\1"\
+	sed -e 's/[$"\\]/\\&/g' -e 's/^\(.*\) <\(.*\)>.*$/GIT_AUTHOR_NAME="\1"\
 GIT_AUTHOR_EMAIL="\2"\
 GIT_AUTHOR_DATE=/'
 }
@@ -779,7 +779,7 @@ insn_patch () {
 	
 	if test -z "$AUTHOR"
 	then
-		sed -n -e '
+		sed -e 's/[$"\\]/\\&/g' -n -e '
 			s/^Author: \(.*\)$/GIT_AUTHOR_NAME="\1"/p;
 			s/^Email: \(.*\)$/GIT_AUTHOR_EMAIL="\1"/p;
 			s/^Date: \(.*\)$/GIT_AUTHOR_DATE="\1"/p
###

Is escaping $, " and \ enough?

> > +	if test -z "$AUTHOR"
> > +	then
> > +		sed -n -e '
> > +			s/^Author: \(.*\)$/GIT_AUTHOR_NAME="\1"/p;
> > +			s/^Email: \(.*\)$/GIT_AUTHOR_EMAIL="\1"/p;
> > +			s/^Date: \(.*\)$/GIT_AUTHOR_DATE="\1"/p
> > +		' <"$infofile" >>"$AUTHOR_SCRIPT"
> 
> The same comment on quoting applies here, I think.

Right.

> > +	if test -n "$failed"
> > +	then
> > +		# XXX: This is just a stupid hack:
> > +		with_author git apply $apply_opts --reject --index "$PATCH"
> 
> Please don't do this without being asked, if you are planning to use this
> in "am" when 3-way fallback was not asked.  It _may_ make sense to give an
> option to the users to ask for .rej if they prefer to work that way better
> than working with 3-way merge fallback, but doing this without being asked
> is not acceptable.

The --reject was just a mind marker for that what I actually think is
useful and less annoying than the current behavior:

> > +		die_to_continue 'Patch failed. See the .rej files.'
> > +		# XXX: We actually needed a git-apply flag that creates
> > +		# conflict markers and sets the DIFF_STATUS_UNMERGED flag.
> 
> That is what -3way is all about, and this codepath is when the user did
> not ask for it, isn't it?

Now imagine you apply a patch that cannot be applied 100% cleanly and
you don't have the 3-way base in the repo. You know what happens?
Yes, the patch is completly rejected, because apply is atomic.
And I think a git-apply option that results in a non-atomic behavior,
that creates conflict markers (and no .rej files), would be a great
usability feature for the "patch" insn in sequencer.
I'd even suggest to make that the default, but that's debatable.

Btw, I removed the mind marker:
--- a/git-sequencer.sh
+++ b/git-sequencer.sh
@@ -836,9 +836,7 @@ insn_patch () {
 
 	if test -n "$failed"
 	then
-		# XXX: This is just a stupid hack:
-		with_author git apply $apply_opts --reject --index "$PATCH"
-		die_to_continue 'Patch failed. See the .rej files.'
+		die_to_continue 'Patch failed.'
 		# XXX: We actually needed a git-apply flag that creates
 		# conflict markers and sets the DIFF_STATUS_UNMERGED flag.
 	fi
###

> > +# Check the "pick" instruction
> > +check_pick () {
> > +	revert=
> > +	mainline=
> > +	while test $# -gt 1
> > +	do
> > ...
> > +	done
> > +
> > +	if test -n "$mainline"
> > +	then
> > +		test -z "$revert" ||
> > +			todo_error "Cannot use $revert together with --mainline."
> 
> Why not?  If you have this...
> 
> 	---A---C---D
>               /
>           ---B
> 
> and you are at D, you may want to undo the merge you made at C and go back
> to either A or B, which essentially is same as cherry-picking diff between
> C and D on top of either A or B.  Both are valid operations aren't they?

Jakub already asked. I told him, that git-revert doesn't know --mainline,
but it seems that this was wrong.  So:

--- a/git-sequencer.sh
+++ b/git-sequencer.sh
@@ -879,13 +879,11 @@ $OPTIONS_GENERAL
 
 # Check the "pick" instruction
 check_pick () {
-	revert=
 	mainline=
 	while test $# -gt 1
 	do
 		case "$1" in
 		-R)
-			revert="$1"
 			;;
 		--mainline)
 			shift
@@ -913,9 +911,6 @@ check_pick () {
 
 	if test -n "$mainline"
 	then
-		test -z "$revert" ||
-			todo_error "Cannot use $revert together with --mainline."
-
 		parents=$(count_parents "$1")
 		test "$parents" -lt "$mainline" &&
 			todo_error "Commit has only $parents (less than $mainline) parents."
###

Regards and big thanks for the fast reply,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
