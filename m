From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v5] [submodule] Add --depth to submodule update/add
Date: Wed, 03 Jul 2013 09:26:02 +0200
Message-ID: <51D3D20A.5000700@web.de>
References: <51D342BB.8080907@web.de> <1372801376-32673-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: hvoigt@hvoigt.net, gitster@pobox.com, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 09:26:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuHSL-000818-CH
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 09:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516Ab3GCH0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 03:26:21 -0400
Received: from mout.web.de ([212.227.17.12]:62564 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754305Ab3GCH0U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 03:26:20 -0400
Received: from [192.168.178.41] ([79.193.89.81]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MUnqm-1UkLJv1jmm-00YCGw; Wed, 03 Jul 2013 09:26:03
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <1372801376-32673-1-git-send-email-iveqy@iveqy.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V03:K0:9mo8PkxZiJWFeosRBgemPUVfL1ZjhoGjNc4RnezzvkDsGo9zTtm
 A4/FOUWbmgAiWPEG9M5cmxSOhKXKsCTS7JTVewc+bwkBTEvNB/FJ07WzQzPeY5ap3srfP6u
 xXmpz1bUiylZ47f71YLYXuhj9z393tEjXSZRw8fJ10CbNJOmVexjK0dicV2qlaCqIp4z9U2
 6BUR1UN5R3ThdoLYnapzQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229460>

Am 02.07.2013 23:42, schrieb Fredrik Gustafsson:
> Add the --depth option to the add and update commands of "git submodule",
> which is then passed on to the clone command. This is useful when the
> submodule(s) are huge and you're not really interested in anything but
> the latest commit.
> 
> Tests are added and some indention adjustments were made to conform to the
> rest of the testfile on "submodule update can handle symbolic links in pwd".
> 
> Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
> ---
> 
> And I finally thought I'd everything right. I appriciate your reviews.
> 
> I left the "" on $5 for consistency as suggested.

Thanks, looking good to me. Passes all tests and the new tests fail
when the change in the submodule script is reverted.

Acked-by: Jens Lehmann <Jens.Lehmann@web.de>

The only minor problem is that this patch still does not apply cleanly
to master, next or pu (I wonder what you based this on ;-). I had to
change the hunk for t7400 to this to make it apply to master:

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 50e6ad7..a055b46 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -963,4 +963,19 @@ test_expect_success 'submodule with UTF-8 name' '
        git submodule >&2 &&
        test -n "$(git submodule | grep "$svname")"
 '
+
+test_expect_success 'submodule add clone shallow submodule' '
+       mkdir super &&
+       pwd=$(pwd)
+       (
+               cd super &&
+               git init &&
+               git submodule add --depth=1 file://"$pwd"/example2 submodule &&
+               (
+                       cd submodule &&
+                       test 1 = $(git log --oneline | wc -l)
+               )
+       )
+'
+
 test_done


>  Documentation/git-submodule.txt | 10 ++++++++--
>  git-submodule.sh                | 24 +++++++++++++++++++++---
>  t/t7400-submodule-basic.sh      | 15 +++++++++++++++
>  t/t7406-submodule-update.sh     | 24 +++++++++++++++++-------
>  4 files changed, 61 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index e576713..605419f 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -10,12 +10,12 @@ SYNOPSIS
>  --------
>  [verse]
>  'git submodule' [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
> -	      [--reference <repository>] [--] <repository> [<path>]
> +	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
>  'git submodule' [--quiet] init [--] [<path>...]
>  'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
>  'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
> -	      [-f|--force] [--rebase] [--reference <repository>]
> +	      [-f|--force] [--rebase] [--reference <repository>] [--depth <depth>]
>  	      [--merge] [--recursive] [--] [<path>...]
>  'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
>  	      [commit] [--] [<path>...]
> @@ -328,6 +328,12 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
>  	only in the submodules of the current repo, but also
>  	in any nested submodules inside those submodules (and so on).
>  
> +--depth::
> +	This option is valid for add and update commands. Create a 'shallow'
> +	clone with a history truncated to the specified number of revisions.
> +	See linkgit:git-clone[1]
> +
> +
>  <path>...::
>  	Paths to submodule(s). When specified this will restrict the command
>  	to only operate on the submodules found at the specified paths.
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 79bfaac..2458e1f 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -32,6 +32,7 @@ nofetch=
>  update=
>  prefix=
>  custom_name=
> +depth=
>  
>  # The function takes at most 2 arguments. The first argument is the
>  # URL that navigates to the submodule origin repo. When relative, this URL
> @@ -211,6 +212,7 @@ module_clone()
>  	name=$2
>  	url=$3
>  	reference="$4"
> +	depth="$5"
>  	quiet=
>  	if test -n "$GIT_QUIET"
>  	then
> @@ -233,7 +235,7 @@ module_clone()
>  		mkdir -p "$gitdir_base"
>  		(
>  			clear_local_git_env
> -			git clone $quiet -n ${reference:+"$reference"} \
> +			git clone $quiet ${depth:+"$depth"} -n ${reference:+"$reference"} \
>  				--separate-git-dir "$gitdir" "$url" "$sm_path"
>  		) ||
>  		die "$(eval_gettext "Clone of '\$url' into submodule path '\$sm_path' failed")"
> @@ -309,6 +311,14 @@ cmd_add()
>  			custom_name=$2
>  			shift
>  			;;
> +		--depth)
> +			case "$2" in '') usage ;; esac
> +			depth="--depth=$2"
> +			shift
> +			;;
> +		--depth=*)
> +			depth=$1
> +			;;
>  		--)
>  			shift
>  			break
> @@ -405,7 +415,7 @@ Use -f if you really want to add it." >&2
>  				echo "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
>  			fi
>  		fi
> -		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" || exit
> +		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" "$depth" || exit
>  		(
>  			clear_local_git_env
>  			cd "$sm_path" &&
> @@ -676,6 +686,14 @@ cmd_update()
>  		--checkout)
>  			update="checkout"
>  			;;
> +		--depth)
> +			case "$2" in '') usage ;; esac
> +			depth="--depth=$2"
> +			shift
> +			;;
> +		--depth=*)
> +			depth=$1
> +			;;
>  		--)
>  			shift
>  			break
> @@ -735,7 +753,7 @@ Maybe you want to use 'update --init'?")"
>  
>  		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
>  		then
> -			module_clone "$sm_path" "$name" "$url" "$reference" || exit
> +			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
>  			cloned_modules="$cloned_modules;$name"
>  			subsha1=
>  		else
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index f47cc7b..bfd1ce9 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -868,4 +868,19 @@ test_expect_success 'submodule deinit fails when submodule has a .git directory
>  	test -n "$(git config --get-regexp "submodule\.example\.")"
>  '
>  
> +test_expect_success 'submodule add clone shallow submodule' '
> +	mkdir super &&
> +	pwd=$(pwd)
> +	(
> +		cd super &&
> +		git init &&
> +		git submodule add --depth=1 file://"$pwd"/example2 submodule &&
> +		(
> +			cd submodule &&
> +			test 1 = $(git log --oneline | wc -l)
> +		)
> +	)
> +'
> +
> +
>  test_done
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index a4ffea0..e0a06e2 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -685,14 +685,24 @@ test_expect_success 'submodule update properly revives a moved submodule' '
>  test_expect_success SYMLINKS 'submodule update can handle symbolic links in pwd' '
>  	mkdir -p linked/dir &&
>  	ln -s linked/dir linkto &&
> -	(
> -		cd linkto &&
> -		git clone "$TRASH_DIRECTORY"/super_update_r2 super &&
> -		(
> -			cd super &&
> -			git submodule update --init --recursive
> -		)
> +	(cd linkto &&
> +	 git clone "$TRASH_DIRECTORY"/super_update_r2 super &&
> +	 (cd super &&
> +	  git submodule update --init --recursive
> +	 )
>  	)
>  '
>  
> +test_expect_success 'submodule update clone shallow submodule' '
> +	git clone cloned super3 &&
> +	pwd=$(pwd)
> +	(cd super3 &&
> +	 sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
> +	 mv -f .gitmodules.tmp .gitmodules &&
> +	 git submodule update --init --depth=3
> +	 (cd submodule &&
> +	  test 1 = $(git log --oneline | wc -l)
> +	 )
> +	)
> +'
>  test_done
> 
