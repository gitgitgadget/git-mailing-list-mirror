From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: commit when continuing after "edit"
Date: Mon, 24 Sep 2007 22:37:08 -0700
Message-ID: <7vlkav71bv.fsf@gitster.siamese.dyndns.org>
References: <20070923224502.GB7249@potapov>
	<Pine.LNX.4.64.0709240121080.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 25 07:37:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia36s-00042g-Rb
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 07:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586AbXIYFhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 01:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbXIYFhS
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 01:37:18 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:53905 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbXIYFhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 01:37:16 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 5CBF413B1A0;
	Tue, 25 Sep 2007 01:37:32 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709240121080.28395@racer.site> (Johannes
	Schindelin's message of "Mon, 24 Sep 2007 01:29:30 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59092>

> When doing an "edit" on a commit, editing and git-adding some files,
> "git rebase -i" complained about a missing "author-script".  The idea was
> that the user would call "git commit --amend" herself.
> 
> But we can be nice and do that for the user.
> 
> To do this, rebase -i stores the author script and message whenever
> writing out a patch, and it remembers to do an "amend" by creating the
> file "amend" in "$DOTEST".
> 
> Noticed by Dmitry Potapov.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 2fa53fd..5982967 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -1,484 +1,488 @@
>  #!/bin/sh
> ...
>  output () {
>  	case "$VERBOSE" in
>  	'')
>  		"$@" > "$DOTEST"/output 2>&1
>  		status=$?
>  		test $status != 0 &&
>  			cat "$DOTEST"/output
>  		return $status
>  	;;

One more level of indent, please.

>  	*)
>  		"$@"
>  	esac

I find it is usually less error prone to help the longer term
maintainability if you do not omit double-semicolon before esac.

>  }
>  
>  require_clean_work_tree () {
>  	# test if working tree is dirty
>  	git rev-parse --verify HEAD > /dev/null &&
>  	git update-index --refresh &&
>  	git diff-files --quiet &&
>  	git diff-index --cached --quiet HEAD ||
>  	die "Working tree is dirty"
>  }
> ... 
>  mark_action_done () {
>  	sed -e 1q < "$TODO" >> "$DONE"
>  	sed -e 1d < "$TODO" >> "$TODO".new
>  	mv -f "$TODO".new "$TODO"
>  	count=$(($(wc -l < "$DONE")))
>  	total=$(($count+$(wc -l < "$TODO")))
>  	printf "Rebasing (%d/%d)\r" $count $total
>  	test -z "$VERBOSE" || echo
>  }
>  
>  make_patch () {
>  	parent_sha1=$(git rev-parse --verify "$1"^ 2> /dev/null)
>  	git diff "$parent_sha1".."$1" > "$DOTEST"/patch

What's the point of using --verify when you do not error out
upon error?  I find this quite inconsistent; your
require_clean_work_tree above is so nicely written.

Is there anything (other than user's common sense, which we
cannot always count on these days) that prevents the caller to
feed a root commit to this function, I wonder?

> -}
> -
> -die_with_patch () {
>  	test -f "$DOTEST"/message ||
>  		git cat-file commit $sha1 | sed "1,/^$/d" > "$DOTEST"/message
>  	test -f "$DOTEST"/author-script ||
>  		get_author_ident_from_commit $sha1 > "$DOTEST"/author-script
> +}

Are these "$sha1" still valid, or do you need "$1" given to the
make_patch function?

>  pick_one () {
>  	no_ff=
>  	case "$1" in -n) sha1=$2; no_ff=t ;; *) sha1=$1 ;; esac
>  	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
>  	test -d "$REWRITTEN" &&
>  		pick_one_preserving_merges "$@" && return
>  	parent_sha1=$(git rev-parse --verify $sha1^ 2>/dev/null)
>  	current_sha1=$(git rev-parse --verify HEAD)

Again --verify without verifying.

>  	if test $no_ff$current_sha1 = $parent_sha1; then
>  		output git reset --hard $sha1
>  		test "a$1" = a-n && output git reset --soft $current_sha1
>  		sha1=$(git rev-parse --short $sha1)
>  		output warn Fast forward to $sha1
>  	else
>  		output git cherry-pick $STRATEGY "$@"
>  	fi
>  }
>  
>  pick_one_preserving_merges () {
>  	case "$1" in -n) sha1=$2 ;; *) sha1=$1 ;; esac
>  	sha1=$(git rev-parse $sha1)
>  
>  	if test -f "$DOTEST"/current-commit
>  	then
>  		current_commit=$(cat "$DOTEST"/current-commit) &&
>  		git rev-parse HEAD > "$REWRITTEN"/$current_commit &&
>  		rm "$DOTEST"/current-commit ||
>  		die "Cannot write current commit's replacement sha1"
>  	fi
>  
>  	# rewrite parents; if none were rewritten, we can fast-forward.
>  	fast_forward=t
>  	preserve=t
>  	new_parents=
>  	for p in $(git rev-list --parents -1 $sha1 | cut -d\  -f2-)

Just a style nit.  A string literal for a SP is easier to read
if written as a SP inside sq pair (i.e. ' ') not backslash
followed by a SP (i.e. \ ).

>  	do
>  		if test -f "$REWRITTEN"/$p
>  		then
>  			preserve=f
>  			new_p=$(cat "$REWRITTEN"/$p)
>  			test $p != $new_p && fast_forward=f
>  			case "$new_parents" in
>  			*$new_p*)
>  				;; # do nothing; that parent is already there
>  			*)
>  				new_parents="$new_parents $new_p"
>  			esac
>  		fi
>  	done
>  	case $fast_forward in
>  	t)
>  		output warn "Fast forward to $sha1"
>  		test $preserve=f && echo $sha1 > "$REWRITTEN"/$sha1

Testing if concatenation of $preserve and "=f" is not an empty
string, which would almost always yield true?

>  		;;
>  	f)
>  		test "a$1" = a-n && die "Refusing to squash a merge: $sha1"
>  
>  		first_parent=$(expr "$new_parents" : " \([^ ]*\)")

Style; typically regexp form of expr and sed expression are
easier to read with quoted with sq, not dq.

>  		# detach HEAD to current parent
>  		output git checkout $first_parent 2> /dev/null ||
>  			die "Cannot move HEAD to $first_parent"
>  
>  		echo $sha1 > "$DOTEST"/current-commit
>  		case "$new_parents" in
>  		\ *\ *)

Likewise here: ' '*' '*

>  			# redo merge
>  			author_script=$(get_author_ident_from_commit $sha1)
>  			eval "$author_script"
>  			msg="$(git cat-file commit $sha1 | \
>  				sed -e '1,/^$/d' -e "s/[\"\\]/\\\\&/g")"

What's this backquoting about?  Your "output" does not eval (and
it shouldn't), so that's not it.  Working around incompatible
echo that does auto magic used to write MERGE_MSG?  Can we lose
the backquoting by using printf "%s\n" there?

> ...
>  nth_string () {
>  	case "$1" in
>  	*1[0-9]|*[04-9]) echo "$1"th;;
>  	*1) echo "$1"st;;
>  	*2) echo "$1"nd;;
>  	*3) echo "$1"rd;;
>  	esac
>  }

Cute.

> ...
>  do_next () {
>  	test -f "$DOTEST"/message && rm "$DOTEST"/message
>  	test -f "$DOTEST"/author-script && rm "$DOTEST"/author-script
> +	test -f "$DOTEST"/amend && rm "$DOTEST"/amend

As you do not check the error from "rm", how are these different
from rm -f "$DOTEST/frotz"?

>  	read command sha1 rest < "$TODO"
>  	case "$command" in
>  	\#|'')
>  		mark_action_done
>  		;;

Perhaps '#'*?

> ...
>  	edit)
>  		comment_for_reflog edit
>  
>  		mark_action_done
>  		pick_one $sha1 ||
>  			die_with_patch $sha1 "Could not apply $sha1... $rest"
>  		make_patch $sha1
> +		: > "$DOTEST"/amend

Good catch, but ':' is redundant ;-)

>  		warn
>  		warn "You can amend the commit now, with"
>  		warn
>  		warn "	git commit --amend"
>  		warn
>  		exit 0
>  		;;
>  	squash)
>  		comment_for_reflog squash
>  
>  		test -z "$(grep -ve '^$' -e '^#' < $DONE)" &&
>  			die "Cannot 'squash' without a previous commit"

Why "test -z"?  Wouldn't this be equivalent?

	grep -v -q -e '^$' -e '^#' "$DONE" || die ...

>  
>  		mark_action_done
>  		make_squash_message $sha1 > "$MSG"
>  		case "$(peek_next_command)" in
>  		squash)
>  			EDIT_COMMIT=
>  			USE_OUTPUT=output
>  			cp "$MSG" "$SQUASH_MSG"
>  		;;

One more level of indent, please.

>  		*)
>  			EDIT_COMMIT=-e
>  			USE_OUTPUT=
>  			test -f "$SQUASH_MSG" && rm "$SQUASH_MSG"

Again, "test -f && rm"?

> ...
>  		pick_one -n $sha1 || failed=t
>  		author_script=$(get_author_ident_from_commit $sha1)
>  		echo "$author_script" > "$DOTEST"/author-script
>  		case $failed in
>  		f)
>  			# This is like --amend, but with a different message
>  			eval "$author_script"
>  			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
>  			$USE_OUTPUT git commit -F "$MSG" $EDIT_COMMIT
>  			;;

The "export" here makes me somewhat nervous -- no chance these
leak into the next round?

> ...
>  		HEAD=$(git rev-parse --verify HEAD) || die "No HEAD?"
>  		UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
>  
>  		test -z "$ONTO" && ONTO=$UPSTREAM
>  
>  		: > "$DOTEST"/interactive || die "Could not mark as interactive"
>  		git symbolic-ref HEAD > "$DOTEST"/head-name ||
>  			die "Could not get HEAD"

It was somewhat annoying that you cannot "rebase -i" the
detached HEAD state.

> ...
>  		cat > "$TODO" << EOF
>  # Rebasing $SHORTUPSTREAM..$SHORTHEAD onto $SHORTONTO
>  #
>  # Commands:
>  #  pick = use commit
>  #  edit = use commit, but stop for amending
>  #  squash = use commit, but meld into previous commit
>  #
>  # If you remove a line here THAT COMMIT WILL BE LOST.
>  #
>  EOF
>  		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
>  			--abbrev=7 --reverse --left-right --cherry-pick \
>  			$UPSTREAM...$HEAD | \
>  			sed -n "s/^>/pick /p" >> "$TODO"
>  
>  		test -z "$(grep -ve '^$' -e '^#' < $TODO)" &&
>  			die_abort "Nothing to do"

Same comment here as before, and there is another one a few
lines below.  Perhaps a trivial shell function is in order?
