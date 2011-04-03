From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2] submodule: Add --force option for git submodule update
Date: Sun, 03 Apr 2011 21:21:58 +0200
Message-ID: <4D98C8D6.3050406@web.de>
References: <4D959DEB.3010206@kalray.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Morey-Chaisemartin <nmorey@kalray.eu>
X-From: git-owner@vger.kernel.org Sun Apr 03 21:22:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6SsG-0002Qy-8h
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 21:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151Ab1DCTWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 15:22:01 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:57545 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000Ab1DCTWA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 15:22:00 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate02.web.de (Postfix) with ESMTP id 0ED1119BC6157;
	Sun,  3 Apr 2011 21:21:59 +0200 (CEST)
Received: from [93.240.125.33] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q6Ss2-0006lZ-00; Sun, 03 Apr 2011 21:21:58 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <4D959DEB.3010206@kalray.eu>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19cQYttJ1xCCqtCxB7aqyz9yScFyhCUj8fRC1BH
	1gayXVXsqnkdRpaS9ODGTfOggIChdBmjDEYSsc0zEX8D+pCbM+
	gM0YgMyhdPxk3KShQX2Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170790>

Am 01.04.2011 11:42, schrieb Nicolas Morey-Chaisemartin:
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
> 
> Signed-off-by: Nicolas Morey-Chaisemartin <nmorey@kalray.eu>

Acked-by: Jens Lehmann <Jens.Lehmann@web.de>

> ---
> 
> Much less intrusive patch that only adds the --force option but do not
> add unnecessary checkouts to throw away *all* the changes
> 
>  Documentation/git-submodule.txt |    6 ++++--
>  git-submodule.sh                |   14 +++++++++-----
>  t/t7406-submodule-update.sh     |   23 +++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 3a5aa01..328bdad 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -185,8 +185,10 @@ OPTIONS
>  
>  -f::
>  --force::
> -	This option is only valid for the add command.
> -	Allow adding an otherwise ignored submodule path.
> +	This option is only valid for add and update commands.
> +	When running add, allow adding an otherwise ignored submodule path.
> +	When running update, throw away local changes in submodules when
> +	switching to a different commit.
>  
>  --cached::
>  	This option is only valid for status and summary commands.  These
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 3a13397..f732709 100755
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
> +		-f|--force)
> +			force=$1
> +			;;
>  		-r|--rebase)
>  			update="rebase"
>  			;;
> @@ -458,10 +461,11 @@ cmd_update()
>  
>  		if test "$subsha1" != "$sha1"
>  		then
> -			force=
> -			if test -z "$subsha1"
> +			subforce=$force
> +			# If we don't already have a -f flag and the submodule has never been checked out
> +			if test -z "$subsha1" -a -z "$force"
>  			then
> -				force="-f"
> +				subforce="-f"
>  			fi
>  
>  			if test -z "$nofetch"
> @@ -490,7 +494,7 @@ cmd_update()
>  				msg="merged in"
>  				;;
>  			*)
> -				command="git checkout $force -q"
> +				command="git checkout $subforce -q"
>  				action="checkout"
>  				msg="checked out"
>  				;;
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
