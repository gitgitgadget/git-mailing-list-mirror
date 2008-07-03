From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 1/4] Add git-sequencer shell prototype
Date: Thu, 3 Jul 2008 12:03:49 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807031142540.9925@racer>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 14:09:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KENcU-0006M6-QC
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 14:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173AbYGCMFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 08:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755172AbYGCMFs
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 08:05:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:39617 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752716AbYGCMFq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 08:05:46 -0400
Received: (qmail invoked by alias); 03 Jul 2008 11:05:44 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp002) with SMTP; 03 Jul 2008 13:05:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19in9cdB0Ji23k2YiUj6fYNdAAzJNuhKdjKu42eDu
	uwwMGO6kuoREGS
X-X-Sender: gene099@racer
In-Reply-To: <7vbq1f68rh.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87269>

Hi,

On Wed, 2 Jul 2008, Junio C Hamano wrote:

> Stephan Beyer <s-beyer@gmx.net> writes:
> 
> > git sequencer is planned as a backend for user scripts
> > that execute a sequence of git instructions and perhaps
> > need manual intervention, for example git-rebase or git-am.
> 
> ...
> > +output () {
> > +	case "$VERBOSE" in
> > +	0)
> > +		"$@" >/dev/null
> > +		;;
> > +	1)
> > +		output=$("$@" 2>&1 )
> > +		status=$?
> > +		test $status -ne 0 && printf '%s\n' "$output"
> > +		return $status
> > +		;;
> > +	2)
> > +		"$@"
> > +		;;
> > +	esac
> > +}
> 
> Perhaps misnamed?  This feels more like "do" or "perform" or "run".

My fault.  I like "perform".

> > +require_clean_work_tree () {
> > +	# test if working tree is dirty
> > +	git rev-parse --verify HEAD >/dev/null &&
> > +	git update-index --ignore-submodules --refresh &&
> > +	git diff-files --quiet --ignore-submodules &&
> > +	git diff-index --cached --quiet HEAD --ignore-submodules -- ||
> > +	die 'Working tree is dirty'
> > +}
> 
> When is it necessary to ignore submodules and why?

Submodules are not updated by checkout.  Indeed, the _only_ Git command 
that actually changes the state of a submodule is "git submodule update".

Therefore, it is wrong to assume that rebase/am/whatever works with 
submodules as far as the working directory is concerned.  Updating 
submodules with any Git command other than "git submodule update" is a 
_pure_ index operation.

Of course, that means that if you use rebase -i's "edit" command to go 
back to a certain revision, edit that, and want to test, it is _your_ 
responsibility to make sure that the submodules are at their correct 
revision.

> Are there cases where submodules should not be ignored?

With above reasoning, it would always be wrong for sequencer to require 
the submodules to be up-to-date.

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

As "count" and "total" are only used for the progress output, anything 
else would not make sense.

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

Yes.  I had exactly that need a few days ago, where I wanted to import a 
few zips, and rebase them on top of an existing branch (which was 
generated in the same manner).

I worked around that limitation of rebase (actually, I only tried rebase 
-i, come to think of it), by rewriting the first commit object, inserting 
the "parent" line.  "fast-export > a1; vi a1; fast-import < a1" can be so 
much fun!

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

Again, my fault (as this was most likely copied from rebase -i).  All the 
files written to $DOTEST in rebase -i should be $IFS safe.

> > +	case $HEADNAME in
> > +	refs/*)
> > +		git symbolic-ref HEAD "$HEADNAME"
> > +		;;
> > +	esac &&
> > +	output git reset --hard "$HEAD"
> > +}
> > +
> > +has_action () {
> > +	grep '^[^#]' "$1" >/dev/null
> > +}
> > +
> > +# Check if text file $1 contains a commit message
> > +has_message () {
> > +	test -n "$(sed -n -e '/^Signed-off-by:/d;/^[^#]/p' <"$1")"
> > +}
> 
> Makes one wonder if we would want to special case other kinds like
> "Acked-by:" as well...

I think this just mimicks "git commit".

> > +# Usage: pick_one (cherry-pick|revert) [-*|--edit] sha1
> > +pick_one () {
> > +	what="$1"
> > +	# we just assume that this is either cherry-pick or revert
> > +	shift
> > +
> > +	# check for fast-forward if no options are given
> > +	if expr "x$1" : 'x[^-]' >/dev/null
> > +	then
> > +		test "$(git rev-parse --verify "$1^")" = \
> > +			"$(git rev-parse --verify HEAD)" &&
> > +			output git reset --hard "$1" &&
> > +			return
> > +	fi
> > +	test "$1" != '--edit' -a "$what" = 'revert' &&
> > +		what='revert --no-edit'
> 
> This looks somewhat wrong.
> 
> When the history looks like ---A---B and we are at A, cherry-picking B can
> be optimized to just advancing to B, but that optimization has a slight
> difference (or two) in the semantics.
> 
>  (1) The committer information would not record the user and time of the
>      sequencer operation, which actually may be a good thing.

This is debatable.  But I think you are correct, for all the same reasons 
why a merge can result in a fast-forward.

>  (2) When $what is revert, this codepath shouldn't be exercised, should 
>  it?

Yes.

>  (3) If B is a merge, even if $what is pick, this codepath shouldn't be
>      exercised, should it?

I think it should, again for the same reason why a merge can result in a 
fast-forward.

> > +make_squash_message () {
> > +	if test -f "$squash_msg"
> > +	then
> > +		count=$(($(sed -n -e 's/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p' \
> > +			<"$squash_msg" | sed -n -e '$p')+1))
> > +		echo "# This is a combination of $count commits."
> > +		sed -e '1d' -e '2,/^./{
> > +			/^$/d
> > +		}' <"$squash_msg"
> > +	else
> > +		count=2
> > +		echo '# This is a combination of 2 commits.'
> > +		echo '# The first commit message is:'
> > +		echo
> > +		commit_message HEAD
> > +	fi
> > +	echo
> > +	echo "# This is the $(nth_string "$count") commit message:"
> > +	echo
> > +	commit_message "$1"
> > +}
> > +
> > +make_squash_message_multiple () {
> > +	echo '# This is a dummy to get the 0.' >"$squash_msg"
> > +	for cur_sha1 in $(git rev-list --reverse "$sha1..HEAD")
> > +	do
> > +		make_squash_message "$cur_sha1" >"$MSG"
> > +		cp "$MSG" "$squash_msg"
> > +	done
> > +}
> 
> Hmm, I know this is how rebase-i is written, but we should be able to do
> better than writing and flipping temporary times N times, shouldn't we?

Right, again my fault.

> > +peek_next_command () {
> > +	sed -n -e '1s/ .*$//p' <"$TODO"
> > +}
> 
> ... which could respond "the next command is '#' (comment)", so we are
> actively counting a comment as a step here.  Does this contradict with the
> mental note we made earlier, and if so, does the discrepancy hurt us
> somewhere in this program?

Yes, this is wrong.  it must be

	sed -n -e '/^#/d' -e '1s .*$//p' < "$TODO"

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

I'd not check in sequencer for the strategy.  Especially given that we 
want to support user-written strategies in the future.

Ciao,
Dscho
