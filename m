From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: commit when continuing after "edit"
Date: Tue, 25 Sep 2007 13:32:42 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709251249450.28395@racer.site>
References: <20070923224502.GB7249@potapov> <Pine.LNX.4.64.0709240121080.28395@racer.site>
 <7vlkav71bv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 14:33:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia9bu-0008LO-Ab
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 14:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbXIYMds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 08:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbXIYMds
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 08:33:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:56475 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752497AbXIYMdr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 08:33:47 -0400
Received: (qmail invoked by alias); 25 Sep 2007 12:33:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 25 Sep 2007 14:33:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180HXhs3GA0RUxH/cyVi/5cNopFA6v3KlpHKp3RIf
	alz/bVTB4j/IpC
X-X-Sender: gene099@racer.site
In-Reply-To: <7vlkav71bv.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59115>

Hi,

I'll send out a fixed patch series later, where the "commit when 
continuing" is th first one, and the style nits are addressed in the 
second one.  A third one will have a minor fixup, a 4th will address the 
detached HEAD issue.

But I need some clarification of the quoting, as detailed below.

On Mon, 24 Sep 2007, Junio C Hamano wrote:

> >  	case "$VERBOSE" in
> >  	'')
> >  		"$@" > "$DOTEST"/output 2>&1
> >  		status=$?
> >  		test $status != 0 &&
> >  			cat "$DOTEST"/output
> >  		return $status
> >  	;;
> 
> One more level of indent, please.

Sorry, of course.

> >  	*)
> >  		"$@"
> >  	esac
> 
> I find it is usually less error prone to help the longer term 
> maintainability if you do not omit double-semicolon before esac.

There were quite a few instances; I fixed them all.

> >  make_patch () {
> >  	parent_sha1=$(git rev-parse --verify "$1"^ 2> /dev/null)
> >  	git diff "$parent_sha1".."$1" > "$DOTEST"/patch
> 
> What's the point of using --verify when you do not error out upon error?  
> I find this quite inconsistent; your require_clean_work_tree above is so 
> nicely written.

Thanks (for the latter).  I changed that (the former).

> Is there anything (other than user's common sense, which we cannot 
> always count on these days) that prevents the caller to feed a root 
> commit to this function, I wonder?

There is a corner case, where it is possible:

A - B - C

D - E - F

$ git checkout F
$ git rebase -i C

I am not quite certain how to fix it... And besides, this fix has no place 
in a style patch.

> > -die_with_patch () {
> >  	test -f "$DOTEST"/message ||
> >  		git cat-file commit $sha1 | sed "1,/^$/d" > "$DOTEST"/message
> >  	test -f "$DOTEST"/author-script ||
> >  		get_author_ident_from_commit $sha1 > "$DOTEST"/author-script
> > +}
> 
> Are these "$sha1" still valid, or do you need "$1" given to the
> make_patch function?

They were not even valid before.  "$1" it is.

> >  pick_one () {
> >  	no_ff=
> >  	case "$1" in -n) sha1=$2; no_ff=t ;; *) sha1=$1 ;; esac
> >  	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
> >  	test -d "$REWRITTEN" &&
> >  		pick_one_preserving_merges "$@" && return
> >  	parent_sha1=$(git rev-parse --verify $sha1^ 2>/dev/null)
> >  	current_sha1=$(git rev-parse --verify HEAD)
> 
> Again --verify without verifying.

Okay, fixed.

> >  	for p in $(git rev-list --parents -1 $sha1 | cut -d\  -f2-)
> 
> Just a style nit.  A string literal for a SP is easier to read if 
> written as a SP inside sq pair (i.e. ' ') not backslash followed by a SP 
> (i.e. \ ).

Right.

> >  	case $fast_forward in
> >  	t)
> >  		output warn "Fast forward to $sha1"
> >  		test $preserve=f && echo $sha1 > "$REWRITTEN"/$sha1
> 
> Testing if concatenation of $preserve and "=f" is not an empty string, 
> which would almost always yield true?

Ouch.  This is wrong.  And fixing that exposed another error: it should be 
an "||" instead of a "&&".

Since it did not trigger erroneous behaviour, just unnecessary writing, I 
put it into the style fixes category.

> >  		first_parent=$(expr "$new_parents" : " \([^ ]*\)")
> 
> Style; typically regexp form of expr and sed expression are easier to 
> read with quoted with sq, not dq.

But in this case, the expression does not change, right?  Fixed.

> >  			# redo merge
> >  			author_script=$(get_author_ident_from_commit $sha1)
> >  			eval "$author_script"
> >  			msg="$(git cat-file commit $sha1 | \
> >  				sed -e '1,/^$/d' -e "s/[\"\\]/\\\\&/g")"
> 
> What's this backquoting about?  Your "output" does not eval (and it 
> shouldn't), so that's not it.  Working around incompatible echo that 
> does auto magic used to write MERGE_MSG?  Can we lose the backquoting by 
> using printf "%s\n" there?

I think so.  I never was good with quoting, but I guess that the more 
important part is the '-m "$msg"'.  This part could use a sanity check of 
somebody who gets quoting right, i.e. you.

> >  do_next () {
> >  	test -f "$DOTEST"/message && rm "$DOTEST"/message
> >  	test -f "$DOTEST"/author-script && rm "$DOTEST"/author-script
> > +	test -f "$DOTEST"/amend && rm "$DOTEST"/amend
> 
> As you do not check the error from "rm", how are these different from rm 
> -f "$DOTEST/frotz"?

The difference: the user will not see many irritating error messages.

I changed this code to use a newly written function "remove_if_exists", 
which die()s if the file exists and could not be removed.

So this is not technically a style fix, but minor enough that I'll put it 
into that patch, too.

> >  	\#|'')
> >  		mark_action_done
> >  		;;
> 
> Perhaps '#'*?

Yeah.  It did not matter much, as not many users wrote "#something" 
anyway.

> > ...
> >  	edit)
> >  		comment_for_reflog edit
> >  
> >  		mark_action_done
> >  		pick_one $sha1 ||
> >  			die_with_patch $sha1 "Could not apply $sha1... $rest"
> >  		make_patch $sha1
> > +		: > "$DOTEST"/amend
> 
> Good catch, but ':' is redundant ;-)

?

This idiom ": > file" is what I used ever since you said that "touch" is 
not so good (not builtin, may behave differently, etc)

Besides, it is not a catch... rebase -i needs to know if it 
continues after "edit", so it can amend the current commit (instead of 
making a new commit, as in the other cases) before continuing.

> >  		test -z "$(grep -ve '^$' -e '^#' < $DONE)" &&
> >  			die "Cannot 'squash' without a previous commit"
> 
> Why "test -z"?  Wouldn't this be equivalent?
> 
> 	grep -v -q -e '^$' -e '^#' "$DONE" || die ...

Yep.  I introduced a new function, "has_action".

> >  		pick_one -n $sha1 || failed=t
> >  		author_script=$(get_author_ident_from_commit $sha1)
> >  		echo "$author_script" > "$DOTEST"/author-script
> >  		case $failed in
> >  		f)
> >  			# This is like --amend, but with a different message
> >  			eval "$author_script"
> >  			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
> >  			$USE_OUTPUT git commit -F "$MSG" $EDIT_COMMIT
> >  			;;
> 
> The "export" here makes me somewhat nervous -- no chance these
> leak into the next round?

I am somewhat wary: I get quoting wrong all the time.  Would

	$USE_OUTPUT $author_script git commit -F "$MSG" $EDIT_COMMIT

work?  I have the slight suspicion that it would not, since

	eval "$author_script"

needs extra quoting in $author_script, no?

> > ...
> >  		HEAD=$(git rev-parse --verify HEAD) || die "No HEAD?"
> >  		UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
> >  
> >  		test -z "$ONTO" && ONTO=$UPSTREAM
> >  
> >  		: > "$DOTEST"/interactive || die "Could not mark as interactive"
> >  		git symbolic-ref HEAD > "$DOTEST"/head-name ||
> >  			die "Could not get HEAD"
> 
> It was somewhat annoying that you cannot "rebase -i" the
> detached HEAD state.

Will fix in a separate patch.

Ciao,
Dscho
