From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [RFC] Using sticky directories to control access to branches.
Date: Thu, 1 Dec 2005 08:42:22 -0700
Organization: Hewlett Packard
Message-ID: <20051201154222.GB18993@hpsvcnb.fc.hp.com>
References: <20051117170129.GA14013@hpsvcnb.fc.hp.com> <7vfypumlu3.fsf@assigned-by-dhcp.cox.net> <20051121180133.GA28171@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Dec 01 16:47:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhqZt-000710-3r
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 16:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVLAPmZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 10:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbVLAPmY
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 10:42:24 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:57991 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932295AbVLAPmX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 10:42:23 -0500
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.11.136.119])
	by atlrel6.hp.com (Postfix) with ESMTP id E02B919B28;
	Thu,  1 Dec 2005 10:42:22 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP
	id A16A9381E6; Thu,  1 Dec 2005 15:42:22 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 8DD614095; Thu,  1 Dec 2005 08:42:22 -0700 (MST)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051121180133.GA28171@hpsvcnb.fc.hp.com>
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13062>

I have tweaked the script a little.  I thought I'd send to the list in
case anyone was following this.  If not, then safely ignore this.

#!/bin/bash

umask 002

# If you are having trouble with this access control hook script you can try
# setting this to true.  It will tell you exactly why a user is being
# allowed/denied access.
verbose=false

# Default shell globbing messes things up downstream
GLOBIGNORE=*

function grant {
  $verbose && echo >&2 "-Grant-		$1"
  echo grant
  exit 0
}

function deny {
  $verbose && echo >&2 "-Deny-		$1"
  echo deny
  exit 1
}

function info {
  $verbose && echo >&2 "-Info-		$1"
}

# Implement generic branch and tag policies.
# - Tags should not be updated once created.
# - Branches should only be fast-forwarded.
case "$1" in
  refs/tags/*)
    [ -f "$GIT_DIR/$1" ] && deny >/dev/null "You can't overwrite an existing tag"
    ;;
  refs/heads/*)
    # No rebasing or rewinding
    if expr "$2" : '0*$' >/dev/null; then
      info "The branch '$1' is new..."
    else
      # updating -- make sure it is a fast forward
      mb=$(git-merge-base "$2" "$3")
      case "$mb,$2" in
        "$2,$mb") info "Update is fast-forward" ;;
        *)        deny >/dev/null  "This is not a fast-forward update." ;;
      esac
    fi
    ;;
  *)
    deny >/dev/null "Branch is not under refs/heads or refs/tags.  What are you trying to do?"
    ;;
esac

# Implement per-branch controls based on username
allowed_users_file=$GIT_DIR/info/allowed-users
username=$(id -u -n)
info "The user is: '$username'"

if [ -f "$allowed_users_file" ]; then
  rc=$(cat $allowed_users_file | grep -v '^#' | grep -v '^$' |
    while read head_pattern user_patterns; do
      matchlen=$(expr "$1" : "$head_pattern")
      if [ "$matchlen" == "${#1}" ]; then
        info "Found matching head pattern: '$head_pattern'"
        for user_pattern in $user_patterns; do
          info "Checking user: '$username' against pattern: '$user_pattern'"
          matchlen=$(expr "$username" : "$user_pattern")
          if [ "$matchlen" == "${#username}" ]; then
            grant "Allowing user: '$username' with pattern: '$user_pattern'"
          fi
        done
        deny "The user is not in the access list for this branch"
      fi
    done
  )
  case "$rc" in
    grant) grant >/dev/null "Granting access based on $allowed_users_file" ;;
    deny)  deny  >/dev/null "Denying  access based on $allowed_users_file" ;;
    *) ;;
  esac
fi

allowed_groups_file=$GIT_DIR/info/allowed-groups
groups=$(id -G -n)
info "The user belongs to the following groups:"
info "'$groups'"

if [ -f "$allowed_groups_file" ]; then
  rc=$(cat $allowed_groups_file | grep -v '^#' | grep -v '^$' |
    while read head_pattern group_patterns; do
      matchlen=$(expr "$1" : "$head_pattern")
      if [ "$matchlen" == "${#1}" ]; then
        info "Found matching head pattern: '$head_pattern'"
        for group_pattern in $group_patterns; do
          for groupname in $groups; do
            info "Checking group: '$groupname' against pattern: '$group_pattern'"
            matchlen=$(expr "$groupname" : "$group_pattern")
            if [ "$matchlen" == "${#groupname}" ]; then
              grant "Allowing group: '$groupname' with pattern: '$group_pattern'"
            fi
          done
        done
        deny "None of the user's groups are in the access list for this branch"
      fi
    done
  )
  case "$rc" in
    grant) grant >/dev/null "Granting access based on $allowed_groups_file" ;;
    deny)  deny  >/dev/null "Denying  access based on $allowed_groups_file" ;;
    *) ;;
  esac
fi

deny >/dev/null "There are no more rules to check.  Denying access"
On Mon, Nov 21, 2005 at 11:01:33AM -0700, Carl Baldwin wrote:
> OK,
> 
> To follow-up on this.  Here is a final version of this script that was
> started by Junio.  I polished it and made it work the way I want it.
> Hopefully, someone on the list will find it useful.
> 
> Here is a basic description.  There are two files:
> .git/info/allowed-users
> .git/info/allowed-groups
> 
> The users file is checked, line by line, followed by the groups file.
> The first line matching the ref to be updated is used.  Each line has
> one regular expression to match the ref followed by one or more regular
> expressions to match user (or group).  Space is the delimeter so the RE
> cannot contain a space.
> 
> If no line matches the ref then access is denied.  For this reason I
> tend to include the following line as the last line of allowed-groups as
> the default since it will match any ref and any group.
> 
> .* .*
> 
> Here is the hook script...  Thanks to Junio for getting me started.  I
> rewrote the whole thing using my own style but much of the code is based
> on his.
> 
> #!/bin/bash
> 
> umask 002
> 
> verbose=no
> 
> # Default shell globbing messes things up later
> GLOBIGNORE=*
> 
> function grant {
>   [ "yes" == "$verbose" ] && echo >&2 "-Grant-		$1"
>   exit 0
> }
> 
> function deny {
>   [ "yes" == "$verbose" ] && echo >&2 "-Deny-		$1"
>   exit 1
> }
> 
> function info {
>   [ "yes" == "$verbose" ] && echo >&2 "-Info-		$1"
> }
> 
> # Implement generic branch and tag policies.
> # - Tags should not be updated once created.
> # - Branches should only be fast-forwarded.
> case "$1" in
>   refs/tags/*)
>     [ -f "$GIT_DIR/$1" ] && deny "You can't overwrite an existing tag"
>     ;;
>   refs/heads/*)
>     # No rebasing or rewinding
>     if expr "$2" : '0*$' >/dev/null; then
>       info "The branch '$1' is new..."
>     else
>       # updating -- make sure it is a fast forward
>       mb=$(git-merge-base "$2" "$3")
>       case "$mb,$2" in
>         "$2,$mb") info "Update is fast-forward" ;;
>         *)        deny  "This is not a fast-forward update." ;;
>       esac
>     fi
>     ;;
>   *)
>     deny "Branch is not under refs/heads or refs/tags.  What are you trying to do?"
>     ;;
> esac
> 
> # Implement per-branch controls based on username
> allowed_users_file=$GIT_DIR/info/allowed-users
> username=$(id -u -n)
> info "The user is: '$username'"
> 
> if [ -f "$allowed_users_file" ]; then
>   3<$allowed_users_file
>   while read -u 3 head_pattern user_patterns; do
>     matchlen=$(expr "$1" : "$head_pattern")
>     if [ "$matchlen" == "${#1}" ]; then
>       info "Found matching head pattern: '$head_pattern'"
>       for user_pattern in $user_patterns; do
>         info "Checking user: '$username' against pattern: '$user_pattern'"
>         matchlen=$(expr "$username" : "$user_pattern")
>         if [ "$matchlen" == "${#username}" ]; then
>           grant "Allowing user: '$username' with pattern: '$user_pattern'"
>         fi
>       done
>       deny "The user is not in the access list for this branch"
>     fi
>   done
> fi
> 
> allowed_groups_file=$GIT_DIR/info/allowed-groups
> groups=$(id -G -n)
> info "The user belongs to the following groups:"
> info "'$groups'"
> 
> if [ -f "$allowed_groups_file" ]; then
>   4<$allowed_groups_file
>   while read -u 4 head_pattern group_patterns; do
>     matchlen=$(expr "$1" : "$head_pattern")
>     if [ "$matchlen" == "${#1}" ]; then
>       info "Found matching head pattern: '$head_pattern'"
>       for group_pattern in $group_patterns; do
>         for groupname in $groups; do
>           info "Checking group: '$groupname' against pattern: '$group_pattern'"
>           matchlen=$(expr "$groupname" : "$group_pattern")
>           if [ "$matchlen" == "${#groupname}" ]; then
>             grant "Allowing group: '$groupname' with pattern: '$group_pattern'"
>           fi
>         done
>       done
>       deny "None of the user's groups are in the access list for this branch"
>     fi
>   done
> fi
> 
> deny "There are no more rules to check.  Denying access"
> # End script here
> 
> Carl
> 
> -- 
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>  Carl Baldwin                        Systems VLSI Laboratory
>  Hewlett Packard Company
>  MS 88                               work: 970 898-1523
>  3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
>  Fort Collins, CO 80525              home: Carl@ecBaldwin.net
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
