From: Lukasz Palczewski <l.palczewski@prevac.pl>
Subject: Re: Restart submodule update --recursive
Date: Fri, 29 Oct 2010 13:37:46 +0200
Message-ID: <4CCAB20A.1000408@prevac.pl>
References: <loom.20101028T090353-376@post.gmane.org> <20101028181515.GB14212@burratino> <loom.20101029T085153-262@post.gmane.org> <20101029091202.GA26442@burratino>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010306030401030700010505"
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Piotrek Pientka <p.pientka@prevac.pl>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 13:48:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBnRf-0001Pv-8N
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 13:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933822Ab0J2LsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 07:48:25 -0400
Received: from mailmxout.mailmx.agnat.pl ([193.239.44.238]:39987 "EHLO
	mailmxout.mailmx.agnat.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932595Ab0J2LsX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 07:48:23 -0400
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Oct 2010 07:48:23 EDT
Received: from smtp.agnat.pl ([193.239.44.82])
	by mailmxout.mailmx.agnat.pl with esmtp (Exim 4.72)
	(envelope-from <l.palczewski@prevac.pl>)
	id 1PBnI1-0002oq-M3
	for git@vger.kernel.org; Fri, 29 Oct 2010 13:38:33 +0200
Received: from [83.18.121.37] (helo=mail.prevac.pl)
	by smtp.agnat.pl with esmtpa (Exim 4.71)
	(envelope-from <l.palczewski@prevac.pl>)
	id 1PBnI0-0002h8-DZ
	for git@vger.kernel.org; Fri, 29 Oct 2010 13:38:33 +0200
Received: (qmail 10889 invoked by uid 1008); 29 Oct 2010 13:38:31 +0200
Received: from jlatkowski.prevac.eu.local (HELO ?127.0.0.1?) (prevac0005@192.168.0.91)
  by mail.prevac.pl with SMTP; 29 Oct 2010 13:38:31 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; pl; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20101029091202.GA26442@burratino>
X-Authenticated-Id: prevac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160329>

This is a multi-part message in MIME format.
--------------010306030401030700010505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jonathan Nieder wrote:
> Hi Lukasz,
>
> [side note: if you use a newsreader, please reply by mail instead of
> through gmane so the Cc: list can be preserved.]
Sorry, but I do not use it. I will send You a normal email.

I have added two options to git submodule update:
--save-progress
--resume-update
First one You can use, to save the ./.git/SubmoduleUpdateLog.log the 
progress of updating:
git submodule update --recursive --save-progress
The second one is used for skipping updated submodules:
git submodule update --recursive --resume-update

The downside of it is, that u can use only one --resume-update. If there 
will be another error, then using it again will start form the last 
submodule that --save-progres saved.

I have send two files:
"git-submodule" - it has my changes
"git-submodule - Original" - it not modyfied
so that You can see what lines I have added.

Let me know if this change will be in next version of git.

Best regards,
Lukasz Palczewski

--------------010306030401030700010505
Content-Type: text/plain;
 name="git-submodule"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="git-submodule"

#!/bin/sh
#
# git-submodules.sh: add, init, update or list git submodules
#
# Copyright (c) 2007 Lars Hjemli

dashless=$(basename "$0" | sed -e 's/-/ /')
USAGE="[--quiet] add [-b branch] [-f|--force] [--reference <repository>] [--] <repository> [<path>]
   or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
   or: $dashless [--quiet] init [--] [<path>...]
   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
   or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
   or: $dashless [--quiet] foreach [--recursive] <command>
   or: $dashless [--quiet] sync [--] [<path>...]"
OPTIONS_SPEC=
. git-sh-setup
. git-parse-remote
require_work_tree

command=
branch=
force=
reference=
cached=
recursive=
init=
files=
nofetch=
update=
prefix=

# Resolve relative url by appending to parent's url
resolve_relative_url ()
{
	remote=$(get_default_remote)
	remoteurl=$(git config "remote.$remote.url") ||
		die "remote ($remote) does not have a url defined in .git/config"
	url="$1"
	remoteurl=${remoteurl%/}
	while test -n "$url"
	do
		case "$url" in
		../*)
			url="${url#../}"
			remoteurl="${remoteurl%/*}"
			;;
		./*)
			url="${url#./}"
			;;
		*)
			break;;
		esac
	done
	echo "$remoteurl/${url%/}"
}

#
# Get submodule info for registered submodules
# $@ = path to limit submodule list
#
module_list()
{
	git ls-files --error-unmatch --stage -- "$@" | sane_grep '^160000 '
}

#
# Map submodule path to submodule name
#
# $1 = path
#
module_name()
{
	# Do we have "submodule.<something>.path = $1" defined in .gitmodules file?
	re=$(printf '%s\n' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
	name=$( git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
       test -z "$name" &&
       die "No submodule mapping found in .gitmodules for path '$path'"
       echo "$name"
}

#
# Clone a submodule
#
# Prior to calling, cmd_update checks that a possibly existing
# path is not a git repository.
# Likewise, cmd_add checks that path does not exist at all,
# since it is the location of a new submodule.
#
module_clone()
{
	path=$1
	url=$2
	reference="$3"

	# If there already is a directory at the submodule path,
	# expect it to be empty (since that is the default checkout
	# action) and try to remove it.
	# Note: if $path is a symlink to a directory the test will
	# succeed but the rmdir will fail. We might want to fix this.
	if test -d "$path"
	then
		rmdir "$path" 2>/dev/null ||
		die "Directory '$path' exists, but is neither empty nor a git repository"
	fi

	test -e "$path" &&
	die "A file already exist at path '$path'"

	if test -n "$reference"
	then
		git-clone "$reference" -n "$url" "$path"
	else
		git-clone -n "$url" "$path"
	fi ||
	die "Clone of '$url' into submodule path '$path' failed"
}

#
# Add a new submodule to the working tree, .gitmodules and the index
#
# $@ = repo path
#
# optional branch is stored in global branch variable
#
cmd_add()
{
	# parse $args after "submodule ... add".
	while test $# -ne 0
	do
		case "$1" in
		-b | --branch)
			case "$2" in '') usage ;; esac
			branch=$2
			shift
			;;
		-f | --force)
			force=$1
			;;
		-q|--quiet)
			GIT_QUIET=1
			;;
		--reference)
			case "$2" in '') usage ;; esac
			reference="--reference=$2"
			shift
			;;
		--reference=*)
			reference="$1"
			shift
			;;
		--)
			shift
			break
			;;
		-*)
			usage
			;;
		*)
			break
			;;
		esac
		shift
	done

	repo=$1
	path=$2

	if test -z "$path"; then
		path=$(echo "$repo" |
			sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
	fi

	if test -z "$repo" -o -z "$path"; then
		usage
	fi

	# assure repo is absolute or relative to parent
	case "$repo" in
	./*|../*)
		# dereference source url relative to parent's url
		realrepo=$(resolve_relative_url "$repo") || exit
		;;
	*:*|/*)
		# absolute url
		realrepo=$repo
		;;
	*)
		die "repo URL: '$repo' must be absolute or begin with ./|../"
	;;
	esac

	# normalize path:
	# multiple //; leading ./; /./; /../; trailing /
	path=$(printf '%s/\n' "$path" |
		sed -e '
			s|//*|/|g
			s|^\(\./\)*||
			s|/\./|/|g
			:start
			s|\([^/]*\)/\.\./||
			tstart
			s|/*$||
		')
	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
	die "'$path' already exists in the index"

	if test -z "$force" && ! git add --dry-run --ignore-missing "$path" > /dev/null 2>&1
	then
		echo >&2 "The following path is ignored by one of your .gitignore files:" &&
		echo >&2 $path &&
		echo >&2 "Use -f if you really want to add it."
		exit 1
	fi

	# perhaps the path exists and is already a git repo, else clone it
	if test -e "$path"
	then
		if test -d "$path"/.git -o -f "$path"/.git
		then
			echo "Adding existing repo at '$path' to the index"
		else
			die "'$path' already exists and is not a valid git repo"
		fi

		case "$repo" in
		./*|../*)
			url=$(resolve_relative_url "$repo") || exit
		    ;;
		*)
			url="$repo"
			;;
		esac
		git config submodule."$path".url "$url"
	else

		module_clone "$path" "$realrepo" "$reference" || exit
		(
			clear_local_git_env
			cd "$path" &&
			# ash fails to wordsplit ${branch:+-b "$branch"...}
			case "$branch" in
			'') git checkout -f -q ;;
			?*) git checkout -f -q -b "$branch" "origin/$branch" ;;
			esac
		) || die "Unable to checkout submodule '$path'"
	fi

	git add $force "$path" ||
	die "Failed to add submodule '$path'"

	git config -f .gitmodules submodule."$path".path "$path" &&
	git config -f .gitmodules submodule."$path".url "$repo" &&
	git add --force .gitmodules ||
	die "Failed to register submodule '$path'"
}

#
# Execute an arbitrary command sequence in each checked out
# submodule
#
# $@ = command to execute
#
cmd_foreach()
{
	# parse $args after "submodule ... foreach".
	while test $# -ne 0
	do
		case "$1" in
		-q|--quiet)
			GIT_QUIET=1
			;;
		--recursive)
			recursive=1
			;;
		-*)
			usage
			;;
		*)
			break
			;;
		esac
		shift
	done

	toplevel=$(pwd)

	module_list |
	while read mode sha1 stage path
	do
		if test -e "$path"/.git
		then
			say "Entering '$prefix$path'"
			name=$(module_name "$path")
			(
				prefix="$prefix$path/"
				clear_local_git_env
				cd "$path" &&
				eval "$@" &&
				if test -n "$recursive"
				then
					cmd_foreach "--recursive" "$@"
				fi
			) ||
			die "Stopping at '$path'; script returned non-zero status."
		fi
	done
}

#
# Register submodules in .git/config
#
# $@ = requested paths (default to all)
#
cmd_init()
{
	# parse $args after "submodule ... init".
	while test $# -ne 0
	do
		case "$1" in
		-q|--quiet)
			GIT_QUIET=1
			;;
		--)
			shift
			break
			;;
		-*)
			usage
			;;
		*)
			break
			;;
		esac
		shift
	done

	module_list "$@" |
	while read mode sha1 stage path
	do
		# Skip already registered paths
		name=$(module_name "$path") || exit
		url=$(git config submodule."$name".url)
		test -z "$url" || continue

		url=$(git config -f .gitmodules submodule."$name".url)
		test -z "$url" &&
		die "No url found for submodule path '$path' in .gitmodules"

		# Possibly a url relative to parent
		case "$url" in
		./*|../*)
			url=$(resolve_relative_url "$url") || exit
			;;
		esac

		git config submodule."$name".url "$url" ||
		die "Failed to register url for submodule path '$path'"

		upd="$(git config -f .gitmodules submodule."$name".update)"
		test -z "$upd" ||
		git config submodule."$name".update "$upd" ||
		die "Failed to register update mode for submodule path '$path'"

		say "Submodule '$name' ($url) registered for path '$path'"
	done
}

#
# Update each submodule path to correct revision, using clone and checkout as needed
#
# $@ = requested paths (default to all)
#
cmd_update()
{
	# parse $args after "submodule ... update".
	orig_args="$@"
	while test $# -ne 0
	do
		case "$1" in
		-q|--quiet)
			shift
			GIT_QUIET=1
			;;
		-i|--init)
			init=1
			shift
			;;
		-N|--no-fetch)
			shift
			nofetch=1
			;;
		-r|--rebase)
			shift
			update="rebase"
			;;
		--reference)
			case "$2" in '') usage ;; esac
			reference="--reference=$2"
			shift 2
			;;
		--reference=*)
			reference="$1"
			shift
			;;
		-m|--merge)
			shift
			update="merge"
			;;
		--recursive)
			shift
			recursive=1
			;;
		--save-progress)
			shift
			save_progress=1
			if test -e ./.git/SubmoduleUpdateLog.log
			then
				rm ./.git/SubmoduleUpdateLog.log
			fi
			;;	
		--resume-update)
			shift
			submodule_resume=1
			;;				
		--)
			shift
			break
			;;
		-*)
			usage
			;;
		*)
			break
			;;
		esac
	done

	if test -n "$init"
	then
		cmd_init "--" "$@" || return
	fi
		
	module_list "$@" |
	while read mode sha1 stage path
	do		
		name=$(module_name "$path") || exit
		url=$(git config submodule."$name".url)
		update_module=$(git config submodule."$name".update)
		
		if test -n "$submodule_resume"
		then
			SubmodulePathResume=`pwd`
			SubmodulePathResume=$SubmodulePathResume/"$name"
			
			#say $SubmodulePathResume
			if test -e ./.git/SubmoduleUpdateLog.log
			then
				AFile=`cat "./.git/SubmoduleUpdateLog.log" | grep "$SubmodulePathResume"`
				
				#say $AFile;			
				if test -n "$AFile"
				then
					say "Skip module '$SubmodulePathResume'"
					CancelRecursive=1
				else
					#say "Checking"
					#say "$SubmodulePathResume"
					CancelRecursive=""
				fi			
			fi
		fi
		
		if test -z "$url"
		then
			# Only mention uninitialized submodules when its
			# path have been specified
			test "$#" != "0" &&
			say "Submodule path '$path' not initialized" &&
			say "Maybe you want to use 'update --init'?"
			continue
		fi

		if ! test -d "$path"/.git -o -f "$path"/.git
		then
			module_clone "$path" "$url" "$reference"|| exit
			subsha1=
		else
			subsha1=$(clear_local_git_env; cd "$path" &&
				git rev-parse --verify HEAD) ||
			die "Unable to find current revision in submodule path '$path'"
		fi

		if ! test -z "$update"
		then
			update_module=$update
		fi

		if test "$subsha1" != "$sha1"
		then
			force=
			if test -z "$subsha1"
			then
				force="-f"
			fi

			if test -z "$nofetch"
			then
				(clear_local_git_env; cd "$path" &&
					git-fetch) ||
				die "Unable to fetch in submodule path '$path'"
			fi
			
			case "$update_module" in
			rebase)
				command="git rebase"
				action="rebase"
				msg="rebased onto"
				;;
			merge)
				command="git merge"
				action="merge"
				msg="merged in"
				;;
			*)
				command="git checkout $force -q"
				action="checkout"
				msg="checked out"
				;;
			esac

			(clear_local_git_env; cd "$path" && $command "$sha1") ||
			die "Unable to $action '$sha1' in submodule path '$path'"
			say "Submodule path '$path': $msg '$sha1'"
		fi
	
		if test -n "$recursive"
		then
			if test -z "$CancelRecursive"
			then
				(clear_local_git_env; cd "$path" && cmd_update $orig_args) ||
				die "Failed to recurse into submodule path '$path'"
			fi
		fi
		
		if test -n "$save_progress"
		then
				SubmodulePath=`pwd`
				SubmodulePath=$SubmodulePath/"$name"
				
				#say "'$SubmodulePath'"
				echo "'$SubmodulePath'" >> ./.git/SubmoduleUpdateLog.log
		fi
	done
}

set_name_rev () {
	revname=$( (
		clear_local_git_env
		cd "$1" && {
			git describe "$2" 2>/dev/null ||
			git describe --tags "$2" 2>/dev/null ||
			git describe --contains "$2" 2>/dev/null ||
			git describe --all --always "$2"
		}
	) )
	test -z "$revname" || revname=" ($revname)"
}
#
# Show commit summary for submodules in index or working tree
#
# If '--cached' is given, show summary between index and given commit,
# or between working tree and given commit
#
# $@ = [commit (default 'HEAD'),] requested paths (default all)
#
cmd_summary() {
	summary_limit=-1
	for_status=
	diff_cmd=diff-index

	# parse $args after "submodule ... summary".
	while test $# -ne 0
	do
		case "$1" in
		--cached)
			cached="$1"
			;;
		--files)
			files="$1"
			;;
		--for-status)
			for_status="$1"
			;;
		-n|--summary-limit)
			if summary_limit=$(($2 + 0)) 2>/dev/null && test "$summary_limit" = "$2"
			then
				:
			else
				usage
			fi
			shift
			;;
		--)
			shift
			break
			;;
		-*)
			usage
			;;
		*)
			break
			;;
		esac
		shift
	done

	test $summary_limit = 0 && return

	if rev=$(git rev-parse -q --verify --default HEAD ${1+"$1"})
	then
		head=$rev
		test $# = 0 || shift
	elif test -z "$1" -o "$1" = "HEAD"
	then
		# before the first commit: compare with an empty tree
		head=$(git hash-object -w -t tree --stdin </dev/null)
		test -z "$1" || shift
	else
		head="HEAD"
	fi

	if [ -n "$files" ]
	then
		test -n "$cached" &&
		die "--cached cannot be used with --files"
		diff_cmd=diff-files
		head=
	fi

	cd_to_toplevel
	# Get modified modules cared by user
	modules=$(git $diff_cmd $cached --ignore-submodules=dirty --raw $head -- "$@" |
		sane_egrep '^:([0-7]* )?160000' |
		while read mod_src mod_dst sha1_src sha1_dst status name
		do
			# Always show modules deleted or type-changed (blob<->module)
			test $status = D -o $status = T && echo "$name" && continue
			# Also show added or modified modules which are checked out
			GIT_DIR="$name/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
			echo "$name"
		done
	)

	test -z "$modules" && return

	git $diff_cmd $cached --ignore-submodules=dirty --raw $head -- $modules |
	sane_egrep '^:([0-7]* )?160000' |
	cut -c2- |
	while read mod_src mod_dst sha1_src sha1_dst status name
	do
		if test -z "$cached" &&
			test $sha1_dst = 0000000000000000000000000000000000000000
		then
			case "$mod_dst" in
			160000)
				sha1_dst=$(GIT_DIR="$name/.git" git rev-parse HEAD)
				;;
			100644 | 100755 | 120000)
				sha1_dst=$(git hash-object $name)
				;;
			000000)
				;; # removed
			*)
				# unexpected type
				echo >&2 "unexpected mode $mod_dst"
				continue ;;
			esac
		fi
		missing_src=
		missing_dst=

		test $mod_src = 160000 &&
		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 >/dev/null &&
		missing_src=t

		test $mod_dst = 160000 &&
		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_dst^0 >/dev/null &&
		missing_dst=t

		total_commits=
		case "$missing_src,$missing_dst" in
		t,)
			errmsg="  Warn: $name doesn't contain commit $sha1_src"
			;;
		,t)
			errmsg="  Warn: $name doesn't contain commit $sha1_dst"
			;;
		t,t)
			errmsg="  Warn: $name doesn't contain commits $sha1_src and $sha1_dst"
			;;
		*)
			errmsg=
			total_commits=$(
			if test $mod_src = 160000 -a $mod_dst = 160000
			then
				range="$sha1_src...$sha1_dst"
			elif test $mod_src = 160000
			then
				range=$sha1_src
			else
				range=$sha1_dst
			fi
			GIT_DIR="$name/.git" \
			git rev-list --first-parent $range -- | wc -l
			)
			total_commits=" ($(($total_commits + 0)))"
			;;
		esac

		sha1_abbr_src=$(echo $sha1_src | cut -c1-7)
		sha1_abbr_dst=$(echo $sha1_dst | cut -c1-7)
		if test $status = T
		then
			if test $mod_dst = 160000
			then
				echo "* $name $sha1_abbr_src(blob)->$sha1_abbr_dst(submodule)$total_commits:"
			else
				echo "* $name $sha1_abbr_src(submodule)->$sha1_abbr_dst(blob)$total_commits:"
			fi
		else
			echo "* $name $sha1_abbr_src...$sha1_abbr_dst$total_commits:"
		fi
		if test -n "$errmsg"
		then
			# Don't give error msg for modification whose dst is not submodule
			# i.e. deleted or changed to blob
			test $mod_dst = 160000 && echo "$errmsg"
		else
			if test $mod_src = 160000 -a $mod_dst = 160000
			then
				limit=
				test $summary_limit -gt 0 && limit="-$summary_limit"
				GIT_DIR="$name/.git" \
				git log $limit --pretty='format:  %m %s' \
				--first-parent $sha1_src...$sha1_dst
			elif test $mod_dst = 160000
			then
				GIT_DIR="$name/.git" \
				git log --pretty='format:  > %s' -1 $sha1_dst
			else
				GIT_DIR="$name/.git" \
				git log --pretty='format:  < %s' -1 $sha1_src
			fi
			echo
		fi
		echo
	done |
	if test -n "$for_status"; then
		if [ -n "$files" ]; then
			echo "# Submodules changed but not updated:"
		else
			echo "# Submodule changes to be committed:"
		fi
		echo "#"
		sed -e 's|^|# |' -e 's|^# $|#|'
	else
		cat
	fi
}
#
# List all submodules, prefixed with:
#  - submodule not initialized
#  + different revision checked out
#
# If --cached was specified the revision in the index will be printed
# instead of the currently checked out revision.
#
# $@ = requested paths (default to all)
#
cmd_status()
{
	# parse $args after "submodule ... status".
	orig_args="$@"
	while test $# -ne 0
	do
		case "$1" in
		-q|--quiet)
			GIT_QUIET=1
			;;
		--cached)
			cached=1
			;;
		--recursive)
			recursive=1
			;;
		--)
			shift
			break
			;;
		-*)
			usage
			;;
		*)
			break
			;;
		esac
		shift
	done

	module_list "$@" |
	while read mode sha1 stage path
	do
		name=$(module_name "$path") || exit
		url=$(git config submodule."$name".url)
		displaypath="$prefix$path"
		if test -z "$url" || ! test -d "$path"/.git -o -f "$path"/.git
		then
			say "-$sha1 $displaypath"
			continue;
		fi
		set_name_rev "$path" "$sha1"
		if git diff-files --ignore-submodules=dirty --quiet -- "$path"
		then
			say " $sha1 $displaypath$revname"
		else
			if test -z "$cached"
			then
				sha1=$(clear_local_git_env; cd "$path" && git rev-parse --verify HEAD)
				set_name_rev "$path" "$sha1"
			fi
			say "+$sha1 $displaypath$revname"
		fi

		if test -n "$recursive"
		then
			(
				prefix="$displaypath/"
				clear_local_git_env
				cd "$path" &&
				cmd_status $orig_args
			) ||
			die "Failed to recurse into submodule path '$path'"
		fi
	done
}
#
# Sync remote urls for submodules
# This makes the value for remote.$remote.url match the value
# specified in .gitmodules.
#
cmd_sync()
{
	while test $# -ne 0
	do
		case "$1" in
		-q|--quiet)
			GIT_QUIET=1
			shift
			;;
		--)
			shift
			break
			;;
		-*)
			usage
			;;
		*)
			break
			;;
		esac
	done
	cd_to_toplevel
	module_list "$@" |
	while read mode sha1 stage path
	do
		name=$(module_name "$path")
		url=$(git config -f .gitmodules --get submodule."$name".url)

		# Possibly a url relative to parent
		case "$url" in
		./*|../*)
			url=$(resolve_relative_url "$url") || exit
			;;
		esac

		if test -e "$path"/.git
		then
		(
			say "Synchronizing submodule url for '$name'"
			git config submodule."$name".url "$url"
			clear_local_git_env
			cd "$path"
			remote=$(get_default_remote)
			git config remote."$remote".url "$url"
		)
		fi
	done
}

# This loop parses the command line arguments to find the
# subcommand name to dispatch.  Parsing of the subcommand specific
# options are primarily done by the subcommand implementations.
# Subcommand specific options such as --branch and --cached are
# parsed here as well, for backward compatibility.

while test $# != 0 && test -z "$command"
do
	case "$1" in
	add | foreach | init | update | status | summary | sync)
		command=$1
		;;
	-q|--quiet)
		GIT_QUIET=1
		;;
	-b|--branch)
		case "$2" in
		'')
			usage
			;;
		esac
		branch="$2"; shift
		;;
	--cached)
		cached="$1"
		;;
	--)
		break
		;;
	-*)
		usage
		;;
	*)
		break
		;;
	esac
	shift
done

# No command word defaults to "status"
test -n "$command" || command=status

# "-b branch" is accepted only by "add"
if test -n "$branch" && test "$command" != add
then
	usage
fi

# "--cached" is accepted only by "status" and "summary"
if test -n "$cached" && test "$command" != status -a "$command" != summary
then
	usage
fi

"cmd_$command" "$@"

--------------010306030401030700010505
Content-Type: text/plain;
 name="git-submodule - Original"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="git-submodule - Original"

#!/bin/sh
#
# git-submodules.sh: add, init, update or list git submodules
#
# Copyright (c) 2007 Lars Hjemli

dashless=$(basename "$0" | sed -e 's/-/ /')
USAGE="[--quiet] add [-b branch] [-f|--force] [--reference <repository>] [--] <repository> [<path>]
   or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
   or: $dashless [--quiet] init [--] [<path>...]
   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
   or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
   or: $dashless [--quiet] foreach [--recursive] <command>
   or: $dashless [--quiet] sync [--] [<path>...]"
OPTIONS_SPEC=
. git-sh-setup
. git-parse-remote
require_work_tree

command=
branch=
force=
reference=
cached=
recursive=
init=
files=
nofetch=
update=
prefix=

# Resolve relative url by appending to parent's url
resolve_relative_url ()
{
	remote=$(get_default_remote)
	remoteurl=$(git config "remote.$remote.url") ||
		die "remote ($remote) does not have a url defined in .git/config"
	url="$1"
	remoteurl=${remoteurl%/}
	while test -n "$url"
	do
		case "$url" in
		../*)
			url="${url#../}"
			remoteurl="${remoteurl%/*}"
			;;
		./*)
			url="${url#./}"
			;;
		*)
			break;;
		esac
	done
	echo "$remoteurl/${url%/}"
}

#
# Get submodule info for registered submodules
# $@ = path to limit submodule list
#
module_list()
{
	git ls-files --error-unmatch --stage -- "$@" | sane_grep '^160000 '
}

#
# Map submodule path to submodule name
#
# $1 = path
#
module_name()
{
	# Do we have "submodule.<something>.path = $1" defined in .gitmodules file?
	re=$(printf '%s\n' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
	name=$( git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
       test -z "$name" &&
       die "No submodule mapping found in .gitmodules for path '$path'"
       echo "$name"
}

#
# Clone a submodule
#
# Prior to calling, cmd_update checks that a possibly existing
# path is not a git repository.
# Likewise, cmd_add checks that path does not exist at all,
# since it is the location of a new submodule.
#
module_clone()
{
	path=$1
	url=$2
	reference="$3"

	# If there already is a directory at the submodule path,
	# expect it to be empty (since that is the default checkout
	# action) and try to remove it.
	# Note: if $path is a symlink to a directory the test will
	# succeed but the rmdir will fail. We might want to fix this.
	if test -d "$path"
	then
		rmdir "$path" 2>/dev/null ||
		die "Directory '$path' exists, but is neither empty nor a git repository"
	fi

	test -e "$path" &&
	die "A file already exist at path '$path'"

	if test -n "$reference"
	then
		git-clone "$reference" -n "$url" "$path"
	else
		git-clone -n "$url" "$path"
	fi ||
	die "Clone of '$url' into submodule path '$path' failed"
}

#
# Add a new submodule to the working tree, .gitmodules and the index
#
# $@ = repo path
#
# optional branch is stored in global branch variable
#
cmd_add()
{
	# parse $args after "submodule ... add".
	while test $# -ne 0
	do
		case "$1" in
		-b | --branch)
			case "$2" in '') usage ;; esac
			branch=$2
			shift
			;;
		-f | --force)
			force=$1
			;;
		-q|--quiet)
			GIT_QUIET=1
			;;
		--reference)
			case "$2" in '') usage ;; esac
			reference="--reference=$2"
			shift
			;;
		--reference=*)
			reference="$1"
			shift
			;;
		--)
			shift
			break
			;;
		-*)
			usage
			;;
		*)
			break
			;;
		esac
		shift
	done

	repo=$1
	path=$2

	if test -z "$path"; then
		path=$(echo "$repo" |
			sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
	fi

	if test -z "$repo" -o -z "$path"; then
		usage
	fi

	# assure repo is absolute or relative to parent
	case "$repo" in
	./*|../*)
		# dereference source url relative to parent's url
		realrepo=$(resolve_relative_url "$repo") || exit
		;;
	*:*|/*)
		# absolute url
		realrepo=$repo
		;;
	*)
		die "repo URL: '$repo' must be absolute or begin with ./|../"
	;;
	esac

	# normalize path:
	# multiple //; leading ./; /./; /../; trailing /
	path=$(printf '%s/\n' "$path" |
		sed -e '
			s|//*|/|g
			s|^\(\./\)*||
			s|/\./|/|g
			:start
			s|\([^/]*\)/\.\./||
			tstart
			s|/*$||
		')
	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
	die "'$path' already exists in the index"

	if test -z "$force" && ! git add --dry-run --ignore-missing "$path" > /dev/null 2>&1
	then
		echo >&2 "The following path is ignored by one of your .gitignore files:" &&
		echo >&2 $path &&
		echo >&2 "Use -f if you really want to add it."
		exit 1
	fi

	# perhaps the path exists and is already a git repo, else clone it
	if test -e "$path"
	then
		if test -d "$path"/.git -o -f "$path"/.git
		then
			echo "Adding existing repo at '$path' to the index"
		else
			die "'$path' already exists and is not a valid git repo"
		fi

		case "$repo" in
		./*|../*)
			url=$(resolve_relative_url "$repo") || exit
		    ;;
		*)
			url="$repo"
			;;
		esac
		git config submodule."$path".url "$url"
	else

		module_clone "$path" "$realrepo" "$reference" || exit
		(
			clear_local_git_env
			cd "$path" &&
			# ash fails to wordsplit ${branch:+-b "$branch"...}
			case "$branch" in
			'') git checkout -f -q ;;
			?*) git checkout -f -q -b "$branch" "origin/$branch" ;;
			esac
		) || die "Unable to checkout submodule '$path'"
	fi

	git add $force "$path" ||
	die "Failed to add submodule '$path'"

	git config -f .gitmodules submodule."$path".path "$path" &&
	git config -f .gitmodules submodule."$path".url "$repo" &&
	git add --force .gitmodules ||
	die "Failed to register submodule '$path'"
}

#
# Execute an arbitrary command sequence in each checked out
# submodule
#
# $@ = command to execute
#
cmd_foreach()
{
	# parse $args after "submodule ... foreach".
	while test $# -ne 0
	do
		case "$1" in
		-q|--quiet)
			GIT_QUIET=1
			;;
		--recursive)
			recursive=1
			;;
		-*)
			usage
			;;
		*)
			break
			;;
		esac
		shift
	done

	toplevel=$(pwd)

	module_list |
	while read mode sha1 stage path
	do
		if test -e "$path"/.git
		then
			say "Entering '$prefix$path'"
			name=$(module_name "$path")
			(
				prefix="$prefix$path/"
				clear_local_git_env
				cd "$path" &&
				eval "$@" &&
				if test -n "$recursive"
				then
					cmd_foreach "--recursive" "$@"
				fi
			) ||
			die "Stopping at '$path'; script returned non-zero status."
		fi
	done
}

#
# Register submodules in .git/config
#
# $@ = requested paths (default to all)
#
cmd_init()
{
	# parse $args after "submodule ... init".
	while test $# -ne 0
	do
		case "$1" in
		-q|--quiet)
			GIT_QUIET=1
			;;
		--)
			shift
			break
			;;
		-*)
			usage
			;;
		*)
			break
			;;
		esac
		shift
	done

	module_list "$@" |
	while read mode sha1 stage path
	do
		# Skip already registered paths
		name=$(module_name "$path") || exit
		url=$(git config submodule."$name".url)
		test -z "$url" || continue

		url=$(git config -f .gitmodules submodule."$name".url)
		test -z "$url" &&
		die "No url found for submodule path '$path' in .gitmodules"

		# Possibly a url relative to parent
		case "$url" in
		./*|../*)
			url=$(resolve_relative_url "$url") || exit
			;;
		esac

		git config submodule."$name".url "$url" ||
		die "Failed to register url for submodule path '$path'"

		upd="$(git config -f .gitmodules submodule."$name".update)"
		test -z "$upd" ||
		git config submodule."$name".update "$upd" ||
		die "Failed to register update mode for submodule path '$path'"

		say "Submodule '$name' ($url) registered for path '$path'"
	done
}

#
# Update each submodule path to correct revision, using clone and checkout as needed
#
# $@ = requested paths (default to all)
#
cmd_update()
{
	# parse $args after "submodule ... update".
	orig_args="$@"
	while test $# -ne 0
	do
		case "$1" in
		-q|--quiet)
			shift
			GIT_QUIET=1
			;;
		-i|--init)
			init=1
			shift
			;;
		-N|--no-fetch)
			shift
			nofetch=1
			;;
		-r|--rebase)
			shift
			update="rebase"
			;;
		--reference)
			case "$2" in '') usage ;; esac
			reference="--reference=$2"
			shift 2
			;;
		--reference=*)
			reference="$1"
			shift
			;;
		-m|--merge)
			shift
			update="merge"
			;;
		--recursive)
			shift
			recursive=1
			;;
		--save-progress)
			shift
			save_progress=1
			;;	
		--resume-update)
			shift
			submodule_resume=1
			;;				
		--)
			shift
			break
			;;
		-*)
			usage
			;;
		*)
			break
			;;
		esac
	done

	if test -n "$init"
	then
		cmd_init "--" "$@" || return
	fi
	
	module_list "$@" |
	while read mode sha1 stage path
	do
		
		name=$(module_name "$path") || exit
		url=$(git config submodule."$name".url)
		update_module=$(git config submodule."$name".update)
		
		if test -n "$submodule_resume"
		then
			SubmodulePathResume=`pwd`
			SubmodulePathResume=$SubmodulePathResume/"$name"
			
			#SubmodulePathResume=$(pwd echo"'$name'")
			#say "'$SubmodulePathResume'"
			
			say $SubmodulePathResume
			AFile=`cat "Test.txt" | grep "$SubmodulePathResume"`
			
			say $AFile;
			
			if test -n "$AFile"
			then
				say "CancelRecursive"
				CancelRecursive=1
			else
				say "dupa"
				CancelRecursive=""
			fi			
		fi
		
		if test -z "$url"
		then
			# Only mention uninitialized submodules when its
			# path have been specified
			test "$#" != "0" &&
			say "Submodule path '$path' not initialized" &&
			say "Maybe you want to use 'update --init'?"
			continue
		fi

		if ! test -d "$path"/.git -o -f "$path"/.git
		then
			module_clone "$path" "$url" "$reference"|| exit
			subsha1=
		else
			subsha1=$(clear_local_git_env; cd "$path" &&
				git rev-parse --verify HEAD) ||
			die "Unable to find current revision in submodule path '$path'"
		fi

		if ! test -z "$update"
		then
			update_module=$update
		fi

		if test "$subsha1" != "$sha1"
		then
			force=
			if test -z "$subsha1"
			then
				force="-f"
			fi

			if test -z "$nofetch"
			then
				(clear_local_git_env; cd "$path" &&
					git-fetch) ||
				die "Unable to fetch in submodule path '$path'"
			fi
			
			if test -n "$submodule_resume"
			then
				update="resume"
			fi

			case "$update_module" in
			rebase)
				command="git rebase"
				action="rebase"
				msg="rebased onto"
				;;
			merge)
				command="git merge"
				action="merge"
				msg="merged in"
				;;
			*)
				command="git checkout $force -q"
				action="checkout"
				msg="checked out"
				;;
			resume)
				
				;;
			esac

			(clear_local_git_env; cd "$path" && $command "$sha1") ||
			die "Unable to $action '$sha1' in submodule path '$path'"
			say "Submodule path '$path': $msg '$sha1'"
		fi
	
		if test -n "$recursive"
		then
			if test -z "$CancelRecursive"
			then
				(clear_local_git_env; cd "$path" && cmd_update $orig_args) ||
				die "Failed to recurse into submodule path '$path'"
			fi
		fi
		
		if test -n "$save_progress"
		then
				SubmodulePath=`pwd`
				SubmodulePath=$SubmodulePath/"$name"
				
				#SubmodulePath=$(pwd echo"'$name'")
				say "'$SubmodulePath'"
				echo "'$SubmodulePath'" >> Test.txt
		fi
	done
}

set_name_rev () {
	revname=$( (
		clear_local_git_env
		cd "$1" && {
			git describe "$2" 2>/dev/null ||
			git describe --tags "$2" 2>/dev/null ||
			git describe --contains "$2" 2>/dev/null ||
			git describe --all --always "$2"
		}
	) )
	test -z "$revname" || revname=" ($revname)"
}
#
# Show commit summary for submodules in index or working tree
#
# If '--cached' is given, show summary between index and given commit,
# or between working tree and given commit
#
# $@ = [commit (default 'HEAD'),] requested paths (default all)
#
cmd_summary() {
	summary_limit=-1
	for_status=
	diff_cmd=diff-index

	# parse $args after "submodule ... summary".
	while test $# -ne 0
	do
		case "$1" in
		--cached)
			cached="$1"
			;;
		--files)
			files="$1"
			;;
		--for-status)
			for_status="$1"
			;;
		-n|--summary-limit)
			if summary_limit=$(($2 + 0)) 2>/dev/null && test "$summary_limit" = "$2"
			then
				:
			else
				usage
			fi
			shift
			;;
		--)
			shift
			break
			;;
		-*)
			usage
			;;
		*)
			break
			;;
		esac
		shift
	done

	test $summary_limit = 0 && return

	if rev=$(git rev-parse -q --verify --default HEAD ${1+"$1"})
	then
		head=$rev
		test $# = 0 || shift
	elif test -z "$1" -o "$1" = "HEAD"
	then
		# before the first commit: compare with an empty tree
		head=$(git hash-object -w -t tree --stdin </dev/null)
		test -z "$1" || shift
	else
		head="HEAD"
	fi

	if [ -n "$files" ]
	then
		test -n "$cached" &&
		die "--cached cannot be used with --files"
		diff_cmd=diff-files
		head=
	fi

	cd_to_toplevel
	# Get modified modules cared by user
	modules=$(git $diff_cmd $cached --ignore-submodules=dirty --raw $head -- "$@" |
		sane_egrep '^:([0-7]* )?160000' |
		while read mod_src mod_dst sha1_src sha1_dst status name
		do
			# Always show modules deleted or type-changed (blob<->module)
			test $status = D -o $status = T && echo "$name" && continue
			# Also show added or modified modules which are checked out
			GIT_DIR="$name/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
			echo "$name"
		done
	)

	test -z "$modules" && return

	git $diff_cmd $cached --ignore-submodules=dirty --raw $head -- $modules |
	sane_egrep '^:([0-7]* )?160000' |
	cut -c2- |
	while read mod_src mod_dst sha1_src sha1_dst status name
	do
		if test -z "$cached" &&
			test $sha1_dst = 0000000000000000000000000000000000000000
		then
			case "$mod_dst" in
			160000)
				sha1_dst=$(GIT_DIR="$name/.git" git rev-parse HEAD)
				;;
			100644 | 100755 | 120000)
				sha1_dst=$(git hash-object $name)
				;;
			000000)
				;; # removed
			*)
				# unexpected type
				echo >&2 "unexpected mode $mod_dst"
				continue ;;
			esac
		fi
		missing_src=
		missing_dst=

		test $mod_src = 160000 &&
		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 >/dev/null &&
		missing_src=t

		test $mod_dst = 160000 &&
		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_dst^0 >/dev/null &&
		missing_dst=t

		total_commits=
		case "$missing_src,$missing_dst" in
		t,)
			errmsg="  Warn: $name doesn't contain commit $sha1_src"
			;;
		,t)
			errmsg="  Warn: $name doesn't contain commit $sha1_dst"
			;;
		t,t)
			errmsg="  Warn: $name doesn't contain commits $sha1_src and $sha1_dst"
			;;
		*)
			errmsg=
			total_commits=$(
			if test $mod_src = 160000 -a $mod_dst = 160000
			then
				range="$sha1_src...$sha1_dst"
			elif test $mod_src = 160000
			then
				range=$sha1_src
			else
				range=$sha1_dst
			fi
			GIT_DIR="$name/.git" \
			git rev-list --first-parent $range -- | wc -l
			)
			total_commits=" ($(($total_commits + 0)))"
			;;
		esac

		sha1_abbr_src=$(echo $sha1_src | cut -c1-7)
		sha1_abbr_dst=$(echo $sha1_dst | cut -c1-7)
		if test $status = T
		then
			if test $mod_dst = 160000
			then
				echo "* $name $sha1_abbr_src(blob)->$sha1_abbr_dst(submodule)$total_commits:"
			else
				echo "* $name $sha1_abbr_src(submodule)->$sha1_abbr_dst(blob)$total_commits:"
			fi
		else
			echo "* $name $sha1_abbr_src...$sha1_abbr_dst$total_commits:"
		fi
		if test -n "$errmsg"
		then
			# Don't give error msg for modification whose dst is not submodule
			# i.e. deleted or changed to blob
			test $mod_dst = 160000 && echo "$errmsg"
		else
			if test $mod_src = 160000 -a $mod_dst = 160000
			then
				limit=
				test $summary_limit -gt 0 && limit="-$summary_limit"
				GIT_DIR="$name/.git" \
				git log $limit --pretty='format:  %m %s' \
				--first-parent $sha1_src...$sha1_dst
			elif test $mod_dst = 160000
			then
				GIT_DIR="$name/.git" \
				git log --pretty='format:  > %s' -1 $sha1_dst
			else
				GIT_DIR="$name/.git" \
				git log --pretty='format:  < %s' -1 $sha1_src
			fi
			echo
		fi
		echo
	done |
	if test -n "$for_status"; then
		if [ -n "$files" ]; then
			echo "# Submodules changed but not updated:"
		else
			echo "# Submodule changes to be committed:"
		fi
		echo "#"
		sed -e 's|^|# |' -e 's|^# $|#|'
	else
		cat
	fi
}
#
# List all submodules, prefixed with:
#  - submodule not initialized
#  + different revision checked out
#
# If --cached was specified the revision in the index will be printed
# instead of the currently checked out revision.
#
# $@ = requested paths (default to all)
#
cmd_status()
{
	# parse $args after "submodule ... status".
	orig_args="$@"
	while test $# -ne 0
	do
		case "$1" in
		-q|--quiet)
			GIT_QUIET=1
			;;
		--cached)
			cached=1
			;;
		--recursive)
			recursive=1
			;;
		--)
			shift
			break
			;;
		-*)
			usage
			;;
		*)
			break
			;;
		esac
		shift
	done

	module_list "$@" |
	while read mode sha1 stage path
	do
		name=$(module_name "$path") || exit
		url=$(git config submodule."$name".url)
		displaypath="$prefix$path"
		if test -z "$url" || ! test -d "$path"/.git -o -f "$path"/.git
		then
			say "-$sha1 $displaypath"
			continue;
		fi
		set_name_rev "$path" "$sha1"
		if git diff-files --ignore-submodules=dirty --quiet -- "$path"
		then
			say " $sha1 $displaypath$revname"
		else
			if test -z "$cached"
			then
				sha1=$(clear_local_git_env; cd "$path" && git rev-parse --verify HEAD)
				set_name_rev "$path" "$sha1"
			fi
			say "+$sha1 $displaypath$revname"
		fi

		if test -n "$recursive"
		then
			(
				prefix="$displaypath/"
				clear_local_git_env
				cd "$path" &&
				cmd_status $orig_args
			) ||
			die "Failed to recurse into submodule path '$path'"
		fi
	done
}
#
# Sync remote urls for submodules
# This makes the value for remote.$remote.url match the value
# specified in .gitmodules.
#
cmd_sync()
{
	while test $# -ne 0
	do
		case "$1" in
		-q|--quiet)
			GIT_QUIET=1
			shift
			;;
		--)
			shift
			break
			;;
		-*)
			usage
			;;
		*)
			break
			;;
		esac
	done
	cd_to_toplevel
	module_list "$@" |
	while read mode sha1 stage path
	do
		name=$(module_name "$path")
		url=$(git config -f .gitmodules --get submodule."$name".url)

		# Possibly a url relative to parent
		case "$url" in
		./*|../*)
			url=$(resolve_relative_url "$url") || exit
			;;
		esac

		if test -e "$path"/.git
		then
		(
			say "Synchronizing submodule url for '$name'"
			git config submodule."$name".url "$url"
			clear_local_git_env
			cd "$path"
			remote=$(get_default_remote)
			git config remote."$remote".url "$url"
		)
		fi
	done
}

# This loop parses the command line arguments to find the
# subcommand name to dispatch.  Parsing of the subcommand specific
# options are primarily done by the subcommand implementations.
# Subcommand specific options such as --branch and --cached are
# parsed here as well, for backward compatibility.

while test $# != 0 && test -z "$command"
do
	case "$1" in
	add | foreach | init | update | status | summary | sync)
		command=$1
		;;
	-q|--quiet)
		GIT_QUIET=1
		;;
	-b|--branch)
		case "$2" in
		'')
			usage
			;;
		esac
		branch="$2"; shift
		;;
	--cached)
		cached="$1"
		;;
	--)
		break
		;;
	-*)
		usage
		;;
	*)
		break
		;;
	esac
	shift
done

# No command word defaults to "status"
test -n "$command" || command=status

# "-b branch" is accepted only by "add"
if test -n "$branch" && test "$command" != add
then
	usage
fi

# "--cached" is accepted only by "status" and "summary"
if test -n "$cached" && test "$command" != status -a "$command" != summary
then
	usage
fi

"cmd_$command" "$@"

--------------010306030401030700010505--
