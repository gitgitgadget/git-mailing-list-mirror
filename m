From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFH] xdiff shows trivially redundant diff.
Date: Sun, 02 Apr 2006 14:02:26 -0700
Message-ID: <7vzmj3k7x9.fsf@assigned-by-dhcp.cox.net>
References: <7v4q1cmj7l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604021035130.30097@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 02 23:02:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQ9ic-00017p-MG
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 23:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWDBVCa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 17:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWDBVC3
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 17:02:29 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:51084 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932295AbWDBVC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Apr 2006 17:02:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060402210227.UKWY20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Apr 2006 17:02:27 -0400
To: Davide Libenzi <davidel@xmailserver.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18284>

--=-=-=

Davide Libenzi <davidel@xmailserver.org> writes:

> On Sun, 2 Apr 2006, Junio C Hamano wrote:
>
>> $ git diff-tree -p 52e8a6^2 52d8a6 -- git-fetch.sh
>>
>> shows a change that trivially is redundant, like this:
>>
>>    diff --git a/git-fetch.sh b/git-fetch.sh
>>    index b4325d9..de4f011 100755
>>    --- a/git-fetch.sh
>>    +++ b/git-fetch.sh
>>    @@ -320,7 +320,7 @@ fetch_main () {
>>..
>> Notice the first '-' and '+' lines of second hunk are identical?
>>
>> There is another interesting thing.  This is running diff
>> between 52e8a6^2 and 52d8a6 blobs, but if I change them slightly
>> so that the first hunk is not different, then this anomaly
>> disappears.
>
> Could you send me the two files that creates the above diff?

I should have tried your pristine xdiff code myself before
bothering you, but I haven't (sorry).

The problem is from the "stripped down" version we use in git,
so you may or may not see the problem in your version.  Attached
are the files.


--=-=-=
Content-Disposition: attachment; filename=F.b4325d9
Content-Description: diff test preimage

#!/bin/sh
#

USAGE='<fetch-options> <repository> <refspec>...'
. git-sh-setup
. git-parse-remote
_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"

LF='
'
IFS="$LF"

no_tags=
tags=
append=
force=
verbose=
update_head_ok=
exec=
upload_pack=
while case "$#" in 0) break ;; esac
do
	case "$1" in
	-a|--a|--ap|--app|--appe|--appen|--append)
		append=t
		;;
	--upl|--uplo|--uploa|--upload|--upload-|--upload-p|\
	--upload-pa|--upload-pac|--upload-pack)
		shift
		exec="--exec=$1" 
		upload_pack="-u $1"
		;;
	-f|--f|--fo|--for|--forc|--force)
		force=t
		;;
	-t|--t|--ta|--tag|--tags)
		tags=t
		;;
	-n|--n|--no|--no-|--no-t|--no-ta|--no-tag|--no-tags)
		no_tags=t
		;;
	-u|--u|--up|--upd|--upda|--updat|--update|--update-|--update-h|\
	--update-he|--update-hea|--update-head|--update-head-|\
	--update-head-o|--update-head-ok)
		update_head_ok=t
		;;
	-v|--verbose)
		verbose=Yes
		;;
	-k|--k|--ke|--kee|--keep)
		keep=--keep
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

case "$#" in
0)
	test -f "$GIT_DIR/branches/origin" ||
		test -f "$GIT_DIR/remotes/origin" ||
			die "Where do you want to fetch from today?"
	set origin ;;
esac

remote_nick="$1"
remote=$(get_remote_url "$@")
refs=
rref=
rsync_slurped_objects=

if test "" = "$append"
then
	: >"$GIT_DIR/FETCH_HEAD"
fi

append_fetch_head () {
    head_="$1"
    remote_="$2"
    remote_name_="$3"
    remote_nick_="$4"
    local_name_="$5"
    case "$6" in
    t) not_for_merge_='not-for-merge' ;;
    '') not_for_merge_= ;;
    esac

    # remote-nick is the URL given on the command line (or a shorthand)
    # remote-name is the $GIT_DIR relative refs/ path we computed
    # for this refspec.
    case "$remote_name_" in
    HEAD)
	note_= ;;
    refs/heads/*)
	note_="$(expr "$remote_name_" : 'refs/heads/\(.*\)')"
	note_="branch '$note_' of " ;;
    refs/tags/*)
	note_="$(expr "$remote_name_" : 'refs/tags/\(.*\)')"
	note_="tag '$note_' of " ;;
    *)
	note_="$remote_name of " ;;
    esac
    remote_1_=$(expr "$remote_" : '\(.*\)\.git/*$') &&
	remote_="$remote_1_"
    note_="$note_$remote_"

    # 2.6.11-tree tag would not be happy to be fed to resolve.
    if git-cat-file commit "$head_" >/dev/null 2>&1
    then
	headc_=$(git-rev-parse --verify "$head_^0") || exit
	echo "$headc_	$not_for_merge_	$note_" >>"$GIT_DIR/FETCH_HEAD"
	[ "$verbose" ] && echo >&2 "* committish: $head_"
	[ "$verbose" ] && echo >&2 "  $note_"
    else
	echo "$head_	not-for-merge	$note_" >>"$GIT_DIR/FETCH_HEAD"
	[ "$verbose" ] && echo >&2 "* non-commit: $head_"
	[ "$verbose" ] && echo >&2 "  $note_"
    fi
    if test "$local_name_" != ""
    then
	# We are storing the head locally.  Make sure that it is
	# a fast forward (aka "reverse push").
	fast_forward_local "$local_name_" "$head_" "$note_"
    fi
}

fast_forward_local () {
    mkdir -p "$(dirname "$GIT_DIR/$1")"
    case "$1" in
    refs/tags/*)
	# Tags need not be pointing at commits so there
	# is no way to guarantee "fast-forward" anyway.
	if test -f "$GIT_DIR/$1"
	then
		if now_=$(cat "$GIT_DIR/$1") && test "$now_" = "$2"
		then
			[ "$verbose" ] && echo >&2 "* $1: same as $3"
		else
			echo >&2 "* $1: updating with $3"
		fi
	else
		echo >&2 "* $1: storing $3"
	fi
	git-update-ref "$1" "$2" 
	;;

    refs/heads/*)
	# $1 is the ref being updated.
	# $2 is the new value for the ref.
	local=$(git-rev-parse --verify "$1^0" 2>/dev/null)
	if test "$local"
	then
	    # Require fast-forward.
	    mb=$(git-merge-base "$local" "$2") &&
	    case "$2,$mb" in
	    $local,*)
		echo >&2 "* $1: same as $3"
		;;
	    *,$local)
		echo >&2 "* $1: fast forward to $3"
		git-update-ref "$1" "$2" "$local"
		;;
	    *)
		false
		;;
	    esac || {
		echo >&2 "* $1: does not fast forward to $3;"
		case ",$force,$single_force," in
		*,t,*)
			echo >&2 "  forcing update."
			git-update-ref "$1" "$2" "$local"
			;;
		*)
			echo >&2 "  not updating."
			;;
		esac
	    }
	else
	    echo >&2 "* $1: storing $3"
	    git-update-ref "$1" "$2"
	fi
	;;
    esac
}

case "$update_head_ok" in
'')
	orig_head=$(git-rev-parse --verify HEAD 2>/dev/null)
	;;
esac

# If --tags (and later --heads or --all) is specified, then we are
# not talking about defaults stored in Pull: line of remotes or
# branches file, and just fetch those and refspecs explicitly given.
# Otherwise we do what we always did.

reflist=$(get_remote_refs_for_fetch "$@")
if test "$tags"
then
	taglist=$(IFS="	" &&
		  git-ls-remote $upload_pack --tags "$remote" |
	          while read sha1 name
		  do
			case "$name" in
			(*^*) continue ;;
			esac
		  	if git-check-ref-format "$name"
			then
			    echo ".${name}:${name}"
			else
			    echo >&2 "warning: tag ${name} ignored"
			fi
		  done)
	if test "$#" -gt 1
	then
		# remote URL plus explicit refspecs; we need to merge them.
		reflist="$reflist$LF$taglist"
	else
		# No explicit refspecs; fetch tags only.
		reflist=$taglist
	fi
fi

fetch_main () {
  reflist="$1"
  refs=

  for ref in $reflist
  do
      refs="$refs$LF$ref"

      # These are relative path from $GIT_DIR, typically starting at refs/
      # but may be HEAD
      if expr "$ref" : '\.' >/dev/null
      then
	  not_for_merge=t
	  ref=$(expr "$ref" : '\.\(.*\)')
      else
	  not_for_merge=
      fi
      if expr "$ref" : '\+' >/dev/null
      then
	  single_force=t
	  ref=$(expr "$ref" : '\+\(.*\)')
      else
	  single_force=
      fi
      remote_name=$(expr "$ref" : '\([^:]*\):')
      local_name=$(expr "$ref" : '[^:]*:\(.*\)')

      rref="$rref$LF$remote_name"

      # There are transports that can fetch only one head at a time...
      case "$remote" in
      http://* | https://*)
	  if [ -n "$GIT_SSL_NO_VERIFY" ]; then
	      curl_extra_args="-k"
	  fi
	  remote_name_quoted=$(perl -e '
	      my $u = $ARGV[0];
	      $u =~ s{([^-a-zA-Z0-9/.])}{sprintf"%%%02x",ord($1)}eg;
	      print "$u";
	  ' "$remote_name")
	  head=$(curl -nsfL $curl_extra_args "$remote/$remote_name_quoted") &&
	  expr "$head" : "$_x40\$" >/dev/null ||
		  die "Failed to fetch $remote_name from $remote"
	  echo >&2 Fetching "$remote_name from $remote" using http
	  git-http-fetch -v -a "$head" "$remote/" || exit
	  ;;
      rsync://*)
	  TMP_HEAD="$GIT_DIR/TMP_HEAD"
	  rsync -L -q "$remote/$remote_name" "$TMP_HEAD" || exit 1
	  head=$(git-rev-parse --verify TMP_HEAD)
	  rm -f "$TMP_HEAD"
	  test "$rsync_slurped_objects" || {
	      rsync -av --ignore-existing --exclude info \
		  "$remote/objects/" "$GIT_OBJECT_DIRECTORY/" || exit

	      # Look at objects/info/alternates for rsync -- http will
	      # support it natively and git native ones will do it on
	      # the remote end.  Not having that file is not a crime.
	      rsync -q "$remote/objects/info/alternates" \
		  "$GIT_DIR/TMP_ALT" 2>/dev/null ||
		  rm -f "$GIT_DIR/TMP_ALT"
	      if test -f "$GIT_DIR/TMP_ALT"
	      then
		  resolve_alternates "$remote" <"$GIT_DIR/TMP_ALT" |
		  while read alt
		  do
		      case "$alt" in 'bad alternate: '*) die "$alt";; esac
		      echo >&2 "Getting alternate: $alt"
		      rsync -av --ignore-existing --exclude info \
		      "$alt" "$GIT_OBJECT_DIRECTORY/" || exit
		  done
		  rm -f "$GIT_DIR/TMP_ALT"
	      fi
	      rsync_slurped_objects=t
	  }
	  ;;
      *)
	  # We will do git native transport with just one call later.
	  continue ;;
      esac

      append_fetch_head "$head" "$remote" \
	  "$remote_name" "$remote_nick" "$local_name" "$not_for_merge"

  done

  case "$remote" in
  http://* | https://* | rsync://* )
      ;; # we are already done.
  *)
    ( : subshell because we muck with IFS
      IFS=" 	$LF"
      (
	  git-fetch-pack $exec $keep "$remote" $rref || echo failed "$remote"
      ) |
      while read sha1 remote_name
      do
	  case "$sha1" in
	  failed)
		  echo >&2 "Fetch failure: $remote"
		  exit 1 ;;
	  esac
	  found=
	  single_force=
	  for ref in $refs
	  do
	      case "$ref" in
	      +$remote_name:*)
		  single_force=t
		  not_for_merge=
		  found="$ref"
		  break ;;
	      .+$remote_name:*)
		  single_force=t
		  not_for_merge=t
		  found="$ref"
		  break ;;
	      .$remote_name:*)
		  not_for_merge=t
		  found="$ref"
		  break ;;
	      $remote_name:*)
		  not_for_merge=
		  found="$ref"
		  break ;;
	      esac
	  done
	  local_name=$(expr "$found" : '[^:]*:\(.*\)')
	  append_fetch_head "$sha1" "$remote" \
		  "$remote_name" "$remote_nick" "$local_name" "$not_for_merge"
      done
    ) || exit ;;
  esac

}

fetch_main "$reflist"

# automated tag following
case "$no_tags$tags" in
'')
	taglist=$(IFS=" " &&
	git-ls-remote $upload_pack --tags "$remote" |
	sed -ne 's|^\([0-9a-f]*\)[ 	]\(refs/tags/.*\)^{}$|\1 \2|p' |
	while read sha1 name
	do
		test -f "$GIT_DIR/$name" && continue
	  	git-check-ref-format "$name" || {
			echo >&2 "warning: tag ${name} ignored"
			continue
		}
		git-cat-file -t "$sha1" >/dev/null 2>&1 || continue
		echo >&2 "Auto-following $name"
		echo ".${name}:${name}"
	done)
	case "$taglist" in
	'') ;;
	?*)
		fetch_main "$taglist" ;;
	esac
esac

# If the original head was empty (i.e. no "master" yet), or
# if we were told not to worry, we do not have to check.
case ",$update_head_ok,$orig_head," in
*,, | t,* )
	;;
*)
	curr_head=$(git-rev-parse --verify HEAD 2>/dev/null)
	if test "$curr_head" != "$orig_head"
	then
	    	git-update-ref HEAD "$orig_head"
		die "Cannot fetch into the current branch."
	fi
	;;
esac

--=-=-=
Content-Disposition: attachment; filename=F.de4f011
Content-Description: diff test postimage

#!/bin/sh
#

USAGE='<fetch-options> <repository> <refspec>...'
. git-sh-setup
. git-parse-remote
_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"

LF='
'
IFS="$LF"

no_tags=
tags=
append=
force=
verbose=
update_head_ok=
exec=
upload_pack=
while case "$#" in 0) break ;; esac
do
	case "$1" in
	-a|--a|--ap|--app|--appe|--appen|--append)
		append=t
		;;
	--upl|--uplo|--uploa|--upload|--upload-|--upload-p|\
	--upload-pa|--upload-pac|--upload-pack)
		shift
		exec="--exec=$1" 
		upload_pack="-u $1"
		;;
	-f|--f|--fo|--for|--forc|--force)
		force=t
		;;
	-t|--t|--ta|--tag|--tags)
		tags=t
		;;
	-n|--n|--no|--no-|--no-t|--no-ta|--no-tag|--no-tags)
		no_tags=t
		;;
	-u|--u|--up|--upd|--upda|--updat|--update|--update-|--update-h|\
	--update-he|--update-hea|--update-head|--update-head-|\
	--update-head-o|--update-head-ok)
		update_head_ok=t
		;;
	-v|--verbose)
		verbose=Yes
		;;
	-k|--k|--ke|--kee|--keep)
		keep=--keep
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

case "$#" in
0)
	test -f "$GIT_DIR/branches/origin" ||
		test -f "$GIT_DIR/remotes/origin" ||
			die "Where do you want to fetch from today?"
	set origin ;;
esac

remote_nick="$1"
remote=$(get_remote_url "$@")
refs=
rref=
rsync_slurped_objects=

if test "" = "$append"
then
	: >"$GIT_DIR/FETCH_HEAD"
fi

append_fetch_head () {
    head_="$1"
    remote_="$2"
    remote_name_="$3"
    remote_nick_="$4"
    local_name_="$5"
    case "$6" in
    t) not_for_merge_='not-for-merge' ;;
    '') not_for_merge_= ;;
    esac

    # remote-nick is the URL given on the command line (or a shorthand)
    # remote-name is the $GIT_DIR relative refs/ path we computed
    # for this refspec.
    case "$remote_name_" in
    HEAD)
	note_= ;;
    refs/heads/*)
	note_="$(expr "$remote_name_" : 'refs/heads/\(.*\)')"
	note_="branch '$note_' of " ;;
    refs/tags/*)
	note_="$(expr "$remote_name_" : 'refs/tags/\(.*\)')"
	note_="tag '$note_' of " ;;
    *)
	note_="$remote_name of " ;;
    esac
    remote_1_=$(expr "$remote_" : '\(.*\)\.git/*$') &&
	remote_="$remote_1_"
    note_="$note_$remote_"

    # 2.6.11-tree tag would not be happy to be fed to resolve.
    if git-cat-file commit "$head_" >/dev/null 2>&1
    then
	headc_=$(git-rev-parse --verify "$head_^0") || exit
	echo "$headc_	$not_for_merge_	$note_" >>"$GIT_DIR/FETCH_HEAD"
	[ "$verbose" ] && echo >&2 "* committish: $head_"
	[ "$verbose" ] && echo >&2 "  $note_"
    else
	echo "$head_	not-for-merge	$note_" >>"$GIT_DIR/FETCH_HEAD"
	[ "$verbose" ] && echo >&2 "* non-commit: $head_"
	[ "$verbose" ] && echo >&2 "  $note_"
    fi
    if test "$local_name_" != ""
    then
	# We are storing the head locally.  Make sure that it is
	# a fast forward (aka "reverse push").
	fast_forward_local "$local_name_" "$head_" "$note_"
    fi
}

fast_forward_local () {
    mkdir -p "$(dirname "$GIT_DIR/$1")"
    case "$1" in
    refs/tags/*)
	# Tags need not be pointing at commits so there
	# is no way to guarantee "fast-forward" anyway.
	if test -f "$GIT_DIR/$1"
	then
		if now_=$(cat "$GIT_DIR/$1") && test "$now_" = "$2"
		then
			[ "$verbose" ] && echo >&2 "* $1: same as $3"
		else
			echo >&2 "* $1: updating with $3"
		fi
	else
		echo >&2 "* $1: storing $3"
	fi
	git-update-ref "$1" "$2" 
	;;

    refs/heads/*)
	# $1 is the ref being updated.
	# $2 is the new value for the ref.
	local=$(git-rev-parse --verify "$1^0" 2>/dev/null)
	if test "$local"
	then
	    # Require fast-forward.
	    mb=$(git-merge-base "$local" "$2") &&
	    case "$2,$mb" in
	    $local,*)
		echo >&2 "* $1: same as $3"
		;;
	    *,$local)
		echo >&2 "* $1: fast forward to $3"
		git-update-ref "$1" "$2" "$local"
		;;
	    *)
		false
		;;
	    esac || {
		echo >&2 "* $1: does not fast forward to $3;"
		case ",$force,$single_force," in
		*,t,*)
			echo >&2 "  forcing update."
			git-update-ref "$1" "$2" "$local"
			;;
		*)
			echo >&2 "  not updating."
			;;
		esac
	    }
	else
	    echo >&2 "* $1: storing $3"
	    git-update-ref "$1" "$2"
	fi
	;;
    esac
}

case "$update_head_ok" in
'')
	orig_head=$(git-rev-parse --verify HEAD 2>/dev/null)
	;;
esac

# If --tags (and later --heads or --all) is specified, then we are
# not talking about defaults stored in Pull: line of remotes or
# branches file, and just fetch those and refspecs explicitly given.
# Otherwise we do what we always did.

reflist=$(get_remote_refs_for_fetch "$@")
if test "$tags"
then
	taglist=$(IFS="	" &&
		  git-ls-remote $upload_pack --tags "$remote" |
	          while read sha1 name
		  do
			case "$name" in
			(*^*) continue ;;
			esac
		  	if git-check-ref-format "$name"
			then
			    echo ".${name}:${name}"
			else
			    echo >&2 "warning: tag ${name} ignored"
			fi
		  done)
	if test "$#" -gt 1
	then
		# remote URL plus explicit refspecs; we need to merge them.
		reflist="$reflist$LF$taglist"
	else
		# No explicit refspecs; fetch tags only.
		reflist=$taglist
	fi
fi

fetch_main () {
  reflist="$1"
  refs=

  for ref in $reflist
  do
      refs="$refs$LF$ref"

      # These are relative path from $GIT_DIR, typically starting at refs/
      # but may be HEAD
      if expr "$ref" : '\.' >/dev/null
      then
	  not_for_merge=t
	  ref=$(expr "$ref" : '\.\(.*\)')
      else
	  not_for_merge=
      fi
      if expr "$ref" : '\+' >/dev/null
      then
	  single_force=t
	  ref=$(expr "$ref" : '\+\(.*\)')
      else
	  single_force=
      fi
      remote_name=$(expr "$ref" : '\([^:]*\):')
      local_name=$(expr "$ref" : '[^:]*:\(.*\)')

      rref="$rref$LF$remote_name"

      # There are transports that can fetch only one head at a time...
      case "$remote" in
      http://* | https://*)
	  if [ -n "$GIT_SSL_NO_VERIFY" ]; then
	      curl_extra_args="-k"
	  fi
	  remote_name_quoted=$(perl -e '
	      my $u = $ARGV[0];
	      $u =~ s{([^-a-zA-Z0-9/.])}{sprintf"%%%02x",ord($1)}eg;
	      print "$u";
	  ' "$remote_name")
	  head=$(curl -nsfL $curl_extra_args "$remote/$remote_name_quoted") &&
	  expr "$head" : "$_x40\$" >/dev/null ||
		  die "Failed to fetch $remote_name from $remote"
	  echo >&2 Fetching "$remote_name from $remote" using http
	  git-http-fetch -v -a "$head" "$remote/" || exit
	  ;;
      rsync://*)
	  TMP_HEAD="$GIT_DIR/TMP_HEAD"
	  rsync -L -q "$remote/$remote_name" "$TMP_HEAD" || exit 1
	  head=$(git-rev-parse --verify TMP_HEAD)
	  rm -f "$TMP_HEAD"
	  test "$rsync_slurped_objects" || {
	      rsync -av --ignore-existing --exclude info \
		  "$remote/objects/" "$GIT_OBJECT_DIRECTORY/" || exit

	      # Look at objects/info/alternates for rsync -- http will
	      # support it natively and git native ones will do it on
	      # the remote end.  Not having that file is not a crime.
	      rsync -q "$remote/objects/info/alternates" \
		  "$GIT_DIR/TMP_ALT" 2>/dev/null ||
		  rm -f "$GIT_DIR/TMP_ALT"
	      if test -f "$GIT_DIR/TMP_ALT"
	      then
		  resolve_alternates "$remote" <"$GIT_DIR/TMP_ALT" |
		  while read alt
		  do
		      case "$alt" in 'bad alternate: '*) die "$alt";; esac
		      echo >&2 "Getting alternate: $alt"
		      rsync -av --ignore-existing --exclude info \
		      "$alt" "$GIT_OBJECT_DIRECTORY/" || exit
		  done
		  rm -f "$GIT_DIR/TMP_ALT"
	      fi
	      rsync_slurped_objects=t
	  }
	  ;;
      *)
	  # We will do git native transport with just one call later.
	  continue ;;
      esac

      append_fetch_head "$head" "$remote" \
	  "$remote_name" "$remote_nick" "$local_name" "$not_for_merge"

  done

  case "$remote" in
  http://* | https://* | rsync://* )
      ;; # we are already done.
  *)
    ( : subshell because we muck with IFS
      IFS=" 	$LF"
      (
	  git-fetch-pack $exec $keep --thin "$remote" $rref || echo failed "$remote"
      ) |
      while read sha1 remote_name
      do
	  case "$sha1" in
	  failed)
		  echo >&2 "Fetch failure: $remote"
		  exit 1 ;;
	  esac
	  found=
	  single_force=
	  for ref in $refs
	  do
	      case "$ref" in
	      +$remote_name:*)
		  single_force=t
		  not_for_merge=
		  found="$ref"
		  break ;;
	      .+$remote_name:*)
		  single_force=t
		  not_for_merge=t
		  found="$ref"
		  break ;;
	      .$remote_name:*)
		  not_for_merge=t
		  found="$ref"
		  break ;;
	      $remote_name:*)
		  not_for_merge=
		  found="$ref"
		  break ;;
	      esac
	  done
	  local_name=$(expr "$found" : '[^:]*:\(.*\)')
	  append_fetch_head "$sha1" "$remote" \
		  "$remote_name" "$remote_nick" "$local_name" "$not_for_merge"
      done
    ) || exit ;;
  esac

}

fetch_main "$reflist"

# automated tag following
case "$no_tags$tags" in
'')
	case "$reflist" in
	*:refs/*)
		# effective only when we are following remote branch
		# using local tracking branch.
		taglist=$(IFS=" " &&
		git-ls-remote $upload_pack --tags "$remote" |
		sed -ne 's|^\([0-9a-f]*\)[ 	]\(refs/tags/.*\)^{}$|\1 \2|p' |
		while read sha1 name
		do
			test -f "$GIT_DIR/$name" && continue
			git-check-ref-format "$name" || {
				echo >&2 "warning: tag ${name} ignored"
				continue
			}
			git-cat-file -t "$sha1" >/dev/null 2>&1 || continue
			echo >&2 "Auto-following $name"
			echo ".${name}:${name}"
		done)
	esac
	case "$taglist" in
	'') ;;
	?*)
		fetch_main "$taglist" ;;
	esac
esac

# If the original head was empty (i.e. no "master" yet), or
# if we were told not to worry, we do not have to check.
case ",$update_head_ok,$orig_head," in
*,, | t,* )
	;;
*)
	curr_head=$(git-rev-parse --verify HEAD 2>/dev/null)
	if test "$curr_head" != "$orig_head"
	then
	    	git-update-ref HEAD "$orig_head"
		die "Cannot fetch into the current branch."
	fi
	;;
esac

--=-=-=--
