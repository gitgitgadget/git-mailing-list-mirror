From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/4] Add git-sequencer shell prototype
Date: Wed, 02 Jul 2008 18:45:06 -0700
Message-ID: <7vbq1f68rh.fsf@gitster.siamese.dyndns.org>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net>
 <1214879914-17866-2-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jul 03 09:00:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEIno-0002Wt-4p
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 09:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbYGCG7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbYGCG53
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:57:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57305 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbYGCBp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 21:45:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2EF8CAA81;
	Wed,  2 Jul 2008 21:45:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4D85EAA80; Wed,  2 Jul 2008 21:45:17 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B60686C6-48A1-11DD-8AF1-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87225>

Stephan Beyer <s-beyer@gmx.net> writes:

> git sequencer is planned as a backend for user scripts
> that execute a sequence of git instructions and perhaps
> need manual intervention, for example git-rebase or git-am.

...
> +output () {
> +	case "$VERBOSE" in
> +	0)
> +		"$@" >/dev/null
> +		;;
> +	1)
> +		output=$("$@" 2>&1 )
> +		status=$?
> +		test $status -ne 0 && printf '%s\n' "$output"
> +		return $status
> +		;;
> +	2)
> +		"$@"
> +		;;
> +	esac
> +}

Perhaps misnamed?  This feels more like "do" or "perform" or "run".

> +require_clean_work_tree () {
> +	# test if working tree is dirty
> +	git rev-parse --verify HEAD >/dev/null &&
> +	git update-index --ignore-submodules --refresh &&
> +	git diff-files --quiet --ignore-submodules &&
> +	git diff-index --cached --quiet HEAD --ignore-submodules -- ||
> +	die 'Working tree is dirty'
> +}

When is it necessary to ignore submodules and why?  Are there cases where
submodules should not be ignored?

> +LAST_COUNT=
> +mark_action_done () {
> +	sed -e 1q <"$TODO" >>"$DONE"
> +	sed -e 1d <"$TODO" >"$TODO.new"
> +	mv -f "$TODO.new" "$TODO"
> +	if test "$VERBOSE" -gt 0
> +	then
> +		count=$(grep -c '^[^#]' <"$DONE")
> +		total=$(expr "$count" + "$(grep -c '^[^#]' <"$TODO")")

Here we are not counting lines that are comments as insns (I am not
complaining; just making a mental note).

> +		if test "$LAST_COUNT" != "$count"
> +		then
> +			LAST_COUNT="$count"
> +			test "$VERBOSE" -lt 1 ||
> +				printf 'Sequencing (%d/%d)\r' "$count" "$total"
> +			test "$VERBOSE" -lt 2 || echo
> +		fi
> +	fi
> +}
> +
> +# Generate message, patch and author script files
> +make_patch () {
> +	parent_sha1=$(git rev-parse --verify "$1"^) ||
> +		die "Cannot get patch for $1^"
> +	git diff-tree -p "$parent_sha1..$1" >"$PATCH"

Could there be a case where we need/want to deal with a root commit
without parents?

> +	test -f "$MSG" ||
> +		commit_message "$1" >"$MSG"
> +	test -f "$AUTHOR_SCRIPT" ||
> +		get_author_ident_from_commit "$1" >"$AUTHOR_SCRIPT"
> +}
> +
> +# Generate a patch and die with "conflict" status code
> +die_with_patch () {
> +	make_patch "$1"
> +	git rerere
> +	die_to_continue "$2"
> +}
> +
> +restore () {
> +	git rerere clear
> +
> +	HEADNAME=$(cat "$SEQ_DIR/head-name")
> +	HEAD=$(cat "$SEQ_DIR/head")

Perhaps

	read HEADNAME <"$SEQ_DIR/head-name"

provided if these values are $IFS safe?

> +	case $HEADNAME in
> +	refs/*)
> +		git symbolic-ref HEAD "$HEADNAME"
> +		;;
> +	esac &&
> +	output git reset --hard "$HEAD"
> +}
> +
> +has_action () {
> +	grep '^[^#]' "$1" >/dev/null
> +}
> +
> +# Check if text file $1 contains a commit message
> +has_message () {
> +	test -n "$(sed -n -e '/^Signed-off-by:/d;/^[^#]/p' <"$1")"
> +}

Makes one wonder if we would want to special case other kinds like
"Acked-by:" as well...

> +# Usage: pick_one (cherry-pick|revert) [-*|--edit] sha1
> +pick_one () {
> +	what="$1"
> +	# we just assume that this is either cherry-pick or revert
> +	shift
> +
> +	# check for fast-forward if no options are given
> +	if expr "x$1" : 'x[^-]' >/dev/null
> +	then
> +		test "$(git rev-parse --verify "$1^")" = \
> +			"$(git rev-parse --verify HEAD)" &&
> +			output git reset --hard "$1" &&
> +			return
> +	fi
> +	test "$1" != '--edit' -a "$what" = 'revert' &&
> +		what='revert --no-edit'

This looks somewhat wrong.

When the history looks like ---A---B and we are at A, cherry-picking B can
be optimized to just advancing to B, but that optimization has a slight
difference (or two) in the semantics.

 (1) The committer information would not record the user and time of the
     sequencer operation, which actually may be a good thing.

 (2) When $what is revert, this codepath shouldn't be exercised, should it?

 (3) If B is a merge, even if $what is pick, this codepath shouldn't be
     exercised, should it?

As to the syntax I tend to prefer

	case "$1" in
        -*)	... do option thing ... ;;
        *)	... do other thing... ;;
        esac

So how about...

	case "$what,$1" in
        revert,--edit)
        	what='revert --no-edit' ;;
        revert,* | cherry-pick,-* )
        	;;
        *)
		if ! git rev-parse --verify "$1^2" &&
	                test "$(git rev-parse --verify "$1^") = \
                	"$(git rev-parse --verify HEAD)"
		then
                	output git reset --hard "$1"
			return
		fi
		;;
	esac

> +make_squash_message () {
> +	if test -f "$squash_msg"
> +	then
> +		count=$(($(sed -n -e 's/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p' \
> +			<"$squash_msg" | sed -n -e '$p')+1))
> +		echo "# This is a combination of $count commits."
> +		sed -e '1d' -e '2,/^./{
> +			/^$/d
> +		}' <"$squash_msg"
> +	else
> +		count=2
> +		echo '# This is a combination of 2 commits.'
> +		echo '# The first commit message is:'
> +		echo
> +		commit_message HEAD
> +	fi
> +	echo
> +	echo "# This is the $(nth_string "$count") commit message:"
> +	echo
> +	commit_message "$1"
> +}
> +
> +make_squash_message_multiple () {
> +	echo '# This is a dummy to get the 0.' >"$squash_msg"
> +	for cur_sha1 in $(git rev-list --reverse "$sha1..HEAD")
> +	do
> +		make_squash_message "$cur_sha1" >"$MSG"
> +		cp "$MSG" "$squash_msg"
> +	done
> +}

Hmm, I know this is how rebase-i is written, but we should be able to do
better than writing and flipping temporary times N times, shouldn't we?

> +peek_next_command () {
> +	sed -n -e '1s/ .*$//p' <"$TODO"
> +}

... which could respond "the next command is '#' (comment)", so we are
actively counting a comment as a step here.  Does this contradict with the
mental note we made earlier, and if so, does the discrepancy hurt us
somewhere in this program?

> +# If $1 is a mark, make a ref from it; otherwise keep it
> +mark_to_ref () {
> +	arg="$1"
> +	ref=$(expr "x$arg" : 'x:0*\([0-9][0-9]*\)$')

You might want to leave comments to describe constraints that led to this
slightly awkward regexp:

 * :0 is allowed
 * :01 is the same as :1

> +strategy_check () {
> +	case "$1" in
> +	resolve|recursive|octopus|ours|subtree|theirs)
> +		return
> +		;;
> +	esac
> +	todo_warn "Strategy '$1' not known."
> +}

Hmm.  Do we need to maintain list of available strategies here and then in
git-merge separately?

> +### Author script functions
> +
> +clean_author_script () {
> +	cat "$ORIG_AUTHOR_SCRIPT" >"$AUTHOR_SCRIPT"
> +}
> +
> +# Take "Name <e-mail>" in stdin and outputs author script
> +make_author_script_from_string () {
> +	sed -e 's/^\(.*\) <\(.*\)>.*$/GIT_AUTHOR_NAME="\1"\
> +GIT_AUTHOR_EMAIL="\2"\
> +GIT_AUTHOR_DATE=/'
> +}

If you are going to "."-source or eval the output from this, you would
need to quote the values a lot more robustly, wouldn't you?  Is this safe
against shell metacharacters in names, mails and/or space between unixtime
and the timezone information?

> +	if test -z "$AUTHOR"
> +	then
> +		sed -n -e '
> +			s/^Author: \(.*\)$/GIT_AUTHOR_NAME="\1"/p;
> +			s/^Email: \(.*\)$/GIT_AUTHOR_EMAIL="\1"/p;
> +			s/^Date: \(.*\)$/GIT_AUTHOR_DATE="\1"/p
> +		' <"$infofile" >>"$AUTHOR_SCRIPT"

The same comment on quoting applies here, I think.

> +		# If sed's result is empty, we keep the original
> +		# author script by appending.
> +	fi
> ...
> +	failed=
> +	with_author git apply $apply_opts --index "$PATCH" || failed=t
> +
> +	if test -n "$failed" -a -n "$threeway" && (with_author fallback_3way)
> +	then
> +		# Applying the patch to an earlier tree and merging the
> +		# result may have produced the same tree as ours.
> +		git diff-index --quiet --cached HEAD -- && {
> +			echo 'No changes -- Patch already applied.'
> +			return 0
> +			# XXX: do we want that?
> +		}
> +		# clear apply_status -- we have successfully merged.
> +		failed=
> +	fi
> +
> +	if test -n "$failed"
> +	then
> +		# XXX: This is just a stupid hack:
> +		with_author git apply $apply_opts --reject --index "$PATCH"

Please don't do this without being asked, if you are planning to use this
in "am" when 3-way fallback was not asked.  It _may_ make sense to give an
option to the users to ask for .rej if they prefer to work that way better
than working with 3-way merge fallback, but doing this without being asked
is not acceptable.

> +		die_to_continue 'Patch failed. See the .rej files.'
> +		# XXX: We actually needed a git-apply flag that creates
> +		# conflict markers and sets the DIFF_STATUS_UNMERGED flag.

That is what -3way is all about, and this codepath is when the user did
not ask for it, isn't it?

> +# Check the "pick" instruction
> +check_pick () {
> +	revert=
> +	mainline=
> +	while test $# -gt 1
> +	do
> ...
> +	done
> +
> +	if test -n "$mainline"
> +	then
> +		test -z "$revert" ||
> +			todo_error "Cannot use $revert together with --mainline."

Why not?  If you have this...

	---A---C---D
              /
          ---B

and you are at D, you may want to undo the merge you made at C and go back
to either A or B, which essentially is same as cherry-picking diff between
C and D on top of either A or B.  Both are valid operations aren't they?

The remainder of the review will have to be in a separate message..
