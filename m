From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [RFC PATCH 1/7] rebase -i: Make option handling in pick_one more
 flexible
Date: Sun, 22 Jun 2014 01:21:30 +0200
Message-ID: <53A6137A.7040803@gmail.com>
References: <cover.1403146774.git.bafain@gmail.com> <53A258DA.3030903@gmail.com> <53A439B2.7000106@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 01:21:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WyUbM-0007hD-Hq
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jun 2014 01:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbaFUXVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2014 19:21:35 -0400
Received: from mail-we0-f178.google.com ([74.125.82.178]:59999 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbaFUXVd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2014 19:21:33 -0400
Received: by mail-we0-f178.google.com with SMTP id x48so5205954wes.37
        for <git@vger.kernel.org>; Sat, 21 Jun 2014 16:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=nxgvqhte8aO1vPifk7RQYFZRjtVxJyBa/CUiwvOayDI=;
        b=Asy9+9vXglCWotAbZyI7gv/YoNhoBkKvO0JXPLyrX3WL3kS+TArWURiQe9XgCxbImX
         dR3LXRPWre1HcjSUWSPzKDa3D+vAq6PBjqoq12bj3D5OLESopUOQRO2BXyNvOu0J6eyb
         ieBn5OI08l8V49MSrLKhaW++XG77WIAk6HMUz1w3DhYes+h4uWnwq+VYpimBQm1YdZO+
         Fkbo0UOGgIUZeSCSS2ve6rkM0IhmFa3pn4ka/VWtZqICw5BTlQeWJJizQQaOECebhLF1
         cDWCmoKYxkhQFSIWil5XkfSCKckD/T1uwnWYJ8qRqZd5OguEX60i1xtMNU9FPiQSt+oD
         /gbg==
X-Received: by 10.180.91.81 with SMTP id cc17mr14379388wib.17.1403392892459;
        Sat, 21 Jun 2014 16:21:32 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id gp15sm25276090wjc.10.2014.06.21.16.21.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Jun 2014 16:21:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53A439B2.7000106@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252302>

Hi Michael,

On 06/20/2014 03:40 PM, Michael Haggerty wrote:
> On 06/19/2014 05:28 AM, Fabian Ruch wrote:
>> `pick_one` and `pick_one_preserving_merges` are wrappers around
>> `cherry-pick` in `rebase --interactive`. They take the hash of a commit
>> and build a `cherry-pick` command line that
>>
>>  - respects the user-supplied merge options
>>  - disables complaints about empty commits
>>  - tries to fast-forward the rebase head unless rebase is forced
>>  - suppresses output unless the user requested higher verbosity
>>  - rewrites merge commits to point to their rebased parents.
>>
>> `pick_one` is used to implement not only `pick` but also `squash`, which
>> amends the previous commit rather than creating a new one. When
>> `pick_one` is called from `squash`, it receives a second argument `-n`.
>> This tells `pick_one` to apply the changes to the index without
>> committing them. Since the argument is almost directly passed to
>> `cherry-pick`, we might want to do the same with other `cherry-pick`
>> options. Currently, `pick_one` expects `-n` to be the first and only
>> argument except for the commit hash.
>>
>> Prepare `pick_one` for additional `cherry-pick` options by allowing `-n`
>> to appear anywhere before the commit hash in the argument list. Loop
>> over the argument list and pop each handled item until the commit hash
>> is the only parameter left on the list. If an option is not supported,
>> ignore it and issue a warning on the console. Construct a new arguments
>> list `extra_args` of recognized options that shall be passed to
>> `cherry-pick` on the command line.
>>
>> Signed-off-by: Fabian Ruch <bafain@gmail.com>
>> ---
>>  git-rebase--interactive.sh | 61 ++++++++++++++++++++++++++++++++++------------
>>  1 file changed, 45 insertions(+), 16 deletions(-)
>>
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index f267d8b..ea5514e 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -237,8 +237,26 @@ git_sequence_editor () {
>>  
>>  pick_one () {
>>  	ff=--ff
>> +	extra_args=
>> +	while test $# -gt 0
>> +	do
>> +		case "$1" in
>> +		-n)
>> +			ff=
>> +			extra_args="$extra_args -n"
>> +			;;
>> +		-*)
>> +			warn "pick_one: ignored option -- $1"
>> +			;;
> 
> This is an internal interface, right?  I.e., user input isn't being
> processed here?  If so, then the presence of an unrecognized option is a
> bug and it is preferable to "die" here rather than "warn".
> 
> The same below and in at least one later commit.

Ok.

>> +		*)
>> +			break
>> +			;;
>> +		esac
>> +		shift
>> +	done
>> +	test $# -ne 1 && die "pick_one: wrong number of arguments"
>> +	sha1=$1
>>  
>> -	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
>>  	case "$force_rebase" in '') ;; ?*) ff= ;; esac
>>  	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
>>  
>> @@ -248,24 +266,35 @@ pick_one () {
>>  	fi
>>  
>>  	test -d "$rewritten" &&
>> -		pick_one_preserving_merges "$@" && return
>> +		pick_one_preserving_merges $extra_args $sha1 && return
>>  	output eval git cherry-pick \
>>  			${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
>> -			"$strategy_args" $empty_args $ff "$@"
>> +			"$strategy_args" $empty_args $ff $extra_args $sha1
>>  }
> 
> It might be confusing that extra_args is used both in pick_one and in
> pick_one_preserving_merges.  Since these are not local variables, the
> call to the latter changes the value of the variable in the former.  I
> don't know if that could be a problem now (can
> pick_one_preserving_merges return with a nonzero exit code?) but even if
> not, it is a trap for future developers.  I recommend giving the two
> variables different names.

Please correct me if I missed something. At the moment (786a89d),
pick_one_preserving_merges will not and cannot return with a non-zero
exit code because it doesn't explicitly return and all possibly failing
last statements are guarded with a ... || die "...". Since this can only
be established by carefully looking at the code, I will change the reuse
of extra_args.

Now that we're at it, what I didn't understand when creating this patch
was why the code doesn't explicitly say "one or the other" in the first
place:

> if test -d "$rewritten"
> then
> 	pick_one_preserving_merges "$@"
> else
> 	output eval git cherry-pick \
> 			${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
> 			"$strategy_args" $empty_args $ff "$@"
> fi

At least that is how I interpreted it. After all, if
pick_one_preserving_merges failed to recreate a merge commit, wouldn't
it be a bug to record the changes in a single-parent commit?

Johannes, I cc'd you this email since you're the author of f09c9b8 -
"Teach rebase -i about --preserve-merges". I hope you don't resent me
digging out this seven-year-old patch.

   Fabian

>>  pick_one_preserving_merges () {
>>  	fast_forward=t
>> -	case "$1" in
>> -	-n)
>> -		fast_forward=f
>> -		sha1=$2
>> -		;;
>> -	*)
>> -		sha1=$1
>> -		;;
>> -	esac
>> -	sha1=$(git rev-parse $sha1)
>> +	no_commit=
>> +	extra_args=
>> +	while test $# -gt 0
>> +	do
>> +		case "$1" in
>> +		-n)
>> +			fast_forward=f
>> +			extra_args="$extra_args -n"
>> +			no_commit=y
>> +			;;
>> +		-*)
>> +			warn "pick_one_preserving_merges: ignored option -- $1"
>> +			;;
>> +		*)
>> +			break
>> +			;;
>> +		esac
>> +		shift
>> +	done
>> +	test $# -ne 1 && die "pick_one_preserving_merges: wrong number of arguments"
>> +	sha1=$(git rev-parse $1)
>>  
>>  	if test -f "$state_dir"/current-commit
>>  	then
>> @@ -335,7 +364,7 @@ pick_one_preserving_merges () {
>>  	f)
>>  		first_parent=$(expr "$new_parents" : ' \([^ ]*\)')
>>  
>> -		if [ "$1" != "-n" ]
>> +		if test -z "$no_commit"
>>  		then
>>  			# detach HEAD to current parent
>>  			output git checkout $first_parent 2> /dev/null ||
>> @@ -344,7 +373,7 @@ pick_one_preserving_merges () {
>>  
>>  		case "$new_parents" in
>>  		' '*' '*)
>> -			test "a$1" = a-n && die "Refusing to squash a merge: $sha1"
>> +			test -n "$no_commit" && die "Refusing to squash a merge: $sha1"
>>  
>>  			# redo merge
>>  			author_script_content=$(get_author_ident_from_commit $sha1)
>> @@ -365,7 +394,7 @@ pick_one_preserving_merges () {
>>  		*)
>>  			output eval git cherry-pick \
>>  				${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
>> -				"$strategy_args" "$@" ||
>> +				"$strategy_args" $extra_args $sha1 ||
>>  				die_with_patch $sha1 "Could not pick $sha1"
>>  			;;
>>  		esac
>>
