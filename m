From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH] git-branch -d <branch>: delete unused branch.
Date: Wed, 14 Sep 2005 10:54:46 -0400
Organization: Network Appliance, Inc.
Message-ID: <432839B6.2070103@citi.umich.edu>
References: <4326F2AE.50108@citi.umich.edu> <7vvf14ox39.fsf@assigned-by-dhcp.cox.net>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090209040401040400030703"
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 16:55:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFYew-0008V2-DP
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 16:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965220AbVINOys (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 10:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbVINOys
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 10:54:48 -0400
Received: from citi.umich.edu ([141.211.133.111]:46630 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S965220AbVINOyr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 10:54:47 -0400
Received: from [141.211.133.33] (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 915D31BACA;
	Wed, 14 Sep 2005 10:54:46 -0400 (EDT)
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf14ox39.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8527>

This is a multi-part message in MIME format.
--------------090209040401040400030703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

what if you want to throw away work in a branch even if it's not merged? 
  doesn't the safety check prevent that?

Junio C Hamano wrote:
> The new flag '-d' lets you delete a branch.  For safety, it does not
> lets you delete the branch you are currently on, nor a branch that
> has been fully merged into your current branch.
> 
> The credit for the safety check idea goes to Daniel Barkalow.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> ---
> 
>  git-branch.sh |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 files changed, 54 insertions(+), 6 deletions(-)
> 
> 6a714989f83ccb93188dc37791da8a0f2e32cabe
> diff --git a/git-branch.sh b/git-branch.sh
> --- a/git-branch.sh
> +++ b/git-branch.sh
> @@ -3,7 +3,7 @@
>  . git-sh-setup || die "Not a git archive"
>  
>  usage () {
> -    echo >&2 "usage: $(basename $0)"' [<branchname> [start-point]]
> +    echo >&2 "usage: $(basename $0)"' [-d <branch>] | [<branch> [start-point]]
>  
>  If no arguments, show available branches and mark current branch with a star.
>  If one argument, create a new branch <branchname> based off of current HEAD.
> @@ -12,6 +12,59 @@ If two arguments, create a new branch <b
>      exit 1
>  }
>  
> +delete_branch () {
> +    option="$1" branch_name="$2"
> +    headref=$(readlink "$GIT_DIR/HEAD" | sed -e 's|^refs/heads/||')
> +    case ",$headref," in
> +    ",$branch_name,")
> +	die "Cannot delete the branch you are on." ;;
> +    ,,)
> +	die "What branch are you on anyway?" ;;
> +    esac
> +    branch=$(cat "$GIT_DIR/refs/heads/$branch_name") &&
> +	branch=$(git-rev-parse --verify "$branch^0") ||
> +	    die "Seriously, what branch are you talking about?"
> +    case "$option" in
> +    -D)
> +	;;
> +    *)
> +	mbs=$(git-merge-base -a "$branch" HEAD | tr '\012' ' ')
> +	case " $mbs " in
> +	*' '$branch' '*)
> +	    # the merge base of branch and HEAD contains branch --
> +	    # which means that the HEAD contains everything in the HEAD.
> +	    ;;
> +	*)
> +	    echo >&2 "The branch '$branch_name' is not a strict subset of your current HEAD.
> +If you are sure you want to delete it, run 'git branch -D $branch_name'."
> +	    exit 1
> +	    ;;
> +	esac
> +	;;
> +    esac
> +    rm -f "$GIT_DIR/refs/heads/$branch_name"
> +    echo "Deleted branch $branch_name."
> +    exit 0
> +}
> +
> +while case "$#,$1" in 0,*) break ;; *,-*) ;; *) break ;; esac
> +do
> +	case "$1" in
> +	-d | -D)
> +		delete_branch "$1" "$2"
> +		exit
> +		;;
> +	--)
> +		shift
> +		break
> +		;;
> +	-*)
> +		usage
> +		;;
> +	esac
> +	shift
> +done
> +
>  case "$#" in
>  0)
>  	headref=$(readlink "$GIT_DIR/HEAD" | sed -e 's|^refs/heads/||')
> @@ -36,11 +89,6 @@ case "$#" in
>  esac
>  branchname="$1"
>  
> -case "$branchname" in
> --*)
> -	usage;;
> -esac
> -
>  rev=$(git-rev-parse --verify "$head") || exit
>  
>  [ -e "$GIT_DIR/refs/heads/$branchname" ] && die "$branchname already exists"
> 


--------------090209040401040400030703
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Linux NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763 4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668 1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------090209040401040400030703--
