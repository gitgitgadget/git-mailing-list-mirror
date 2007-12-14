From: =?ISO-8859-1?Q?Jos=E9?= Fonseca <jrfonseca@tungstengraphics.com>
Subject: [RFE/PATCH] git-fetch-rebase
Date: Fri, 14 Dec 2007 22:12:31 +0000
Message-ID: <1197670351.21175.33.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-XoVZi7AfzWJLuXr3SJuD"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 23:13:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3Imj-0005Ut-Rp
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 23:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932808AbXLNWNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 17:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932770AbXLNWNH
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 17:13:07 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:55192 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765543AbXLNWNF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 17:13:05 -0500
Received: by fg-out-1718.google.com with SMTP id e21so4025fga.17
        for <git@vger.kernel.org>; Fri, 14 Dec 2007 14:13:03 -0800 (PST)
Received: by 10.86.60.7 with SMTP id i7mr3489095fga.48.1197670383176;
        Fri, 14 Dec 2007 14:13:03 -0800 (PST)
Received: from ?192.168.0.105? ( [87.196.1.216])
        by mx.google.com with ESMTPS id 12sm13129156fks.2007.12.14.14.12.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Dec 2007 14:13:01 -0800 (PST)
X-Mailer: Evolution 2.12.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68353>


--=-XoVZi7AfzWJLuXr3SJuD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

Hi,

For those who use git as a better centralized SCM, it became a common
practice to do git-fetch + git-rebase instead of just git-pull, so that
the history is linear, instead of being full of tiny merges. 

However, there is no git command for such common procedure (at least
AFAIK). Attached is a variation of the git-pull porcelain (taken from
git version debian.1.5.3.7.1-dirty) that instead of doing git-fetch +
git-merge, it does git-fetch + git-rebase.

I've been using this git-fetch-rebase script frequently, and it really
boosts my productivity (I use it when updating from the main repository,
and before pushing my changes to the main repository).

I'd like see this script, or an equivalent command, included the git
distribution.

Cheers,

Jos� Fonseca

--=-XoVZi7AfzWJLuXr3SJuD
Content-Disposition: attachment; filename=git-fetch-rebase
Content-Type: text/plain; name=git-fetch-rebase; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

#!/bin/sh
#
# Copyright (c) 2007 José Fonseca
# Copyright (c) 2005 Junio C Hamano
#
# Fetch a remote ref and rebase the current HEAD on top of it.

USAGE='[-s strategy]... [<fetch-options>] <repo> <head>'
LONG_USAGE='Fetch a remote ref and rebase the current HEAD onto it.'
SUBDIRECTORY_OK=Yes
. git-sh-setup
set_reflog_action "fetch-rebase $*"
require_work_tree
cd_to_toplevel

test -z "$(git ls-files -u)" ||
	die "You are in the middle of a conflicted merge."

strategy_args=
while :
do
	case "$1" in
	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
		--strateg=*|--strategy=*|\
	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
		case "$#,$1" in
		*,*=*)
			strategy=`expr "z$1" : 'z-[^=]*=\(.*\)'` ;;
		1,*)
			usage ;;
		*)
			strategy="$2"
			shift ;;
		esac
		strategy_args="${strategy_args}-s $strategy "
		;;
	-h|--h|--he|--hel|--help)
		usage
		;;
	*)
		# Pass thru anything that may be meant for fetch.
		break
		;;
	esac
	shift
done

orig_head=$(git rev-parse --verify HEAD 2>/dev/null)
git-fetch "$@" || exit 1

merge_head=$(sed -e '/	not-for-merge	/d' \
	-e 's/	.*//' "$GIT_DIR"/FETCH_HEAD | \
	tr '\012' ' ')

case "$merge_head" in
'')
	curr_branch=$(git symbolic-ref -q HEAD)
	case $? in
	  0) ;;
	  1) echo >&2 "You are not currently on a branch; you must explicitly"
	     echo >&2 "specify which branch you wish to rebase onto:"
	     echo >&2 "  git fetch-rebase <remote> <branch>"
	     exit 1;;
	  *) exit $?;;
	esac
	curr_branch=${curr_branch#refs/heads/}

	echo >&2 "You asked me to rebase without telling me which branch you"
	echo >&2 "want to rebase, and 'branch.${curr_branch}.merge' in"
	echo >&2 "your configuration file does not tell me either.  Please"
	echo >&2 "name which branch you want to rebase on the command line and"
	echo >&2 "try again (e.g. 'git fetch-rebase <repository> <refspec>')."
	echo >&2 "See git-pull(1) for details on the refspec."
	echo >&2
	echo >&2 "If you often rebase to the same branch, you may want to"
	echo >&2 "configure the following variables in your configuration"
	echo >&2 "file:"
	echo >&2
	echo >&2 "    branch.${curr_branch}.remote = <nickname>"
	echo >&2 "    branch.${curr_branch}.merge = <remote-ref>"
	echo >&2 "    remote.<nickname>.url = <url>"
	echo >&2 "    remote.<nickname>.fetch = <refspec>"
	echo >&2
	echo >&2 "See git-config(1) for details."
	exit 1
	;;
?*' '?*)
	echo >&2 "Cannot rebase onto multiple branches"
	exit 1
	;;
esac

if test -z "$orig_head"
then
	echo >&2 "Cannot rebase empty head"
	exit 1
fi

exec git-rebase $strategy_args $merge_head

--=-XoVZi7AfzWJLuXr3SJuD
Content-Disposition: attachment; filename=git-pull_to_git-fetch-rebase.diff
Content-Type: text/x-patch; name=git-pull_to_git-fetch-rebase.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

--- /usr/bin/git-pull	2007-12-04 09:46:21.000000000 +0000
+++ git-fetch-rebase	2007-12-13 12:38:52.000000000 +0000
@@ -1,34 +1,25 @@
 #!/bin/sh
 #
+# Copyright (c) 2007 José Fonseca
 # Copyright (c) 2005 Junio C Hamano
 #
-# Fetch one or more remote refs and merge it/them into the current HEAD.
+# Fetch a remote ref and rebase the current HEAD on top of it.
 
-USAGE='[-n | --no-summary] [--no-commit] [-s strategy]... [<fetch-options>] <repo> <head>...'
-LONG_USAGE='Fetch one or more remote refs and merge it/them into the current HEAD.'
+USAGE='[-s strategy]... [<fetch-options>] <repo> <head>'
+LONG_USAGE='Fetch a remote ref and rebase the current HEAD onto it.'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
-set_reflog_action "pull $*"
+set_reflog_action "fetch-rebase $*"
 require_work_tree
 cd_to_toplevel
 
 test -z "$(git ls-files -u)" ||
 	die "You are in the middle of a conflicted merge."
 
-strategy_args= no_summary= no_commit= squash=
+strategy_args=
 while :
 do
 	case "$1" in
-	-n|--n|--no|--no-|--no-s|--no-su|--no-sum|--no-summ|\
-		--no-summa|--no-summar|--no-summary)
-		no_summary=-n ;;
-	--summary)
-		no_summary=$1
-		;;
-	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
-		no_commit=--no-commit ;;
-	--sq|--squ|--squa|--squas|--squash)
-		squash=--squash ;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
@@ -55,30 +46,7 @@
 done
 
 orig_head=$(git rev-parse --verify HEAD 2>/dev/null)
-git-fetch --update-head-ok "$@" || exit 1
-
-curr_head=$(git rev-parse --verify HEAD 2>/dev/null)
-if test "$curr_head" != "$orig_head"
-then
-	# The fetch involved updating the current branch.
-
-	# The working tree and the index file is still based on the
-	# $orig_head commit, but we are merging into $curr_head.
-	# First update the working tree to match $curr_head.
-
-	echo >&2 "Warning: fetch updated the current branch head."
-	echo >&2 "Warning: fast forwarding your working tree from"
-	echo >&2 "Warning: commit $orig_head."
-	git update-index --refresh 2>/dev/null
-	git read-tree -u -m "$orig_head" "$curr_head" ||
-		die 'Cannot fast-forward your working tree.
-After making sure that you saved anything precious from
-$ git diff '$orig_head'
-output, run
-$ git reset --hard
-to recover.'
-
-fi
+git-fetch "$@" || exit 1
 
 merge_head=$(sed -e '/	not-for-merge	/d' \
 	-e 's/	.*//' "$GIT_DIR"/FETCH_HEAD | \
@@ -90,21 +58,21 @@
 	case $? in
 	  0) ;;
 	  1) echo >&2 "You are not currently on a branch; you must explicitly"
-	     echo >&2 "specify which branch you wish to merge:"
-	     echo >&2 "  git pull <remote> <branch>"
+	     echo >&2 "specify which branch you wish to rebase onto:"
+	     echo >&2 "  git fetch-rebase <remote> <branch>"
 	     exit 1;;
 	  *) exit $?;;
 	esac
 	curr_branch=${curr_branch#refs/heads/}
 
-	echo >&2 "You asked me to pull without telling me which branch you"
-	echo >&2 "want to merge with, and 'branch.${curr_branch}.merge' in"
+	echo >&2 "You asked me to rebase without telling me which branch you"
+	echo >&2 "want to rebase, and 'branch.${curr_branch}.merge' in"
 	echo >&2 "your configuration file does not tell me either.  Please"
-	echo >&2 "name which branch you want to merge on the command line and"
-	echo >&2 "try again (e.g. 'git pull <repository> <refspec>')."
+	echo >&2 "name which branch you want to rebase on the command line and"
+	echo >&2 "try again (e.g. 'git fetch-rebase <repository> <refspec>')."
 	echo >&2 "See git-pull(1) for details on the refspec."
 	echo >&2
-	echo >&2 "If you often merge with the same branch, you may want to"
+	echo >&2 "If you often rebase to the same branch, you may want to"
 	echo >&2 "configure the following variables in your configuration"
 	echo >&2 "file:"
 	echo >&2
@@ -117,21 +85,15 @@
 	exit 1
 	;;
 ?*' '?*)
-	if test -z "$orig_head"
-	then
-		echo >&2 "Cannot merge multiple branches into empty head"
-		exit 1
-	fi
+	echo >&2 "Cannot rebase onto multiple branches"
+	exit 1
 	;;
 esac
 
 if test -z "$orig_head"
 then
-	git update-ref -m "initial pull" HEAD $merge_head "" &&
-	git read-tree --reset -u HEAD || exit 1
-	exit
+	echo >&2 "Cannot rebase empty head"
+	exit 1
 fi
 
-merge_name=$(git fmt-merge-msg <"$GIT_DIR/FETCH_HEAD") || exit
-exec git-merge $no_summary $no_commit $squash $strategy_args \
-	"$merge_name" HEAD $merge_head
+exec git-rebase $strategy_args $merge_head

--=-XoVZi7AfzWJLuXr3SJuD--
