From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH] contrib/subtree: add repo url to commit messages
Date: Sat, 21 May 2016 17:52:11 -0500
Message-ID: <87twhrowh0.fsf@waller.obbligato.org>
References: <20160223102559.GA18668@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, npaolucci@atlassian.com
To: Mathias Nyman <mathias.nyman@iki.fi>
X-From: git-owner@vger.kernel.org Sun May 22 01:29:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4GLH-0005Fi-6B
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 01:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbcEUX3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2016 19:29:40 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:57884 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751974AbcEUX3g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 19:29:36 -0400
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.86)
	(envelope-from <greened@obbligato.org>)
	id 1b4Fki-0004BE-U9; Sat, 21 May 2016 17:52:13 -0500
In-Reply-To: <20160223102559.GA18668@iki.fi> (Mathias Nyman's message of "Tue,
	23 Feb 2016 12:25:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295252>

Mathias Nyman <mathias.nyman@iki.fi> writes:

> For recalling where a subtree came from; git-subtree operations 'add'
> and 'pull', when called with the <repository> parameter add this to the
> commit message:
>     git-subtree-repo: <repo_url>

I am sorry it tooks a couple of months to respond.  I am finally coming
up for air at work.

What is the future intent of this?  I've toyed with the idea of adding
something like this either as commit message metadata or in .gitconfig
but every time I get ready to pull the trigger, I question what it will
be used for.

Having been using git-subtree in anger for a couple of years now, I
frequently pull subtree updates from multiple sources, so noting a
particular repository is not only mostly meaningless, it may actually be
misleading in that a quick perusal of the logs may lead one to think
commits were draw from fewer places than they actually were.

I don't think it would be a good idea, for example, to have git-subtree
use this information to auto-guess from where to pull future commits.
Again, I think that would be misleading behavior.

                         -David

> Other operations that don't have the <repository> information, like
> 'merge' and 'add' without <repository>, are unchanged. Users with such a
> workflow will continue to be on their own with the --message parameter,
> if they'd like to record where the subtree came from.
>
> Signed-off-by: Mathias Nyman <mathias.nyman@iki.fi>
> Based-on-patch-by: Nicola Paolucci <npaolucci@atlassian.com>
> ---
>  contrib/subtree/git-subtree.sh | 73 ++++++++++++++++++++++++++++--------------
>  1 file changed, 49 insertions(+), 24 deletions(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 7a39b30..7cf73c0 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -335,18 +335,21 @@ add_msg()
>  	dir="$1"
>  	latest_old="$2"
>  	latest_new="$3"
> +	repo="$4" # optional
>  	if [ -n "$message" ]; then
>  		commit_message="$message"
>  	else
>  		commit_message="Add '$dir/' from commit '$latest_new'"
>  	fi
> -	cat <<-EOF
> -		$commit_message
> -		
> -		git-subtree-dir: $dir
> -		git-subtree-mainline: $latest_old
> -		git-subtree-split: $latest_new
> -	EOF
> +	echo $commit_message
> +	echo
> +	echo git-subtree-dir: $dir
> +	echo git-subtree-mainline: $latest_old
> +	echo git-subtree-split: $latest_new
> +	if [ -n "$repo" ]; then
> +		repo_url=$(get_repository_url "$repo")
> +		echo "git-subtree-repo: $repo_url"
> +	fi
>  }
>  
>  add_squashed_msg()
> @@ -382,8 +385,9 @@ squash_msg()
>  	dir="$1"
>  	oldsub="$2"
>  	newsub="$3"
> +	repo="$4" # optional
>  	newsub_short=$(git rev-parse --short "$newsub")
> -	
> +
>  	if [ -n "$oldsub" ]; then
>  		oldsub_short=$(git rev-parse --short "$oldsub")
>  		echo "Squashed '$dir/' changes from $oldsub_short..$newsub_short"
> @@ -397,6 +401,10 @@ squash_msg()
>  	echo
>  	echo "git-subtree-dir: $dir"
>  	echo "git-subtree-split: $newsub"
> +	if [ -n "$repo" ]; then
> +		repo_url=$(get_repository_url "$repo")
> +		echo "git-subtree-repo: $repo_url"
> +	fi
>  }
>  
>  toptree_for_commit()
> @@ -440,12 +448,13 @@ new_squash_commit()
>  	old="$1"
>  	oldsub="$2"
>  	newsub="$3"
> +	repo="$4" # optional
>  	tree=$(toptree_for_commit $newsub) || exit $?
>  	if [ -n "$old" ]; then
> -		squash_msg "$dir" "$oldsub" "$newsub" | 
> +		squash_msg "$dir" "$oldsub" "$newsub" "$repo" |
>  			git commit-tree "$tree" -p "$old" || exit $?
>  	else
> -		squash_msg "$dir" "" "$newsub" |
> +		squash_msg "$dir" "" "$newsub" "$repo" |
>  			git commit-tree "$tree" || exit $?
>  	fi
>  }
> @@ -517,6 +526,16 @@ ensure_valid_ref_format()
>  	    die "'$1' does not look like a ref"
>  }
>  
> +get_repository_url()
> +{
> +	repo=$1
> +	repo_url=$(git config --get remote.$repo.url)
> +	if [ -z "$repo_url" ]; then
> +		repo_url=$repo
> +	fi
> +	echo $repo_url
> +}
> +
>  cmd_add()
>  {
>  	if [ -e "$dir" ]; then
> @@ -548,19 +567,18 @@ cmd_add()
>  cmd_add_repository()
>  {
>  	echo "git fetch" "$@"
> -	repository=$1
> +	repo=$1
>  	refspec=$2
>  	git fetch "$@" || exit $?
>  	revs=FETCH_HEAD
> -	set -- $revs
> +	set -- $revs $repo
>  	cmd_add_commit "$@"
>  }
>  
>  cmd_add_commit()
>  {
> -	revs=$(git rev-parse $default --revs-only "$@") || exit $?
> -	set -- $revs
> -	rev="$1"
> +	rev=$(git rev-parse $default --revs-only "$1") || exit $?
> +	repo="$2" # optional
>  	
>  	debug "Adding $dir as '$rev'..."
>  	git read-tree --prefix="$dir" $rev || exit $?
> @@ -575,12 +593,12 @@ cmd_add_commit()
>  	fi
>  	
>  	if [ -n "$squash" ]; then
> -		rev=$(new_squash_commit "" "" "$rev") || exit $?
> +		rev=$(new_squash_commit "" "" "$rev" "$repo") || exit $?
>  		commit=$(add_squashed_msg "$rev" "$dir" |
>  			 git commit-tree $tree $headp -p "$rev") || exit $?
>  	else
>  		revp=$(peel_committish "$rev") &&
> -		commit=$(add_msg "$dir" "$headrev" "$rev" |
> +		commit=$(add_msg "$dir" "$headrev" "$rev" "$repo" |
>  			 git commit-tree $tree $headp -p "$revp") || exit $?
>  	fi
>  	git reset "$commit" || exit $?
> @@ -609,7 +627,8 @@ cmd_split()
>  	else
>  		unrevs="$(find_existing_splits "$dir" "$revs")"
>  	fi
> -	
> +e
> +	rev="$1"
>  	# We can't restrict rev-list to only $dir here, because some of our
>  	# parents have the $dir contents the root, and those won't match.
>  	# (and rev-list --follow doesn't seem to solve this)
> @@ -683,15 +702,20 @@ cmd_split()
>  
>  cmd_merge()
>  {
> -	revs=$(git rev-parse $default --revs-only "$@") || exit $?
> +	revs=$(git rev-parse $default --revs-only "$1") || exit $?
>  	ensure_clean
> -	
>  	set -- $revs
>  	if [ $# -ne 1 ]; then
>  		die "You must provide exactly one revision.  Got: '$revs'"
>  	fi
> +	do_merge "$@"
> +}
> +
> +do_merge()
> +{
>  	rev="$1"
> -	
> +	repo="$2" # optional
> +
>  	if [ -n "$squash" ]; then
>  		first_split="$(find_latest_squash "$dir")"
>  		if [ -z "$first_split" ]; then
> @@ -704,7 +728,7 @@ cmd_merge()
>  			say "Subtree is already at commit $rev."
>  			exit 0
>  		fi
> -		new=$(new_squash_commit "$old" "$sub" "$rev") || exit $?
> +		new=$(new_squash_commit "$old" "$sub" "$rev" "$repo") || exit $?
>  		debug "New squash commit: $new"
>  		rev="$new"
>  	fi
> @@ -730,12 +754,13 @@ cmd_pull()
>  	if [ $# -ne 2 ]; then
>  	    die "You must provide <repository> <ref>"
>  	fi
> +	repo=$1
>  	ensure_clean
>  	ensure_valid_ref_format "$2"
>  	git fetch "$@" || exit $?
>  	revs=FETCH_HEAD
> -	set -- $revs
> -	cmd_merge "$@"
> +	set -- $revs $repo
> +	do_merge "$@"
>  }
>  
>  cmd_push()
