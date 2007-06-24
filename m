From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Teach rebase an interactive mode
Date: Sun, 24 Jun 2007 01:15:13 -0700
Message-ID: <7v4pkxydim.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706240001150.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 24 10:15:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2NFy-0005zp-PF
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 10:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbXFXIPV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 04:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752355AbXFXIPU
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 04:15:20 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:42483 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314AbXFXIPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 04:15:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070624081514.TJXP2558.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 24 Jun 2007 04:15:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FLFE1X0031kojtg0000000; Sun, 24 Jun 2007 04:15:14 -0400
In-Reply-To: <Pine.LNX.4.64.0706240001150.4059@racer.site> (Johannes
	Schindelin's message of "Sun, 24 Jun 2007 00:01:51 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50776>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 0c00090..2e474e8 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> ...
> +Interactive mode
> +----------------
> +
> +Rebasing interactively means that you have a chance to edit the commits
> +which are rebased.  You can not only reorder the commits, but also
> +remove them (weeding out bad or otherwise unwanted patches).

Maybe it's just my bad English comprehension skill, but I needed
to read "You can not only ... but also" twice.  "You can reorder
and also remove" would mean the same thing and would be much
easier for non natives to understand.

> +
> +The list will look like this:
> +
> +-------------------------------------------
> +pick deadbee The oneline of this commit
> +pick fa1afe1 The oneline of the next commit
> +...
> +-------------------------------------------
> +
> +The oneline descriptions are purely for your pleasure; `git-rebase` will
> +not look at them but at the commit names, so do not delete or edit the
> +names.

By "commit name", do you mean deadbee?  After reading the full
patch I know that is what you meant, but it was a bit unclear
during my initial pass.

> +By replacing the command "pick" with the command "edit", you can tell
> +`git-rebase` to stop after applying that commit, so that you can edit
> +the files and/or the commit message, amend the commit and continue
> +rebasing.
> +
> +If you want to fold two commits into one, just replace the command "pick"
> +with "squash" for the second commit.  After squashing the commits,
> +`git-rebase` will start an editor with both commit messages, so you
> +can compose the commit message for the squashed commit.

There was a question about squashing more than two on the list,
and you explained it as "one would get the idea", but I am not
sure I got it right.  Would this be what you meant?

	If you want to fold two or more commits into one,
	replace the command "pick" with "squash" for the second
	and subsequent commit.

> diff --git a/Makefile b/Makefile
> index 0d904a9..edb421b 100644
> --- a/Makefile
> +++ b/Makefile
> ...
> +# MOTIVATION
> +#
> +# Consider this type of workflow:
> ...
> +# Sometimes the thing fixed in B.2. cannot be amended to the not-quite
> +# perfect commit it fixes, because that commit is buried deeply in a
> +# patch series.
> +#
> +# Use this script after plenty of "A"s and "B"s, by rearranging, and
> +# possibly editing and merging commits.

This part is missing from Documentation/git-rebase.txt and
should move there, and the USAGE: part of the documentation
should be removed from here; otherwise you need to maintain the
two in sync.

> +USAGE='(--continue | --abort | --skip | [--onto <branch>] <upstream> [<branch>])'
> +
> +. git-sh-setup
> +require_work_tree
> +
> +DOTEST="$GIT_DIR/.dotest-merge"
> +TODO="$DOTEST"/todo
> +DONE="$DOTEST"/done
> +STRATEGY=
> +VERBOSE=
> +
> +warn () {
> +	echo "$@" >&2
> +}

I would have used "$*" instead.

> +require_clean_work_tree () {
> +	# test if working tree is dirty
> +	git rev-parse --verify HEAD > /dev/null &&
> +	git update-index --refresh &&
> +	test -z "`git diff-files --name-only`" &&
> +	test -z "`git diff-index --cached --name-only HEAD`" ||
> +	die "Working tree is dirty"
> +}

Heh, I think I showed

	git diff-files --quiet && git diff-index --cached --quiet

to somebody else today.  Let's be modern ;-).

Is today my "nitpick shell scripts day"? ;-)

> +ORIG_REFLOG_ACTION="$GIT_REFLOG_ACTION"
> +
> +comment_for_reflog () {
> +	if test -z "$ORIG_REFLOG_ACTION"; then
> +		GIT_REFLOG_ACTION="rebase --interactive ($1)"
> +		export GIT_REFLOG_ACTION

Please use shorter prefix, "rebase -i".  "git reflog" output is
easer to read that way.

> +	fi
> +}
> +
> +mark_action_done () {
> +	sed -n 1p < "$TODO" >> "$DONE"
> +	sed -n '2,$p' < "$TODO" >> "$TODO".new
> +	mv -f "$TODO".new "$TODO"
> +}

I would have written "sed -e 1q" and "sed -e 1d".

> +make_patch () {
> +	parent_sha1=$(git rev-parse --verify "$1"^ 2> /dev/null)
> +	git diff "$parent_sha1".."$1" > "$DOTEST"/patch
> +}
> +
> +die_with_patch () {
> +	make_patch "$1"
> +	die "$2"
> +}
> +
> +pick_one () {
> +	case "$1" in -n) sha1=$2 ;; *) sha1=$1 ;; esac
> +	parent_sha1=$(git rev-parse --verify $sha1^ 2>/dev/null)
> +	current_sha1=$(git rev-parse --verify HEAD)
> +	if [ $current_sha1 = $parent_sha1 ]; then
> +		git reset --hard $sha1
> +		sha1=$(git rev-parse --short $sha1)
> +		warn Fast forward to $sha1
> +	else
> +		git cherry-pick $STRATEGY "$@"
> +	fi
> +}

I wonder what happens when the user mistakenly breaks the commit
object name on the 'pick' command line and the above --verify
fails.  A bit better error checking is needed here.

> +
> +do_next () {
> +	read command sha1 rest < "$TODO"
> +	case "$command" in
> +	\#)

Hmph.  Don't you allow a blank line also as a comment (for readability)?

> +		mark_action_done
> +		continue
> +	;;

Style.  Indent ';;' one more level, that is:

	case "$to_test" in
        arm1)
        	action
                ;;
	...
        esac                

> +	squash)
> +		comment_for_reflog squash
> +
> +		test -s "$DONE" ||
> +			die "Cannot 'squash' without a previous commit"

As '#' comment line is sent to DONE file with mark_action_done,
non empty DONE file does not necessarily mean you have a
previous commit --- am I mistaken?

> +
> +		mark_action_done
> +		failed=f
> +		pick_one -n $sha1 || failed=t
> +		MSG="$DOTEST"/message
> +		echo "# This is a combination of two commits." > "$MSG"
> +		echo "# The first commit's message is:" >> "$MSG"
> +		git cat-file commit HEAD | sed -n '/^$/,$p' >> "$MSG"
> +		echo >> "$MSG"
> +		echo "# And this is the 2nd commit message:" >> "$MSG"
> +		echo >> "$MSG"
> +		git cat-file commit $sha1 | sed -n '/^$/,$p' >> "$MSG"

So you have one blank line after "# The first commit's message is:"
but have two blank lines after "# And this is the 2nd"?

Style.  Always prefix sed scripts with "-e", like so:

	git cat-file commit HEAD | sed -e '1,/^$/d'

> +		git reset --soft HEAD^
> +		author_script=$(get_author_ident_from_commit $sha1)
> +		case $failed in
> +		f)
> +			# This is like --amend, but with a different message
> +			eval $author_script

Missing dq, like the other patch to git-commit?

> +			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
> +			git commit -F "$MSG" -e
> +		;;
> +		t)
> +			cp "$MSG" "$GIT_DIR"/MERGE_MSG
> +			warn
> +			warn "Could not apply $sha1... $rest"
> +			warn "After you fixed that, commit the result with"
> +			warn
> +			warn "  $(echo $author_script | tr '\012' ' ') \\"
> +			warn "	  git commit -F \"$GIT_DIR\"/MERGE_MSG -e"
> +			die_with_patch $sha1 ""
> +		esac
> +	;;
> +	*)
> +		warn "Unknown command: $command $sha1 $rest"
> +		die_with_patch $sha1 "Please fix this in the file $TODO."
> +	esac
> +	test -s "$TODO" && continue

It is not clear to me from reading the POSIX that this
"continue" is allowed, although both bash and dash seem to work
as you expect.  continue "shall return to the top of the
smallest enclosing for, while or until loop" and the enclosing
while loop you are continuing is actually the one in do_rest
function, which is the caller of this.  If POSIX meant dynamic
scoping rules, that is fine, but lexically that 'while' does not
enclose this 'continue'.

I think this one can safely be changed to "return" and there
won't be any need for such an worry.

> +
> +	HEAD=$(git rev-parse HEAD)
> +	HEADNAME=$(cat "$DOTEST"/head-name)
> +	git update-ref $HEADNAME $HEAD &&
> +	git symbolic-ref HEAD $HEADNAME || exit

Don't we want reflog entries for these two operations?

> +	rm -rf "$DOTEST" &&
> +	warn "Successfully rebased and updated $HEADNAME."
> +
> +	exit $?
> +}
> +
> +do_rest () {
> +	while :
> +	do
> +		do_next
> +	done
>
> +	test $? = 0 -a -f "$DOTEST"/verbose &&
> +		git diff --stat $(cat "$DOTEST"/head)..HEAD

I am not sure what command's exit status $? refers to at this
point.  do_next is not run in a subshell, so when it exits, you
would not reach here, would you?

> +	exit
> +}

One says "exit $?" the other says "exit" -- they mean the same
;-).

> +while case "$#" in 0) break ;; esac
> +do

No need to quote $#.

> +	case "$1" in
> +	--continue)
> +		comment_for_reflog continue
> +
> +		test -d "$DOTEST" || die "No interactive rebase running"
> +
> +		require_clean_work_tree
> +		do_rest
> +	;;

Indent ;; one more level please.

> +	--abort)
> +		comment_for_reflog abort
> +
> +		test -d "$DOTEST" || die "No interactive rebase running"
> +
> +		HEADNAME=$(cat "$DOTEST"/head-name)
> +		HEAD=$(cat "$DOTEST"/head)
> +		git symbolic-ref HEAD $HEADNAME &&
> +		git reset --hard $HEAD &&
> +		rm -rf "$DOTEST"
> +		exit
> +	;;
> +	--skip)
> +		comment_for_reflog skip
> +
> +		test -d "$DOTEST" || die "No interactive rebase running"
> +
> +		git reset --hard && do_rest
> +	;;
> +	-s|--strategy)
> +		case "$#,$1" in
> +		*,*=*)
> +			STRATEGY="-s `expr "z$1" : 'z-[^=]*=\(.*\)'`" ;;
> +		1,*)
> +			usage ;;
> +		*)
> +			STRATEGY="-s $2"
> +			shift ;;
> +		esac

Are we missing a shift before the above "case"?

> +	;;
> +	--merge)
> +		# we use merge anyway
> +	;;
> +	-C*)
> +		die "Interactive rebase uses merge, so $1 does not make sense"
> +	;;
> +	-v)
> +		VERBOSE=t
> +	;;
> +	-i|--interactive)
> +		# yeah, we know
> +	;;
> +	''|-h)
> +		usage
> +	;;
> +	*)
> +		test -d "$DOTEST" &&
> +			die "Interactive rebase already started"
> +
> +		git var GIT_COMMITTER_IDENT >/dev/null ||
> +			die "You need to set your committer info first"
> +
> +		comment_for_reflog start
> +
> +		ONTO=
> +		case "$1" in
> +		--onto)
> +			ONTO=$(git rev-parse --verify "$2") ||
> +				die "Does not point to a valid commit: $2"
> +			shift; shift
> +			;;
> +		esac
> +
> +		require_clean_work_tree
> +
> +		test -z "$2" || git checkout "$2" ||
> +			die "Could not checkout $2"

Can you afford to detach HEAD here?  Later you check with
symbolic-ref so I think not, which means "$2" must be a valid
branch name, so it should be tested like:

	git show-ref --verify --quiet "refs/heads/$2"

> +		HEAD=$(git rev-parse --verify HEAD) || die "No HEAD?"
> +		UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
> +
> +		test -z "$ONTO" && ONTO=$UPSTREAM
> +
> +		mkdir "$DOTEST" || die "Could not create temporary $DOTEST"
> +		: > "$DOTEST"/interactive || die "Could not mark as interactive"
> +		git symbolic-ref HEAD > "$DOTEST"/head-name ||
> +			die "Could not get HEAD"
> +
> +		echo $HEAD > "$DOTEST"/head
> +		echo $UPSTREAM > "$DOTEST"/upstream
> +		echo $ONTO > "$DOTEST"/onto
> +		test t = "$VERBOSE" && : > "$DOTEST"/verbose
> +
> +		cat > "$TODO" << EOF
> +# Reorder by exchanging lines.  Skip by removing lines.  If you want to
> +# edit a commit, replace the "pick" command with "edit".  If you want to
> +# squash the changes of a commit A into a commit B, place A directly
> +# after B, and replace the "pick" command with "squash".
> +EOF
> +		git rev-list --no-merges --pretty=oneline --abbrev-commit \
> +			--abbrev=7 --reverse $UPSTREAM..$HEAD | \
> +			sed "s/^/pick /" >> "$TODO"
> +
> +		test -s "$TODO" || die "Nothing to do"
> +
> +		cp "$TODO" "$TODO".backup
> +		${VISUAL:-${EDITOR:-vi}} "$TODO" ||
> +			die "Could not execute editor"
> +
> +		git reset --hard $ONTO && do_rest
> +	;;
> +	esac
> +	shift
> +done

> diff --git a/git-rebase.sh b/git-rebase.sh
> index 2aa3a01..9e25158 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -3,7 +3,7 @@
>  # Copyright (c) 2005 Junio C Hamano.
>  #
>  
> -USAGE='[-v] [--onto <newbase>] <upstream> [<branch>]'
> +USAGE='[--interactive | -i] [-v] [--onto <newbase>] <upstream> [<branch>]'
>  LONG_USAGE='git-rebase replaces <branch> with a new branch of the
>  same name.  When the --onto option is provided the new branch starts
>  out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
> @@ -120,6 +120,16 @@ finish_rb_merge () {
>  	echo "All done."
>  }
>  
> +is_interactive () {
> +	test -f "$dotest"/interactive ||
> +	while case "$1" in ''|-i|--interactive) break ;; esac
> +	do
> +		shift
> +	done && test -n "$1"
> +}

I think by case "$1" in '') you meant "we ran out", but that is
not a good pattern.  Check $# at the same time, otherwise you
would stop at an empty argument that is followed by other
arguments.

This is just an idea, but I have been wondering if it would be
useful if we teach rebase (interactive or not) to handle a merge
from an unrelated (wrt the rebase that is being performed)
branch.  That is, if you had this development on top of the
origin 'O':

             X
              \  
           A---M---B     
          /
  ---o---O

that you committed A, merged X and then committed B, you should
be able to rebase on top of an updated upstream 'Q':

             X
              \  
           A---M---B     
          /
  ---o---O---P---Q

by 'pick A/merge M/pick B', which would do:

                     X
                      \
                   A'--M'--B'
                  /
  ---o---O---P---Q

Note that A', M' and B' are different commit objects (rebase
rewrites the history) from the original picture, but X is the
same commit from the original picture.
