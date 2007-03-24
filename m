From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Convert emailing part of hooks--update to hooks--post-receive
Date: Sat, 24 Mar 2007 05:43:24 -0700
Message-ID: <7vlkhmg6c3.fsf@assigned-by-dhcp.cox.net>
References: <200703231023.58911.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 13:43:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV5az-0006zX-Ei
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 13:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbXCXMn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 08:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbXCXMn2
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 08:43:28 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:50259 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbXCXMn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 08:43:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070324124325.SHWZ748.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 24 Mar 2007 08:43:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ecjQ1W0011kojtg0000000; Sat, 24 Mar 2007 08:43:25 -0400
In-Reply-To: <200703231023.58911.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 23 Mar 2007 10:23:58 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42998>

Andy Parkins <andyparkins@gmail.com> writes:

>  git rev-parse --not --all | grep -v $(<$refname) |
>  git rev-list --pretty --stdin $newrev --not $baserev
>
> This uses git-rev-parse followed by grep to filter out the revision of
> the ref in question before it gets to rev-list and inhibits the output
> of itself.  By using $(<$refname) rather than $newrev as the filter, it
> also takes care of the situation where another update to the same ref
> has been made since $refname was $newrev.

Is $(<$refname) even POSIX?  Are we sure $refname is always a
file (not a packed ref)?

If the other push updates the same ref you are filtering out,
that would make "grep -v" to remove it from the exclusion set,
which is a neat trick.  However, wouldn't that cause the
rev-list to report the effect of the other push, and not your
push?  I am wondering if the mail would say "Alice pushed and
this branch has these commits as the result" and ends up
including Bob's commits in it when that happens.

>  * All uses of "git-command" changed to "git command", to cope better
>    if a user decided not to install all the hard links to git;

I think that is a good discipline in general, but I wonder if it
is strictly necessary.  Doesn't hook already get invoked with
environment that has GIT_EXEC_PATH at the beginning of the PATH?

> +generate_email()
> +{
> ...
> +		refs/remotes/*,commit)
> +			# tracking branch
> +			refname_type="tracking branch"
> +			short_refname=${refname##refs/remotes/}
> +			echo "*** Push-update of tracking branch, $refname"
> +			echo "***  - no email generated." >&2

Huh?  Did you mean to send the first one also to stderr?

> +			exit 0
> +			;;
> +		*)
> +			# Anything else (is there anything else?)
> +			echo "*** Unknown type of update to $refname ($rev_type)" >&2
> +			echo "***  - no email generated"

Huh?  Did you mean to send the second one also to stderr?

It usually is easier to spot this kind of gotchas if you
consistently write like this instead:

	echo >&2 "your message comes here..."
	echo >&2 "... and the second line is here"

> +			exit 1
> +			;;
> +	esac
> +
> +	# Check if we've got anyone to send to
> +	if [ -z "$recipients" ]; then
> +		echo "*** hooks.recipients is not set so no email will be sent" >&2
> +		echo "*** for $refname update $oldrev->$newrev" >&2
> +		exit 0
> +	fi
> +
> +	# Email parameters
> +	# The committer will be obtained from the latest existing rev; so
> +	# for a deletion it will be the oldrev, for the others, then newrev
> +	committer=$(git show --pretty=full -s $rev | grep "^Commit: " | sed -e "s/^Commit: //")

Please never pipe grep into sed, or the other way around.  It
makes the script look amateurish.

I think you meant:

	.... | sed -ne 's/^Commit: //p'

Is it assumed that pushing developers do not cross-pull,
bypassing the repository this hook is in?  Otherwise, if Alice
does a lot of work, Bob pulls from her (bypassing this
repository), makes a tiny fix, and Alice pulls (bypassing this
repository) back from Bob, the last pull by Alice would result
in a fast-forward, and when Alice pushes the results back, this
repository will see the Bob's tiny fix at the tip, the script
takes that commit as the representative, and From: line would
have Bob's name on it.

It would not be a problem as long as you use this repository as
the _ONLY_ place developers meet, but that's a big assumption:
centralized repo with CVS-mentality.

The assumption is not wrong per-se, but I think that needs to be
documented at one place, near the top: "if you subscribe to this
kind of workflow, then this e-mail script is for you, otherwise,
it is not".

Similarly the other assumption your script makes should be
documented: the "list only new commits to the entire repository"
design.  I do not think that behaviour is for everybody, but you
already know that, and I would not make further comments on this
point, other than saying that I do agree it is good for some
people.  It all depends on the workflow and recipients'
interests.

> +	# The email subject will contain the best description of the ref
> +	# that we can build from the parameters
> +	describe=$(git describe $rev 2>/dev/null)
> +	if [ -z "$describe" ]; then
> +		describe=$rev
> +	fi
> +
> +	generate_email_header
> +
> +	# Call the correct body generation function - object oriented programming
> +	# in a script - overkill perhaps?

I do not think so.  It is a good style as long as you do not
botch it and leave the variables empty -- even in that case the
runtime would notice and say "generate___email: no such command"
;-).

> +	fn_name=general
> +	case "$refname_type" in
> +		# --- Branches
> +		"tracking branch"|branch)
> +			fn_name=branch
> +			;;
> +		# --- Annotated tags
> +		"annotated tag")
> +			fn_name=atag
> +			;;
> +	esac

Please indent the case arms at the same level as "case/esac",
like this:

	case $var in
        foo | bar)
        	do this
                ;;
	esac

which is in line with:

	switch (x) {
        case 1:
        	foo;
                break;
	}

> +	generate_${change_type}_${fn_name}_email
> +
> +	generate_email_footer
> +}
> +
> +generate_email_header()
> +{
> +	# --- Email (all stdout will be the email)
> +	# Generate header
> +	cat <<-EOF
> +	From: $committer
> +	To: $recipients
> +	Subject: ${EMAILPREFIX}$projectdesc $refname_type, $short_refname, ${change_type}d. $describe
> +	X-Git-Refname: $refname
> +	X-Git-Reftype: $refname_type
> +	X-Git-Oldrev: $oldrev
> +	X-Git-Newrev: $newrev
> +
> +	This is an automated email from the git hooks/post-receive script. It was
> +	generated because a ref change was pushed to the repository containing
> +	the project "$projectdesc".
> +
> +	The $refname_type, $short_refname has been ${change_type}d
> +	EOF
> +}

Micronit.  Some committer names (GIT_COMMITTER_NAME) that are
not quoted may need to be quoted to appear on the From: header
(most notable is a name with dot after middle initial).

> +
> +generate_email_footer()
> +{
> +	cat <<-EOF
> +
> +	hooks/post-receive
> +	--
> +	Git Source Code Management System
> +	EOF
> +}

A signature separator line is usually "^-- $", not "^--$".

I'd rather not to have name Git there, for two reasons.  If you
are the lead of the development group who is also contact to the
QA group, you would probably get e-mail notifications from your
development repo and QA group repo.  Instead of the generic
'Git' name, which does not add any information of real value, it
would be better to have an identifier of the repository (you
would configure it in description perhaps).  Granted, the same
information is on Subject: line, but the body of the message may
be saved in a separate file for later perusal.

Also, this is (as described in the first part of the script)
only an example script, and although I am willing to help making
sure this is bug-free (like spending time writing this message
right now -- wow, I've been sitting here typing this e-mail for
almost two hours), I do not want to be held responsible for any
bugs in it, nor I do not want anybody to mistakenly think that
what this script does is the way to run things recommended by
the Git community.  It really is just "a useful script to use
WITH git Andy wrote", not "THE hook Git gives us".

> +# --------------- Branches
> +
> +#
> +# Called for the creation of a branch
> +#
> +generate_create_branch_email()
> +{
> +	# This is a new branch and so oldrev is not valid
> +	echo "        at  $newrev ($newrev_type)"
> +	echo ""

I kind of like the attention to the detail of giving an empty
argv[1] to echo (it used to be customary to do this for
portability), but I wonder if it is still needed...

> +
> +	echo $LOGBEGIN
> +	# This shows all log entries that are not already covered by
> +	# another ref - i.e. commits that are now accessible from this
> +	# ref that were previously not accessible (see generate_update_branch_email
> +	# for the explanation of this command)
> +	git rev-parse --not --branches | grep -v $(<${GIT_DIR}/$refname) |
> +	git rev-list --pretty --stdin $newrev --not $baserev
> +	echo $LOGEND
> +}

Where does $baserev come from?  Random leftover garbage from
invocation for the branch the main while loop handled before
this branch?

I think "--not $baserev" is useless for a new branch ;-).

> +
> +#
> +# Called for the change of a pre-existing branch
> +#
> +generate_update_branch_email()
> +{
> +	# Consider this:
> +	#   1 --- 2 --- O --- X --- 3 --- 4 --- N
> +	#
> +	# O is $oldrev for $refname
> +	# N is $newrev for $refname
> +	# X is a revision pointed to by some other ref, for which we may
> +	#   assume that an email has already been generated.

You are doing this one branch at a time even though a single
push may update more than one branch.  I wonder what happens if
branch A and B are pushed, and they both contain shared new
material?  When this is run for A, the entire contribution of B
(after push happened) is excluded.  Then when this is run for
B, the entire contribution of A is excluded.  Doesn't that mean
the commits new to this repository that are shared between A and
B appear for neither branches?  There must be something obvious
I am missing...

> +	# Next problem, consider this:
> +	#   * --- B --- * --- O ($oldrev)
> +	#          \
> +	#           * --- X --- * --- N ($newrev)
> +	#
> +	# That is to say, there is no guarantee that newrev is a strict subset of
> +	# oldrev (it would have required a --force, but that's allowed).  So, we
> +	# can't simply say rev-list $oldrev..$newrev.  Instead we find the common
> +	# base of the two revs and list from there.

This comment and logic is wrong.  In the above graph, if you say
"rev-list O..N" (which is "rev-list N ^O"), you would get
commits that are reachable from N, excluding the ones that are
also reachable from O, so you would get N, * before it, X and *
before it.

> +	#
> +	# As above, we need to take into account the presence of X; if another
> +	# branch is already in the repository and points at some of the revisions
> +	# that we are about to output - we don't want them.  The solution is as
> +	# before: git-rev-parse output filtered.

So, I think "rev-list N ^O ^X" is what you would want here,
which is the same as the first "single strand of pearls" case.
And notice that I did not have to say anything about base?  I do
not think it is necessary to compute base if you are only
interested in showing which commits are new.

It is however useful to compute it for another reason, namely
that you would want to give different messages depending on
fast-forwardness of O->N transition.  However, even for that
purpose, merge-base may not be necessarily the best way to see
if it is a fast forward for this application.

> +	#
> +	# Finally, tags:
> +	#   1 --- 2 --- O --- T --- 3 --- 4 --- N
> +	#
> +	# Tags pushed into the repository generate nice shortlog emails that
> +	# summarise the commits between them and the previous tag.  However,
> +	# those emails don't include the full commit messages that we output
> +	# for a branch update.  Therefore we still want to output revisions
> +	# that have been output on a tag email.
> +	#
> +	# Luckily, git-rev-parse includes just the tool.  Instead of using "--all"
> +	# we use "--branches"; this has the added benefit that "remotes/" will
> +	# be ignored as well.

Ok.

> +
> +	baserev=$(git merge-base $oldrev $newrev)
> +
> +	# List all the revisions from baserev to newrev in a kind of
> +	# "table-of-contents"; note this list can include revisions that have
> +	# already had notification emails and is present to show the full detail
> +	# of the change from rolling back the old revision to the base revision and
> +	# then forward to the new revision
> +	for rev in $(git rev-list $newrev --not $baserev)
> +	do
> +		revtype=$(git cat-file -t "$rev")
> +		echo "       via  $rev ($revtype)"
> +	done
> +
> +	# If the baserev is equal to the oldrev, then we know that this was a
> +	# fast forward update; otherwise "--force" was used, and we give a more
> +	# detailed explanation of what happened.

That's bog-standard way we use to see if O->N transition is a
fast forward, but for this application, since it is far more
likely to be than it isn't, I think computing "rev-list N..O"
and checking if it reports anything is a better check
(especially because its results can be used in a way I'll
describe later).

N..O lists commits that are reachable from O but not from N, in
other words, the commits lost by moving head from O to N.  If
that is not an empty set, it is not a fast-forward.

> +	if [ "$baserev" = "$oldrev" ]; then
> +		echo "      from  $oldrev ($oldrev_type)"
> +	else
> +		echo "      from  $baserev"
> +		echo "  discards  $oldrev ($oldrev_type) and its branch"
> +		echo ""
> +		echo "This update added new revisions after undoing old revisions.  That is to"
> +		echo "say, the old revision is not a strict subset of the new revision.  This"
> +		echo "situation occurs when you --force push a change and generate a"
> +		echo "repository containing something like this:"
> +		echo ""
> +		echo " * -- * -- B -- O -- O -- O ($oldrev)"
> +		echo "            \\"
> +		echo "             N -- N -- N ($newrev)"
> +		echo ""
> +		echo "When this happens we assume that you've already had alert emails for all"
> +		echo "of the O revisions, and so we here report only the revisions in the N"
> +		echo "branch from the common base, B ($baserev),"
> +		echo "up to the new branch endpoint."
> +	fi

I suspect the recipients would want to know which ones are
discarded, so perhaps list O with:

	"rev-list N..O"

Notice you do not need to use B to compute this set either.  I
think you can replace "--not $baserev" with "--not $oldrev" in
all these "rev-list --pretty --stdin $newrev" invocations.

> +
> +	echo ""
> +	echo "Those revisions listed above that are new to this repository have"
> +	echo "not appeared on any other notification email; so we list those"
> +	echo "revisions in full, below."
> +
> +	echo ""
> +	echo $LOGBEGIN
> +	git rev-parse --not --branches | grep -v $(<${GIT_DIR}/$refname) |
> +	git rev-list --pretty --stdin $newrev --not $baserev

I am recommending to get rid of merge-base, which means you
won't have $baserev, but it can be replaced with $oldrev.

"O..N" looks more gittish than "$(merge-base O N)..N"

> +
> +	# XXX: Need a way of detecting whether git rev-list actually outputted
> +	# anything, so that we can issue a "no new revisions added by this
> +	# update" message
> +
> +	echo $LOGEND
> +
> +	# The diffstat is shown from the old revision to the new revision.  This
> +	# is to show the truth of what happened in this change.  There's no point
> +	# showing the stat from the base to the new revision because the base
> +	# is effectively a random revision at this point - the user will be
> +	# interested in what this revision changed - including the undoing of
> +	# previous revisions in the case of non-fast forward updates.

> +	echo ""
> +	echo "Summary of changes:"
> +	git diff-tree --no-color --stat -M -C --find-copies-harder $baserev..$newrev
> +}

Comment and code mismatch between $baserev and $oldrev?

"-M -C" is redundant.  Just "-C" should do.  If you really want
to spend extra cycles, then "--find-copies-harder" is fine, but
I think that implies "-C".

Do you even need --no-color?  I thought we specifically tried
not to do the color or any UI stuff for the lower-level
diff-{tree,files,index} brothers.

I would add --summary to the list, though.

> +
> +#
> +# Called for the deletion of a branch
> +#
> +generate_delete_branch_email()
> +{
> +	echo "       was  $oldrev"
> +	echo ""
> +}

Perhaps with a one-line?

> +
> +# --------------- Annotated tags
> +
> +#
> +# Called for the creation of an annotated tag
> +#
> +generate_create_atag_email()
> +{
> +	echo "        at  $newrev ($newrev_type)"
> +
> +	generate_atag_email
> +}

Perhaps with a one-line?

> +
> +#
> +# Called for the update of an annotated tag (this is probably a rare event
> +# and may not even be allowed)
> +#
> +generate_update_atag_email()
> +{
> +	echo "        to  $newrev ($newrev_type)"
> +	echo "      from  $oldrev (which is now obsolete)"
> +
> +	generate_atag_email
> +}
> +
> +#
> +# Called when an annotated tag is created or changed
> +#
> +generate_atag_email()
> +{
> +	# Use git-for-each-ref to pull out the individual fields from the tag
> +	eval $(git-for-each-ref --format='
> +	tagobject="%(*objectname)"
> +	tagtype="%(*objecttype)"
> +	tagger="%(taggername)"
> +	tagged="%(taggerdate)"' $refname
> +	)

Perfect example of using for-each-ref and nicely done.  Contrary
to what you said earlier, I see a hyphen between git and
for-each-ref, though.

> +
> +	echo "   tagging  $tagobject ($tagtype)"
> +	case "$tagtype" in
> +	commit)
> +		# If the tagged object is a commit, then we assume this is a
> +		# release, and so we calculate which tag this tag is replacing
> +		prevtag=$(git describe --abbrev=0 $newrev^ 2>/dev/null)

What if $newrev is a merge, I wonder...

> +
> +		if [ -n "$prevtag" ]; then
> +			echo "  replaces  $prevtag"
> +		fi
> +		;;
> +	*)
> +		echo "    length  $(git cat-file -s $tagobject) bytes"
> +		;;
> +	esac
> +	echo " tagged by  $tagger"
> +	echo "        on  $tagged"
> +
> +	echo ""
> +	echo $LOGBEGIN
> +
> +	# Show the content of the tag message; this might contain a change log
> +	# or release notes so is worth displaying.  "tail -n +5" is there to
> +	# remove the first 4 lines of the tag object, those details have
> +	# already been summarised above
> +	git cat-file tag $newrev | tail -q -n +5

Didn't you mean to update this with:

	... | sed -e '1,/^$/d'

?

> +
> +	echo ""
> +	case "$tagtype" in
> +	commit)
> +		# Only commit tags make sense to have rev-list operations performed
> +		# on them
> +		if [ -n "$prevtag" ]; then
> +			# Show changes since the previous release
> +			git rev-list --pretty=short "$prevtag..$newrev" | git shortlog
> +		else
> +			# No previous tag, show all the changes since time began
> +			git rev-list --pretty=short $newrev | git shortlog
> +		fi
> +		;;
> +	*)
> +		# XXX: Is there anything useful we can do for non-commit objects?
> +		;;

You won't get a tag to another tag with %(*objecttype), so you
only have to worry about trees and blobs.  But in addition to
the "length XX bytes" you already said the type of what it tags
upfront, so I do not think of anything else to say here.

> +# --- Config
> +# Set GIT_DIR either from the working directory, or from the environment
> +# variable.
> +GIT_DIR=$(git-rev-parse --git-dir 2>/dev/null)
> +if [ -z "$GIT_DIR" ]; then
> +	echo "fatal: post-receive: GIT_DIR not set"
> +	exit 1
> +fi
> +
> +projectdesc=$(cat $GIT_DIR/description)

This goes on the Subject: header; you'd better make sure the
repository is not misconfigured to have more than one lines in
it.

> +# Check if the description is unchanged from it's default, and shorten it to a
> +# more manageable length if it is
> +if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
> +then
> +	projectdesc="UNNAMED PROJECT"
> +fi

I vaguely recall you made this die instead of leaving unnamed...
