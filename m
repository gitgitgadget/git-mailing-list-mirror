From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Thu, 23 Jun 2005 03:15:03 -0400
Message-ID: <42BA6177.8060202@pobox.com>
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org> <42BA18AF.2070406@pobox.com> <Pine.LNX.4.58.0506221915280.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070008040508040306090201"
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 09:17:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlLxC-0002GW-JG
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 09:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVFWHWc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 03:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVFWHW2
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 03:22:28 -0400
Received: from mail.dvmed.net ([216.237.124.58]:33970 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262613AbVFWHPH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 03:15:07 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DlLvV-000386-Uy; Thu, 23 Jun 2005 07:15:06 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506221915280.11175@ppc970.osdl.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------070008040508040306090201
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> How about this patch? Then you can say
> 
> 	git-apply --stat --summary --apply --index /tmp/my.patch
> 
> and it will not only apply the patch, but also give a diffstat and a
> summary or renames etc..

Quite nice.



>>I usually want just two things:
>>
>>1) browse the log
>>
>>2) list changes in local tree that are not in $remote_tree, a la
>>	bk changes -L ../linux-2.6
>>
>>I agree that seeing the merge csets is useful, that is why [being 
>>ignorant of 'git log'] I used git-changes-script.
> 
> 
> For (1) "bk log" is good.

Chuckle.  What does one call a Freudian slip, in computer-land?


> For (2) you'll have to use your own script, or
> just have the remote tree as a branch in the same tree, in which case you
> can do
> 
> 	git log remotebranch..mybranch

Very neat.  That makes some things a bit easier, since I usually carry a 
'vanilla' branch as .git/refs/heads/master, and do all my modifications 
on other branches.

FWIW, git-changes-script (attached) facilitates #2 for me right now.  I 
use it just like BK's '-L' feature:

	cd netdev-2.6
	git checkout -f ieee80211
	git-changes-script -L ../linux-2.6 | less

That will produce the same output as the feature you just taught me,

	git log master..ieee80211

WARNING:  You have previously called git-changes-script quite ugly (not 
surprising), and this 'git log x..y' will probably replace it in my 
usage, long term.

	Jeff



--------------070008040508040306090201
Content-Type: text/plain;
 name="git-changes-script"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-changes-script"

#!/bin/bash
#
# Make a log of changes in a GIT branch.
#
# This script was originally written by (c) Ross Vandegrift.
# Adapted to his scripts set by (c) Petr Baudis, 2005.
# Major optimizations by (c) Phillip Lougher.
# Rendered trivial by Linus Torvalds.
# Added -L|-R option by James Bottomley
#
# options:
# script [-L <dir> | -R <dir> |-r <from_sha1> [ -r <to_sha1] ] [<sha1>]
#
# With no options shows all the revisions from HEAD to the root
# -L shows all the changes in the local tree compared to the tree at <dir>
# -R shows all the changes in the remote tree at <dir> compared to the local
# -r shows all the changes in one commit or between two

tmpfile=/tmp/git_changes.$$
r1=
r2=

showcommit() {
	commit="$1"
	echo commit ${commit%:*};
	git-cat-file commit $commit | \
		while read key rest; do
			case "$key" in
			"author"|"committer")
				date=(${rest#*> })
				sec=${date[0]}; tz=${date[1]}
				dtz=${tz/+/+ }; dtz=${dtz/-/- }
				pdate="$(date -Rud "1970-01-01 UTC + $sec sec $dtz" 2>/dev/null)"
				if [ "$pdate" ]; then
					echo $key $rest | sed "s/>.*/> ${pdate/+0000/$tz}/"
				else
					echo $key $rest
				fi
				;;
			"")
				echo; cat
				;;
			*)
				echo $key $rest
				;;
			esac

		done
}

while true; do
	case "$1" in
		-R)	shift;
			diffsearch=+
			remote="$1"
			shift;;
		-L)	shift;
			diffsearch=-
			remote="$1"
			shift;;
		-r)	shift;
			if [ -z "$r1" ]; then
				r1="$1"
			else
				r2="$1"
			fi
			shift;;
		*)	base="$1"
			break;;
	esac
done

if [ -n "$r1" ]; then
	if [ -z "$r2" ]; then
		showcommit $r1
		exit 0
	fi
	diffsearch=+
	remote=`pwd`;
	tobase="$r2";
	base="$r1"
fi
	
if [ -z "$base" ]; then
	base=$(cat .git/HEAD) || exit 1
fi

git-rev-tree $base | sort -rn  > ${tmpfile}.base
if [ -n "$remote" ]; then
	[ -d $remote/.git ] || exit 1
	if [ -z "$tobase" ]; then
		tobase=$(cat $remote/.git/HEAD) || exit 1
	fi
	pushd $remote > /dev/null
	git-rev-tree $tobase | sort -rn > ${tmpfile}.remote
	diff -u ${tmpfile}.base ${tmpfile}.remote | grep "^${diffsearch}[^${diffsearch}]" | cut -c 1- > ${tmpfile}.diff
	rm -f ${tmpfile}.base ${tmpfile}.remote
	mv ${tmpfile}.diff ${tmpfile}.base
	if [ $diffsearch = "-" ]; then
		popd > /dev/null
	fi
fi

[ -s "${tmpfile}.base" ] || exit 0

cat ${tmpfile}.base | while read time commit parents; do
	showcommit $commit
	echo -e "\n--------------------------"

done
rm -f ${tmpfile}.base

--------------070008040508040306090201--
