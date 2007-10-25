From: Michel Marti <mma@objectxp.com>
Subject: Re: Feature request: Limit git-status reports to a directory
Date: Thu, 25 Oct 2007 15:03:35 +0200
Message-ID: <ffq477$mji$1@ger.gmane.org>
References: <ffofbm$lmc$1@ger.gmane.org> <46dff0320710241914t7d93aae1t991fbcaacde77046@mail.gmail.com> <Pine.LNX.4.64.0710251050390.25221@racer.site>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040101080003040006080705"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 15:04:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il2Nl-0007sk-Eh
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 15:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbXJYNEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 09:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753507AbXJYNEE
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 09:04:04 -0400
Received: from main.gmane.org ([80.91.229.2]:33230 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753505AbXJYNEB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 09:04:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Il2NJ-0005GJ-B2
	for git@vger.kernel.org; Thu, 25 Oct 2007 13:03:49 +0000
Received: from 62-2-156-214.static.cablecom.ch ([62.2.156.214])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Oct 2007 13:03:49 +0000
Received: from mma by 62-2-156-214.static.cablecom.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Oct 2007 13:03:49 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 62-2-156-214.static.cablecom.ch
User-Agent: Icedove 1.5.0.12 (X11/20070730)
In-Reply-To: <Pine.LNX.4.64.0710251050390.25221@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62316>

This is a multi-part message in MIME format.
--------------040101080003040006080705
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

on 10/25/2007 11:55 AM Johannes Schindelin said the following:
> I am not so sure.  In other SCMs, "git status" may be a way to do "git 
> diff --name-only" or "git ls-files", but not in git.  Here, it strictly 
> means "what would be happening if I were to commit _right_ _now_?".
I somehow agree with your argument, but then again, sometimes I'm still interested in
*only* the status for a given directory.

IMHO, answering the question "what would be happening if...?" should be  git-commit's task
(e.g. git-commit --dry-run). And git-status should behave similar to git-log and git-diff.

For those interested: I have attached a little script that mimics current git-status
(except the "dry-run" stuff) but also can take a list of directories/files.


--------------040101080003040006080705
Content-Type: text/plain;
 name="git-status-new"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-status-new"

#!/bin/sh

USAGE='[--staged] [--changed] [--untracked]'
SUBDIRECTORY_OK=1 . git-sh-setup
require_work_tree

print_stat_line() {
	case "$1" in
		M)	echo "#       modified:  $2";;
		A)	echo "#       new file:  $2";;
		R*)	echo "#       renamed:   $2 -> $3";;
		D)	echo "#       deleted:   $2";;
		U)	echo "#       unmerged:  $2";;
		X)	echo "#       $2";;
		*)	echo "#       [$S]:      $2";;
	esac
}

STAGED= CHANGED= UNTRACKED= HP=

while test $# != 0
do
	case "$1" in
		-s|--staged) STAGED=1; shift;;
		-c|--changed) CHANGED=1; shift;;
		-u|--untracked) UNTRACKED=1; shift;;
		--) shift; break;;
		-*) usage;;
		 *) break;;
	esac
done

if BRANCH_NAME=$(git symbolic-ref -q HEAD)
then
	BRANCH_NAME="On branch $(expr "z$BRANCH_NAME" : 'zrefs/heads/\(.*\)')"
else
	BRANCH_NAME="Not currently on any branch"
fi

[ "$#" = 0 ] && cd_to_toplevel


if [ -z "$STAGED$CHANGED$UNTRACKED" ]; then
	STAGED=1; CHANGED=1; UNTRACKED=1
fi

SP=$(echo _/$(git rev-parse --show-cdup)|tr '/' ' '|wc -w)

echo "# $BRANCH_NAME"

# Changes to be commited
[ "$STAGED" ] && git-diff --name-status --cached -M -- "$@"|while read S F R
do
	if [ -z "$HP" ]; then
		echo '# Changes to be committed:'
		echo '#   (use "git reset HEAD <file>..." to unstage)'
		echo '#'
		HP=1
	fi
	F=$(echo $F|cut -d'/' -f$SP-)
	print_stat_line "$S" "$F" "$R"

done

# Changed but not updated
[ "$CHANGED" ] && git-diff --name-status -- "$@"|while read S F
do
	if [ -z "$HP" ]; then
		echo '#'
		echo '# Changed but not updated:'
		echo '#   (use "git add <file>..." to update what will be committed)'
		echo '#'
		HP=1
	fi
	F=$(echo $F|cut -d'/' -f$SP-)
	print_stat_line "$S" "$F"
done

# Untracked files
[ "$UNTRACKED" ] && git-ls-files --exclude-per-directory=.gitignore -o --directory -- "$@"|while read F
do
	if [ -z "$HP" ]; then
		echo '#'
		echo '# Untracked files:'
		echo '#   (use "git add <file>..." to include in what will be committed)'
		echo '#'
		HP=1
	fi
	print_stat_line "X" "$F"
done


--------------040101080003040006080705--
