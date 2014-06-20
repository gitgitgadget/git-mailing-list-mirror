From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC PATCH 1/7] rebase -i: Make option handling in pick_one more
 flexible
Date: Fri, 20 Jun 2014 15:40:02 +0200
Message-ID: <53A439B2.7000106@alum.mit.edu>
References: <cover.1403146774.git.bafain@gmail.com> <53A258DA.3030903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Fabian Ruch <bafain@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 15:40:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxz36-00039D-E2
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 15:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966329AbaFTNkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 09:40:06 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:52941 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965829AbaFTNkE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jun 2014 09:40:04 -0400
X-AuditID: 1207440e-f79026d000000c25-be-53a439b3f1d0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 73.A0.03109.3B934A35; Fri, 20 Jun 2014 09:40:03 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96616.dip0.t-ipconnect.de [79.201.102.22])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5KDe2l3002532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 20 Jun 2014 09:40:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <53A258DA.3030903@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqLvZckmwwYWfFhaH5t5jt+i60s3k
	wOSxc9Zddo/Pm+QCmKK4bZISS8qCM9Pz9O0SuDNuNf1jK+jVqujbUNjAuFehi5GTQ0LAROLc
	1NesELaYxIV769lAbCGBy4wS27YEdzFyAdnnmSSmLzgHVsQroC2xZ+l09i5GDg4WAVWJq/0B
	IGE2AV2JRT3NTCC2qECQxOzP89ghygUlTs58wgJiiwiYSxzfMQssLiwQIbH+4FR2iF0BEo/O
	TGIGsTkFNCWOL9nFAjJeQkBcoqcxCCTMLKAj8a7vATOELS+x/e0c5gmMArOQbJiFpGwWkrIF
	jMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9XIzS/RSU0o3MUJClG8HY/t6mUOMAhyMSjy8
	naaLg4VYE8uKK3MPMUpyMCmJ8rrrLAkW4kvKT6nMSCzOiC8qzUktPsQowcGsJMJ7SxYox5uS
	WFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4OUExqKQYFFqempFWmZOCUKa
	iYMTZDiXlEhxal5KalFiaUlGPChG44uBUQqS4gHaqwDSzltckJgLFIVoPcWoy3HqzrE2JiGW
	vPy8VClx3mYLoCIBkKKM0jy4FbCE9IpRHOhjYV4VkFE8wGQGN+kV0BImoCWLexaBLClJREhJ
	NTB2KFyae2fJqcmMm9bXZMtlTNkrscKfRXrRDp25uk3u1rW6Pw5y1p2tfPk4OvzTiVuJFuu/
	+2esaO31vnyL+491f3Te9YabgXbPth97e8BE+0ndx8jlGRYOG9s0udVs1r4P3J6p 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252224>

On 06/19/2014 05:28 AM, Fabian Ruch wrote:
> `pick_one` and `pick_one_preserving_merges` are wrappers around
> `cherry-pick` in `rebase --interactive`. They take the hash of a commit
> and build a `cherry-pick` command line that
> 
>  - respects the user-supplied merge options
>  - disables complaints about empty commits
>  - tries to fast-forward the rebase head unless rebase is forced
>  - suppresses output unless the user requested higher verbosity
>  - rewrites merge commits to point to their rebased parents.
> 
> `pick_one` is used to implement not only `pick` but also `squash`, which
> amends the previous commit rather than creating a new one. When
> `pick_one` is called from `squash`, it receives a second argument `-n`.
> This tells `pick_one` to apply the changes to the index without
> committing them. Since the argument is almost directly passed to
> `cherry-pick`, we might want to do the same with other `cherry-pick`
> options. Currently, `pick_one` expects `-n` to be the first and only
> argument except for the commit hash.
> 
> Prepare `pick_one` for additional `cherry-pick` options by allowing `-n`
> to appear anywhere before the commit hash in the argument list. Loop
> over the argument list and pop each handled item until the commit hash
> is the only parameter left on the list. If an option is not supported,
> ignore it and issue a warning on the console. Construct a new arguments
> list `extra_args` of recognized options that shall be passed to
> `cherry-pick` on the command line.
> 
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---
>  git-rebase--interactive.sh | 61 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 45 insertions(+), 16 deletions(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index f267d8b..ea5514e 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -237,8 +237,26 @@ git_sequence_editor () {
>  
>  pick_one () {
>  	ff=--ff
> +	extra_args=
> +	while test $# -gt 0
> +	do
> +		case "$1" in
> +		-n)
> +			ff=
> +			extra_args="$extra_args -n"
> +			;;
> +		-*)
> +			warn "pick_one: ignored option -- $1"
> +			;;

This is an internal interface, right?  I.e., user input isn't being
processed here?  If so, then the presence of an unrecognized option is a
bug and it is preferable to "die" here rather than "warn".

The same below and in at least one later commit.

> +		*)
> +			break
> +			;;
> +		esac
> +		shift
> +	done
> +	test $# -ne 1 && die "pick_one: wrong number of arguments"
> +	sha1=$1
>  
> -	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
>  	case "$force_rebase" in '') ;; ?*) ff= ;; esac
>  	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
>  
> @@ -248,24 +266,35 @@ pick_one () {
>  	fi
>  
>  	test -d "$rewritten" &&
> -		pick_one_preserving_merges "$@" && return
> +		pick_one_preserving_merges $extra_args $sha1 && return
>  	output eval git cherry-pick \
>  			${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
> -			"$strategy_args" $empty_args $ff "$@"
> +			"$strategy_args" $empty_args $ff $extra_args $sha1
>  }

It might be confusing that extra_args is used both in pick_one and in
pick_one_preserving_merges.  Since these are not local variables, the
call to the latter changes the value of the variable in the former.  I
don't know if that could be a problem now (can
pick_one_preserving_merges return with a nonzero exit code?) but even if
not, it is a trap for future developers.  I recommend giving the two
variables different names.

>  pick_one_preserving_merges () {
>  	fast_forward=t
> -	case "$1" in
> -	-n)
> -		fast_forward=f
> -		sha1=$2
> -		;;
> -	*)
> -		sha1=$1
> -		;;
> -	esac
> -	sha1=$(git rev-parse $sha1)
> +	no_commit=
> +	extra_args=
> +	while test $# -gt 0
> +	do
> +		case "$1" in
> +		-n)
> +			fast_forward=f
> +			extra_args="$extra_args -n"
> +			no_commit=y
> +			;;
> +		-*)
> +			warn "pick_one_preserving_merges: ignored option -- $1"
> +			;;
> +		*)
> +			break
> +			;;
> +		esac
> +		shift
> +	done
> +	test $# -ne 1 && die "pick_one_preserving_merges: wrong number of arguments"
> +	sha1=$(git rev-parse $1)
>  
>  	if test -f "$state_dir"/current-commit
>  	then
> @@ -335,7 +364,7 @@ pick_one_preserving_merges () {
>  	f)
>  		first_parent=$(expr "$new_parents" : ' \([^ ]*\)')
>  
> -		if [ "$1" != "-n" ]
> +		if test -z "$no_commit"
>  		then
>  			# detach HEAD to current parent
>  			output git checkout $first_parent 2> /dev/null ||
> @@ -344,7 +373,7 @@ pick_one_preserving_merges () {
>  
>  		case "$new_parents" in
>  		' '*' '*)
> -			test "a$1" = a-n && die "Refusing to squash a merge: $sha1"
> +			test -n "$no_commit" && die "Refusing to squash a merge: $sha1"
>  
>  			# redo merge
>  			author_script_content=$(get_author_ident_from_commit $sha1)
> @@ -365,7 +394,7 @@ pick_one_preserving_merges () {
>  		*)
>  			output eval git cherry-pick \
>  				${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
> -				"$strategy_args" "$@" ||
> +				"$strategy_args" $extra_args $sha1 ||
>  				die_with_patch $sha1 "Could not pick $sha1"
>  			;;
>  		esac
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
