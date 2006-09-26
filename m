From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH 3/3] update a few Porcelain-ish for ref lock safety.
Date: Tue, 26 Sep 2006 19:08:43 +0100
Message-ID: <45196CAB.6030903@shadowen.org>
References: <20060918065429.6f4de06e.chriscool@tuxfamily.org>	<200609231322.30214.chriscool@tuxfamily.org>	<7veju2nthl.fsf@assigned-by-dhcp.cox.net>	<200609240645.54467.chriscool@tuxfamily.org>	<7vmz8o1em0.fsf_-_@assigned-by-dhcp.cox.net> <7vu02uqzaj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 20:09:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSHMm-0003D7-I7
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 20:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWIZSJJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 14:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWIZSJJ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 14:09:09 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:40196 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932392AbWIZSJI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 14:09:08 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GSHME-0006bf-8l; Tue, 26 Sep 2006 19:08:38 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu02uqzaj.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27806>

Junio C Hamano wrote:
> This updates the use of git-update-ref in git-branch, git-tag
> and git-commit to make them safer in a few corner cases as
> demonstration.
> 
>  - git-tag makes sure that the named tag does not exist, allows
>    you to edit tag message and then creates the tag.  If a tag
>    with the same name was created by somebody else in the
>    meantime, it used to happily overwrote it.  Now it notices
>    the situation.
> 
>  - git-branch -d and git-commit (for the initial commit) had the
>    same issue but with smaller race window, which is plugged
>    with this.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> 
>  * Obviously I would need to update this on top of Linus's
>    packed-refs, but this 3-patch series applies on top of the
>    current "master". 
> 
>  git-branch.sh |    9 ++++++---
>  git-commit.sh |    2 +-
>  git-tag.sh    |    9 ++++++---
>  3 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/git-branch.sh b/git-branch.sh
> index e0501ec..2b58d20 100755
> --- a/git-branch.sh
> +++ b/git-branch.sh
> @@ -42,8 +42,7 @@ If you are sure you want to delete it, r
>  	    esac
>  	    ;;
>  	esac
> -	rm -f "$GIT_DIR/logs/refs/heads/$branch_name"
> -	rm -f "$GIT_DIR/refs/heads/$branch_name"
> +	git update-ref -d "refs/heads/$branch_name" "$branch"
>  	echo "Deleted branch $branch_name."
>      done
>      exit 0
> @@ -112,6 +111,7 @@ rev=$(git-rev-parse --verify "$head") ||
>  git-check-ref-format "heads/$branchname" ||
>  	die "we do not like '$branchname' as a branch name."
>  
> +prev=0000000000000000000000000000000000000000
>  if [ -e "$GIT_DIR/refs/heads/$branchname" ]
>  then
>  	if test '' = "$force"
> @@ -121,10 +121,13 @@ then
>  	then
>  		die "cannot force-update the current branch."
>  	fi
> +	prev=`git rev-parse --verify "refs/heads/$branchname"`
>  fi
>  if test "$create_log" = 'yes'
>  then
>  	mkdir -p $(dirname "$GIT_DIR/logs/refs/heads/$branchname")
>  	touch "$GIT_DIR/logs/refs/heads/$branchname"
>  fi
> -git update-ref -m "branch: Created from $head" "refs/heads/$branchname" $rev
> +git update-ref -m "branch: Created from $head" \
> +	"refs/heads/$branchname" $rev $prev
> +
> diff --git a/git-commit.sh b/git-commit.sh
> index 5a4c659..87b13ef 100755
> --- a/git-commit.sh
> +++ b/git-commit.sh
> @@ -554,8 +554,8 @@ else
>  		exit 1
>  	fi
>  	PARENTS=""
> -	current=
>  	rloga='commit (initial)'
> +	current=0000000000000000000000000000000000000000
>  fi
>  
>  if test -z "$no_edit"
> diff --git a/git-tag.sh b/git-tag.sh
> index a0afa25..2bde3c0 100755
> --- a/git-tag.sh
> +++ b/git-tag.sh
> @@ -63,8 +63,11 @@ done
>  
>  name="$1"
>  [ "$name" ] || usage
> -if [ -e "$GIT_DIR/refs/tags/$name" -a -z "$force" ]; then
> -    die "tag '$name' already exists"
> +prev=0000000000000000000000000000000000000000

It seems a little odd to need to use such a large 'none' thing.  Will
linus' updates start returning this when there is no tag?  If so then it
makes sense.  Else perhaps it would be nice to have a short cut for it.
 Such as 'none'.

-apw
