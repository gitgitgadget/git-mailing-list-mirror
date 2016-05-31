From: Mathias Nyman <m.nyman@iki.fi>
Subject: Re: [PATCH] contrib/subtree: add repo url to commit messages
Date: Tue, 31 May 2016 15:19:20 +0300
Message-ID: <20160531121920.GA8180@iki.fi>
References: <20160223102559.GA18668@iki.fi>
 <87twhrowh0.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org, gitster@pobox.com, npaolucci@atlassian.com
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue May 31 14:19:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7idt-00033U-H4
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 14:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbcEaMTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 08:19:25 -0400
Received: from mail.kapsi.fi ([217.30.184.167]:51831 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484AbcEaMTY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 08:19:24 -0400
Received: from lakka.kapsi.fi ([2001:1bc8:1004::1] ident=Debian-exim)
	by mail.kapsi.fi with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <lem@kapsi.fi>)
	id 1b7idk-0003aU-MU; Tue, 31 May 2016 15:19:20 +0300
Received: from lem by lakka.kapsi.fi with local (Exim 4.84_2)
	(envelope-from <lem@lakka.kapsi.fi>)
	id 1b7idk-0006z2-Kz; Tue, 31 May 2016 15:19:20 +0300
Content-Disposition: inline
In-Reply-To: <87twhrowh0.fsf@waller.obbligato.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 2001:1bc8:1004::1
X-SA-Exim-Mail-From: lem@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295971>

On 2016-05-21 17:52-0500, David A. Greene wrote:
>Mathias Nyman <mathias.nyman@iki.fi> writes:
>
>> For recalling where a subtree came from; git-subtree operations 'add'
>> and 'pull', when called with the <repository> parameter add this to the
>> commit message:
>>     git-subtree-repo: <repo_url>
>
>I am sorry it tooks a couple of months to respond.  I am finally coming
>up for air at work.
>
>What is the future intent of this?  I've toyed with the idea of adding
>something like this either as commit message metadata or in .gitconfig
>but every time I get ready to pull the trigger, I question what it will
>be used for.
>
>Having been using git-subtree in anger for a couple of years now, I
>frequently pull subtree updates from multiple sources, so noting a
>particular repository is not only mostly meaningless, it may actually be
>misleading in that a quick perusal of the logs may lead one to think
>commits were draw from fewer places than they actually were.
>
>I don't think it would be a good idea, for example, to have git-subtree
>use this information to auto-guess from where to pull future commits.
>Again, I think that would be misleading behavior.
>
>                         -David
>

I don't have future features in mind which would build upon this.

For me this would be very helpful for identifying where to pull in
updates from; I'm specifically thinking of the use case where
git-subtree is used for managing third party dependencies. In
particular when you want to bump versions, it would be convenient to
have the history in the history :). So, having git-subtree
automatically document that in the commit message seemed like a good
idea to me.


:Mathias

>> Other operations that don't have the <repository> information, like
>> 'merge' and 'add' without <repository>, are unchanged. Users with such a
>> workflow will continue to be on their own with the --message parameter,
>> if they'd like to record where the subtree came from.
>>
>> Signed-off-by: Mathias Nyman <mathias.nyman@iki.fi>
>> Based-on-patch-by: Nicola Paolucci <npaolucci@atlassian.com>
>> ---
>>  contrib/subtree/git-subtree.sh | 73 ++++++++++++++++++++++++++++--------------
>>  1 file changed, 49 insertions(+), 24 deletions(-)
>>
>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
>> index 7a39b30..7cf73c0 100755
>> --- a/contrib/subtree/git-subtree.sh
>> +++ b/contrib/subtree/git-subtree.sh
>> @@ -335,18 +335,21 @@ add_msg()
>>  	dir="$1"
>>  	latest_old="$2"
>>  	latest_new="$3"
>> +	repo="$4" # optional
>>  	if [ -n "$message" ]; then
>>  		commit_message="$message"
>>  	else
>>  		commit_message="Add '$dir/' from commit '$latest_new'"
>>  	fi
>> -	cat <<-EOF
>> -		$commit_message
>> -		
>> -		git-subtree-dir: $dir
>> -		git-subtree-mainline: $latest_old
>> -		git-subtree-split: $latest_new
>> -	EOF
>> +	echo $commit_message
>> +	echo
>> +	echo git-subtree-dir: $dir
>> +	echo git-subtree-mainline: $latest_old
>> +	echo git-subtree-split: $latest_new
>> +	if [ -n "$repo" ]; then
>> +		repo_url=$(get_repository_url "$repo")
>> +		echo "git-subtree-repo: $repo_url"
>> +	fi
>>  }
>>
>>  add_squashed_msg()
>> @@ -382,8 +385,9 @@ squash_msg()
>>  	dir="$1"
>>  	oldsub="$2"
>>  	newsub="$3"
>> +	repo="$4" # optional
>>  	newsub_short=$(git rev-parse --short "$newsub")
>> -	
>> +
>>  	if [ -n "$oldsub" ]; then
>>  		oldsub_short=$(git rev-parse --short "$oldsub")
>>  		echo "Squashed '$dir/' changes from $oldsub_short..$newsub_short"
>> @@ -397,6 +401,10 @@ squash_msg()
>>  	echo
>>  	echo "git-subtree-dir: $dir"
>>  	echo "git-subtree-split: $newsub"
>> +	if [ -n "$repo" ]; then
>> +		repo_url=$(get_repository_url "$repo")
>> +		echo "git-subtree-repo: $repo_url"
>> +	fi
>>  }
>>
>>  toptree_for_commit()
>> @@ -440,12 +448,13 @@ new_squash_commit()
>>  	old="$1"
>>  	oldsub="$2"
>>  	newsub="$3"
>> +	repo="$4" # optional
>>  	tree=$(toptree_for_commit $newsub) || exit $?
>>  	if [ -n "$old" ]; then
>> -		squash_msg "$dir" "$oldsub" "$newsub" |
>> +		squash_msg "$dir" "$oldsub" "$newsub" "$repo" |
>>  			git commit-tree "$tree" -p "$old" || exit $?
>>  	else
>> -		squash_msg "$dir" "" "$newsub" |
>> +		squash_msg "$dir" "" "$newsub" "$repo" |
>>  			git commit-tree "$tree" || exit $?
>>  	fi
>>  }
>> @@ -517,6 +526,16 @@ ensure_valid_ref_format()
>>  	    die "'$1' does not look like a ref"
>>  }
>>
>> +get_repository_url()
>> +{
>> +	repo=$1
>> +	repo_url=$(git config --get remote.$repo.url)
>> +	if [ -z "$repo_url" ]; then
>> +		repo_url=$repo
>> +	fi
>> +	echo $repo_url
>> +}
>> +
>>  cmd_add()
>>  {
>>  	if [ -e "$dir" ]; then
>> @@ -548,19 +567,18 @@ cmd_add()
>>  cmd_add_repository()
>>  {
>>  	echo "git fetch" "$@"
>> -	repository=$1
>> +	repo=$1
>>  	refspec=$2
>>  	git fetch "$@" || exit $?
>>  	revs=FETCH_HEAD
>> -	set -- $revs
>> +	set -- $revs $repo
>>  	cmd_add_commit "$@"
>>  }
>>
>>  cmd_add_commit()
>>  {
>> -	revs=$(git rev-parse $default --revs-only "$@") || exit $?
>> -	set -- $revs
>> -	rev="$1"
>> +	rev=$(git rev-parse $default --revs-only "$1") || exit $?
>> +	repo="$2" # optional
>>  	
>>  	debug "Adding $dir as '$rev'..."
>>  	git read-tree --prefix="$dir" $rev || exit $?
>> @@ -575,12 +593,12 @@ cmd_add_commit()
>>  	fi
>>  	
>>  	if [ -n "$squash" ]; then
>> -		rev=$(new_squash_commit "" "" "$rev") || exit $?
>> +		rev=$(new_squash_commit "" "" "$rev" "$repo") || exit $?
>>  		commit=$(add_squashed_msg "$rev" "$dir" |
>>  			 git commit-tree $tree $headp -p "$rev") || exit $?
>>  	else
>>  		revp=$(peel_committish "$rev") &&
>> -		commit=$(add_msg "$dir" "$headrev" "$rev" |
>> +		commit=$(add_msg "$dir" "$headrev" "$rev" "$repo" |
>>  			 git commit-tree $tree $headp -p "$revp") || exit $?
>>  	fi
>>  	git reset "$commit" || exit $?
>> @@ -609,7 +627,8 @@ cmd_split()
>>  	else
>>  		unrevs="$(find_existing_splits "$dir" "$revs")"
>>  	fi
>> -	
>> +e
>> +	rev="$1"
>>  	# We can't restrict rev-list to only $dir here, because some of our
>>  	# parents have the $dir contents the root, and those won't match.
>>  	# (and rev-list --follow doesn't seem to solve this)
>> @@ -683,15 +702,20 @@ cmd_split()
>>
>>  cmd_merge()
>>  {
>> -	revs=$(git rev-parse $default --revs-only "$@") || exit $?
>> +	revs=$(git rev-parse $default --revs-only "$1") || exit $?
>>  	ensure_clean
>> -	
>>  	set -- $revs
>>  	if [ $# -ne 1 ]; then
>>  		die "You must provide exactly one revision.  Got: '$revs'"
>>  	fi
>> +	do_merge "$@"
>> +}
>> +
>> +do_merge()
>> +{
>>  	rev="$1"
>> -	
>> +	repo="$2" # optional
>> +
>>  	if [ -n "$squash" ]; then
>>  		first_split="$(find_latest_squash "$dir")"
>>  		if [ -z "$first_split" ]; then
>> @@ -704,7 +728,7 @@ cmd_merge()
>>  			say "Subtree is already at commit $rev."
>>  			exit 0
>>  		fi
>> -		new=$(new_squash_commit "$old" "$sub" "$rev") || exit $?
>> +		new=$(new_squash_commit "$old" "$sub" "$rev" "$repo") || exit $?
>>  		debug "New squash commit: $new"
>>  		rev="$new"
>>  	fi
>> @@ -730,12 +754,13 @@ cmd_pull()
>>  	if [ $# -ne 2 ]; then
>>  	    die "You must provide <repository> <ref>"
>>  	fi
>> +	repo=$1
>>  	ensure_clean
>>  	ensure_valid_ref_format "$2"
>>  	git fetch "$@" || exit $?
>>  	revs=FETCH_HEAD
>> -	set -- $revs
>> -	cmd_merge "$@"
>> +	set -- $revs $repo
>> +	do_merge "$@"
>>  }
>>
>>  cmd_push()
