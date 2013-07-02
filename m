From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4] [submodule] Add --depth to submodule update/add
Date: Tue, 02 Jul 2013 23:14:35 +0200
Message-ID: <51D342BB.8080907@web.de>
References: <51D311F2.1030009@web.de> <1372788530-19760-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: hvoigt@hvoigt.net, gitster@pobox.com, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 23:14:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu7uR-0006tp-5F
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 23:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124Ab3GBVOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 17:14:43 -0400
Received: from mout.web.de ([212.227.17.11]:54905 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753510Ab3GBVOm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 17:14:42 -0400
Received: from [192.168.178.41] ([79.193.89.81]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0Md4xS-1UbuIh3D8s-00IAXM; Tue, 02 Jul 2013 23:14:38
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <1372788530-19760-1-git-send-email-iveqy@iveqy.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V03:K0:XtoZd73h3iILP9g00jxjyIIAn8lUyfNtZUU/2hnHm0vhw18i9nL
 LVhRIvPAhpLIvdRV9O63GnFa2rEmBr1BdWw1DSZk80B+guzKl/zmECkH9nB715vFBA4iOqq
 uzPqqr52D7pgKU1vCLr68Gys9PxWeVKx1GFNOYzENu2xZYEbcIPpdPTNR41eHpTn5Gl9EEU
 CEbyCeAxIBP0xNYt/nvdw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229431>

Am 02.07.2013 20:08, schrieb Fredrik Gustafsson:
> Add the --depth option to the add and update commands of "git submodule",
> which is then passed on to the clone command. This is useful when the
> submodule(s) are huge and you're not really interested in anything but
> the latest commit.
> 
> Tests are added and to make --depth work the path for test "setup a submodule
> tree" had to be modified. Also did some indent adjustments to conform to the
> rest of the testfile on "submodule update can handle symbolic links in pwd".

If I see that correctly no test setup is modified anymore (which is good).
I think this paragraph should read:

  Tests are added and some indention adjustments were made to conform to the
  rest of the testfile on "submodule update can handle symbolic links in pwd".

> Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
> ---
> 
>> The first line of the commit message still sounds strange to me, please see
>> my answer in the thread you quoted.
>>
>> Also the documentation still talks about --clone-depth.
> 
> Sorry about that, it's fixed in this patch

Except for the synopsis ;-)

>> The assignment to reference right above that is quoted like that too. I wonder
>> if we should also use ${depth:+"$depth"} as argument to clone.
> 
> I don't have any opinion about this. I guess it works the way it is, I just don't
> understand it according to the shell-syntax I know.
> 
> If we should fix it, perhaps fix it in an other patch together with $reference?

Like Junio said in his email, let's just use this:

		depth=$5
		...

		git clone $quiet ${depth:+"$depth"} -n ...

(But for me the reference example shows that quoting $5 should do no harm
here, and for consistency I would prefer using 'depth="$5"' here too)

>  Documentation/git-submodule.txt | 10 ++++++++--
>  git-submodule.sh                | 24 +++++++++++++++++++++---
>  t/t7400-submodule-basic.sh      | 15 +++++++++++++++
>  t/t7406-submodule-update.sh     | 24 +++++++++++++++++-------
>  4 files changed, 61 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index e576713..77a052a 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -10,12 +10,12 @@ SYNOPSIS
>  --------
>  [verse]
>  'git submodule' [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
> -	      [--reference <repository>] [--] <repository> [<path>]
> +	      [--reference <repository>] [--clone-depth <depth>] [--] <repository> [<path>]

s/--clone-depth/--depth/

>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
>  'git submodule' [--quiet] init [--] [<path>...]
>  'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
>  'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
> -	      [-f|--force] [--rebase] [--reference <repository>]
> +	      [-f|--force] [--rebase] [--reference <repository>] [--clone-depth <depth>]

s/--clone-depth/--depth/

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
> index 79bfaac..1cfe2bf 100755
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
> +			git clone $quiet $depth -n ${reference:+"$reference"} \
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
