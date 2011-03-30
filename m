From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule: Add --force option for git submodule update
Date: Wed, 30 Mar 2011 20:32:28 +0200
Message-ID: <4D93773C.2010807@web.de>
References: <4D92E225.3040602@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: devel-git@morey-chaisemartin.com
X-From: git-owner@vger.kernel.org Wed Mar 30 20:32:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q50C4-0007xA-MW
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 20:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755365Ab1C3Scb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 14:32:31 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:52465 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883Ab1C3Sca (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 14:32:30 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate03.web.de (Postfix) with ESMTP id E154618AC5214;
	Wed, 30 Mar 2011 20:32:28 +0200 (CEST)
Received: from [93.240.98.1] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q50Bw-0005cP-00; Wed, 30 Mar 2011 20:32:28 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <4D92E225.3040602@morey-chaisemartin.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19lIk9Apb2BgUIw/zZP9NCDLQI3BfAE2Nmiooje
	v6UqWZ1Mu2rOZNylKmZnT3mqAHo3SGfRYhdu8uPn//UYYveOFx
	nlrbHN45M16ChyXT+Efg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170400>

Am 30.03.2011 09:56, schrieb Nicolas Morey-Chaisemartin:
> By default git submodule update runs a simple checkout on submodules
> that are not up-to-date.
> If the submodules contains modified or untracked files, the command may
> exit sanely with an error:
> 
> $ git submodule update
> error: Your local changes to the following files would be overwritten by
> checkout:
> 	file
> Please, commit your changes or stash them before you can switch branches.
> Aborting
> Unable to checkout '1b69c6e55606b48d3284a3a9efe4b58bfb7e8c9e' in
> submodule path 'test1'
> 
> This implies that to reset a whole git submodule tree, a user has to run
> first 'git submodule foreach --recursive git checkout -f' to then be
> able to run git submodule update.
> 
> This patch adds a --force option for the update command (only used for
> submodules without --rebase or --merge options). It passes the --force
> option to git checkout which will throw away the local changes.
> Also when --force is specified, git checkout -f is always called on
> submodules whether their HEAD matches the reference or not.

I like where this is going (and it has tests too :-).

Maybe we can simplify the patch and simplify one of the tests (see below)
but apart from that I'm all for it.

> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
> ---
>  Documentation/git-submodule.txt |    5 ++-
>  git-submodule.sh                |   68 ++++++++++++++++++++------------------
>  t/t7406-submodule-update.sh     |   23 +++++++++++++
>  3 files changed, 62 insertions(+), 34 deletions(-)
> 
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 3a5aa01..6482a84 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -185,8 +185,9 @@ OPTIONS
>  
>  -f::
>  --force::
> -	This option is only valid for the add command.
> -	Allow adding an otherwise ignored submodule path.
> +	This option is only valid for add and update commands.
> +	When running add, allow adding an otherwise ignored submodule path.
> +	When running update, throw away local changes in submodules.
>  
>  --cached::
>  	This option is only valid for status and summary commands.  These
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 3a13397..a195879 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -8,7 +8,7 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
>  USAGE="[--quiet] add [-b branch] [-f|--force] [--reference <repository>] [--] <repository> [<path>]
>     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] init [--] [<path>...]
> -   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
> +   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
>     or: $dashless [--quiet] foreach [--recursive] <command>
>     or: $dashless [--quiet] sync [--] [<path>...]"
> @@ -385,6 +385,9 @@ cmd_update()
>  		-N|--no-fetch)
>  			nofetch=1
>  			;;
> +		-f | --force)
> +			force=$1
> +			;;
>  		-r|--rebase)
>  			update="rebase"
>  			;;

All looking good up to here. But I wonder if the rest of git-submodule.sh
could be changed a bit less invasive ... maybe as simple as this?

@@ -458,7 +461,6 @@ cmd_update()

 		if test "$subsha1" != "$sha1"
 		then
-			force=
 			if test -z "$subsha1"
 			then
 				force="-f"

Now force will not be cleared and thus contain "-f" if the user provided
it on the command line. All tests (including your new ones) are running
fine with this simplification ... am I missing something?

> @@ -430,6 +433,7 @@ cmd_update()
>  		name=$(module_name "$path") || exit
>  		url=$(git config submodule."$name".url)
>  		update_module=$(git config submodule."$name".update)
> +		force_checkout=
>  		if test -z "$url"
>  		then
>  			# Only mention uninitialized submodules when its
> @@ -456,13 +460,38 @@ cmd_update()
>  			update_module=$update
>  		fi
>  
> -		if test "$subsha1" != "$sha1"
> +		if test -z "$subsha1" -a -z "$force"
> +		then
> +		    force_checkout="-f"
> +		fi
> +
> +		# Is this something we just cloned?
> +		case ";$cloned_modules;" in
> +		    *";$name;"*)
> +			 # then there is no local change to integrate
> +			 update_module= ;;
> +		esac
> +
> +		case "$update_module" in
> +		    rebase)
> +			 command="git rebase"
> +			 action="rebase"
> +			 msg="rebased onto"
> +			 ;;
> +		    merge)
> +			 command="git merge"
> +			 action="merge"
> +			 msg="merged in"
> +			 ;;
> +		    *)
> +			 command="git checkout $force $force_checkout -q"
> +			 action="checkout"
> +			 msg="checked out"
> +			 ;;
> +		esac
> +
> +		if test "$subsha1" != "$sha1" || test -n "$force" -a "$action" = "checkout"
>  		then
> -			force=
> -			if test -z "$subsha1"
> -			then
> -				force="-f"
> -			fi
>  
>  			if test -z "$nofetch"
>  			then
> @@ -471,31 +500,6 @@ cmd_update()
>  				die "Unable to fetch in submodule path '$path'"
>  			fi
>  
> -			# Is this something we just cloned?
> -			case ";$cloned_modules;" in
> -			*";$name;"*)
> -				# then there is no local change to integrate
> -				update_module= ;;
> -			esac
> -
> -			case "$update_module" in
> -			rebase)
> -				command="git rebase"
> -				action="rebase"
> -				msg="rebased onto"
> -				;;
> -			merge)
> -				command="git merge"
> -				action="merge"
> -				msg="merged in"
> -				;;
> -			*)
> -				command="git checkout $force -q"
> -				action="checkout"
> -				msg="checked out"
> -				;;
> -			esac
> -
>  			(clear_local_git_env; cd "$path" && $command "$sha1") ||
>  			die "Unable to $action '$sha1' in submodule path '$path'"
>  			say "Submodule path '$path': $msg '$sha1'"

And if I'm right all stuff up to here can go.

> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index fa9d23a..5d24d9f 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -74,6 +74,29 @@ test_expect_success 'submodule update detaching the HEAD ' '
>  	)
>  '
>  
> +test_expect_success 'submodule update should fail due to local changes' '
> +	(cd super/submodule &&
> +	 git reset --hard HEAD~1 &&
> +	 echo "local change" > file
> +	) &&
> +	(cd super &&
> +	 (cd submodule &&
> +	  compare_head
> +	 ) &&
> +	 test_must_fail git submodule update submodule
> +	)
> +'

This test is shorter and might be easier to understand rewritten as:

+test_expect_success 'submodule update should fail due to local changes' '
+	(cd super &&
+	 (cd submodule &&
+	  git reset --hard HEAD~1 &&
+	  echo "local change" > file
+	  compare_head
+	 ) &&
+	 test_must_fail git submodule update submodule
+	)
+'

> +test_expect_success 'submodule update should throw away changes with --force ' '
> +	(cd super &&
> +	 (cd submodule &&
> +	  compare_head
> +	 ) &&
> +	 git submodule update --force submodule &&
> +	 cd submodule &&
> +	 ! compare_head
> +	)
> +'
> +
>  test_expect_success 'submodule update --rebase staying on master' '
>  	(cd super/submodule &&
>  	  git checkout master
