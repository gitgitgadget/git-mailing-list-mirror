From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 1/7] rebase -i: Make option handling in pick_one more
 flexible
Date: Mon, 23 Jun 2014 18:09:56 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1406231801190.14982@s15462909.onlinehome-server.info>
References: <cover.1403146774.git.bafain@gmail.com> <53A258DA.3030903@gmail.com> <53A439B2.7000106@alum.mit.edu> <53A6137A.7040803@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 18:10:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz6on-0004rC-R3
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 18:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358AbaFWQKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 12:10:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:61669 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754158AbaFWQJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 12:09:59 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0LuP19-1WakDL1agp-011lrf;
 Mon, 23 Jun 2014 18:09:56 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <53A6137A.7040803@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:nD3Qxz4KeTxy28zKHWhNQ/WGbgdscKHkYwnAXi7hJbNT0OcpiWE
 pgXPm4KhLohMvQsMW5M66O5u1yfdsGr8xEFzopBQxkzNLBtETi6bm31bCz2Fsgp7wVVM+2t
 FDjuFyJ/5t7FR17n3s3q2Uzul9GQ1xcxo4wtT4xvxDlcgiRvoYxdqmEhIlxbjj8G9qxbIj1
 qF6o8oJBvcp/IjB7a+Pww==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252348>

Hi,

On Sun, 22 Jun 2014, Fabian Ruch wrote:

> On 06/20/2014 03:40 PM, Michael Haggerty wrote:
> > On 06/19/2014 05:28 AM, Fabian Ruch wrote:
> >> `pick_one` and `pick_one_preserving_merges` are wrappers around
> >> `cherry-pick` in `rebase --interactive`. They take the hash of a commit
> >> and build a `cherry-pick` command line that
> >>
> >>  - respects the user-supplied merge options
> >>  - disables complaints about empty commits
> >>  - tries to fast-forward the rebase head unless rebase is forced
> >>  - suppresses output unless the user requested higher verbosity
> >>  - rewrites merge commits to point to their rebased parents.
> >>
> >> `pick_one` is used to implement not only `pick` but also `squash`, which
> >> amends the previous commit rather than creating a new one. When
> >> `pick_one` is called from `squash`, it receives a second argument `-n`.
> >> This tells `pick_one` to apply the changes to the index without
> >> committing them. Since the argument is almost directly passed to
> >> `cherry-pick`, we might want to do the same with other `cherry-pick`
> >> options. Currently, `pick_one` expects `-n` to be the first and only
> >> argument except for the commit hash.
> >>
> >> Prepare `pick_one` for additional `cherry-pick` options by allowing `-n`
> >> to appear anywhere before the commit hash in the argument list. Loop
> >> over the argument list and pop each handled item until the commit hash
> >> is the only parameter left on the list. If an option is not supported,
> >> ignore it and issue a warning on the console. Construct a new arguments
> >> list `extra_args` of recognized options that shall be passed to
> >> `cherry-pick` on the command line.
> >>
> >> [...]
> >> +		*)
> >> +			break
> >> +			;;
> >> +		esac
> >> +		shift
> >> +	done
> >> +	test $# -ne 1 && die "pick_one: wrong number of arguments"
> >> +	sha1=$1
> >>  
> >> -	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
> >>  	case "$force_rebase" in '') ;; ?*) ff= ;; esac
> >>  	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
> >>  
> >> @@ -248,24 +266,35 @@ pick_one () {
> >>  	fi
> >>  
> >>  	test -d "$rewritten" &&
> >> -		pick_one_preserving_merges "$@" && return
> >> +		pick_one_preserving_merges $extra_args $sha1 && return
> >>  	output eval git cherry-pick \
> >>  			${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
> >> -			"$strategy_args" $empty_args $ff "$@"
> >> +			"$strategy_args" $empty_args $ff $extra_args $sha1
> >>  }
> > 
> > It might be confusing that extra_args is used both in pick_one and in
> > pick_one_preserving_merges.  Since these are not local variables, the
> > call to the latter changes the value of the variable in the former.  I
> > don't know if that could be a problem now (can
> > pick_one_preserving_merges return with a nonzero exit code?) but even if
> > not, it is a trap for future developers.  I recommend giving the two
> > variables different names.
> 
> Please correct me if I missed something. At the moment (786a89d),
> pick_one_preserving_merges will not and cannot return with a non-zero
> exit code because it doesn't explicitly return and all possibly failing
> last statements are guarded with a ... || die "...". Since this can only
> be established by carefully looking at the code, I will change the reuse
> of extra_args.

I agree that this is a good change, but I would like to point out that it
would be a good change even if it pick_one_preserving_merged could return
with a non-zero exit code, even if it could be established easier that it
cannot return with a non-zero exit code: it is plainly confusing. (My
fault, of course.)

> Now that we're at it, what I didn't understand when creating this patch
> was why the code doesn't explicitly say "one or the other" in the first
> place:
> 
> > if test -d "$rewritten"
> > then
> > 	pick_one_preserving_merges "$@"
> > else
> > 	output eval git cherry-pick \
> > 			${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
> > 			"$strategy_args" $empty_args $ff "$@"
> > fi
> 
> At least that is how I interpreted it. After all, if
> pick_one_preserving_merges failed to recreate a merge commit, wouldn't
> it be a bug to record the changes in a single-parent commit?
> 
> Johannes, I cc'd you this email since you're the author of f09c9b8 -
> "Teach rebase -i about --preserve-merges". I hope you don't resent me
> digging out this seven-year-old patch.

I do not resent you. Nor do I resent that the seven-year-old change is
coming to light again. But I have to admit that my recollection as to the
rationale for the way the code was written is very faint indeed.

Also, my commit messages were substantially inferior back then, so I guess
that the commit message of f09c9b8 does not quite help to jog my memory.

Looking at that revision of git-rebase--interactive.sh, however, I see
three call sites of pick_one, and I would suspect that I wanted to
maintain DRY code. Having said that, today I would replace

	@@ -68,6 +71,8 @@ die_abort () {
	 pick_one () {
		case "$1" in -n) sha1=$2 ;; *) sha1=$1 ;; esac
		git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
	+       test -d "$REWRITTEN" &&
	+               pick_one_preserving_merges "$@" && return
		parent_sha1=$(git rev-parse --verify $sha1^ 2>/dev/null)
		current_sha1=$(git rev-parse --verify HEAD)
		if [ $current_sha1 = $parent_sha1 ]; then

by

	@@ -68,6 +71,8 @@ die_abort () {
	 pick_one () {
		case "$1" in -n) sha1=$2 ;; *) sha1=$1 ;; esac
		git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
	+       if test -d "$REWRITTEN"
	+       then
	+               pick_one_preserving_merges "$@"
	+               return
	+       fi
		parent_sha1=$(git rev-parse --verify $sha1^ 2>/dev/null)
		current_sha1=$(git rev-parse --verify HEAD)
		if [ $current_sha1 = $parent_sha1 ]; then

instead.

Hope this clarifies things!
Dscho
